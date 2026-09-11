using System.Reflection;
using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Messaging;

[ComVisible(true)]
public interface IMethodMessage : IMessage
{
	int ArgCount { get; }

	object[] Args { get; }

	LogicalCallContext LogicalCallContext { get; }

	MethodBase MethodBase { get; }

	string MethodName { get; }

	object MethodSignature { get; }

	string TypeName { get; }

	string Uri { get; }

	object GetArg(int argNum);
}
