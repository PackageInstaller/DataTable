using Bamboo.ECS;

namespace ACT.Event;

public class SkillCountChangeEvt : BaseEventContent
{
	public Entity eb;

	public string countBindSkillName;

	public int preCount;

	public int nowCount;

	public int maxCount;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		eb = default;
		countBindSkillName = string.Empty;
		preCount = 0;
		nowCount = 0;
		maxCount = 0;
	}
}
