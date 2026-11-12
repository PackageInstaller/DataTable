using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Soldier._10017;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "Support";

	private static readonly FP supportDelaySec = 1;

	private const int buffId = 250103801;

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
		_skill.Clear();
	}

	public void OnUpdate()
	{
	}

	private void DoMainLogic()
	{
		_actor.StartLogicCoroutine(AddBuffToRandomAllyAfterDelay());
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Support", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private IEnumerator AddBuffToRandomAllyAfterDelay()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(supportDelaySec));
		if (!_aborted)
		{
			AddBuffToRandomAlly();
		}
	}

	private void AddBuffToRandomAlly()
	{
		SoldierLevelController soldierLevelController = ModuleController<AdventureModuleController>.Instance?.levelInstance as SoldierLevelController;
		if (!(soldierLevelController == null))
		{
			soldierLevelController.GetBattleActors(_actor, _allyBuffer);
			_allyBuffer.RemoveAll((SoldierActor a) => a == null || a.isDead);
			if (_allyBuffer.Count != 0)
			{
				_allyBuffer.get_Item(TSRandom.Range(0, _allyBuffer.Count)).buffComponent?.AddBuff(250103801, _actor);
			}
		}
	}
}
