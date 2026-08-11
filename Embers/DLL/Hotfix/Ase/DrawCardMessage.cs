using GameFramework.Runtime;

namespace Ase;

public class DrawCardMessage : MessageBase
{
	public DrawCardMsgEnum MsgEnum;

	public object Arg;

	public DrawCardMessage(object sender, DrawCardMsgEnum msgEnum, object arg = null)
		: base(sender)
	{
		MsgEnum = msgEnum;
		Arg = arg;
	}
}
