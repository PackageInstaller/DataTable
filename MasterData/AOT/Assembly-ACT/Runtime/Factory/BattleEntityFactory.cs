using System;
using ACT;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.Utility;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace Runtime.Factory;

public static class BattleEntityFactory
{
	public static async UniTask SpawnBattlePart(Entity er, string configPath, Vector3 pos, bool isBornLeft, bool active = true)
	{
		CompBehave compBehave = er.GetCompBehave();
		await compBehave.InitCharacter(configPath);
		if (!er.IsValid)
		{
			return;
		}
		ConfigCharacter config = compBehave.Config;
		if (config == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("character " + configPath + " config not exist");
			}
			return;
		}
		PrecacheUtility.Preload<YooAssetReference>(config.Precache);
		GameObject root = compBehave.Root;
		CapsuleCollider component = root.GetComponent<CapsuleCollider>();
		CompTransform? compTransform = er.GetCompTransform();
		compTransform.SetBaseCollider(component);
		if (!CompPhysics.IsGroundLikeMotion(config.motionType))
		{
			root.transform.position = pos;
		}
		else
		{
			root.transform.position = PhysicsUtility.GetGroundPoint(pos + component.center + new Vector3(0f, 0.05f, 0f), component.Size()) - component.center;
		}
		compTransform.InitPosition(root.transform.position);
		CompPhysics? compPhysics = er.GetCompPhysics();
		compPhysics.motion = config.motionType;
		compPhysics.SetConstZ(pos.z);
		CompMotion compMotion = er.GetCompMotion();
		compMotion.Init(compBehave.Animator);
		CompAbility compAbility = er.GetCompAbility();
		compAbility.BattleInit();
		CompAbilityBindAction(er);
		MonoECS.instance.SpawnBehave(er, isBornLeft);
		CompAim compAim = er.GetCompAim();
		if (compAim != null && (object)compAim.aimIK != null)
		{
			compAim.ikOriginTrans = compAim.aimIK.solver.transform;
		}
		CompSound compSound = er.GetCompSound();
		if (config.audioConfig != null)
		{
			foreach (YooAssetReference item in config.audioConfig.FmodBanksAssetID)
			{
				compSound.LoadBank(item);
			}
			compSound.Init(config.audioConfig.ToVoiceMap());
		}
		else if (config.fmodBanksAssetID != null)
		{
			foreach (YooAssetReference item2 in config.fmodBanksAssetID)
			{
				compSound.LoadBank(item2);
			}
		}
		compAbility.AddAbilities(config.abilities, AbilitySource.Passive);
		if (config.abilitiyBindings != null)
		{
			compAbility.AddAbilitiesByBindings(config.abilitiyBindings);
		}
		if (er.IsCharacter())
		{
			EntityType entityType = er.GetEntityType();
			if (entityType == EntityType.Monster || entityType == EntityType.Boss || entityType == EntityType.Elite)
			{
				return;
			}
		}
		if (!string.IsNullOrEmpty(config.ultimetaTimelineAssetID.GUID))
		{
			AssetStationManager.BattleStation.InstantiateAsync(config.ultimetaTimelineAssetID, (AssetLoadHandle result) =>
			{
				GameObject gameObject = result.AsGameObject();
				gameObject.SetActive(value: false);
				compMotion.ultimetaTimeline = gameObject;
			});
		}
		if (!string.IsNullOrEmpty(config.monsterUltimetaTimelineAssetID.GUID))
		{
			AssetStationManager.BattleStation.InstantiateAsync(config.ultimetaTimelineAssetID, (AssetLoadHandle result) =>
			{
				GameObject gameObject = result.AsGameObject();
				gameObject.SetActive(value: false);
				compMotion.ultimetaTimeline = gameObject;
			});
		}
		EffectDressRuntimeUtility.SyncDressFromCharacter(er);
		SpawnCharacterBattlePartEvt evt = Singleton<EventManager>.instance.GetEvt<SpawnCharacterBattlePartEvt>();
		evt.entityBehave = er;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnSpawnCharacterBattlePart, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private static void CompAbilityBindAction(Entity eb)
	{
		CompAbility compAbility = eb.GetCompAbility();
		compAbility.onEntityHpChange += (Action<int, int, Entity>)((int pre, int after, Entity er) =>
		{
			EventManager instance = Singleton<EventManager>.instance;
			EntityHpChangeEvt evt = instance.GetEvt<EntityHpChangeEvt>();
			evt.oldHp = pre;
			evt.curHp = after;
			evt.basicMaxHp = compAbility.maxHP;
			evt.curMaxHp = compAbility.maxHP;
			evt.curHpPercentage = (float)evt.curHp / (float)evt.curMaxHp;
			instance.EventDispatch(ClientEvent.EntityHpChange, evt);
			instance.ReleaseEvt(evt);
		});
		CompAbility compAbility2 = compAbility;
		compAbility2.onActivePostureChange = (Action<Entity, bool>)Delegate.Combine(compAbility2.onActivePostureChange, (Action<Entity, bool>)((Entity entity, bool active) =>
		{
			if (active)
			{
				EventManager instance = Singleton<EventManager>.instance;
				EntityEnterPostureEvt evt = instance.GetEvt<EntityEnterPostureEvt>();
				instance.EventDispatch(ClientEvent.EntityEnterPosture, evt);
				instance.ReleaseEvt(evt);
			}
			else
			{
				EventManager instance2 = Singleton<EventManager>.instance;
				EntityExitPostureEvt evt2 = instance2.GetEvt<EntityExitPostureEvt>();
				instance2.EventDispatch(ClientEvent.EntityExitPosture, evt2);
				instance2.ReleaseEvt(evt2);
			}
		}));
		CompAbility compAbility3 = compAbility;
		compAbility3.onPostureChange = (Action<Entity, int, int>)Delegate.Combine(compAbility3.onPostureChange, (Action<Entity, int, int>)((Entity entity, int pre, int after) =>
		{
			EventManager instance = Singleton<EventManager>.instance;
			EntityPostureChangeEvt evt = instance.GetEvt<EntityPostureChangeEvt>();
			evt.entityId = entity.Id;
			evt.maxPosture = compAbility.maxPosture;
			evt.oldPosture = pre;
			evt.curPosture = after;
			evt.curPosturePercentage = (float)evt.curPosture / (float)evt.maxPosture;
			instance.EventDispatch(ClientEvent.EntityPostureChange, evt);
			instance.ReleaseEvt(evt);
		}));
		CompAbility compAbility4 = compAbility;
		compAbility4.onRevivePostureProgressChange = (Action<Entity, float, float>)Delegate.Combine(compAbility4.onRevivePostureProgressChange, (Action<Entity, float, float>)((Entity entity, float pre, float after) =>
		{
			if (Mathf.Approximately(pre, 1f) && after < 1f)
			{
				EventManager instance = Singleton<EventManager>.instance;
				EntityEnterWeakEvt evt = instance.GetEvt<EntityEnterWeakEvt>();
				evt.curWeakPercentage = compAbility.revivePostureProgress;
				instance.EventDispatch(ClientEvent.EntityEnterWeak, evt);
				instance.ReleaseEvt(evt);
			}
			else if (pre < 1f && Mathf.Approximately(after, 1f))
			{
				if (!compAbility.IsWeak)
				{
					EventManager instance2 = Singleton<EventManager>.instance;
					EntityExitWeakEvt evt2 = instance2.GetEvt<EntityExitWeakEvt>();
					instance2.EventDispatch(ClientEvent.EntityExitWeak, evt2);
					instance2.ReleaseEvt(evt2);
				}
			}
			else
			{
				EventManager instance3 = Singleton<EventManager>.instance;
				EntityWeakChangeEvt evt3 = instance3.GetEvt<EntityWeakChangeEvt>();
				evt3.weakPercentage = after;
				instance3.EventDispatch(ClientEvent.EntityWeakChange, evt3);
				instance3.ReleaseEvt(evt3);
			}
		}));
		CompAbility compAbility5 = compAbility;
		compAbility5.onPostureBurstChange = (Action<Entity, bool>)Delegate.Combine(compAbility5.onPostureBurstChange, (Action<Entity, bool>)((Entity entity, bool active) =>
		{
			if (active)
			{
				EventManager instance = Singleton<EventManager>.instance;
				EntityEnterBurstEvt evt = instance.GetEvt<EntityEnterBurstEvt>();
				instance.EventDispatch(ClientEvent.EntityEnterBurst, evt);
				instance.ReleaseEvt(evt);
			}
			else
			{
				EventManager instance2 = Singleton<EventManager>.instance;
				EntityExitBurstEvt evt2 = instance2.GetEvt<EntityExitBurstEvt>();
				instance2.EventDispatch(ClientEvent.EntityExitBurst, evt2);
				instance2.ReleaseEvt(evt2);
			}
		}));
		CompAbility compAbility6 = compAbility;
		compAbility6.onCharacterDamageHit = (Action<Entity, int>)Delegate.Combine(compAbility6.onCharacterDamageHit, (Action<Entity, int>)((Entity entity, int i) =>
		{
			EventManager instance = Singleton<EventManager>.instance;
			EntityHitByCharacterEvt evt = instance.GetEvt<EntityHitByCharacterEvt>();
			evt.entityId = entity.Id;
			evt.characterDamageType = i;
			instance.EventDispatch(ClientEvent.EntityHitByCharacter, evt);
			instance.ReleaseEvt(evt);
		}));
	}
}
