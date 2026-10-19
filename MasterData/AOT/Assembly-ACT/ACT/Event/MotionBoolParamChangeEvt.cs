using Bamboo.ECS;

namespace ACT.Event;

public class MotionBoolParamChangeEvt : BaseEventContent
{
	public Entity entity;

	public string name;

	public bool value;

	public override void ReleaseEvt()
	{
		name = string.Empty;
		value = false;
		base.ReleaseEvt();
	}
}
