using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14301;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private bool _isRangeAttack;

	private string _normalAttackStageTag;

	private int _nextNormalAttackStage;

	private HashSet<long> _triggerDamageIdSet_P1;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_isRangeAttack = _actor.attackTarget != null && _actor.DistanceWithRadius(_actor.attackTarget) > Config.distance_SwitchAttackMode;
		CheckResetStage();
	}

	private void CheckResetStage()
	{
		if (_isRangeAttack)
		{
			FP logicTagValue = _actor.logicVariable.GetLogicTagValue("LastNormalAttackFinsihTime_Range");
			if (logicTagValue <= 0 || _actor.LogicTime - logicTagValue > Config.delay_ResetNormalAttackStage)
			{
				_actor.logicVariable.SetLogicTagValue("NormalAttackStage_Range", 0);
			}
		}
		else
		{
			FP logicTagValue2 = _actor.logicVariable.GetLogicTagValue("LastNormalAttackFinsihTime_Melee");
			if (logicTagValue2 <= 0 || _actor.LogicTime - logicTagValue2 > Config.delay_ResetNormalAttackStage)
			{
				_actor.logicVariable.SetLogicTagValue("NormalAttackStage_Melee", 0);
			}
		}
	}

	public void OnStart()
	{
		string comboTag = GetComboTag(out _normalAttackStageTag, out _nextNormalAttackStage);
		if (string.IsNullOrEmpty(comboTag))
		{
			_skill.Clear();
			return;
		}
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(comboTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = string.Equals(_normalAttackStageTag, "NormalAttackStage_Range");
	}

	private string GetComboTag(out string normalAttackStageTag, out int nextNormalAttackStage)
	{
		List<string> list = Config.comboTagList_NormalAttack_Melee;
		normalAttackStageTag = "NormalAttackStage_Melee";
		if (_isRangeAttack)
		{
			list = Config.comboTagList_NormalAttack_Range;
			normalAttackStageTag = "NormalAttackStage_Range";
		}
		int num = _actor.logicVariable.GetLogicTagValue(normalAttackStageTag).AsInt();
		num = TSMath.Clamp(num, 0, list.Count - 1).AsInt();
		nextNormalAttackStage = num + 1;
		nextNormalAttackStage = ((nextNormalAttackStage < list.Count) ? nextNormalAttackStage : 0);
		return list.get_Item(num);
	}

	public void OnUpdate()
	{
		LockDirection();
	}

	private void OnAnticipationEnd()
	{
		if (!string.IsNullOrEmpty(_normalAttackStageTag) && _nextNormalAttackStage >= 0)
		{
			_actor.logicVariable.SetLogicTagValue(_normalAttackStageTag, _nextNormalAttackStage);
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "143NrmQiangAtkEvent") && CommonUtils.HavePersonalPerk(_actor.dataID, 514310, out var _) && (_actor.logicVariable.GetLogicTagValue("LastTriggerTime_P10") <= 0 || _actor.LogicTime - _actor.logicVariable.GetLogicTagValue("LastTriggerTime_P10") > Config_MainControl.triggerCD_P10) && _actor.buffComponent.CheckBuffByBuffID(14310011))
		{
			TSVector2 tSVector = Config_MainControl.generateLaserOffsetList_P10.get_Item(TSRandom.Range(0, Config_MainControl.generateLaserOffsetList_P10.Count));
			TSVector2 tSVector2 = _actor.tsTransform.Position + _actor.tsTransform.Left * tSVector.x + _actor.tsTransform.Forward * tSVector.y;
			TSVector2 tSVector3 = ((_actor.attackTarget != null) ? (_actor.attackTarget.tsTransform.Position - tSVector2).normalized : _actor.tsTransform.Forward);
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_143_P10_JiGuang", tSVector2, tSVector3.GetAngle(), (AreaEffectEntity areaEffect) =>
			{
				areaEffect.tsTransform.PositionY += Config_MainControl.generateLaserPositionY_P10;
			});
			_actor.logicVariable.SetLogicTagValue("LastTriggerTime_P10", _actor.LogicTime);
		}
	}

	protected override void OnReceiveDamage(IEvent evt)
	{
		base.OnReceiveDamage(evt);
		if (evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && adventureActorReceiveDamageEvent.from == _actor && CommonUtils.HavePersonalPerk(_actor.dataID, 514301, out var perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P1) && _actor.buffComponent.CheckBuffByBuffID(14301011))
		{
			if (_triggerDamageIdSet_P1 == null)
			{
				_triggerDamageIdSet_P1 = new HashSet<long>(5);
			}
			if (_triggerDamageIdSet_P1.Add(adventureActorReceiveDamageEvent.uniqueAttackId))
			{
				TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, CommonUtils.GetDeterministicCircleShape(Config_MainControl.generateTornadoRadius_P1_P2, Config_MainControl.generateTornadoRadius_P1_P2, _actor.tsTransform.Position), isReachable: false);
				string fxAlias = (CommonUtils.HavePersonalPerk(_actor.dataID, 514302, out perkLevel) ? "AreaEffect_143_P1_LongJuanFeng_P2" : "AreaEffect_143_P1_LongJuanFeng");
				ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, randomPointInShape);
				_actor.buffComponent.RemoveBuffByBuffId(14301011);
			}
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
		if (_isRangeAttack)
		{
			_actor.logicVariable.SetLogicTagValue("LastNormalAttackFinsihTime_Range", _actor.LogicTime);
		}
		else
		{
			_actor.logicVariable.SetLogicTagValue("LastNormalAttackFinsihTime_Melee", _actor.LogicTime);
		}
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
		_normalAttackStageTag = null;
		_nextNormalAttackStage = 0;
		_triggerDamageIdSet_P1?.Clear();
	}
}
