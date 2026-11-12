using System;
using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70021MaoYan;

public class Skill_NormalADS : SkillAdvancedBase
{
	private string actionKey_1 = "N_ADS_Aim";

	private string actionKey_2 = "N_ADS_Fire";

	private string actionKey_3 = "N_ADS_Stand";

	private FP loopTime_1 = 2;

	private string evt_BeginTurn = "TurnAround01";

	private string evt_EndTurn = "StopTrun01";

	private FP time_turn = 2;

	private FP spd_turn = 75;

	private CoroutineNode corMain;

	private LookAtTarget _lookAtTarget = new LookAtTarget();

	private AimTarget _aimTarget = new AimTarget();

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	private void Clear()
	{
		StopCoroutine(ref corMain);
		_aimTarget.Clear();
		_lookAtTarget.Clear();
	}

	private void onFinish()
	{
		_skill?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		Skill_NormalADS skill_NormalADS = this;
		string actionTag = actionKey_1;
		Action<string> action = onCustomEvent;
		Action onInterrupt = onFinish;
		RequestComboAttack req = skill_NormalADS.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onInterrupt, action);
		yield return loopTime_1;
		_actor.CancelAttack();
		while (!req.isRecoveryBegin)
		{
			yield return null;
		}
		Skill_NormalADS skill_NormalADS2 = this;
		string actionTag2 = actionKey_2;
		onInterrupt = onFinish;
		req = skill_NormalADS2.BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, null, onInterrupt, null, null, fadeOutAnim: true);
		while (!req.isRecoveryBegin)
		{
			yield return null;
		}
		Skill_NormalADS skill_NormalADS3 = this;
		string actionTag3 = actionKey_3;
		onInterrupt = onFinish;
		Action onComboFinish = onFinish;
		skill_NormalADS3.BeginAttack(actionTag3, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, null, fadeOutAnim: true);
	}

	private void onCustomEvent(string eveName)
	{
		if (string.Equals(eveName, evt_BeginTurn))
		{
			LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
			_lookAtTarget.BeginLookAt(_actor, activedPlayerActor, time_turn, spd_turn, null);
		}
		else if (string.Equals(eveName, evt_EndTurn))
		{
			_lookAtTarget.StopLookAt();
		}
	}
}
