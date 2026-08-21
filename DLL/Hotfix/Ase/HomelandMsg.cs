using GameFramework.Runtime;

namespace Ase;

public class HomelandMsg : MessageBase
{
	private HomelandMsgType type;

	private object arg;

	public HomelandMsgType Type => type;

	public object Arg => arg;

	public HomelandMsg(object sender, HomelandMsgType type, object arg = null)
		: base(sender)
	{
		this.type = type;
		this.arg = arg;
	}
}
