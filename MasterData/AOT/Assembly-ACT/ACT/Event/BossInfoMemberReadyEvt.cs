using Bamboo.ECS;

namespace ACT.Event;

public class BossInfoMemberReadyEvt : BaseEventContent
{
	public EntityId entityId;

	public override void ReleaseEvt()
	{
		entityId = default;
	}
}
