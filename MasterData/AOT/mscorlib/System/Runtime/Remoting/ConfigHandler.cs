using System.Collections;
using System.Globalization;
using System.Reflection;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting.Lifetime;
using Mono.Xml;

namespace System.Runtime.Remoting;

internal class ConfigHandler : SmallXmlParser.IContentHandler
{
	private ArrayList typeEntries = new ArrayList();

	private ArrayList channelInstances = new ArrayList();

	private ChannelData currentChannel;

	private Stack currentProviderData;

	private string currentClientUrl;

	private string appName;

	private string currentXmlPath = "";

	private bool onlyDelayedChannels;

	public ConfigHandler(bool onlyDelayedChannels)
	{
		this.onlyDelayedChannels = onlyDelayedChannels;
	}

	private void ValidatePath(string element, params string[] paths)
	{
		foreach (string path in paths)
		{
			if (CheckPath(path))
			{
				return;
			}
		}
		throw new RemotingException("Element " + element + " not allowed in this context");
	}

	private bool CheckPath(string path)
	{
		CompareInfo compareInfo = CultureInfo.InvariantCulture.CompareInfo;
		if (compareInfo.IsPrefix(path, "/", CompareOptions.Ordinal))
		{
			return path == currentXmlPath;
		}
		return compareInfo.IsSuffix(currentXmlPath, path, CompareOptions.Ordinal);
	}

	public void OnStartParsing(SmallXmlParser parser)
	{
	}

	public void OnProcessingInstruction(string name, string text)
	{
	}

	public void OnIgnorableWhitespace(string s)
	{
	}

	public void OnStartElement(string name, SmallXmlParser.IAttrList attrs)
	{
		try
		{
			if (currentXmlPath.StartsWith("/configuration/system.runtime.remoting"))
			{
				ParseElement(name, attrs);
			}
			currentXmlPath = currentXmlPath + "/" + name;
		}
		catch (Exception ex)
		{
			throw new RemotingException("Error in element " + name + ": " + ex.Message, ex);
		}
	}

	public void ParseElement(string name, SmallXmlParser.IAttrList attrs)
	{
		if (currentProviderData != null)
		{
			ReadCustomProviderData(name, attrs);
			return;
		}
		switch (name)
		{
		case "application":
			ValidatePath(name, "system.runtime.remoting");
			if (attrs.Names.Length != 0)
			{
				appName = attrs.Values[0];
			}
			break;
		case "lifetime":
			ValidatePath(name, "application");
			ReadLifetine(attrs);
			break;
		case "channels":
			ValidatePath(name, "system.runtime.remoting", "application");
			break;
		case "channel":
			ValidatePath(name, "channels");
			if (currentXmlPath.IndexOf("application") != -1)
			{
				ReadChannel(attrs, isTemplate: false);
			}
			else
			{
				ReadChannel(attrs, isTemplate: true);
			}
			break;
		case "serverProviders":
			ValidatePath(name, "channelSinkProviders", "channel");
			break;
		case "clientProviders":
			ValidatePath(name, "channelSinkProviders", "channel");
			break;
		case "provider":
		case "formatter":
			if (CheckPath("application/channels/channel/serverProviders") || CheckPath("channels/channel/serverProviders"))
			{
				ProviderData value = ReadProvider(name, attrs, isTemplate: false);
				currentChannel.ServerProviders.Add(value);
			}
			else if (CheckPath("application/channels/channel/clientProviders") || CheckPath("channels/channel/clientProviders"))
			{
				ProviderData value = ReadProvider(name, attrs, isTemplate: false);
				currentChannel.ClientProviders.Add(value);
			}
			else if (CheckPath("channelSinkProviders/serverProviders"))
			{
				ProviderData value = ReadProvider(name, attrs, isTemplate: true);
				RemotingConfiguration.RegisterServerProviderTemplate(value);
			}
			else if (CheckPath("channelSinkProviders/clientProviders"))
			{
				ProviderData value = ReadProvider(name, attrs, isTemplate: true);
				RemotingConfiguration.RegisterClientProviderTemplate(value);
			}
			else
			{
				ValidatePath(name);
			}
			break;
		case "client":
			ValidatePath(name, "application");
			currentClientUrl = attrs.GetValue("url");
			break;
		case "service":
			ValidatePath(name, "application");
			break;
		case "wellknown":
			ValidatePath(name, "client", "service");
			if (CheckPath("client"))
			{
				ReadClientWellKnown(attrs);
			}
			else
			{
				ReadServiceWellKnown(attrs);
			}
			break;
		case "activated":
			ValidatePath(name, "client", "service");
			if (CheckPath("client"))
			{
				ReadClientActivated(attrs);
			}
			else
			{
				ReadServiceActivated(attrs);
			}
			break;
		case "soapInterop":
			ValidatePath(name, "application");
			break;
		case "interopXmlType":
			ValidatePath(name, "soapInterop");
			ReadInteropXml(attrs, isElement: false);
			break;
		case "interopXmlElement":
			ValidatePath(name, "soapInterop");
			ReadInteropXml(attrs, isElement: false);
			break;
		case "preLoad":
			ValidatePath(name, "soapInterop");
			ReadPreload(attrs);
			break;
		case "debug":
			ValidatePath(name, "system.runtime.remoting");
			break;
		case "channelSinkProviders":
			ValidatePath(name, "system.runtime.remoting");
			break;
		case "customErrors":
			ValidatePath(name, "system.runtime.remoting");
			RemotingConfiguration.SetCustomErrorsMode(attrs.GetValue("mode"));
			break;
		default:
			throw new RemotingException("Element '" + name + "' is not valid in system.remoting.configuration section");
		}
	}

