using GameFramework.Runtime;

namespace Ase;

public class GameNewsMessage : MessageBase
{
	public NewsTipMsgEnum MsgEnum;

	public object Arg;

	public GameNewsMessage(object sender, NewsTipMsgEnum msgEnum, object arg = null)
		: base(sender)
	{
		MsgEnum = msgEnum;
		Arg = arg;
	}
}
