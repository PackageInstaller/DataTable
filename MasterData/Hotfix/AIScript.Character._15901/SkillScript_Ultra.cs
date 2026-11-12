using System;
using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15901;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private const string actionKey1 = "159_Ultra_TL";

	private const string actionKey2 = "159_Ultra_NoTL";

	private string evt_shoot = "shoot";

	private CoroutineNode corMain;

	private string actionKey;

	private PlayTimeline _playTimeline = new PlayTimeline();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		_actor.EnableCloseBlock();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.DisableInvincible();
		_actor.DisableCloseBlock();
		StopCoroutine(ref corMain);
	}

	public void OnStart()
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("UICloseEvent", a1: false);
		_playTimeline.Play(_actor, () =>
		{
			actionKey = "159_Ultra_TL";
			MonoSingleton<LuaManager>.Instance.FireEvent("UICloseEvent", a1: true);
			StartCoroutine(ref corMain, DoMainLogic(hasTimeline: true));
		}, () =>
		{
			actionKey = "159_Ultra_NoTL";
			MonoSingleton<LuaManager>.Instance.FireEvent("UICloseEvent", a1: true);
			StartCoroutine(ref corMain, DoMainLogic(hasTimeline: false));
		});
	}

	private IEnumerator DoMainLogic(bool hasTimeline)
	{
		SkillScript_Ultra skillScript_Ultra = this;
		string actionTag = actionKey;
		LogicEntity attackTarget = _actor.attackTarget;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = OnFinishOrInterrupt;
		System.Action onInterrupt = OnFinishOrInterrupt;
		skillScript_Ultra.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: true, attackTarget, null, default, null, null, onComboFinish, onInterrupt, action);
		yield return null;
	}

	private void OnFinishOrInterrupt()
	{
		_skill?.Clear();
	}

	private void onCustomEvent(string evt)
	{
	}
}
