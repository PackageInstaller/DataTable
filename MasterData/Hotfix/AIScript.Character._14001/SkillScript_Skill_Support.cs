using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14001;

public class SkillScript_Skill_Support : SkillAdvancedBase
{
	private int _loopTimes;

	private int _launchMissileTimes;

	private TSVector2 _targetPosition;

	private bool _hasTriggerPerkLogic_P22;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_loopTimes = 0;
		_launchMissileTimes = 0;
		_actor.actorSearchTargetInfo.AddSearchRange(Config_Support.addSearchRange_Skill, ActorSearchTarget.SearchType.allRange);
		_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		_targetPosition = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position);
		_hasTriggerPerkLogic_P22 = false;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514022, out var perkLevel) && _actor.isHide)
		{
			_actor.Visible();
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514026, out perkLevel))
		{
			_actor.buffComponent.AddBuff(14026011, _actor);
		}
		DefaultLookAt();
	}

	public void OnStart()
	{
		string text = "140_Support_Skill_Fireworks";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514021, out var perkLevel))
		{
			if (CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.SE))
			{
				text = (CommonUtils.HavePersonalPerk(_actor.dataID, 514025, out perkLevel) ? "140_Support_Skill_Fireworks_P25P21" : "140_Support_Skill_Fireworks_P21");
			}
			else if (CommonUtils.HavePersonalPerk(_actor.dataID, 514025, out perkLevel))
			{
				text = "140_Support_Skill_Fireworks_P25";
			}
		}
		else if (CommonUtils.HavePersonalPerk(_actor.dataID, 514025, out perkLevel))
		{
			text = "140_Support_Skill_Fireworks_P25";
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboLoop = OnComboLoop;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
	}

	private void OnCustomEvent(string eventName)
	{
		int perkLevel;
		if (string.Equals(eventName, "140_Support_Shoot"))
		{
			if (_launchMissileTimes % 5 == 0)
			{
				_targetPosition = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position);
				DefaultLookAt();
			}
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.eventHashCode = Config_Support.eventHashCode_SkillTriggerLaunchMissile;
			AdventureActorCustomEvent adventureActorCustomEvent2 = adventureActorCustomEvent;
			if (adventureActorCustomEvent2.tsVector2ParamList == null)
			{
				adventureActorCustomEvent2.tsVector2ParamList = new List<TSVector2>();
			}
			adventureActorCustomEvent.tsVector2ParamList.Clear();
			adventureActorCustomEvent.tsVector2ParamList.Add(_targetPosition);
			_actor.DispatchEvent(adventureActorCustomEvent);
			_launchMissileTimes++;
		}
		else if (string.Equals(eventName, "140_P22_Rage"))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514022, out perkLevel))
			{
				_actor.buffComponent.AddBuff(14022011, _actor);
			}
		}
		else if (string.Equals(eventName, "140_P25") && CommonUtils.HavePersonalPerk(_actor.dataID, 514025, out perkLevel))
		{
			AdventureActorCustomEvent adventureActorCustomEvent3 = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent3.sender = _actor;
			adventureActorCustomEvent3.eventHashCode = Config_Support.eventHashCode_TriggerPerkLogic_P25;
			_actor.DispatchEvent(adventureActorCustomEvent3);
		}
	}

	private void OnComboLoop()
	{
		_loopTimes++;
		if (_loopTimes >= 13)
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514022, out var _))
			{
				Action<string> onCustomEvent = OnCustomEvent_P22;
				Action onComboFinish = OnFinish;
				Action onInterrupt = OnInterrupt;
				BeginAttack("140_Support_Skill_Fireworks_P22_Rush", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
			}
			else
			{
				comboAttack.CancelAttack();
			}
		}
	}

	private void OnCustomEvent_P22(string eventName)
	{
		if (string.Equals(eventName, "140_P22_Rush"))
		{
			_actor.Hide(performanceMode: true);
			TryTriggerPerkLogic_P22();
		}
	}

	private void TryTriggerPerkLogic_P22()
	{
		if (!_hasTriggerPerkLogic_P22)
		{
			_hasTriggerPerkLogic_P22 = true;
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(14022011);
			_actor.buffComponent.AddBuffNum(14022012, buffNumByID, _actor);
			_actor.buffComponent.RemoveBuffByBuffId(14022011);
			ILRuntimeAPI.ShootByDirection("Bullet_140_Support_Skill_P22_Rush", _actor, default, _actor.tsTransform.Forward, _actor.tsTransform.Position);
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
		_actor.actorSearchTargetInfo.AddSearchRange(-Config_Support.addSearchRange_Skill, ActorSearchTarget.SearchType.allRange);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514022, out var perkLevel))
		{
			TryTriggerPerkLogic_P22();
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514030, out perkLevel))
		{
			_actor.buffComponent.AddBuff(14030011, _actor);
		}
	}
}
