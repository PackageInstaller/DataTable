using System;
using System.Collections;
using TrueSync;

namespace AIScript.Monster.TowerDefense._12501;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string comboTag_Ultra = "Ultra_NoTL";

	private string eventName_EnterBerserk = "StartRage";

	private FP baseSkillTime = 16;

	private int enterBerserkEvt = CommonHelper.StringToHash("12501_EnterBerserk");

	private CoroutineNode corMain;

	public override FP BaseSkillTime => baseSkillTime;

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

	public void OnUpdate()
	{
	}

	private IEnumerator DoMainLogic()
	{
		SkillScript_Skill skillScript_Skill = this;
		string actionTag = comboTag_Ultra;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = SkillFinish;
		Action onInterrupt = SkillInterrupt;
		skillScript_Skill.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		yield break;
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventName_EnterBerserk))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = enterBerserkEvt;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}
}
