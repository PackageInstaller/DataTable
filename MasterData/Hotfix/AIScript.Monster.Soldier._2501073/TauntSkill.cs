using System;
using System.Collections.Generic;

namespace AIScript.Monster.Soldier._2501073;

public class TauntSkill : SkillAdvancedBase
{
	private const string comboTag = "Spawn";

	private const int buffId_Taunt = 260113411;

	private readonly List<SoldierActor> _targetSoldierActors = new List<SoldierActor>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_targetSoldierActors.Clear();
	}

	public void OnStart()
	{
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Spawn", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		if (!(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return;
		}
		soldierLevelController.GetBattleActors(_actor.attackTarget as SoldierActor, _targetSoldierActors);
		List<SoldierActor> targetSoldierActors = _targetSoldierActors;
		if (targetSoldierActors == null || targetSoldierActors.Count <= 0)
		{
			return;
		}
		foreach (SoldierActor targetSoldierActor in _targetSoldierActors)
		{
			targetSoldierActor.buffComponent.AddBuff(260113411, _actor);
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_targetSoldierActors.Clear();
	}
}
