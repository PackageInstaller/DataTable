using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14201;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private string key_1 = "Ultra_TimelineOn";

	private string key_2 = "Ultra_TimelineOff";

	private string key_1_T1 = "Ultra_TimelineOn_T1";

	private string key_2_T1 = "Ultra_TimelineOff_T1";

	private string evt_castArea = "142UltraBoom";

	private CoroutineNode corMain;

	private CoroutineNode corSupport;

	private string actionKey;

	private PlayTimeline _playTimeline = new PlayTimeline();

	private int ultraEvent = CommonHelper.StringToHash("UltraAreaEffect");

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.DisableInvincible();
		StopCoroutine(ref corMain);
		StopCoroutine(ref corSupport);
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

	private IEnumerator DoMainLogic()
	{
		SkillScript_Ultra skillScript_Ultra = this;
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = onFinishOrInterrupt;
		System.Action onInterrupt = onFinishOrInterrupt;
		skillScript_Ultra.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, action);
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
		LogicEntity assistantAttackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
		SkillScript_Ultra skillScript_Ultra = this;
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		System.Action onInterrupt = onFinishOrInterrupt;
		System.Action onComboFinish = onFinishOrInterrupt;
		skillScript_Ultra.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, assistantAttackTarget, null, default, null, null, onComboFinish, onInterrupt, action);
		yield break;
	}

	private void ParseKey(bool timeline)
	{
		actionKey = (timeline ? key_1 : key_2);
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_castArea))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = ultraEvent;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
