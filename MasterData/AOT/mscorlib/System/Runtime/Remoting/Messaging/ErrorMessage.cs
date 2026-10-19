using System.Collections;
using System.Reflection;

namespace System.Runtime.Remoting.Messaging;

[Serializable]
internal class ErrorMessage : IMethodCallMessage, IMethodMessage, IMessage
{
	private string _uri = "Exception";

	public int ArgCount => 0;

	public object[] Args => null;

	public MethodBase MethodBase => null;

	public string MethodName => "unknown";

	public object MethodSignature => null;

	public virtual IDictionary Properties => null;

	public string TypeName => "unknown";

	public string Uri => _uri;

	public LogicalCallContext LogicalCallContext => null;

	public object GetArg(int arg_num)
	{
		return null;
	}
}
