using ACT.Battle;

namespace ACT.Event;

public class OnKillEntity : BaseEventContent
{
	public AttackData attackData;

	public int beforeKillHp;

	public int maxHp;

	public override void ReleaseEvt()
	{
		beforeKillHp = 0;
		maxHp = 0;
		attackData = null;
	}
}
