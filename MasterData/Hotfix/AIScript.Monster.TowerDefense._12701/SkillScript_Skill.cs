using System;
using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.TowerDefense._12701;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string key = "Skill";

	private string evt_water = "127WaterArea";

	private FP loopTime = 10;

	private int perkId_3 = 1270103;

	private FP leftTime_3 = 5;

	private int castAreaEvent = CommonHelper.StringToHash("CastArea");

	private CoroutineNode corMain;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
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
		string actionTag = key;
		SkillScript_Skill skillScript_Skill = this;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = SkillFinish;
		System.Action onInterrupt = SkillInterrupt;
		skillScript_Skill.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
		yield return _actor.WaitTime(GetPerk(perkId_3) ? (loopTime + leftTime_3) : loopTime);
		_actor.CancelAttack();
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_water))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = castAreaEvent;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}
}
