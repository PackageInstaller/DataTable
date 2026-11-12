using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Soldier._90001;

public class MainSkill : SkillAdvancedBase
{
	private const string actionKey = "Skill";

	private static readonly FP healDelaySec = 0.7;

	private const int healBuffId = 250103901;

	private bool _aborted;

	private readonly List<SoldierActor> _allyBuffer = new List<SoldierActor>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_aborted = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_aborted = true;
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
		_aborted = true;
		OnFinish();
	}

	public void OnUpdate()
	{
	}

	private void DoMainLogic()
	{
		_actor.StartLogicCoroutine(HealRandomAllyAfterDelay());
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private IEnumerator HealRandomAllyAfterDelay()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(healDelaySec));
		if (!_aborted)
		{
			HealRandomAlly();
		}
	}

	private void HealRandomAlly()
	{
		SoldierLevelController soldierLevelController = ModuleController<AdventureModuleController>.Instance?.levelInstance as SoldierLevelController;
		if (!(soldierLevelController == null))
		{
			soldierLevelController.GetBattleActors(_actor, _allyBuffer);
			_allyBuffer.RemoveAll((SoldierActor a) => a == null || a.isDead);
			if (_allyBuffer.Count != 0)
			{
				_allyBuffer.get_Item(TSRandom.Range(0, _allyBuffer.Count)).buffComponent?.AddBuff(250103901, _actor);
			}
		}
	}
}
