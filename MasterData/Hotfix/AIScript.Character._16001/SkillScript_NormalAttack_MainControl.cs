#define LOG_ERROR
using System;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._16001;

public class SkillScript_NormalAttack_MainControl : SkillAdvancedBase
{
	private int _stage;

	private List<string> _curComboTagList;

	private string _comboTag;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		InitData();
	}

	private void InitData()
	{
		_stage = _actor.logicVariable.GetLogicTagValue("NormalAttackStage").AsInt();
		int perkLevel;
		if (((PlayerAdventureActor)_actor).status != ActorStatus.Default)
		{
			_curComboTagList = Config_MainControl.comboTagList_NormalAttack_Megaphone;
		}
		else if (CommonUtils.HavePersonalPerk(_actor.dataID, 516007, out perkLevel))
		{
			_curComboTagList = Config_MainControl.comboTagList_NormalAttack_BubbleGun_P7;
		}
		else
		{
			_curComboTagList = Config_MainControl.comboTagList_NormalAttack_BubbleGun;
		}
		_stage = TSMath.Clamp(_stage, 0, _curComboTagList.Count - 1).AsInt();
		_comboTag = _curComboTagList.get_Item(_stage);
	}

	public void OnStart()
	{
		if (string.IsNullOrEmpty(_comboTag))
		{
			NovaLogger.Error($"该普攻段数未配置,普攻段数:{_stage}");
			OnFinish();
			return;
		}
		string comboTag = _comboTag;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(comboTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnAnticipationEnd()
	{
		int num = _stage + 1;
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", (num < _curComboTagList.Count) ? num : 0);
	}

	public void OnUpdate()
	{
		LockDirection();
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "160_AddEnergy"))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = Config.eventHashCode_AddDecibel;
			adventureActorCustomEvent.intParam = 3;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
		else if (string.Equals(eventName, "160_AddEnergy_Final"))
		{
			AdventureActorCustomEvent adventureActorCustomEvent2 = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent2.sender = _actor;
			adventureActorCustomEvent2.actor = _actor;
			adventureActorCustomEvent2.eventHashCode = Config.eventHashCode_AddDecibel;
			adventureActorCustomEvent2.intParam = 4;
			_actor.DispatchEvent(adventureActorCustomEvent2);
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_stage = 0;
		_comboTag = null;
	}
}
