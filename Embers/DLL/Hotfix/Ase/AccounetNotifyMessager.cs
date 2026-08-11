using GameFramework.Runtime;

namespace Ase;

public class AccounetNotifyMessager : MessageBase
{
	public bool IsLogin;

	public int DisconnectReason;

	public AccounetNotifyMessager(object sender, bool isLogin, int disconnectReason)
		: base(sender)
	{
		IsLogin = isLogin;
		DisconnectReason = disconnectReason;
	}
}