	public void OnEndElement(string name)
	{
		if (currentProviderData != null)
		{
			currentProviderData.Pop();
			if (currentProviderData.Count == 0)
			{
				currentProviderData = null;
			}
		}
		currentXmlPath = currentXmlPath.Substring(0, currentXmlPath.Length - name.Length - 1);
	}

	private void ReadCustomProviderData(string name, SmallXmlParser.IAttrList attrs)
	{
		SinkProviderData sinkProviderData = (SinkProviderData)currentProviderData.Peek();
		SinkProviderData sinkProviderData2 = new SinkProviderData(name);
		for (int i = 0; i < attrs.Names.Length; i++)
		{
			sinkProviderData2.Properties[attrs.Names[i]] = attrs.GetValue(i);
		}
		sinkProviderData.Children.Add(sinkProviderData2);
		currentProviderData.Push(sinkProviderData2);
	}

	private void ReadLifetine(SmallXmlParser.IAttrList attrs)
	{
		for (int i = 0; i < attrs.Names.Length; i++)
		{
			switch (attrs.Names[i])
			{
			case "leaseTime":
				LifetimeServices.LeaseTime = ParseTime(attrs.GetValue(i));
				break;
			case "sponsorshipTimeout":
				LifetimeServices.SponsorshipTimeout = ParseTime(attrs.GetValue(i));
				break;
			case "renewOnCallTime":
				LifetimeServices.RenewOnCallTime = ParseTime(attrs.GetValue(i));
				break;
			case "leaseManagerPollTime":
				LifetimeServices.LeaseManagerPollTime = ParseTime(attrs.GetValue(i));
				break;
			default:
				throw new RemotingException("Invalid attribute: " + attrs.Names[i]);
			}
		}
	}

	private TimeSpan ParseTime(string s)
	{
		if (s == "" || s == null)
		{
			throw new RemotingException("Invalid time value");
		}
		int num = s.IndexOfAny(new char[4] { 'D', 'H', 'M', 'S' });
		string text;
		if (num == -1)
		{
			text = "S";
		}
		else
		{
			text = s.Substring(num);
			s = s.Substring(0, num);
		}
		double value;
		try
		{
			value = double.Parse(s);
		}
		catch
		{
			throw new RemotingException("Invalid time value: " + s);
		}
		return text switch
		{
			"D" => TimeSpan.FromDays(value), 
			"H" => TimeSpan.FromHours(value), 
			"M" => TimeSpan.FromMinutes(value), 
			"S" => TimeSpan.FromSeconds(value), 
			"MS" => TimeSpan.FromMilliseconds(value), 
			_ => throw new RemotingException("Invalid time unit: " + text), 
		};
	}

	private void ReadChannel(SmallXmlParser.IAttrList attrs, bool isTemplate)
	{
		ChannelData channelData = new ChannelData();
		for (int i = 0; i < attrs.Names.Length; i++)
		{
			string text = attrs.Names[i];
			string text2 = attrs.Values[i];
			if (text == "ref" && !isTemplate)
			{
				channelData.Ref = text2;
			}
			else if (text == "delayLoadAsClientChannel")
			{
				channelData.DelayLoadAsClientChannel = text2;
			}
			else if ((text == "id") & isTemplate)
			{
				channelData.Id = text2;
			}
			else if (text == "type")
			{
				channelData.Type = text2;
			}
			else
			{
				channelData.CustomProperties.Add(text, text2);
			}
		}
		if (isTemplate)
		{
			if (channelData.Id == null)
			{
				throw new RemotingException("id attribute is required");
			}
			if (channelData.Type == null)
			{
				throw new RemotingException("id attribute is required");
			}
			RemotingConfiguration.RegisterChannelTemplate(channelData);
		}
		else
		{
			channelInstances.Add(channelData);
		}
		currentChannel = channelData;
	}

