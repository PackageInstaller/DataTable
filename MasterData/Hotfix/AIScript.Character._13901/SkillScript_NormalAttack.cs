using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13901;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private int _stage;

	private List<string> _curComboTagList;

	private bool _isLastStage;

	private bool _isCloseBlock;

	private bool _canLockDirection;

	private Dash _dash;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_curComboTagList = Config.comboTagList_NormalAttack;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513910, out var _) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.WE) && _actor.buffComponent.CheckBuffByBuffTag(Config.buffTag_FirstStage_UltraSkill))
		{
			_curComboTagList = Config_MainControl.comboTagList_NormalAttack_P10;
		}
		FP value = _actor.logicVariable.GetLogicTagValue("NormalAttackStage");
		FP logicTagValue = _actor.logicVariable.GetLogicTagValue("LastNormalAttackFinishTime");
		if (_actor.LogicTime - logicTagValue > Config.holdTime_NormalAttackStage)
		{
			value = 0;
		}
		_stage = TSMath.Clamp(value, 0, _curComboTagList.Count - 1).AsInt();
		_isLastStage = _stage == _curComboTagList.Count - 1;
		_isCloseBlock = false;
		_canLockDirection = true;
	}

	public void OnStart()
	{
		string actionTag = _curComboTagList.get_Item(_stage);
		LogicEntity attackTarget = _actor.attackTarget;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onRecoveryBegin = OnRecoveryBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: true, attackTarget, null, default, onAnticipationEnd, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnAnticipationEnd()
	{
		int num = _stage + 1;
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", (num < _curComboTagList.Count) ? num : 0);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "139_Atk_CloseBlock"))
		{
			EnableCloseBlock();
			if (_isLastStage)
			{
				DashToPosition();
			}
		}
		else if (string.Equals(eventName, "139_Atk_EnableBlock"))
		{
			_dash?.Interrupte();
			DisableCloseBlock();
		}
		else
		{
			if (!string.Equals(eventName, "Event_P02") || !CommonUtils.HavePersonalPerk(_actor.dataID, 513902, out var perkLevel))
			{
				return;
			}
			FP logicTagValue = _actor.logicVariable.GetLogicTagValue("LastTriggerTime_P2");
			int parameterId = 13902011;
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513907, out perkLevel) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.WE) && _actor.buffComponent.CheckBuffByBuffID(13907001))
			{
				parameterId = 13907002;
			}
			if (logicTagValue <= 0 || _actor.LogicTime - logicTagValue > CommonUtils.GetScriptValue(_actor, parameterId))
			{
				GetSoul(1);
				List<string> list = Config_MainControl.areaEffectKeyList_P2;
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 513905, out perkLevel))
				{
					list = Config_MainControl.areaEffectKeyList_P2_P5;
				}
				string fxAlias = list.get_Item(TSRandom.Range(0, list.Count));
				TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
				{
					shapeType = DeterministicShape.ShapeType.Circle,
					innerRadius = 0,
					radius = Config_MainControl.randomRadius_AreaEffect_P2,
					position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position)
				}, isReachable: false);
				ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, randomPointInShape, _actor.tsTransform.Rotation);
				_actor.logicVariable.SetLogicTagValue("LastTriggerTime_P2", _actor.LogicTime);
			}
		}
	}

	private void GetSoul(int count)
	{
		if (count > 0 && (!CommonUtils.HavePersonalPerk(_actor.dataID, 513903, out var _) || !_actor.buffComponent.CheckBuffByBuffTag(Config.buffTag_FirstStage_UltraSkill)))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = Config_MainControl.eventHashCode_AddSoul;
			adventureActorCustomEvent.intParam = count;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private void DashToPosition()
	{
		if (_actor.attackTarget == null)
		{
			return;
		}
		TSVector2 normalized = (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
		TSVector2 tSVector = _actor.attackTarget.tsTransform.Position + normalized * (_actor.attackTarget.GetRadius() + _actor.GetRadius() + Config.extraMoveDistance_LastStage_NormalAttack);
		bool flag = false;
		if (_actor.QueryPositionReachable(tSVector))
		{
			FP fP = TSVector2.Distance(_actor.tsTransform.Position, tSVector);
			if (fP <= Config.maxMoveDistance_LastStage_NormalAttack)
			{
				FP speed = fP / Config.moveDuration_LastStage_NormalAttack;
				_canLockDirection = false;
				CancelLockDirection();
				if (_dash == null)
				{
					_dash = new Dash();
				}
				_dash.BeginDash(_actor, normalized, speed, fP, default, null, null, null, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
				flag = true;
			}
		}
		if (flag)
		{
			return;
		}
		tSVector = _actor.attackTarget.tsTransform.Position - normalized * (_actor.attackTarget.GetRadius() + _actor.GetRadius());
		if (!_actor.QueryPositionReachable(tSVector))
		{
			return;
		}
		FP fP2 = TSVector2.Distance(_actor.tsTransform.Position, tSVector);
		if (fP2 < TSVector2.Distance(_actor.tsTransform.Position, _actor.attackTarget.tsTransform.Position) && fP2 <= Config.maxMoveDistance_LastStage_NormalAttack)
		{
			FP speed2 = fP2 / Config.moveDuration_LastStage_NormalAttack;
			_canLockDirection = false;
			CancelLockDirection();
			if (_dash == null)
			{
				_dash = new Dash();
			}
			_dash.BeginDash(_actor, normalized, speed2, fP2, default, null, null, null, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		}
	}

	private void EnableCloseBlock()
	{
		if (!_isCloseBlock)
		{
			_isCloseBlock = true;
			_actor.EnableCloseBlock();
		}
	}

	private void DisableCloseBlock()
	{
		if (_isCloseBlock)
		{
			_isCloseBlock = false;
			_actor.DisableCloseBlock();
		}
	}

	public void OnUpdate()
	{
		if (_canLockDirection)
		{
			LockDirection();
		}
	}

	private void OnRecoveryBegin()
	{
		_canLockDirection = true;
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.logicVariable.SetLogicTagValue("LastNormalAttackFinishTime", _actor.LogicTime);
		_dash?.Interrupte();
		_dash?.Clear();
		DisableCloseBlock();
		_isCloseBlock = false;
		_canLockDirection = false;
		_stage = 0;
	}
}
