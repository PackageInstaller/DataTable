using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13701;

public class ParallelScript_MainControl : ParallelScript
{
	private Dictionary<long, int> _alertHitCountByTarget = new Dictionary<long, int>();

	private FP _alertLastTriggerTime;

	private FP _alertSessionStartSeen;

	private List<LogicEntity> _searchBuffer_513709 = new List<LogicEntity>();

	private FP _lastTriggerTime_513710;

	private CoroutineNode _corAlertAreaEffect;

	private long _areaEffectIdA;

	private long _areaEffectIdB;

	private bool _alertActiveLastFrame;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ApplyDodgeCDReduction();
	}

	private void ApplyDodgeCDReduction()
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513712, out var _))
		{
			PlayerSkillCd playerSkillCd = ((PlayerAdventureActor)_actor).playerSkillCd;
			int num = CommonUtils.GetScriptValue(_actor, 13712011).AsInt();
			playerSkillCd.ModifySectionResumeTimePercentAmend(100 - num, ActionKey.A);
		}
	}

	public void OnUpdate()
	{
		bool flag = _actor.buffComponent.CheckBuffByBuffID(13700011);
		if (flag && !_alertActiveLastFrame)
		{
			StopAlertCoroutine();
			_corAlertAreaEffect = _actor.StartLogicCoroutine(PlayAreaEffectSequence());
		}
		else if (!flag && _alertActiveLastFrame)
		{
			StopAlertCoroutine();
		}
		_alertActiveLastFrame = flag;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		StopAlertCoroutine();
		_alertActiveLastFrame = false;
	}

	private IEnumerator PlayAreaEffectSequence()
	{
		bool flag = CommonUtils.HavePersonalPerk(_actor.dataID, 513703, out var perkLevel);
		bool useP = CommonUtils.HavePersonalPerk(_actor.dataID, 513708, out perkLevel);
		string keyA = Config_MainControl.SelectAlertSpreadKey(flag, useP);
		string keyB = (flag ? "AreaEffect_137_MainSkill_Ring_In_P3" : "AreaEffect_137_MainSkill_Ring_In");
		FP durationA = (flag ? Config_MainControl.durationTime_A_513703 : Config_MainControl.switchTime_AToB);
		FP durationB = (flag ? Config_MainControl.durationTime_A_513703 : Config_MainControl.switchTime_AToB);
		while (_actor.buffComponent.CheckBuffByBuffID(13700011))
		{
			StopAreaEffectA();
			StopAreaEffectB();
			_areaEffectIdA = ILRuntimeAPI.PlayAreaEffect(_actor, keyA, _actor.tsTransform.Position);
			yield return _actor.WaitTime(durationA);
			StopAreaEffectA();
			_areaEffectIdB = ILRuntimeAPI.PlayAreaEffect(_actor, keyB, _actor.tsTransform.Position);
			yield return _actor.WaitTime(durationB);
			StopAreaEffectB();
		}
		StopAreaEffectA();
		StopAreaEffectB();
		_corAlertAreaEffect = null;
	}

	private void StopAlertCoroutine()
	{
		if (_corAlertAreaEffect != null)
		{
			_actor.StopLogicCoroutine(_corAlertAreaEffect);
			_corAlertAreaEffect = null;
		}
		StopAreaEffectA();
		StopAreaEffectB();
	}

	private void StopAreaEffectA()
	{
		if (_areaEffectIdA > 0)
		{
			ILRuntimeAPI.StopAreaEffect(_areaEffectIdA);
			_areaEffectIdA = 0L;
		}
	}

	private void StopAreaEffectB()
	{
		if (_areaEffectIdB > 0)
		{
			ILRuntimeAPI.StopAreaEffect(_areaEffectIdB);
			_areaEffectIdB = 0L;
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config.damageTag_NormalAttack_137) && TryRollArmedEnergy())
		{
			_actor.buffComponent.AddBuffNum(13700012, 2, _actor);
			_actor.logicVariable.SetLogicTagValue("LastArmedEnergyTime", _actor.LogicTime);
			CommonHelper_137.TryFireGrenade(_actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513704, out var perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.AlertHitTag_137) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.AlertHitTag_137Self) && _actor.buffComponent.CheckBuffByBuffID(13700011) && damageEvent.to is AdventureActor adventureActor)
		{
			FP logicTagValue = _actor.logicVariable.GetLogicTagValue("AlertSessionStart");
			if (logicTagValue != _alertSessionStartSeen)
			{
				_alertHitCountByTarget.Clear();
				_alertLastTriggerTime = FP.Zero;
				_alertSessionStartSeen = logicTagValue;
			}
			long id = adventureActor.Id;
			_alertHitCountByTarget.TryGetValue(id, out var value);
			value++;
			_alertHitCountByTarget.set_Item(id, value);
			if ((!(_alertLastTriggerTime > FP.Zero) || !(_actor.LogicTime <= _alertLastTriggerTime + Config_MainControl.AlertReTriggerCD)) && value >= 2)
			{
				TryPlayAlertSpreadAt(adventureActor);
				_alertHitCountByTarget.set_Item(id, 0);
				_alertLastTriggerTime = _actor.LogicTime;
			}
		}
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_513707_Atk5_TriggerWindMark) && CommonUtils.HavePersonalPerk(_actor.dataID, 513707, out perkLevel))
		{
			CommonHelper_137.TryTriggerWindMark(_actor, damageEvent.to);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513710, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config.damageTag_NormalAttack_137) && (!(_lastTriggerTime_513710 > FP.Zero) || !(_actor.LogicTime <= _lastTriggerTime_513710 + Config_MainControl.cd_513710)))
		{
			_actor.buffComponent.AddBuff(13710011, _actor);
			_lastTriggerTime_513710 = _actor.LogicTime;
		}
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config.UltraHitTag_137) && CommonUtils.HavePersonalPerk(_actor.dataID, 513711, out perkLevel))
		{
			CommonHelper_137.TryTriggerWindMark(_actor, damageEvent.to);
		}
	}

	protected override void OnSelfBulletFinish(AdventureBulletFinishEvent bulletEvt)
	{
		base.OnSelfBulletFinish(bulletEvt);
	}

	protected override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		if (evt.sender as AdventureActor == _actor && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && CommonUtils.HavePersonalPerk(_actor.dataID, 513704, out var perkLevel))
		{
			_actor.buffComponent.AddBuff(13704011, _actor);
		}
		if (evt.sender as AdventureActor == _actor && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && CommonUtils.HavePersonalPerk(_actor.dataID, 513709, out perkLevel))
		{
			CommonUtils.SearchNearTargetsByCircle(_actor, Config_MainControl.searchRadius_513709, isConfront: true, includeSelf: false, _searchBuffer_513709);
			int count = _searchBuffer_513709.Count;
			if (count > 0)
			{
				_actor.buffComponent.AddBuffNum(13709011, count, _actor);
			}
		}
	}

	protected override void OnSelfGetBuff(AdventureActorGetBuff getBuffEvt)
	{
		base.OnSelfGetBuff(getBuffEvt);
		if (getBuffEvt.eventInfo.buffId == 13700011 && CommonUtils.HavePersonalPerk(_actor.dataID, 513707, out var _))
		{
			_actor.buffComponent.AddBuff(13707011, _actor);
		}
	}

	protected override void OnSelfBuffRemove(AdventureActorRemoveBuff removeBuffEvt)
	{
		base.OnSelfBuffRemove(removeBuffEvt);
		if (removeBuffEvt.eventInfo.buffId == 13700011 && CommonUtils.HavePersonalPerk(_actor.dataID, 513707, out var _))
		{
			_actor.buffComponent.RemoveBuffByBuffId(13707011);
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		if (!(evt is AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent) || _actor == null || !CommonUtils.HavePersonalPerk(_actor.dataID, 513713, out var _) || adventureElementMarkTriggerEvent.elementType != HotfixEnum.elementType.AE || !(adventureElementMarkTriggerEvent.triggerActor is PlayerAdventureActor playerAdventureActor) || playerAdventureActor.actorElementInfo.elementType != HotfixEnum.elementType.AE)
		{
			return;
		}
		List<AdventureActor> allPlayerActors = ILRuntimeAPI.GetAllPlayerActors(_actor);
		for (int i = 0; i < allPlayerActors.Count; i++)
		{
			AdventureActor adventureActor = allPlayerActors.get_Item(i);
			if (adventureActor.actorElementInfo.elementType == HotfixEnum.elementType.AE)
			{
				adventureActor.buffComponent.AddBuff(13713011, _actor);
			}
		}
	}

	protected override void OnSelfBeforeHit(AdventureActorReceiveDamageBeforeHitEvent beforeHit)
	{
		base.OnSelfBeforeHit(beforeHit);
		if (CommonUtils.CheckHitByTag(beforeHit.hitDamageTag, Config.CrossSlashHitTag_137) && CommonUtils.HavePersonalPerk(_actor.dataID, 513701, out var perkLevel))
		{
			AdventureActor.AddFromAttr(13701011, _actor);
		}
		if (CommonUtils.CheckHitByTag(beforeHit.hitDamageTag, Config.CrossSlashHitTag_137) && CommonUtils.HavePersonalPerk(_actor.dataID, 513705, out perkLevel) && beforeHit.to.IsEliteOrBossMonster())
		{
			AdventureActor.AddFromAttr(13705001, _actor);
		}
		if (CommonUtils.CheckHitByTag(beforeHit.hitDamageTag, Config_MainControl.AlertHitTag_137) && CommonUtils.HavePersonalPerk(_actor.dataID, 513708, out perkLevel))
		{
			AdventureActor.AddFromAttr(13708001, _actor);
		}
	}

	private void TryPlayAlertSpreadAt(AdventureActor target)
	{
		bool useFast = CommonUtils.HavePersonalPerk(_actor.dataID, 513703, out var perkLevel);
		bool useP = CommonUtils.HavePersonalPerk(_actor.dataID, 513708, out perkLevel);
		string fxAlias = Config_MainControl.SelectAlertSpreadKey(useFast, useP, follow: false);
		ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, target.tsTransform.Position);
	}
}
