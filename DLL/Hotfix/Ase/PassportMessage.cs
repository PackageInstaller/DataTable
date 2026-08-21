using GameFramework.Runtime;

namespace Ase;

public class PassportMessage : MessageBase
{
	public PassportMsgEnum MsgEnum;

	public object Arg;

	public PassportMessage(object sender, PassportMsgEnum msgEnum, object arg = null)
		: base(sender)
	{
		MsgEnum = msgEnum;
		Arg = arg;
	}
}
