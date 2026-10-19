using Bamboo.ECS;

namespace ACT.Event;

public class AssistValChangeEvt : BaseEventContent
{
	public Entity eb;

	public float assistVal;

	public float assistMax;

	public float assistPercent;

	public float assistCost;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		eb = default;
		assistVal = 0f;
		assistMax = 0f;
		assistPercent = 0f;
		assistCost = 0f;
	}
}
