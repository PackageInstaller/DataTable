using System.Collections;

namespace System.Runtime.Remoting;

internal class ChannelData
{
	internal string Ref;

	internal string Type;

	internal string Id;

	internal string DelayLoadAsClientChannel;

	private ArrayList _serverProviders = new ArrayList();

	private ArrayList _clientProviders = new ArrayList();

	private Hashtable _customProperties = new Hashtable();

	internal ArrayList ServerProviders
	{
		get
		{
			if (_serverProviders == null)
			{
				_serverProviders = new ArrayList();
			}
			return _serverProviders;
		}
	}

	public ArrayList ClientProviders
	{
		get
		{
			if (_clientProviders == null)
			{
				_clientProviders = new ArrayList();
			}
			return _clientProviders;
		}
	}

	public Hashtable CustomProperties
	{
		get
		{
			if (_customProperties == null)
			{
				_customProperties = new Hashtable();
			}
			return _customProperties;
		}
	}

	public void CopyFrom(ChannelData other)
	{
		if (Ref == null)
		{
			Ref = other.Ref;
		}
		if (Id == null)
		{
			Id = other.Id;
		}
		if (Type == null)
		{
			Type = other.Type;
		}
		if (DelayLoadAsClientChannel == null)
		{
			DelayLoadAsClientChannel = other.DelayLoadAsClientChannel;
		}
		if (other._customProperties != null)
		{
			foreach (DictionaryEntry customProperty in other._customProperties)
			{
				if (!CustomProperties.ContainsKey(customProperty.Key))
				{
					CustomProperties[customProperty.Key] = customProperty.Value;
				}
			}
		}
		if (_serverProviders == null && other._serverProviders != null)
		{
			foreach (ProviderData serverProvider in other._serverProviders)
			{
				ProviderData providerData = new ProviderData();
				providerData.CopyFrom(serverProvider);
				ServerProviders.Add(providerData);
			}
		}
		if (_clientProviders != null || other._clientProviders == null)
		{
			return;
		}
		foreach (ProviderData clientProvider in other._clientProviders)
		{
			ProviderData providerData2 = new ProviderData();
			providerData2.CopyFrom(clientProvider);
			ClientProviders.Add(providerData2);
		}
	}
}
