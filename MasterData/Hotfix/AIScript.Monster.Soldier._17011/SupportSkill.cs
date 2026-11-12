using System;
using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Soldier._17011;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "Support";

	private const string actionKey_Ex = "Support";

	private static readonly FP loopDurationSec_base = 0.6;

	private static readonly FP loopDurationSec_Ex = 1.3;

	private int _potentialLv = 1;

	private bool _aborted;

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
		_actor.CancelAiming();
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
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private void DoMainLogic()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		string actionTag = ((_potentialLv >= 2) ? "Support" : "Support");
		LogicEntity attackTarget = _actor.attackTarget;
		Action onAnticipationEnd = OnLoopBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, attackTarget, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	private void OnLoopBegin()
	{
		_actor.StartLogicCoroutine(StopLoopAfterDelay());
	}

	private IEnumerator StopLoopAfterDelay()
	{
		FP seconds = ((_potentialLv >= 2) ? loopDurationSec_Ex : loopDurationSec_base);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(seconds));
		if (!_aborted)
		{
			comboAttack?.CancelAttack();
		}
	}
}
