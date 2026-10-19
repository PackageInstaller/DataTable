using ACT.Battle;

namespace ACT.Event;

public class DamageEvt : BaseEventContent
{
	public AttackData AttackData;

	public override void ReleaseEvt()
	{
		AttackData = null;
	}
}
