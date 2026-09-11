using System.Runtime.InteropServices;
using System.Runtime.Remoting.Messaging;

namespace System.Runtime.Remoting.Contexts;

[ComVisible(true)]
public interface IDynamicMessageSink
{
	void ProcessMessageFinish(IMessage replyMsg, bool bCliSide, bool bAsync);

	void ProcessMessageStart(IMessage reqMsg, bool bCliSide, bool bAsync);
}
