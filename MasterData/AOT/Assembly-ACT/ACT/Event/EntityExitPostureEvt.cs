using Bamboo.ECS;

namespace ACT.Event;

public class EntityExitPostureEvt : BaseEventContent
{
	public EntityId entityId;

	public override void ReleaseEvt()
	{
		entityId = default;
	}
}
