using Bamboo.ECS;

namespace ACT.Event;

public class EntityExitBurstEvt : BaseEventContent
{
	public EntityId entityId;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entityId = default;
	}
}
