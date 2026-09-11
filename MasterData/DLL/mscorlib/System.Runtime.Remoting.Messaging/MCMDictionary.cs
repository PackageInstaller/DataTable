namespace System.Runtime.Remoting.Messaging;

internal class MCMDictionary : MessageDictionary
{
	public static string[] InternalKeys = new string[6] { "__Uri", "__MethodName", "__TypeName", "__MethodSignature", "__Args", "__CallContext" };

	public MCMDictionary(IMethodMessage message)
		: base(message)
	{
		base.MethodKeys = InternalKeys;
	}
}