	private ProviderData ReadProvider(string name, SmallXmlParser.IAttrList attrs, bool isTemplate)
	{
		ProviderData providerData = ((name == "provider") ? new ProviderData() : new FormatterData());
		SinkProviderData sinkProviderData = new SinkProviderData("root");
		providerData.CustomData = sinkProviderData.Children;
		currentProviderData = new Stack();
		currentProviderData.Push(sinkProviderData);
		for (int i = 0; i < attrs.Names.Length; i++)
		{
			string text = attrs.Names[i];
			string text2 = attrs.Values[i];
			if ((text == "id") & isTemplate)
			{
				providerData.Id = text2;
			}
			else if (text == "type")
			{
				providerData.Type = text2;
			}
			else if (text == "ref" && !isTemplate)
			{
				providerData.Ref = text2;
			}
			else
			{
				providerData.CustomProperties.Add(text, text2);
			}
		}
		if ((providerData.Id == null) & isTemplate)
		{
			throw new RemotingException("id attribute is required");
		}
		return providerData;
	}

	private void ReadClientActivated(SmallXmlParser.IAttrList attrs)
	{
		string type = GetNotNull(attrs, "type");
		string assemblyName = ExtractAssembly(ref type);
		if (currentClientUrl == null || currentClientUrl == "")
		{
			throw new RemotingException("url attribute is required in client element when it contains activated entries");
		}
		typeEntries.Add(new ActivatedClientTypeEntry(type, assemblyName, currentClientUrl));
	}

	private void ReadServiceActivated(SmallXmlParser.IAttrList attrs)
	{
		string type = GetNotNull(attrs, "type");
		string assemblyName = ExtractAssembly(ref type);
		typeEntries.Add(new ActivatedServiceTypeEntry(type, assemblyName));
	}

	private void ReadClientWellKnown(SmallXmlParser.IAttrList attrs)
	{
		string notNull = GetNotNull(attrs, "url");
		string type = GetNotNull(attrs, "type");
		string assemblyName = ExtractAssembly(ref type);
		typeEntries.Add(new WellKnownClientTypeEntry(type, assemblyName, notNull));
	}

	private void ReadServiceWellKnown(SmallXmlParser.IAttrList attrs)
	{
		string notNull = GetNotNull(attrs, "objectUri");
		string notNull2 = GetNotNull(attrs, "mode");
		string type = GetNotNull(attrs, "type");
		string assemblyName = ExtractAssembly(ref type);
		WellKnownObjectMode mode;
		if (notNull2 == "SingleCall")
		{
			mode = WellKnownObjectMode.SingleCall;
		}
		else
		{
			if (!(notNull2 == "Singleton"))
			{
				throw new RemotingException("wellknown object mode '" + notNull2 + "' is invalid");
			}
			mode = WellKnownObjectMode.Singleton;
		}
		typeEntries.Add(new WellKnownServiceTypeEntry(type, assemblyName, notNull, mode));
	}

	private void ReadInteropXml(SmallXmlParser.IAttrList attrs, bool isElement)
	{
		Type type = Type.GetType(GetNotNull(attrs, "clr"));
		string[] array = GetNotNull(attrs, "xml").Split(',');
		string text = array[0].Trim();
		string text2 = ((array.Length != 0) ? array[1].Trim() : null);
		if (isElement)
		{
			SoapServices.RegisterInteropXmlElement(text, text2, type);
		}
		else
		{
			SoapServices.RegisterInteropXmlType(text, text2, type);
		}
	}

	private void ReadPreload(SmallXmlParser.IAttrList attrs)
	{
		string value = attrs.GetValue("type");
		string value2 = attrs.GetValue("assembly");
		if (value != null && value2 != null)
		{
			throw new RemotingException("Type and assembly attributes cannot be specified together");
		}
		if (value != null)
		{
			SoapServices.PreLoad(Type.GetType(value));
			return;
		}
		if (value2 != null)
		{
			SoapServices.PreLoad(Assembly.Load(value2));
			return;
		}
		throw new RemotingException("Either type or assembly attributes must be specified");
	}

	private string GetNotNull(SmallXmlParser.IAttrList attrs, string name)
	{
		string value = attrs.GetValue(name);
		if (value == null || value == "")
		{
			throw new RemotingException(name + " attribute is required");
		}
		return value;
	}

	private string ExtractAssembly(ref string type)
	{
		int num = type.IndexOf(',');
		if (num == -1)
		{
			return "";
		}
		string result = type.Substring(num + 1).Trim();
		type = type.Substring(0, num).Trim();
		return result;
	}

	public void OnChars(string ch)
	{
	}

	public void OnEndParsing(SmallXmlParser parser)
	{
		RemotingConfiguration.RegisterChannels(channelInstances, onlyDelayedChannels);
		if (appName != null)
		{
			RemotingConfiguration.ApplicationName = appName;
		}
		if (!onlyDelayedChannels)
		{
			RemotingConfiguration.RegisterTypes(typeEntries);
		}
	}
}
