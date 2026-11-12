#define LOG_DEBUG
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using PathologicalGames;
using TrueSync;
using UnityEngine;

namespace AIScript.FateCardTheme;

public class FateCard_FireRing : BaseFateCardTheme
{
	private const string triggerFxPath = "fire_trigger_s";

	private readonly FP duration = 1;

	private const int hitDamageId = 986101;

	private readonly FP cd = 1.5;

	private const string fxPath = "fire_firering_6m_1s_01";

	private readonly int fireRingDamageTag = CommonHelper.StringToHash("fireRing");

	private readonly FP initInnerRadius = 0.3;

	private readonly FP radius = 1;

	private readonly FP diffuseSpeed = 0.48;

	private readonly FP diffuseInterval = 0.08;

	private readonly FP attackInterval = 0.2;

	private readonly int hitId_2p = 986102;

	private const string fxPath_bom6 = "fire_firering_6m_q2";

	private const string fxPath_ProB = "fire_firering_6m_1s_13";

	private readonly int attriId_13 = 440;

	private string _fireRingPrefabName;

	private GameObject _prefab_FireRing;

	private List<long> _perk2pTriggers;

	private Dictionary<string, GameObject> _fxPrefabDic;

	public override void OnEnable()
	{
		NovaLogger.Debug("FateCard_FireRing OnEnable");
		base.OnEnable();
		_fireRingPrefabName = $"FireRing_{_actor.dataID}";
		_perk2pTriggers = new List<long>(10);
		_fxPrefabDic = new Dictionary<string, GameObject>(4);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_DIFFUSE", OnDiffuseEvent);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("AREA_EFFECT_DIFFUSE", OnDiffuseEvent);
		_perk2pTriggers.Clear();
		_perk2pTriggers = null;
		_fxPrefabDic.Clear();
		_fxPrefabDic = null;
	}

	protected override void OnTrigger()
	{
		NovaLogger.Debug("FateCard_FireRing OnTrigger");
		if (CheckTimeout(cd))
		{
			PlayFireRing(986101);
			TriggerTheme();
		}
	}

	private void PlayFireRing(int hitDamageId)
	{
		CommonUtils.PlayOneOffFx(_actor, "fire_trigger_s");
		GameObject fireRingPrefab = GetFireRingPrefab(iFollow: false);
		ILRuntimeAPI.PlayAreaEffect(_actor, fireRingPrefab, _actor.tsTransform.Position, default, (AreaEffectEntity entity) =>
		{
			entity.ActiveSelf = true;
			if (CanExcuteA)
			{
				_perk2pTriggers.Add(entity.Id);
			}
			FP fP = duration;
			string text = "fire_firering_6m_1s_01";
			if (CanExcuteB)
			{
				fP = duration * 2;
				text = "fire_firering_6m_1s_13";
			}
			entity.duration = fP;
			if (_fxPrefabDic.TryGetValue(text, out var value))
			{
				entity.fx = value;
			}
			else
			{
				GameObject fxByAlias = ModuleController<AdventureModuleController>.Instance.GetFxByAlias(_actor, text, forceUseCommonConfig: true);
				_fxPrefabDic.Add(text, fxByAlias);
				entity.fx = fxByAlias;
			}
			AreaEffect_AttackComponent logicComponent = entity.GetLogicComponent<AreaEffect_AttackComponent>();
			if (logicComponent != null)
			{
				logicComponent.hitDamageId = hitDamageId;
				if (CanExcuteB)
				{
					logicComponent.delayClearHittedRecord = true;
					logicComponent.clearHittedRecordDelayTime = fP * 0.5f;
				}
				else
				{
					logicComponent.delayClearHittedRecord = false;
				}
			}
			AreaEffect_DiffuseComponent logicComponent2 = entity.GetLogicComponent<AreaEffect_DiffuseComponent>();
			if (logicComponent2 != null)
			{
				logicComponent2.maxDiffuseTime = fP;
				if (CanExcuteB)
				{
					logicComponent2.changeSpeed = true;
					logicComponent2.delay_Change = fP * 0.5f;
					logicComponent2.speed_Change = -diffuseSpeed;
				}
				else
				{
					logicComponent2.changeSpeed = false;
				}
			}
		});
	}

