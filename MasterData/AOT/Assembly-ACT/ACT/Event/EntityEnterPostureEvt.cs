using Bamboo.ECS;

namespace ACT.Event;

public class EntityEnterPostureEvt : BaseEventContent
{
	public EntityId entityId;

	public override void ReleaseEvt()
	{
		entityId = default;
	}
}
