using System.Runtime.Remoting.Contexts;
using System.Runtime.Remoting.Messaging;

namespace System.Runtime.Remoting;

internal abstract class Identity
{
	protected string _objectUri;

	protected IMessageSink _channelSink;

	protected IMessageSink _envoySink;

	private DynamicPropertyCollection _clientDynamicProperties;

	private DynamicPropertyCollection _serverDynamicProperties;

	protected ObjRef _objRef;

	private bool _disposed;

	public IMessageSink ChannelSink
	{
		get
		{
			return _channelSink;
		}
		set
		{
			_channelSink = value;
		}
	}

	public IMessageSink EnvoySink => _envoySink;

	public string ObjectUri
	{
		get
		{
			return _objectUri;
		}
		set
		{
			_objectUri = value;
		}
	}

	public bool IsConnected => _objectUri != null;

	public bool Disposed
	{
		get
		{
			return _disposed;
		}
		set
		{
			_disposed = value;
		}
	}

	public DynamicPropertyCollection ClientDynamicProperties
	{
		get
		{
			if (_clientDynamicProperties == null)
			{
				_clientDynamicProperties = new DynamicPropertyCollection();
			}
			return _clientDynamicProperties;
		}
	}

	public bool HasServerDynamicSinks
	{
		get
		{
			if (_serverDynamicProperties != null)
			{
				return _serverDynamicProperties.HasProperties;
			}
			return false;
		}
	}

	public Identity(string objectUri)
	{
		_objectUri = objectUri;
	}

	public abstract ObjRef CreateObjRef(Type requestedType);

	public void NotifyClientDynamicSinks(bool start, IMessage req_msg, bool client_site, bool async)
	{
		if (_clientDynamicProperties != null && _clientDynamicProperties.HasProperties)
		{
			_clientDynamicProperties.NotifyMessage(start, req_msg, client_site, async);
		}
	}

	public void NotifyServerDynamicSinks(bool start, IMessage req_msg, bool client_site, bool async)
	{
		if (_serverDynamicProperties != null && _serverDynamicProperties.HasProperties)
		{
			_serverDynamicProperties.NotifyMessage(start, req_msg, client_site, async);
		}
	}
}
