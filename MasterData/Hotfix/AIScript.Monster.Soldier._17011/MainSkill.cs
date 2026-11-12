using System;
using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Soldier._17011;

public class MainSkill : SkillAdvancedBase
{
	private const string actionKey = "Skill";

	private static readonly FP buffDelaySec = 0.25;

	private const int selfBuffId = 250102201;

	private bool _aborted;

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
		_actor.StartLogicCoroutine(AddSelfBuffAfterDelay());
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private IEnumerator AddSelfBuffAfterDelay()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(buffDelaySec));
		if (!_aborted)
		{
			_actor.buffComponent?.AddBuff(250102201, _actor);
		}
	}
}
