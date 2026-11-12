using TrueSync;

namespace AIScript.Monster.Soldier._50581;

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
			new SkillEntry(105058101, 30, 10),
			new SkillEntry(5058101, 10, 10),
			new SkillEntry(5058105, 30, 10),
			new SkillEntry(105058102, 30, 10),
			new SkillEntry(5058106, 20, 10)
		};
	}
}
