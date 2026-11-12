using TrueSync;

namespace AIScript.Monster.Soldier._50511;

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
		return new SkillEntry[5]
		{
			new SkillEntry(105051101, 5, 10),
			new SkillEntry(105051102, 5, 10),
			new SkillEntry(105051103, 30, 10),
			new SkillEntry(105051105, 30, 10),
			new SkillEntry(105051104, 30, 10)
		};
	}
}
