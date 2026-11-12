using System;
using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13501;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private string key_1 = "135_Ultra_TL_T2";

	private string key_2 = "135_Ultra_NoTL_T2";

	private string key_1_F6 = "135_Ultra_TL_T2";

	private string key_2_F6 = "135_Ultra_NoTL_T2";

	private int buffId_fate6 = 13592011;

	private CoroutineNode corMain;

	private CoroutineNode corSupport;

	private string actionKey;

	private PlayTimeline _playTimeline = new PlayTimeline();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	public void OnStart()
	{
		if ((_actor as PlayerAdventureActor).isAssist)
		{
			DoSupportSkill();
		}
		else
		{
			DoMainSkill();
		}
	}

	protected void onFinishOrInterrupt()
	{
		_skill.Clear();
	}

	private void Clear()
	{
		_actor.DisableInvincible();
		StopCoroutine(ref corMain);
		StopCoroutine(ref corSupport);
	}

	private void DoMainSkill()
	{
		_playTimeline.Play(_actor, () =>
		{
			ParseKey(timeline: true);
			StartCoroutine(ref corMain, DoMainLogic());
		}, () =>
		{
			ParseKey(timeline: false);
			StartCoroutine(ref corMain, DoMainLogic());
		});
	}

	private void ParseKey(bool timeline)
	{
		actionKey = (timeline ? key_1 : key_2);
	}

	private IEnumerator DoMainLogic()
	{
		AddBuff();
		SkillScript_Ultra skillScript_Ultra = this;
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = onFinishOrInterrupt;
		System.Action onInterrupt = onFinishOrInterrupt;
		skillScript_Ultra.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
		yield break;
	}

	private void DoSupportSkill()
	{
		_playTimeline.Play(_actor, () =>
		{
			ParseKey(timeline: true);
			StartCoroutine(ref corSupport, DoSupportLogic());
		}, () =>
		{
			ParseKey(timeline: false);
			StartCoroutine(ref corSupport, DoSupportLogic());
		});
	}

	private IEnumerator DoSupportLogic()
	{
		AddBuff();
		SkillScript_Ultra skillScript_Ultra = this;
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		System.Action onInterrupt = onFinishOrInterrupt;
		System.Action onComboFinish = onFinishOrInterrupt;
		skillScript_Ultra.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
		yield break;
	}

	private void AddBuff()
	{
	}

	private void onCustomEvent(string eventName)
	{
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
