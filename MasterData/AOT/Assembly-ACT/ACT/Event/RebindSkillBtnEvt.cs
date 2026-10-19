using Bamboo.ECS;

namespace ACT.Event;

public class RebindSkillBtnEvt : BaseEventContent
{
	public Entity entity;

	public string motionName;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entity = default;
		motionName = string.Empty;
	}
}
