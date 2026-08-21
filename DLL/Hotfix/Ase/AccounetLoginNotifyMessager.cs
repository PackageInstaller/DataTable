using GameFramework.Runtime;

namespace Ase;

public class AccounetLoginNotifyMessager : MessageBase
{
	public int LoginType;

	public AccounetLoginNotifyMessager(object sender, int logintype)
		: base(sender)
	{
		LoginType = logintype;
	}
}
