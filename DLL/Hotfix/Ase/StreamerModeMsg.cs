using GameFramework.Runtime;

namespace Ase;

public class StreamerModeMsg : MessageBase
{
	public object Args;

	public StreamerModeMsg(object sender, object args = null)
		: base(sender)
	{
		base.Sender = sender;
		Args = args;
	}
}