	private void OnDiffuseEvent(IEvent evt)
	{
		AdventureAreaEffectDiffuseEvent adventureAreaEffectDiffuseEvent = evt as AdventureAreaEffectDiffuseEvent;
		if (adventureAreaEffectDiffuseEvent.iDiffuseMax && _perk2pTriggers.Contains(adventureAreaEffectDiffuseEvent.entityID))
		{
			string fxAlias = "fire_firering_6m_q2";
			PlayFX playFX = new PlayFX();
			TSVector2 position = new TSVector2(adventureAreaEffectDiffuseEvent.pos.x, adventureAreaEffectDiffuseEvent.pos.z);
			playFX.Play(_actor, null, fxAlias, adventureAreaEffectDiffuseEvent.pos.y, position, _actor.tsTransform.Forward);
			playFX.Clear();
			CommomAreaHitConfig commomAreaHitConfig = new CommomAreaHitConfig();
			commomAreaHitConfig.position = position;
			commomAreaHitConfig.hitDamageId = hitId_2p;
			ILRuntimeAPI.CircleAreaHit(_actor, commomAreaHitConfig, adventureAreaEffectDiffuseEvent.hitBoxRadius, 0);
			_perk2pTriggers.Remove(adventureAreaEffectDiffuseEvent.entityID);
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent _evt)
	{
		base.OnBeforeHit(_evt);
		if (_evt.from as AdventureActor != null && CommonUtils.CheckHitByTag(_evt.hitDamageTag, fireRingDamageTag))
		{
			_ = _evt.to;
			if (CanExcuteB)
			{
				AdventureActor.AddFromAttr(attriId_13, _actor);
			}
		}
	}

	private GameObject GetFireRingPrefab(bool iFollow)
	{
		if (_prefab_FireRing == null)
		{
			SpawnPool spawnPool = PoolManager.Pools.get_Item("Effect");
			if (spawnPool != null)
			{
				_prefab_FireRing = spawnPool.GetPrefabGo(_fireRingPrefabName);
			}
			if (_prefab_FireRing == null)
			{
				_prefab_FireRing = new GameObject(_fireRingPrefabName);
				_prefab_FireRing.SetActive(value: false);
				AreaEffectEntity entity = InitAreaEntity(_prefab_FireRing);
				InitAttackComponent(entity);
				InitDiffuseComponent(entity);
				if (iFollow)
				{
					InitFollowComponent(entity);
				}
			}
		}
		return _prefab_FireRing;
	}

	private AreaEffectEntity InitAreaEntity(GameObject prefab)
	{
		AreaEffectEntity areaEffectEntity = prefab.AddOrGetComponent<AreaEffectEntity>();
		areaEffectEntity.hitBoxShape = HitBox.Shape.Circle;
		areaEffectEntity.hitBoxInnerRadius = initInnerRadius;
		areaEffectEntity.hitBoxRadius = radius + initInnerRadius;
		areaEffectEntity.UpdateColliderShape();
		return areaEffectEntity;
	}

	private void InitAttackComponent(AreaEffectEntity entity)
	{
		AreaEffect_AttackComponent areaEffect_AttackComponent = entity.AddOrGetMonoLogicComponent<AreaEffect_AttackComponent>();
		areaEffect_AttackComponent.hitDelay = 0;
		areaEffect_AttackComponent.hitInterval = attackInterval;
		areaEffect_AttackComponent.damageImmuneDuration = duration;
	}

	private void InitDiffuseComponent(AreaEffectEntity entity)
	{
		AreaEffect_DiffuseComponent areaEffect_DiffuseComponent = entity.AddOrGetMonoLogicComponent<AreaEffect_DiffuseComponent>();
		areaEffect_DiffuseComponent.interval = diffuseInterval;
		areaEffect_DiffuseComponent.speed = diffuseSpeed;
		areaEffect_DiffuseComponent.radiusTogether = true;
		areaEffect_DiffuseComponent.innerRadiusDiffuseType = AreaEffect_DiffuseComponent.InnerRadiusDiffuseType.SameSpeed;
	}

	private void InitFollowComponent(AreaEffectEntity entity)
	{
		AreaEffect_FollowComponent areaEffect_FollowComponent = entity.AddOrGetMonoLogicComponent<AreaEffect_FollowComponent>();
		areaEffect_FollowComponent.targetType = AreaEffect_FollowComponent.FollowTargetType.Owner;
		areaEffect_FollowComponent.isSlowMove = false;
	}
}
