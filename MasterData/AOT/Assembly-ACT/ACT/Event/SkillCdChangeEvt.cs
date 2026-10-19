using Bamboo.ECS;

namespace ACT.Event;

public class SkillCdChangeEvt : BaseEventContent
{
	public Entity eb;

	public string cdName;

	public int nowCount;

	public int maxCount;

	public float nowCd;

	public float configCd;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		eb = default;
		cdName = string.Empty;
		nowCount = 0;
		maxCount = 0;
		nowCd = 0f;
		configCd = 0f;
	}
}
