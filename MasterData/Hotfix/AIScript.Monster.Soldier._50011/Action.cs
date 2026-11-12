namespace AIScript.Monster.Soldier._50011;

public class Action : SoldierSkillCycleActionBase
{
	protected override SkillEntry[] BuildSkillCycle()
	{
		return new SkillEntry[5]
		{
			new SkillEntry(105001101, 5, 10),
			new SkillEntry(105001103, 5, 10),
			new SkillEntry(105001104, 5, 360),
			new SkillEntry(105001101, 5, 10),
			new SkillEntry(105001102, 15, 10)
		};
	}
}
