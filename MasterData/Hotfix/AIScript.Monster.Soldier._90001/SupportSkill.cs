using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Soldier._90001;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "Support";

	private static readonly FP supportDelaySec = 0.7;

	private const int buffId_base = 250103902;

	private const int buffId_2Star = 250103903;

	private const int buffId_3Star = 250103904;

	private const int buffId_3Star_2 = 250103905;

	private int _potentialLv = 1;

	private bool _aborted;

	private readonly List<SoldierActor> _allyBuffer = new List<SoldierActor>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_aborted = false;
		_potentialLv = (_actor as SoldierActor).GetPotentialLv();
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
		if (soldierLevelController == null)
		{
			return;
		}
		soldierLevelController.GetBattleActors(_actor, _allyBuffer);
		_allyBuffer.RemoveAll((SoldierActor a) => a == null || a.isDead);
		if (_allyBuffer.Count != 0)
		{
			SoldierActor soldierActor = _allyBuffer.get_Item(TSRandom.Range(0, _allyBuffer.Count));
			soldierActor.buffComponent?.AddBuff(GetBuffId(), _actor);
			if (_potentialLv >= 3)
			{
				soldierActor.buffComponent?.AddBuff(250103905, _actor);
			}
		}
	}

	private int GetBuffId()
	{
		if (_potentialLv >= 3)
		{
			return 250103904;
		}
		if (_potentialLv >= 2)
		{
			return 250103903;
		}
		return 250103902;
	}
}
