using System;
using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Soldier._15001;

public class MainSkill : SkillAdvancedBase
{
	private const string actionKey = "Skill";

	private const int buffId = 250102501;

	private static readonly FP buffDelay = 0.1;

	private CoroutineNode corMain;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		_actor.CancelAiming();
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

	private IEnumerator DoMainLogic()
	{
		MainSkill mainSkill = this;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		mainSkill.BeginAttack("Skill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		yield return _actor.WaitTime(buffDelay);
		_actor.buffComponent.AddBuff(250102501, _actor);
	}
}
