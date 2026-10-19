using ACT.Battle;
using ACT.Event;
using Bamboo.ECS;

namespace ACT.UI;

public class OperateBtnBindSkillInfo
{
	public EntityId EntityId { get; }

	public string MotionName { get; }

	public string belongSkillName { get; }

	public int CurSkillCount { get; private set; }

	public int MaxCount { get; private set; }

	public float CurSkilllCd { get; set; }

	public float ConfigCd { get; private set; }

	public OperateBtnBindSkillInfo(EntityId entityId, string motionName, Skill skill)
	{
		EntityId = entityId;
		MotionName = motionName;
		belongSkillName = skill?.Name ?? string.Empty;
		CurSkillCount = skill?.NowCount ?? 0;
		MaxCount = skill?.MaxCount ?? 0;
		CurSkilllCd = skill?.NowCd ?? 0f;
		ConfigCd = skill?.config.CD ?? 0f;
	}

	public void UpdateCd(SkillCdChangeEvt skillCdChangeEvt)
	{
		if (skillCdChangeEvt.eb.GetCompCharacter() != null && !(EntityId != skillCdChangeEvt.eb.Id) && !(belongSkillName != skillCdChangeEvt.cdName))
		{
			CurSkillCount = skillCdChangeEvt.nowCount;
			MaxCount = skillCdChangeEvt.maxCount;
			CurSkilllCd = skillCdChangeEvt.nowCd;
			ConfigCd = skillCdChangeEvt.configCd;
		}
	}

	public void UpdateCount(SkillCountChangeEvt skillCountChangeEvt)
	{
		if (!(EntityId != skillCountChangeEvt.eb.Id) && !(belongSkillName != skillCountChangeEvt.countBindSkillName))
		{
			CurSkillCount = skillCountChangeEvt.nowCount;
			MaxCount = skillCountChangeEvt.maxCount;
		}
	}
}
