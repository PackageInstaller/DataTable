#define LOG_ERROR
using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14401;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private int _stage;

	private List<string> _curComboTagList;

	private string _comboTag;

	private bool _isLastStage;

	private bool _canLockTarget;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_stage = (int)(long)_actor.logicVariable.GetLogicTagValue("NormalAttackStage");
		if (_stage < 0)
		{
			NovaLogger.Error($"非法的普攻段数:{_stage}");
			OnFinish();
			return;
		}
		_curComboTagList = Config.comboTagList_NormalAttack;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514401, out var perkLevel) && _actor.buffComponent.CheckBuffByBuffID(14401011))
		{
			_curComboTagList = Config_MainControl.comboTagList_NormalAttack_P1;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514405, out perkLevel) && _actor.logicVariable.GetLogicTagToggle("TriggerPerk_P5"))
		{
			_stage = _curComboTagList.Count - 1;
			_actor.logicVariable.ToggleLogicTag("TriggerPerk_P5", value: false);
		}
		_comboTag = ((_stage < _curComboTagList.Count) ? _curComboTagList.get_Item(_stage) : null);
		_canLockTarget = true;
		_isLastStage = _stage == _curComboTagList.Count - 1;
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
		LogicEntity attackTarget = _actor.attackTarget;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(comboTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: true, attackTarget, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnAnticipationEnd()
	{
		int num = _stage + 1;
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", (num < _curComboTagList.Count) ? num : 0);
	}

	public void OnUpdate()
	{
		LockDirection(_canLockTarget ? default(TSVector2) : _actor.tsTransform.Forward);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "144_S"))
		{
			_canLockTarget = false;
		}
		else if (string.Equals(eventName, "144_AtkInvincibleAdd"))
		{
			_actor.buffComponent.AddBuff(14400001, _actor);
		}
		else if (string.Equals(eventName, "144_AtkInvincibleRemove"))
		{
			_actor.buffComponent.RemoveBuffByBuffId(14400001);
		}
		else
		{
			if (!string.Equals(eventName, "144_Shadow_Atk") || !CommonUtils.HavePersonalPerk(_actor.dataID, 514402, out var _) || !_actor.buffComponent.CheckBuffByBuffID(14401011))
			{
				return;
			}
			TSVector2 tSVector = Config_MainControl.summonOffset_P2.get_Item(TSRandom.Range(0, Config_MainControl.summonOffset_P2.Count));
			TSVector2 tSVector2 = _actor.tsTransform.Position + _actor.tsTransform.Left * tSVector.x + _actor.tsTransform.Forward * tSVector.y;
			TSVector2 dir = _actor.tsTransform.Forward;
			if (_actor.attackTarget != null)
			{
				dir = (_actor.attackTarget.tsTransform.Position - tSVector2).normalized;
			}
			if (!Config.replaceMonsterIdDic_Summon_ForSkin.TryGetValue(_actor.skinID, out var value))
			{
				value = 14401111;
			}
			ILRuntimeAPI.SummonMonster(_actor, 0, value, tSVector2, dir, Config.summonCfg_Summon, null, (MonsterAdventureActor summoned) =>
			{
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 514405, out var _))
				{
					if (_isLastStage)
					{
						int buffNumByID = _actor.buffComponent.GetBuffNumByID(14406012);
						_actor.logicVariable.SetLogicTagValue("AdditionalAttrCount_P2_P6", buffNumByID);
					}
					else
					{
						_actor.logicVariable.SetLogicTagValue("AdditionalAttrCount_P2_P6", 0);
					}
				}
				summoned.logicVariable.SetLogicTagValue("DelayUseSkillTime_Summon", Config_MainControl.summonedDelayUseSkillTime_P2);
				summoned.logicVariable.SetLogicTagStringValue("SkillComboTag_Summon", _comboTag);
				summoned.attackTarget = _actor.attackTarget;
				summoned.logicVariable.ToggleLogicTag("SummonFinish_Summon", value: true);
			});
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
		_actor.buffComponent.RemoveBuffByBuffId(14400001);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514405, out var perkLevel) && !_isLastStage)
		{
			_actor.buffComponent.RemoveBuffByBuffId(14405011, 1);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514406, out perkLevel) && _isLastStage)
		{
			_actor.buffComponent.RemoveBuffByBuffId(14406012);
		}
		_stage = 0;
		_comboTag = null;
		_canLockTarget = false;
		_isLastStage = false;
	}
}
