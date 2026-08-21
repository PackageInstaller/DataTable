using System.Runtime.Remoting.Activation;

namespace System.Runtime.Remoting.Messaging;

internal class ConstructionCallDictionary : MessageDictionary
{
	public static string[] InternalKeys = new string[11]
	{
		"__Uri", "__MethodName", "__TypeName", "__MethodSignature", "__Args", "__CallContext", "__CallSiteActivationAttributes", "__ActivationType", "__ContextProperties", "__Activator",
		"__ActivationTypeName"
	};

	public ConstructionCallDictionary(IConstructionCallMessage message)
		: base(message)
	{
		base.MethodKeys = InternalKeys;
	}

	protected override object GetMethodProperty(string key)
	{
		return key switch
		{
			"__Activator" => ((IConstructionCallMessage)_message).Activator, 
			"__CallSiteActivationAttributes" => ((IConstructionCallMessage)_message).CallSiteActivationAttributes, 
			"__ActivationType" => ((IConstructionCallMessage)_message).ActivationType, 
			"__ContextProperties" => ((IConstructionCallMessage)_message).ContextProperties, 
			"__ActivationTypeName" => ((IConstructionCallMessage)_message).ActivationTypeName, 
			_ => base.GetMethodProperty(key), 
		};
	}

	protected override void SetMethodProperty(string key, object value)
	{
		switch (key)
		{
		case "__Activator":
			((IConstructionCallMessage)_message).Activator = (IActivator)value;
			break;
		case "__CallSiteActivationAttributes":
		case "__ActivationType":
		case "__ContextProperties":
		case "__ActivationTypeName":
			throw new ArgumentException("key was invalid");
		default:
			base.SetMethodProperty(key, value);
			break;
		}
	}
}
