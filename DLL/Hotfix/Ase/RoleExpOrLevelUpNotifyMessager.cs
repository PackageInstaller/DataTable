using GameFramework.Runtime;

namespace Ase;

public class RoleExpOrLevelUpNotifyMessager : MessageBase
{
	public enum RoleExpLevelMsgEnum
	{
		OnlyExpUp,
		LevelUp
	}

	public RoleExpLevelMsgEnum MessageEnum;

	public int Level;

	public long Exp;

	public RoleExpOrLevelUpNotifyMessager(object sender)
		: base(sender)
	{
	}
}
