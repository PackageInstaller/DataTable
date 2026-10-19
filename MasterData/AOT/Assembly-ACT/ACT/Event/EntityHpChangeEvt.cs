using ACT.Battle;
using Bamboo.ECS;

namespace ACT.Event;

public class EntityHpChangeEvt : BaseEventContent
{
	public EntityId entityId;

	public EntityType entityType;

	public int basicMaxHp;

	public int curMaxHp;

	public int oldHp;

	public int curHp;

	public float curHpPercentage;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entityType = EntityType.Null;
		entityId = default;
		basicMaxHp = (curMaxHp = (oldHp = (curHp = 0)));
		curHpPercentage = 0f;
	}
}
