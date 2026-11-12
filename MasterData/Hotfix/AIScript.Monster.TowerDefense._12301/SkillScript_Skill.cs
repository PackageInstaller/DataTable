using System;
using System.Collections;
using TrueSync;

namespace AIScript.Monster.TowerDefense._12301;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string key = "Skill";

	private string evt_summon = "Summon";

	private int summonEvt = CommonHelper.StringToHash("summonEvt");

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
		yield break;
	}

	protected void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_summon))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.eventHashCode = summonEvt;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}
}
