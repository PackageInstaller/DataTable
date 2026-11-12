using System;
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12001;

public class SkillScript_MainControl : SkillAdvancedBase
{
	private const string bullet = "Bullet_12001_B1_Skill_Garland_Near";

	private const string bullet_07 = "Bullet_12001_B1P7_Skill_Garland_BigNear";

	private Dictionary<int, string> dicSkillTag = new Dictionary<int, string> { [0] = "120_B1" };

	private readonly string event_021 = "120_B1P1";

	private CoroutineNode corMain;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		Parallel.mainSkill = true;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		Parallel.mainSkill = false;
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	protected void onFinishOrInterrupt()
	{
		_skill.Clear();
	}

	protected void OnCustomEvent(string evt)
	{
		if (!evt.Equals(event_021))
		{
			return;
		}
		if (GetPerk(512001))
		{
			if (GetPerk(512007))
			{
				ILRuntimeAPI.ShootRotateWepon("Bullet_12001_B1P7_Skill_Garland_BigNear", _actor, null, _actor.tsTransform.Forward);
				ILRuntimeAPI.ShootRotateWepon("Bullet_12001_B1P7_Skill_Garland_BigMid", _actor, null, _actor.tsTransform.Forward);
			}
			else
			{
				ILRuntimeAPI.ShootRotateWepon("Bullet_12001_B1_Skill_Garland_Near", _actor, null, _actor.tsTransform.Forward);
				ILRuntimeAPI.ShootRotateWepon("Bullet_12001_B1_Skill_Garland_Mid", _actor, null, _actor.tsTransform.Forward);
			}
		}
		else if (GetPerk(512007))
		{
			ILRuntimeAPI.ShootRotateWepon("Bullet_12001_B1P7_Skill_Garland_BigNear", _actor, null, _actor.tsTransform.Forward);
		}
		else
		{
			ILRuntimeAPI.ShootRotateWepon("Bullet_12001_B1_Skill_Garland_Near", _actor, null, _actor.tsTransform.Forward);
		}
	}

	protected virtual void OnRecoveryBegin()
	{
	}

	protected virtual void OnAnticipationEnd()
	{
	}

	private IEnumerator DoMainLogic()
	{
		int key = 0;
		SkillScript_MainControl skillScript_MainControl = this;
		string actionTag = dicSkillTag.get_Item(key);
		System.Action onComboFinish = onFinishOrInterrupt;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onInterrupt = onFinishOrInterrupt;
		System.Action onAnticipationEnd = OnAnticipationEnd;
		System.Action onRecoveryBegin = OnRecoveryBegin;
		skillScript_MainControl.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent);
		yield return null;
	}

	public void OnUpdate()
	{
		LockDirection();
	}
}
