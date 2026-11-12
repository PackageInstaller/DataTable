using TrueSync;

namespace AIScript.Monster.Soldier._50181.Water;

public class Action : SoldierSkillCycleActionBase
{
	protected override FP InitialStrengthOverride => 0;

	protected override SkillEntry[] BuildSkillCycle()
	{
		return new SkillEntry[3]
		{
			new SkillEntry(105018102, 30, 10),
			new SkillEntry(105018103, 30, 10),
			new SkillEntry(105018104, 30, 10)
		};
	}
}
