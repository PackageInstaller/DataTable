using System;
using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Soldier._17031;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "Support_1";

	private const string actionKey_2 = "Support_2";

	private const string actionKey_3 = "Support_3";

	private static readonly FP loopDuration = 2;

	private static readonly FP loopDuration_2 = 2;

	private static readonly FP loopDuration_3 = 2;

	private int PotentialLv = 1;

	private CoroutineNode corMain;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
		StopCoroutine(ref corMain);
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
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
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private IEnumerator DoMainLogic()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		string actionTag = GetActionKey();
		FP seconds = GetLoopDuration();
		SupportSkill supportSkill = this;
		LogicEntity attackTarget = _actor.attackTarget;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		supportSkill.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, attackTarget, default, null, null, onComboFinish, onInterrupt);
		yield return _actor.WaitTime(seconds);
		_actor.CancelAttack();
	}

	private string GetActionKey()
	{
		if (PotentialLv >= 3)
		{
			return "Support_3";
		}
		if (PotentialLv >= 2)
		{
			return "Support_2";
		}
		return "Support_1";
	}

	private FP GetLoopDuration()
	{
		if (PotentialLv >= 3)
		{
			return loopDuration_3;
		}
		if (PotentialLv >= 2)
		{
			return loopDuration_2;
		}
		return loopDuration;
	}
}
