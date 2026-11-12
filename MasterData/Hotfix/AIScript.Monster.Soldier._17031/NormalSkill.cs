using System;
using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Soldier._17031;

public class NormalSkill : SkillAdvancedBase
{
	private const string actionKey = "Attack";

	private static readonly FP loopDuration = 1.5;

	private CoroutineNode corMain;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
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
		NormalSkill normalSkill = this;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		normalSkill.BeginAttack("Attack", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		yield return _actor.WaitTime(loopDuration);
		_actor.CancelAttack();
	}
}
