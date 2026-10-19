using Bamboo.ECS;

namespace ACT.Event;

public class MotionIntParamChangeEvt : BaseEventContent
{
	public Entity entity;

	public string name;

	public int value;

	public override void ReleaseEvt()
	{
		name = string.Empty;
		value = 0;
		base.ReleaseEvt();
	}
}
