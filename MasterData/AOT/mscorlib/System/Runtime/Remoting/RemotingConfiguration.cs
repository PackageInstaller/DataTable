using System.Collections;
using System.IO;
using System.Runtime.InteropServices;
using System.Runtime.Remoting.Activation;
using System.Runtime.Remoting.Channels;
using Mono.Xml;

namespace System.Runtime.Remoting;

[ComVisible(true)]
public static class RemotingConfiguration
{
	private static string applicationID = null;

	private static string applicationName = null;

	private static string processGuid = null;

	private static bool defaultConfigRead = false;

	private static bool defaultDelayedConfigRead = false;

	private static CustomErrorsModes _errorMode = CustomErrorsModes.RemoteOnly;

	private static Hashtable wellKnownClientEntries = new Hashtable();

	private static Hashtable activatedClientEntries = new Hashtable();

	private static Hashtable wellKnownServiceEntries = new Hashtable();

	private static Hashtable activatedServiceEntries = new Hashtable();

	private static Hashtable channelTemplates = new Hashtable();

	private static Hashtable clientProviderTemplates = new Hashtable();

	private static Hashtable serverProviderTemplates = new Hashtable();

	public static string ApplicationName
	{
		get
		{
			return applicationName;
		}
		set
		{
			applicationName = value;
		}
	}

	public static string ProcessId
	{
		get
		{
			if (processGuid == null)
			{
				processGuid = AppDomain.GetProcessGuid();
			}
			return processGuid;
		}
	}

	internal static void LoadDefaultDelayedChannels()
	{
		lock (channelTemplates)
		{
			if (!defaultDelayedConfigRead && !defaultConfigRead)
			{
				SmallXmlParser smallXmlParser = new SmallXmlParser();
				using (TextReader input = new StreamReader(Environment.GetMachineConfigPath()))
				{
					ConfigHandler handler = new ConfigHandler(onlyDelayedChannels: true);
					smallXmlParser.Parse(input, handler);
				}
				defaultDelayedConfigRead = true;
			}
		}
	}

	public static bool IsActivationAllowed(Type svrType)
	{
		lock (channelTemplates)
		{
			return activatedServiceEntries.ContainsKey(svrType);
		}
	}

	public static ActivatedClientTypeEntry IsRemotelyActivatedClientType(Type svrType)
	{
		lock (channelTemplates)
		{
			return activatedClientEntries[svrType] as ActivatedClientTypeEntry;
		}
	}

	public static WellKnownClientTypeEntry IsWellKnownClientType(Type svrType)
	{
		lock (channelTemplates)
		{
			return wellKnownClientEntries[svrType] as WellKnownClientTypeEntry;
		}
	}

	public static void RegisterActivatedClientType(ActivatedClientTypeEntry entry)
	{
		lock (channelTemplates)
		{
			if (wellKnownClientEntries.ContainsKey(entry.ObjectType) || activatedClientEntries.ContainsKey(entry.ObjectType))
			{
				throw new RemotingException("Attempt to redirect activation of type '" + entry.ObjectType.FullName + "' which is already redirected.");
			}
			activatedClientEntries[entry.ObjectType] = entry;
			ActivationServices.EnableProxyActivation(entry.ObjectType, enable: true);
		}
	}

	public static void RegisterActivatedServiceType(ActivatedServiceTypeEntry entry)
	{
		lock (channelTemplates)
		{
			activatedServiceEntries.Add(entry.ObjectType, entry);
		}
	}

	public static void RegisterWellKnownClientType(WellKnownClientTypeEntry entry)
	{
		lock (channelTemplates)
		{
			if (wellKnownClientEntries.ContainsKey(entry.ObjectType) || activatedClientEntries.ContainsKey(entry.ObjectType))
			{
				throw new RemotingException("Attempt to redirect activation of type '" + entry.ObjectType.FullName + "' which is already redirected.");
			}
			wellKnownClientEntries[entry.ObjectType] = entry;
			ActivationServices.EnableProxyActivation(entry.ObjectType, enable: true);
		}
	}

