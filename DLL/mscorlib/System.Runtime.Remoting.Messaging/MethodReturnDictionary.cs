namespace System.Runtime.Remoting.Messaging;

internal class MethodReturnDictionary : MessageDictionary
{
	public static string[] InternalReturnKeys = new string[7] { "__Uri", "__MethodName", "__TypeName", "__MethodSignature", "__OutArgs", "__Return", "__CallContext" };

	public static string[] InternalExceptionKeys = new string[1] { "__CallContext" };

	public MethodReturnDictionary(IMethodReturnMessage message)
		: base(message)
	{
		if (message.Exception == null)
		{
			base.MethodKeys = InternalReturnKeys;
		}
		else
		{
			base.MethodKeys = InternalExceptionKeys;
		}
	}
}
