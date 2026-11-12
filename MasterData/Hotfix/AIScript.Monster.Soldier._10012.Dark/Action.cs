using TrueSync;

namespace AIScript.Monster.Soldier._10012.Dark;

public class Action : SoldierSkillCycleActionBase
{
	protected override FP InitialStrengthOverride => 0;

	protected override SkillEntry[] BuildSkillCycle()
	{
		return new SkillEntry[4]
		{
			new SkillEntry(101001201, 5, 10),
			new SkillEntry(101001202, 5, 10),
			new SkillEntry(101001203, 30, 10),
			new SkillEntry(101001204, 30, 10)
		};
	}
}