	public static void RegisterWellKnownServiceType(WellKnownServiceTypeEntry entry)
	{
		lock (channelTemplates)
		{
			wellKnownServiceEntries[entry.ObjectUri] = entry;
			RemotingServices.CreateWellKnownServerIdentity(entry.ObjectType, entry.ObjectUri, entry.Mode);
		}
	}

	internal static void RegisterChannelTemplate(ChannelData channel)
	{
		channelTemplates[channel.Id] = channel;
	}

	internal static void RegisterClientProviderTemplate(ProviderData prov)
	{
		clientProviderTemplates[prov.Id] = prov;
	}

	internal static void RegisterServerProviderTemplate(ProviderData prov)
	{
		serverProviderTemplates[prov.Id] = prov;
	}

	internal static void RegisterChannels(ArrayList channels, bool onlyDelayed)
	{
		foreach (ChannelData channel in channels)
		{
			if ((onlyDelayed && channel.DelayLoadAsClientChannel != "true") || (defaultDelayedConfigRead && channel.DelayLoadAsClientChannel == "true"))
			{
				continue;
			}
			if (channel.Ref != null)
			{
				ChannelData channelData2 = (ChannelData)channelTemplates[channel.Ref];
				if (channelData2 == null)
				{
					throw new RemotingException("Channel template '" + channel.Ref + "' not found");
				}
				channel.CopyFrom(channelData2);
			}
			foreach (ProviderData serverProvider in channel.ServerProviders)
			{
				if (serverProvider.Ref != null)
				{
					ProviderData providerData2 = (ProviderData)serverProviderTemplates[serverProvider.Ref];
					if (providerData2 == null)
					{
						throw new RemotingException("Provider template '" + serverProvider.Ref + "' not found");
					}
					serverProvider.CopyFrom(providerData2);
				}
			}
			foreach (ProviderData clientProvider in channel.ClientProviders)
			{
				if (clientProvider.Ref != null)
				{
					ProviderData providerData4 = (ProviderData)clientProviderTemplates[clientProvider.Ref];
					if (providerData4 == null)
					{
						throw new RemotingException("Provider template '" + clientProvider.Ref + "' not found");
					}
					clientProvider.CopyFrom(providerData4);
				}
			}
			ChannelServices.RegisterChannelConfig(channel);
		}
	}

	internal static void RegisterTypes(ArrayList types)
	{
		foreach (TypeEntry type in types)
		{
			if (type is ActivatedClientTypeEntry)
			{
				RegisterActivatedClientType((ActivatedClientTypeEntry)type);
			}
			else if (type is ActivatedServiceTypeEntry)
			{
				RegisterActivatedServiceType((ActivatedServiceTypeEntry)type);
			}
			else if (type is WellKnownClientTypeEntry)
			{
				RegisterWellKnownClientType((WellKnownClientTypeEntry)type);
			}
			else if (type is WellKnownServiceTypeEntry)
			{
				RegisterWellKnownServiceType((WellKnownServiceTypeEntry)type);
			}
		}
	}

	public static bool CustomErrorsEnabled(bool isLocalRequest)
	{
		if (_errorMode == CustomErrorsModes.Off)
		{
			return false;
		}
		if (_errorMode == CustomErrorsModes.On)
		{
			return true;
		}
		return !isLocalRequest;
	}

	internal static void SetCustomErrorsMode(string mode)
	{
		if (mode == null)
		{
			throw new RemotingException("mode attribute is required");
		}
		string text = mode.ToLower();
		if (text != "on" && text != "off" && text != "remoteonly")
		{
			throw new RemotingException("Invalid custom error mode: " + mode);
		}
		_errorMode = (CustomErrorsModes)Enum.Parse(typeof(CustomErrorsModes), text, ignoreCase: true);
	}
}
