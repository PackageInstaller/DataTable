using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11601;

public class ParallelScript_Support : ParallelScript
{
	private Dictionary<long, int> _receiveExplosionDamageDic;

	private Dictionary<long, CoroutineNode> _receiveExplosionDamageCDCorDic;

	public override void OnEnable()
	{
		base.OnEnable();
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 511633, out var _))
		{
			return;
		}
		int num = 0;
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (actorL.actorElementInfo.elementType == HotfixEnum.elementType.SE)
			{
				num++;
			}
		}
		foreach (PlayerAdventureActor actorL2 in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			for (int i = 0; i < num; i++)
			{
				actorL2.buffComponent?.AddBuff(11633011, _actor);
			}
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511622, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P22))
		{
			AdventureActor.AddFromAttr(11622001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511623, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P23))
		{
			AdventureActor.AddFromAttr(11623001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511624, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P24))
		{
			AdventureActor.AddFromAttr(11624001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511625, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P25))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(11625011);
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(11625001, _actor, buffNumByID);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511627, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P27))
		{
			AdventureActor.AddFromAttr(11627001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511628, out perkLevel) && monsterAdventureActor.buffComponent.CheckBuffByBuffTag(Config_Support.buffTag_Check_P28))
		{
			AdventureActor.AddFromAttr(11628001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511630, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P30))
		{
			AdventureActor.AddFromAttr(11630001, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		int perkLevel;
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_AddSeedBuff_Skill))
		{
			int buffID = 11691011;
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 511623, out perkLevel))
			{
				buffID = 11623011;
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 511629, out perkLevel))
				{
					monsterAdventureActor.buffComponent.AddBuff(11629012, _actor);
				}
			}
			else if (CommonUtils.HavePersonalPerk(_actor.dataID, 511629, out perkLevel))
			{
				monsterAdventureActor.buffComponent.AddBuff(11629011, _actor);
			}
			monsterAdventureActor.buffComponent.AddBuff(buffID, _actor);
		}
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_SeedExplosion_Skill))
		{
			if (_receiveExplosionDamageDic == null)
			{
				_receiveExplosionDamageDic = new Dictionary<long, int>();
			}
			if (_receiveExplosionDamageDic.TryGetValue(monsterAdventureActor.Id, out var value))
			{
				_receiveExplosionDamageDic.set_Item(monsterAdventureActor.Id, value + 1);
			}
			else
			{
				_receiveExplosionDamageDic.Add(monsterAdventureActor.Id, 1);
			}
			if (_receiveExplosionDamageCDCorDic == null)
			{
				_receiveExplosionDamageCDCorDic = new Dictionary<long, CoroutineNode>();
			}
			if (_receiveExplosionDamageDic.get_Item(monsterAdventureActor.Id) >= 6)
			{
				monsterAdventureActor.buffComponent.AddBuff(11691013, _actor);
				_receiveExplosionDamageDic.set_Item(monsterAdventureActor.Id, 0);
				if (_receiveExplosionDamageCDCorDic.TryGetValue(monsterAdventureActor.Id, out var value2))
				{
					_actor.StopLogicCoroutine(value2);
					_receiveExplosionDamageCDCorDic.Remove(monsterAdventureActor.Id);
				}
			}
			else if (!_receiveExplosionDamageCDCorDic.ContainsKey(monsterAdventureActor.Id))
			{
				_receiveExplosionDamageCDCorDic.Add(monsterAdventureActor.Id, _actor.StartLogicCoroutine(ReceiveExplosionCD(monsterAdventureActor.Id)));
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511623, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P23))
		{
			monsterAdventureActor.buffComponent.AddBuff(6011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511626, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P26))
		{
			monsterAdventureActor.buffComponent.AddBuff(11626011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511631, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P31))
		{
			monsterAdventureActor.buffComponent.AddBuff(6011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511624, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P24) && monsterAdventureActor.buffComponent.CheckBuffByBuffTag(Config_Support.buffTag_Seed_Skill))
		{
			FP logicTagValue = _actor.logicVariable.GetLogicTagValue("TriggerExplosionTimes_P24");
			if (logicTagValue < 10 && TriggerSeedExplosion(monsterAdventureActor))
			{
				_actor.logicVariable.SetLogicTagValue("TriggerExplosionTimes_P24", logicTagValue + 1);
			}
		}
	}

	private IEnumerator ReceiveExplosionCD(long monsterId)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_Support.unitTime_TriggerSeedExplosion_Skill));
		if (_receiveExplosionDamageDic.ContainsKey(monsterId))
		{
			_receiveExplosionDamageDic.set_Item(monsterId, 0);
		}
		_receiveExplosionDamageCDCorDic.Remove(monsterId);
	}

	protected override void OnLandMarkTrigger(AdventureActor triggerActor, AdventureActor markActor)
	{
		base.OnLandMarkTrigger(triggerActor, markActor);
		if (markActor.buffComponent.CheckBuffByBuffTag(Config_Support.buffTag_Seed_Skill))
		{
			TriggerSeedExplosion(markActor);
		}
	}

	private bool TriggerSeedExplosion(AdventureActor target)
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511624, out var perkLevel))
		{
			if (target.buffComponent.CheckBuffByBuffID(11691014))
			{
				return false;
			}
			target.buffComponent.AddBuff(11691014, _actor);
		}
		FP explosionScale = 1;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511624, out perkLevel))
		{
			explosionScale = 1 + Config_Support.addAreaEffectScale_P24 * 0.01f;
		}
		PlayFX playFX = new PlayFX();
		playFX.Play(_actor, null, "fx_11601_base_Skill_Sup_seed_bomb_explosion", default, target.tsTransform.Position, default, null, 1f, explosionScale.AsFloat());
		playFX.fxInstance.Bind(target.gameObject, target.gameObject);
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_11601_Skill_Sup_AttachSeedBoom", target.tsTransform.Position, default, (AreaEffectEntity areaEffect) =>
		{
			areaEffect.ModifyScale(explosionScale);
		});
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511630, out perkLevel))
		{
			List<LogicEntity> list = ILRuntimeAPI.SearchByRangeAndPosition(_actor, target.tsTransform.Position, Config_Support.searchRadius_P30, null, isConfront: true, onlyAlive: true, includeSelf: false, (LogicEntity entity) => entity != target);
			if (list.Count > 0)
			{
				LogicEntity logicEntity = list.get_Item(TSRandom.Range(0, list.Count));
				TSVector2 normalized = (logicEntity.tsTransform.Position - target.tsTransform.Position).normalized;
				TSVector2 position = target.tsTransform.Position + TSVector2.Rotate(normalized, 90) * Config_Support.shootOffset_P30.x + normalized * (target.GetRadius() + Config_Support.shootOffset_P30.z);
				FP y = Config_Support.shootOffset_P30.y;
				ILRuntimeAPI.Shoot("Bullet_11601_Skill_Sup_Seed_Perk30", _actor, default, position, y, logicEntity.tsTransform.Position, null, AimType.Position, BulletDirectionType.BulletToTarget);
			}
		}
		return true;
	}

	private void Clear()
	{
		_receiveExplosionDamageDic?.Clear();
		if (_receiveExplosionDamageCDCorDic == null || _receiveExplosionDamageCDCorDic.Count <= 0)
		{
			return;
		}
		foreach (CoroutineNode value in _receiveExplosionDamageCDCorDic.Values)
		{
			_actor.StopLogicCoroutine(value);
		}
		_receiveExplosionDamageCDCorDic.Clear();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		Clear();
	}
}
