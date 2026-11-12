using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16201;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private List<string> _comboTagList;

	private string _comboTag;

	private bool _isExtra;

	private bool _isDashAttack;

	private bool _changeStage;

	private int _stage;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		InitData();
		if (_isExtra)
		{
			_actor.EnableSuperArmor();
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516210, out var _) && _isExtra)
		{
			_actor.buffComponent.AddBuff(16290001, _actor);
		}
	}

	private void InitData()
	{
		_isExtra = false;
		_isDashAttack = false;
		_changeStage = false;
		bool flag = CommonUtils.HavePersonalPerk(_actor.dataID, 516204, out var perkLevel);
		if (flag && _actor.buffComponent.HaveBuffNumMax(16204011))
		{
			_actor.buffComponent.RemoveBuffByBuffId(16204011);
			_comboTag = "Skill_Main_SuperZhong";
			_isExtra = true;
			return;
		}
		FP logicTagValue = _actor.logicVariable.GetLogicTagValue("LastDashNormalAttackFinishTime");
		if (_actor.LogicTime - logicTagValue > Config.triggerCD_Dash_NormalAttack && _actor.attackTarget != null && _actor.DistanceWithRadius(_actor.attackTarget) >= Config.useDistance_Dash_NormalAttack)
		{
			_comboTag = "162AtkDashQing";
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516203, out perkLevel))
			{
				_comboTag = "162AtkDashZhong";
			}
			_isDashAttack = true;
			return;
		}
		FP value = _actor.logicVariable.GetLogicTagValue("NormalAttackStage");
		logicTagValue = _actor.logicVariable.GetLogicTagValue("LastNormalAttackFinishTime");
		if (_actor.LogicTime - logicTagValue > Config.holdTime_NormalAttackStage)
		{
			value = 0;
		}
		_comboTagList = Config.comboTagList_NormalAttack;
		if (flag)
		{
			_comboTagList = Config_MainControl.comboTagList_NormalAttack_P4;
		}
		_stage = TSMath.Clamp(value, 0, _comboTagList.Count - 1).AsInt();
		_comboTag = _comboTagList.get_Item(_stage);
		_changeStage = true;
	}

	public void OnStart()
	{
		string comboTag = _comboTag;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(comboTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnAnticipationEnd()
	{
		if (_changeStage)
		{
			List<string> comboTagList = _comboTagList;
			if (comboTagList != null && comboTagList.Count > 0)
			{
				int num = _stage + 1;
				_actor.logicVariable.SetLogicTagValue("NormalAttackStage", (num < _comboTagList.Count) ? num : 0);
			}
		}
	}

	private void OnCustomEvent(string eventName)
	{
		int perkLevel;
		if (string.Equals(eventName, "162NrmAtkJianQI"))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = Config.eventHashCode_TriggerSowrdAura;
			adventureActorCustomEvent.intParam = 162100004;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
		else if (string.Equals(eventName, "162P2"))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516202, out perkLevel) && _isDashAttack)
			{
				AdventureActorCustomEvent adventureActorCustomEvent2 = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent2.sender = _actor;
				adventureActorCustomEvent2.actor = _actor;
				adventureActorCustomEvent2.eventHashCode = Config.eventHashCode_TriggerSowrdAura;
				adventureActorCustomEvent2.intParam = 162310009;
				_actor.DispatchEvent(adventureActorCustomEvent2);
			}
		}
		else if (string.Equals(eventName, "162P3"))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516203, out perkLevel) && _isDashAttack)
			{
				AdventureActorCustomEvent adventureActorCustomEvent3 = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent3.sender = _actor;
				adventureActorCustomEvent3.actor = _actor;
				adventureActorCustomEvent3.eventHashCode = Config_MainControl.eventHashCode_TriggerLightingSword;
				_actor.DispatchEvent(adventureActorCustomEvent3);
			}
		}
		else if (string.Equals(eventName, "162P8LeiDianArea") && CommonUtils.HavePersonalPerk(_actor.dataID, 516208, out perkLevel) && _isExtra)
		{
			TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * Config_MainControl.generateOffset_P8.x + _actor.tsTransform.Forward * Config_MainControl.generateOffset_P8.y;
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_162_LeiDianArea_P8", position);
		}
	}

	public void OnUpdate()
	{
		LockDirection();
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
		_actor.logicVariable.SetLogicTagValue("LastNormalAttackFinishTime", _actor.LogicTime);
		if (_isDashAttack)
		{
			_actor.logicVariable.SetLogicTagValue("LastDashNormalAttackFinishTime", _actor.LogicTime);
		}
		if (_isExtra)
		{
			_actor.DisableSuperArmor();
		}
		_comboTag = null;
		_isExtra = false;
		_isDashAttack = false;
		_changeStage = false;
		_stage = 0;
	}
}
