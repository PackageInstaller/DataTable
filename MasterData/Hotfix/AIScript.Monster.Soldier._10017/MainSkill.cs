using System;

namespace AIScript.Monster.Soldier._10017;

public class MainSkill : SkillAdvancedBase
{
	private const string actionKey = "Skill";

	private const int goldItemId = 40;

	private const int goldCount_base = 1;

	private const int goldCount_3Star = 3;

	private int _potentialLv = 1;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
	}

	private void DoMainLogic()
	{
		GrantGold();
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private void GrantGold()
	{
		int itemCount = ((_potentialLv < 3) ? 1 : 3);
		(ModuleController<AdventureModuleController>.Instance?.levelInstance as SoldierLevelController)?.AddItem(40, itemCount);
	}
}
