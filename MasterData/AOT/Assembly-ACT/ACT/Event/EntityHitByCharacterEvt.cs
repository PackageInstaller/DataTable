using Bamboo.ECS;

namespace ACT.Event;

public class EntityHitByCharacterEvt : BaseEventContent
{
	public EntityId entityId;

	public int characterDamageType;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entityId = default;
		characterDamageType = 0;
	}
}
