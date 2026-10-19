using Bamboo.ECS;

namespace ACT.Event;

public class EntityEnterWeakEvt : BaseEventContent
{
	public EntityId entityId;

	public float curWeakPercentage;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entityId = default;
		curWeakPercentage = 0f;
	}
}
