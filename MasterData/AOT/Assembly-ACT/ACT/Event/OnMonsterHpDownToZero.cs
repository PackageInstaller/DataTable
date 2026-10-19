using Bamboo.ECS;

namespace ACT.Event;

public class OnMonsterHpDownToZero : BaseEventContent
{
	public bool lastOnHitDirIsLeft;

	public Entity attacker;

	public Entity attackee;

	public override void ReleaseEvt()
	{
		lastOnHitDirIsLeft = false;
		attacker = default;
	}
}
