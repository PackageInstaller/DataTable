using Bamboo.ECS;

namespace ACT.Event;

public class EntityBurstChangeEvt : BaseEventContent
{
	public EntityId entityId;

	public int maxBurst;

	public int oldBurst;

	public int curBurst;

	public float curBurstPercentage;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entityId = default;
		maxBurst = (oldBurst = (curBurst = 0));
		curBurstPercentage = 0f;
	}
}
