using TrueSync;

namespace AIScript.Monster.Soldier._50571;

public class Action : SoldierSkillCycleActionBase
{
	protected override FP InitialStrengthOverride => 0;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		SetSuperArmorEnable(autoDisableWhenSkillDisable: false);
	}

	protected override SkillEntry[] BuildSkillCycle()
	{
		return new SkillEntry[6]
		{
			new SkillEntry(105057102, 5, 10),
			new SkillEntry(105057104, 8, 10),
			new SkillEntry(5057104, 10, 10),
			new SkillEntry(105057101, 10, 10),
			new SkillEntry(105057103, 30, 10),
			new SkillEntry(5057118, 10, 10)
		};
	}
}
