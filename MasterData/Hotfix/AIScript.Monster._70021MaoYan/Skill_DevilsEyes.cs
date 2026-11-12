using System;
using System.Collections;
using TrueSync;

namespace AIScript.Monster._70021MaoYan;

public class Skill_DevilsEyes : SkillAdvancedBase
{
	private string actionKey = "DevilsEyes";

	private FP loopTimeA = 0.5;

	private FP loopTimeB = 3;

	private CoroutineNode corMain;

	private bool isHurt;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		isHurt = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	private void Clear()
	{
		StopCoroutine(ref corMain);
	}

	private void onFinish()
	{
		_skill?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		isHurt = false;
		FP lastTime = loopTimeA;
		while (lastTime > 0 && !isHurt)
		{
			lastTime -= _actor.LogicDeltaTime;
			yield return null;
		}
		if (!isHurt)
		{
			_skill.Clear();
			yield break;
		}
		Skill_DevilsEyes skill_DevilsEyes = this;
		string actionTag = actionKey;
		Action onInterrupt = onFinish;
		Action onComboFinish = onFinish;
		skill_DevilsEyes.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		yield return loopTimeB;
		_actor.CancelAttack();
	}

	protected override void OnReceiveDamage(IEvent evt)
	{
		base.OnReceiveDamage(evt);
		if ((evt as AdventureActorReceiveDamageEvent).to == _actor)
		{
			isHurt = true;
		}
	}
}
