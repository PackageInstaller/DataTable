using System;
using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Soldier._17001;

public class MainSkill : SkillAdvancedBase
{
	private const string actionKey = "Skill";

	private const int buffId_Self = 250102102;

	private static readonly FP buffDelayTime = 0.5;

	private CoroutineNode corBuff;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corBuff);
	}

	public void OnStart()
	{
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		StartCoroutine(ref corBuff, DelayAddBuff());
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

	private IEnumerator DelayAddBuff()
	{
		yield return _actor.WaitTime(buffDelayTime);
		_actor.buffComponent.AddBuff(250102102, _actor);
	}
}
