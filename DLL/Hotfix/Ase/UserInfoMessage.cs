using GameFramework.Runtime;

namespace Ase;

public class UserInfoMessage : MessageBase
{
	public enum MsgTypeEnum
	{
		AccountDataRefreshByReLogin,
		UserBaseInfoChanged,
		SingleLoginMinutesChanged,
		ChargeDataChanged
	}

	public MsgTypeEnum MessageType;

	public object Args;

	public UserInfoMessage(object sender, MsgTypeEnum type, object args = null)
		: base(sender)
	{
		base.Sender = sender;
		MessageType = type;
		Args = args;
	}
}
