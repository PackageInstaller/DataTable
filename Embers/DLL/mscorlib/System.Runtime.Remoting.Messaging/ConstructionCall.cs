using System.Collections;
using System.Runtime.InteropServices;
using System.Runtime.Remoting.Activation;
using System.Runtime.Remoting.Proxies;
using System.Runtime.Serialization;

namespace System.Runtime.Remoting.Messaging;

[Serializable]
[ComVisible(true)]
[CLSCompliant(false)]
public class ConstructionCall : MethodCall, IConstructionCallMessage, IMessage, IMethodCallMessage, IMethodMessage
{
	private IActivator _activator;

	private object[] _activationAttributes;

	private IList _contextProperties;

	private Type _activationType;

	private string _activationTypeName;

	private bool _isContextOk;

	[NonSerialized]
	private RemotingProxy _sourceProxy;

	internal bool IsContextOk
	{
		get
		{
			return _isContextOk;
		}
		set
		{
			_isContextOk = value;
		}
	}

	public Type ActivationType
	{
		get
		{
			if (_activationType == null)
			{
				_activationType = Type.GetType(_activationTypeName);
			}
			return _activationType;
		}
	}

	public string ActivationTypeName => _activationTypeName;

	public IActivator Activator
	{
		get
		{
			return _activator;
		}
		set
		{
			_activator = value;
		}
	}

	public object[] CallSiteActivationAttributes => _activationAttributes;

	public IList ContextProperties
	{
		get
		{
			if (_contextProperties == null)
			{
				_contextProperties = new ArrayList();
			}
			return _contextProperties;
		}
	}

	public override IDictionary Properties => base.Properties;

	internal RemotingProxy SourceProxy
	{
		get
		{
			return _sourceProxy;
		}
		set
		{
			_sourceProxy = value;
		}
	}

	internal ConstructionCall(Type type)
	{
		_activationType = type;
		_activationTypeName = type.AssemblyQualifiedName;
		_isContextOk = true;
	}

	internal ConstructionCall(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}

	internal override void InitDictionary()
	{
		InternalProperties = ((MessageDictionary)(ExternalProperties = new ConstructionCallDictionary(this))).GetInternalProperties();
	}

	internal void SetActivationAttributes(object[] attributes)
	{
		_activationAttributes = attributes;
	}

	internal override void InitMethodProperty(string key, object value)
	{
		switch (key)
		{
		case "__Activator":
			_activator = (IActivator)value;
			break;
		case "__CallSiteActivationAttributes":
			_activationAttributes = (object[])value;
			break;
		case "__ActivationType":
			_activationType = (Type)value;
			break;
		case "__ContextProperties":
			_contextProperties = (IList)value;
			break;
		case "__ActivationTypeName":
			_activationTypeName = (string)value;
			break;
		default:
			base.InitMethodProperty(key, value);
			break;
		}
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		base.GetObjectData(info, context);
		IList list = _contextProperties;
		if (list != null && list.Count == 0)
		{
			list = null;
		}
		info.AddValue("__Activator", _activator);
		info.AddValue("__CallSiteActivationAttributes", _activationAttributes);
		info.AddValue("__ActivationType", null);
		info.AddValue("__ContextProperties", list);
		info.AddValue("__ActivationTypeName", _activationTypeName);
	}
}
