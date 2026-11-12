public class SkillEventInfo
{
	public HotfixEnum.skillSlotType skillSlotType;

	public int skillId;

	public bool checkSkillInterval;

	public SkillEventInfo(HotfixEnum.skillSlotType skillSlotType, int skillId, bool checkSkillInterval = false)
	{
		this.skillSlotType = skillSlotType;
		this.skillId = skillId;
		this.checkSkillInterval = checkSkillInterval;
	}

	public void Clear()
	{
		skillSlotType = HotfixEnum.skillSlotType.NONE;
		skillId = 0;
		checkSkillInterval = false;
	}
}
