using System;
using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15501;

public class SkillScript_Support : SkillAdvancedBase
{
	private string key_base = "155_Support_Skill_4Times";

	private string key_P28 = "155_Support_Skill_6Times";

	private string key_Dash = "155_Support_Skill_End";

	private string evt_shoot1 = "Surf_1";

	private string evt_shoot2 = "Surf_2";

	private string evt_shoot3 = "Surf_3";

	private string evt_shoot4 = "Surf_4";

	private string evt_shoot5 = "Surf_5";

	private string evt_shoot6 = "Surf_6";

	private string evt_End = "Surf_End";

	private FP radius_enter = 2f;

	private int shootEvt = CommonHelper.StringToHash("shootEvt");

	private string runEffect = "fx_15501_Loop_run";

	private string runEffect1 = "fx_15501_Loop_run02";

	private const int perkId_28 = 515523;

	private CoroutineNode corMain;

	private bool bEnd;

	private PlayFX playFX_Run = new PlayFX();

	private PlayFX playFX_Run1 = new PlayFX();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		bEnd = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(corMain);
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		_actor.Hide();
		string actionTag = (GetPerk(515523) ? key_P28 : key_base);
		SkillScript_Support skillScript_Support = this;
		Action<string> action = onCustomEvent;
		skillScript_Support.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, null, action);
		while (!bEnd)
		{
			yield return null;
		}
		PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		TSVector2 tSVector = TrueSyncExtensions.RandomPointInsideRing(activedPlayerActor.tsTransform.Position, radius_enter, radius_enter);
		TSVector2 normalized = (activedPlayerActor.tsTransform.Position - tSVector).normalized;
		_actor.LookAtDir(normalized, 0);
		SkillScript_Support skillScript_Support2 = this;
		string actionTag2 = key_Dash;
		System.Action onComboFinish = SkillFinish;
		System.Action onInterrupt = SkillInterrupt;
		RequestComboAttack req = skillScript_Support2.BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		while (!req.isAnticipationEnd)
		{
			yield return null;
		}
		_actor.Visible();
		playFX_Run.Play(_actor, runEffect, 1f, _actor.transform.position, _actor.transform.rotation);
		playFX_Run1.Play(_actor, runEffect1, 1f, _actor.transform.position, _actor.transform.rotation);
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_shoot1))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = shootEvt;
			adventureActorCustomEvent.intParam = 1;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
		else if (evt.Equals(evt_shoot2))
		{
			AdventureActorCustomEvent adventureActorCustomEvent2 = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent2.eventHashCode = shootEvt;
			adventureActorCustomEvent2.intParam = 2;
			_actor.DispatchEvent(adventureActorCustomEvent2);
		}
		else if (evt.Equals(evt_shoot3))
		{
			AdventureActorCustomEvent adventureActorCustomEvent3 = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent3.eventHashCode = shootEvt;
			adventureActorCustomEvent3.intParam = 3;
			_actor.DispatchEvent(adventureActorCustomEvent3);
		}
		else if (evt.Equals(evt_shoot4))
		{
			AdventureActorCustomEvent adventureActorCustomEvent4 = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent4.eventHashCode = shootEvt;
			adventureActorCustomEvent4.intParam = 4;
			_actor.DispatchEvent(adventureActorCustomEvent4);
		}
		else if (evt.Equals(evt_shoot5))
		{
			AdventureActorCustomEvent adventureActorCustomEvent5 = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent5.eventHashCode = shootEvt;
			adventureActorCustomEvent5.intParam = 5;
			_actor.DispatchEvent(adventureActorCustomEvent5);
		}
		else if (evt.Equals(evt_shoot6))
		{
			AdventureActorCustomEvent adventureActorCustomEvent6 = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent6.eventHashCode = shootEvt;
			adventureActorCustomEvent6.intParam = 4;
			_actor.DispatchEvent(adventureActorCustomEvent6);
		}
		else if (evt.Equals(evt_End))
		{
			bEnd = true;
		}
	}
}
