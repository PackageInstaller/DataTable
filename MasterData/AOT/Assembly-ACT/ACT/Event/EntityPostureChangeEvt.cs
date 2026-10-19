using Bamboo.ECS;

namespace ACT.Event;

public class EntityPostureChangeEvt : BaseEventContent
{
	public EntityId entityId;

	public int maxPosture;

	public int oldPosture;

	public int curPosture;

	public float curPosturePercentage;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entityId = default;
		maxPosture = (oldPosture = (curPosture = 0));
		curPosturePercentage = 0f;
	}
}
