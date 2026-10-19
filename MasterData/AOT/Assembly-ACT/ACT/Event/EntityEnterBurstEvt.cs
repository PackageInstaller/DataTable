using Bamboo.ECS;

namespace ACT.Event;

public class EntityEnterBurstEvt : BaseEventContent
{
	public EntityId entityId;

	public int maxBurst;

	public int curBurst;

	public float curBurstPercentage;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entityId = default;
		maxBurst = (curBurst = 0);
		curBurstPercentage = 0f;
	}
}
