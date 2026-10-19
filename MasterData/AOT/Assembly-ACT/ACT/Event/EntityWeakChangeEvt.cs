using Bamboo.ECS;

namespace ACT.Event;

public class EntityWeakChangeEvt : BaseEventContent
{
	public EntityId entityId;

	public float weakPercentage;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entityId = default;
		weakPercentage = 0f;
	}
}
