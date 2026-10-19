using Bamboo.ECS;

namespace ACT.Event;

public class FleeStateEndEvt : BaseEventContent
{
	public Entity fleeMonster;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		fleeMonster = default;
	}
}
