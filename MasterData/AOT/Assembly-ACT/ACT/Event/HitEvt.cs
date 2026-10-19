using ACT.Battle;
using Bamboo.ECS;

namespace ACT.Event;

public class HitEvt : BaseEventContent
{
	public Entity attacker;

	public Entity target;

	public AttackData AttackData;

	public override void ReleaseEvt()
	{
		AttackData = null;
	}
}
