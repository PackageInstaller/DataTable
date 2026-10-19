using Bamboo.ECS;

namespace ACT.Event;

public class EntityExitWeakEvt : BaseEventContent
{
	public EntityId entityId;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entityId = default;
	}
}
