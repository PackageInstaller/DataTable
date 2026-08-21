using System.Collections.Generic;
using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class EffectSystem : BaseSystem
{
	private Dictionary<int, List<EffectEntity>> effectBindGroupDic = new Dictionary<int, List<EffectEntity>>();

	protected override bool IsLogicSystem => false;

	public List<EffectEntity> GetEffectBindList(int bindId)
	{
		effectBindGroupDic.TryGetValue(bindId, out var value);
		return value;
	}

	private void AddEffectBindGroup(int bindId, EffectEntity effectEntity)
	{
		if (!effectBindGroupDic.TryGetValue(bindId, out var value))
		{
			value = new List<EffectEntity>();
			effectBindGroupDic.Add(bindId, value);
		}
		if (!value.Contains(effectEntity))
		{
			value.Add(effectEntity);
		}
	}

	public void RemoveEffectBindGroup(int bindId, EffectEntity effectEntity)
	{
		if (effectBindGroupDic.TryGetValue(bindId, out var value))
		{
			value.Remove(effectEntity);
		}
	}

	public void RemoveBindGroupEffect(int effectId)
	{
		foreach (List<EffectEntity> value in effectBindGroupDic.Values)
		{
			for (int i = 0; i < value.Count; i++)
			{
				if (value[i].Id == effectId)
				{
					value.RemoveAt(i);
					return;
				}
			}
		}
	}

	private void RemoveAllEffectBindGroup(int bindId)
	{
		if (effectBindGroupDic.ContainsKey(bindId))
		{
			effectBindGroupDic.Remove(bindId);
		}
	}

	public GameObject CreateBulletEffectGameObject(BaseEntity parentEntity, int effectId)
	{
		DREffect effectSkinIdByParentSkinConfig = parentEntity.GetEffectSkinIdByParentSkinConfig(effectId);
		if (effectSkinIdByParentSkinConfig == null)
		{
			return null;
		}
		if (!GameSettingCtrlPlayEffect(parentEntity, effectSkinIdByParentSkinConfig))
		{
			return null;
		}
		if (!EffectDataCtrlPlayEffect(parentEntity, parentEntity, effectSkinIdByParentSkinConfig))
		{
			return null;
		}
		if (effectId <= 0)
		{
			return null;
		}
		string effectAssetPathByLevel = GetEffectAssetPathByLevel(effectSkinIdByParentSkinConfig);
		return GetSystem<EntityViewCacheSystem>().LoadEntityView(effectSkinIdByParentSkinConfig.Id, effectAssetPathByLevel);
	}

	public BaseEntity PlayEffect(BaseEntity releaseEntity, BaseEntity ownerEntity, EffectType effectType, int effectId, string pointKey, Vector3 effectPoint, Vector3 effectOffset, Vector3 effectRotation, Vector3 rotationOffset, bool followParentDispose, float effectScale = 1f, bool isFollowBone = false)
	{
		if (releaseEntity != null && !((IEntityRoom)releaseEntity).InLocalActorRoom())
		{
			return null;
		}
		DREffect effectSkinIdByParentSkinConfig = releaseEntity.GetEffectSkinIdByParentSkinConfig(effectId);
		if (effectSkinIdByParentSkinConfig == null)
		{
			return null;
		}
		if (!GameSettingCtrlPlayEffect(ownerEntity, effectSkinIdByParentSkinConfig))
		{
			return null;
		}
		if (!EffectDataCtrlPlayEffect(releaseEntity, ownerEntity, effectSkinIdByParentSkinConfig))
		{
			return null;
		}
		if (effectId <= 0)
		{
			return null;
		}
		EffectData effectData = ReferencePool.Acquire<EffectData>();
		effectData.effectData = effectSkinIdByParentSkinConfig;
		effectData.effectType = effectType;
		effectData.offset = effectOffset;
		effectData.isFollowBone = isFollowBone;
		effectData.followDispose = followParentDispose;
		effectData.owner = ownerEntity;
		string effectAssetPathByLevel = GetEffectAssetPathByLevel(effectSkinIdByParentSkinConfig);
		GameObject gameObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(effectSkinIdByParentSkinConfig.Id, effectAssetPathByLevel);
		if (gameObject == null)
		{
			return null;
		}
		EntityData entityData = ReferencePool.Acquire<EntityData>();
		entityData.logicType = EntityLogicType.Display;
		entityData.updateType = EntityUpdateType.Local;
		entityData.entityObject = gameObject;
		entityData.parent = ownerEntity;
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.position = effectOffset;
		entityPositionData.scale = Vector3.one * effectScale;
		EntityBoneComponent component = ownerEntity.GetComponent<EntityBoneComponent>();
		if (component == null)
		{
			return null;
		}
		if (effectData.effectType == EffectType.FIXED_POINT)
		{
			entityPositionData.position = effectPoint + effectOffset;
			entityPositionData.rotation = effectRotation + rotationOffset;
		}
		else
		{
			Transform boneRoot = component.GetBoneRoot(pointKey);
			if (boneRoot == null)
			{
				return null;
			}
			effectData.boneTsm = boneRoot;
			switch (effectType)
			{
			case EffectType.FIXED:
				entityPositionData.position = effectData.boneTsm.position + TSUtil.TransformPoint(Vector3.zero, effectData.boneTsm.eulerAngles, effectData.boneTsm.localScale, effectOffset);
				entityPositionData.rotation = effectData.boneTsm.rotation.eulerAngles + rotationOffset;
				break;
			case EffectType.FOLLOW_ENTITY:
			case EffectType.FOLLOW_BONE_SCREEN_LIMIT:
			case EffectType.FOLLOW_BONE_POSITION:
			{
				Vector3 position = effectData.boneTsm.position;
				entityPositionData.position = TSUtil.TransformPoint(position, effectData.boneTsm.eulerAngles, effectData.boneTsm.localScale, effectOffset);
				entityPositionData.rotation = ownerEntity.transform.rotation.eulerAngles + rotationOffset;
				effectData.offset = entityPositionData.position - position;
				break;
			}
			default:
				if (effectData.effectType == EffectType.FOLLOW_BONE)
				{
					entityPositionData.rotation = rotationOffset;
					entityPositionData.position = effectOffset;
				}
				else if (effectData.effectType == EffectType.FOLLOW_EFFECTMOVE)
				{
					entityPositionData.position = TSUtil.TransformPoint(effectData.boneTsm.position, Vector3.zero, effectData.boneTsm.localScale, effectOffset);
					entityPositionData.rotation = ownerEntity.transform.rotation.eulerAngles + rotationOffset;
				}
				break;
			}
		}
		entityData.pointData = entityPositionData;
		entityData.userData = effectData;
		entityData.parent = ownerEntity;
		EffectEntity effectEntity = ((effectData.effectType != EffectType.FOLLOW_UI) ? GetSystem<EntitySystem>().CreateEntity<EffectEntity>(effectSkinIdByParentSkinConfig.Id, entityData, isSyncEntity: false, currentTickCreate: true) : GetSystem<EntitySystem>().CreateEntity<ScreenEffectEntity>(effectSkinIdByParentSkinConfig.Id, entityData, isSyncEntity: false, currentTickCreate: true));
		if (effectType == EffectType.FOLLOW_BONE)
		{
			AddEffectBindGroup(ownerEntity.Id, effectEntity);
		}
		return effectEntity;
	}

	public BaseEntity PlayFollowBulletEffect(BaseEntity ownerEntity, BaseEntity bulletEntity, EffectType effectType, int effectId, Vector3 effectOffset, Vector3 rotationOffset, bool followParentDispose, bool viewIsNeedLerp, float stableMovementSharpness, float stableRotationSharpness, float effectScale = 1f)
	{
		DREffect effectSkinIdByParentSkinConfig = ownerEntity.GetEffectSkinIdByParentSkinConfig(effectId);
		if (effectSkinIdByParentSkinConfig == null)
		{
			return null;
		}
		if (!GameSettingCtrlPlayEffect(ownerEntity, effectSkinIdByParentSkinConfig))
		{
			return null;
		}
		if (!EffectDataCtrlPlayEffect(ownerEntity, ownerEntity, effectSkinIdByParentSkinConfig))
		{
			return null;
		}
		if (effectId <= 0)
		{
			return null;
		}
		EffectData effectData = ReferencePool.Acquire<EffectData>();
		effectData.effectData = effectSkinIdByParentSkinConfig;
		effectData.effectType = effectType;
		effectData.offset = effectOffset;
		effectData.followDispose = followParentDispose;
		effectData.owner = bulletEntity;
		effectData.ViewIsNeedLerp = viewIsNeedLerp;
		effectData.StableRotationSharpness = stableRotationSharpness;
		effectData.StableMovementSharpness = stableMovementSharpness;
		string effectAssetPathByLevel = GetEffectAssetPathByLevel(effectSkinIdByParentSkinConfig);
		GameObject gameObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(effectSkinIdByParentSkinConfig.Id, effectAssetPathByLevel);
		if (gameObject == null)
		{
			return null;
		}
		EntityData entityData = ReferencePool.Acquire<EntityData>();
		entityData.logicType = EntityLogicType.Display;
		entityData.updateType = bulletEntity.UpdateType;
		entityData.entityObject = gameObject;
		entityData.parent = bulletEntity;
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.scale = Vector3.one * effectScale;
		if (effectData.effectType != EffectType.FOLLOW_ENTITY)
		{
			return null;
		}
		Vector3 position = bulletEntity.transform.position;
		entityPositionData.position = TSUtil.TransformPoint(position, bulletEntity.transform.eulerAngles, bulletEntity.transform.localScale, effectOffset);
		entityPositionData.rotation = bulletEntity.transform.rotation.eulerAngles + rotationOffset;
		effectData.offset = entityPositionData.position - position;
		entityData.pointData = entityPositionData;
		entityData.userData = effectData;
		return GetSystem<EntitySystem>().CreateEntity<EffectEntity>(effectSkinIdByParentSkinConfig.Id, entityData, isSyncEntity: false, currentTickCreate: true);
	}

	public BaseEntity PlayEffect(BaseEntity releaseEntity, BaseEntity ownerEntity, int effectId, Vector3 effectPoint, Vector3 effectRotation, float effectScale = 1f, bool isHitEffect = false)
	{
		DREffect effectSkinIdByParentSkinConfig = releaseEntity.GetEffectSkinIdByParentSkinConfig(effectId);
		if (effectSkinIdByParentSkinConfig == null)
		{
			return null;
		}
		if (world.WorldForbidPlayEffect)
		{
			return null;
		}
		if (!GameSettingCtrlPlayEffect(ownerEntity, effectSkinIdByParentSkinConfig, isHitEffect))
		{
			return null;
		}
		if (!EffectDataCtrlPlayEffect(releaseEntity, ownerEntity, effectSkinIdByParentSkinConfig))
		{
			return null;
		}
		if (effectId <= 0)
		{
			return null;
		}
		EffectData effectData = ReferencePool.Acquire<EffectData>();
		effectData.effectData = effectSkinIdByParentSkinConfig;
		effectData.effectType = (string.IsNullOrEmpty(effectSkinIdByParentSkinConfig.DefaultFollowType) ? EffectType.FIXED_POINT : Utility.Convert.StringToEnum<EffectType>(effectSkinIdByParentSkinConfig.DefaultFollowType));
		effectData.followDispose = effectSkinIdByParentSkinConfig.FollowParentDispose;
		effectData.owner = ownerEntity;
		effectData.IsAttackEffect = isHitEffect;
		string effectAssetPathByLevel = GetEffectAssetPathByLevel(effectSkinIdByParentSkinConfig);
		GameObject gameObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(effectSkinIdByParentSkinConfig.Id, effectAssetPathByLevel);
		if (gameObject == null)
		{
			return null;
		}
		EntityData entityData = ReferencePool.Acquire<EntityData>();
		entityData.logicType = EntityLogicType.Display;
		entityData.updateType = EntityUpdateType.Local;
		entityData.entityObject = gameObject;
		entityData.parent = ownerEntity;
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.position = effectPoint;
		entityPositionData.rotation = effectRotation;
		entityPositionData.scale = Vector3.one * effectScale;
		entityData.pointData = entityPositionData;
		entityData.userData = effectData;
		return GetSystem<EntitySystem>().CreateEntity<EffectEntity>(effectSkinIdByParentSkinConfig.Id, entityData, isSyncEntity: false, currentTickCreate: true);
	}

	public BaseEntity PlayForeverEffect(BaseEntity releaseEntity, BaseEntity ownerEntity, int effectId, Vector3 effectPoint, Vector3 effectRotation, float effectScale = 1f, bool isHitEffect = false)
	{
		DREffect effectSkinIdByParentSkinConfig = releaseEntity.GetEffectSkinIdByParentSkinConfig(effectId);
		if (effectSkinIdByParentSkinConfig == null)
		{
			return null;
		}
		if (world.WorldForbidPlayEffect)
		{
			return null;
		}
		if (!GameSettingCtrlPlayEffect(ownerEntity, effectSkinIdByParentSkinConfig, isHitEffect))
		{
			return null;
		}
		if (!EffectDataCtrlPlayEffect(releaseEntity, ownerEntity, effectSkinIdByParentSkinConfig))
		{
			return null;
		}
		if (effectId <= 0)
		{
			return null;
		}
		EffectData effectData = ReferencePool.Acquire<EffectData>();
		effectData.effectData = effectSkinIdByParentSkinConfig;
		effectData.effectType = (string.IsNullOrEmpty(effectSkinIdByParentSkinConfig.DefaultFollowType) ? EffectType.FIXED_POINT : Utility.Convert.StringToEnum<EffectType>(effectSkinIdByParentSkinConfig.DefaultFollowType));
		effectData.followDispose = effectSkinIdByParentSkinConfig.FollowParentDispose;
		effectData.owner = ownerEntity;
		effectData.IsAttackEffect = isHitEffect;
		string effectAssetPathByLevel = GetEffectAssetPathByLevel(effectSkinIdByParentSkinConfig);
		GameObject gameObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(effectSkinIdByParentSkinConfig.Id, effectAssetPathByLevel);
		if (gameObject == null)
		{
			return null;
		}
		EntityData entityData = ReferencePool.Acquire<EntityData>();
		entityData.logicType = EntityLogicType.Display;
		entityData.updateType = EntityUpdateType.Local;
		entityData.entityObject = gameObject;
		entityData.parent = ownerEntity;
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.position = effectPoint;
		entityPositionData.rotation = effectRotation;
		entityPositionData.scale = Vector3.one * effectScale;
		entityData.pointData = entityPositionData;
		entityData.userData = effectData;
		return GetSystem<EntitySystem>().CreateEntity<ForeverEffectEntity>(effectSkinIdByParentSkinConfig.Id, entityData, isSyncEntity: false, currentTickCreate: true);
	}

	public BaseEntity PlayLinkEffect(BaseEntity releaseEntity, int effectId, LinkEffectData linkData)
	{
		DREffect effectSkinIdByParentSkinConfig = releaseEntity.GetEffectSkinIdByParentSkinConfig(effectId);
		if (effectSkinIdByParentSkinConfig == null)
		{
			return null;
		}
		if (!GameSettingCtrlPlayEffect(linkData.OwnerEntity, effectSkinIdByParentSkinConfig))
		{
			return null;
		}
		if (!EffectDataCtrlPlayEffect(null, linkData.OwnerEntity, effectSkinIdByParentSkinConfig))
		{
			return null;
		}
		linkData.DrEffect = effectSkinIdByParentSkinConfig;
		string effectAssetPathByLevel = GetEffectAssetPathByLevel(effectSkinIdByParentSkinConfig);
		GameObject gameObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(effectSkinIdByParentSkinConfig.Id, effectAssetPathByLevel);
		if (gameObject == null)
		{
			return null;
		}
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.position = Vector3.zero;
		entityPositionData.rotation = Vector3.zero;
		EntityData entityData = ReferencePool.Acquire<EntityData>();
		entityData.logicType = EntityLogicType.Display;
		entityData.updateType = EntityUpdateType.Local;
		entityData.entityObject = gameObject;
		entityData.userData = linkData;
		entityData.parent = linkData.OwnerEntity;
		entityData.pointData = entityPositionData;
		return GetSystem<EntitySystem>().CreateEntity<LinkEffectEntity>(effectSkinIdByParentSkinConfig.Id, entityData, isSyncEntity: false, currentTickCreate: true);
	}

	public BuffEffectEntity PlayBuffEffect(BaseEntity releaseEntity, BaseEntity ownerEntity, int buffEffectType, int effectId, string pointKey, bool buffIgnoreTimeScale)
	{
		DREffect effectSkinIdByParentSkinConfig = releaseEntity.GetEffectSkinIdByParentSkinConfig(effectId);
		if (effectSkinIdByParentSkinConfig == null)
		{
			return null;
		}
		if (!GameSettingCtrlPlayEffect(ownerEntity, effectSkinIdByParentSkinConfig))
		{
			return null;
		}
		if (!EffectDataCtrlPlayEffect(releaseEntity, ownerEntity, effectSkinIdByParentSkinConfig))
		{
			return null;
		}
		BuffEffectData buffEffectData = ReferencePool.Acquire<BuffEffectData>();
		buffEffectData.effectData = effectSkinIdByParentSkinConfig;
		buffEffectData.effectType = (string.IsNullOrEmpty(effectSkinIdByParentSkinConfig.DefaultFollowType) ? EffectType.FOLLOW_BONE : Utility.Convert.StringToEnum<EffectType>(effectSkinIdByParentSkinConfig.DefaultFollowType));
		buffEffectData.followDispose = effectSkinIdByParentSkinConfig.FollowParentDispose;
		buffEffectData.owner = ownerEntity;
		buffEffectData.disposeType = buffEffectType;
		buffEffectData.BuffIgnoreTimeScale = buffIgnoreTimeScale;
		string effectAssetPathByLevel = GetEffectAssetPathByLevel(effectSkinIdByParentSkinConfig);
		GameObject gameObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(effectSkinIdByParentSkinConfig.Id, effectAssetPathByLevel);
		if (gameObject == null)
		{
			return null;
		}
		EntityBoneComponent component = ownerEntity.GetComponent<EntityBoneComponent>();
		if (component == null)
		{
			return null;
		}
		Transform boneRoot = component.GetBoneRoot(pointKey);
		if (boneRoot == null)
		{
			return null;
		}
		buffEffectData.boneTsm = boneRoot;
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.position = buffEffectData.boneTsm.position + TSUtil.TransformPoint(Vector3.zero, buffEffectData.boneTsm.eulerAngles, buffEffectData.boneTsm.localScale, Vector3.zero);
		entityPositionData.rotation = ownerEntity.transform.rotation.eulerAngles;
		entityPositionData.position = Vector3.zero;
		entityPositionData.rotation = Vector3.zero;
		EntityData entityData = ReferencePool.Acquire<EntityData>();
		entityData.logicType = EntityLogicType.Display;
		entityData.updateType = EntityUpdateType.Local;
		entityData.entityObject = gameObject;
		entityData.pointData = entityPositionData;
		entityData.userData = buffEffectData;
		entityData.parent = ownerEntity;
		BuffEffectEntity buffEffectEntity = GetSystem<EntitySystem>().CreateEntity<BuffEffectEntity>(effectSkinIdByParentSkinConfig.Id, entityData, isSyncEntity: false, currentTickCreate: true);
		AddEffectBindGroup(ownerEntity.Id, buffEffectEntity);
		return buffEffectEntity;
	}

	private bool GameSettingCtrlPlayEffect(BaseEntity ownerEntity, DREffect drEffect, bool isHitEffect = false)
	{
		if (!SystemIsNeedExecute)
		{
			return false;
		}
		if (world.WorldForbidPlayEffect)
		{
			return drEffect?.IsPlayOnReConnect ?? false;
		}
		EntitySystem system = GetSystem<EntitySystem>();
		if (system != null && system.GetEntityIsTeam(ownerEntity))
		{
			if (isHitEffect)
			{
				return GetTeammateHitEffectAlpha(drEffect) > 0f;
			}
			return GetTeammateSkillEffectAlpha(drEffect) > 0f;
		}
		return true;
	}

	public float GetTeammateSkillEffectAlpha(int effectId)
	{
		if (effectId == 0)
		{
			return 0f;
		}
		DREffect dataRow = GameEntry.DataTable.GetDataRow<DREffect>(effectId);
		return GetTeammateSkillEffectAlpha(dataRow);
	}

	public float GetTeammateSkillEffectAlpha(DREffect config)
	{
		if (config != null && config.IgnoreSettings)
		{
			return 1f;
		}
		return GameSettingExtension.GetFloatRawValue("队友技能特效强度");
	}

	public float GetTeammateHitEffectAlpha(int effectId)
	{
		if (effectId == 0)
		{
			return 0f;
		}
		DREffect dataRow = GameEntry.DataTable.GetDataRow<DREffect>(effectId);
		return GetTeammateHitEffectAlpha(dataRow);
	}

	public float GetTeammateHitEffectAlpha(DREffect config)
	{
		if (config != null && config.IgnoreSettings)
		{
			return 1f;
		}
		return GameSettingExtension.GetFloatRawValue("队友击中特效强度");
	}

	public bool EffectDataCtrlPlayEffect(BaseEntity releaseEntity, BaseEntity ownerEntity, DREffect drEffect)
	{
		if (drEffect.VFXVisibilityEnum == VFXVisibilityEnum.All)
		{
			return true;
		}
		if (drEffect.VFXVisibilityEnum == VFXVisibilityEnum.ReleasePlayerOnly)
		{
			return releaseEntity?.IsActorEntity ?? false;
		}
		if (drEffect.VFXVisibilityEnum == VFXVisibilityEnum.NotReleasePlayer)
		{
			if (releaseEntity == null)
			{
				return false;
			}
			return !releaseEntity.IsActorEntity;
		}
		if (drEffect.VFXVisibilityEnum == VFXVisibilityEnum.ParentObjectHolderOnly)
		{
			return ownerEntity?.IsActorEntity ?? false;
		}
		if (drEffect.VFXVisibilityEnum == VFXVisibilityEnum.NotParentObjectHolder)
		{
			return !(ownerEntity?.IsActorEntity ?? false);
		}
		if (drEffect.VFXVisibilityEnum == VFXVisibilityEnum.SummonerOnly)
		{
			if (releaseEntity == null || releaseEntity.GetEntityType() != EntityType.SummonedEntity)
			{
				return false;
			}
			return releaseEntity.Parent?.IsActorEntity ?? false;
		}
		return true;
	}

	public string GetEffectAssetPathByLevel(DREffect drEffect)
	{
		int intRawValue = GameSettingExtension.GetIntRawValue("特效等级");
		string result = "";
		switch (intRawValue)
		{
		case 0:
			result = drEffect.LowLevelAssetPath;
			break;
		case 1:
			result = drEffect.MidLevelAssetPath;
			break;
		case 2:
			result = drEffect.HighLevelAssetPath;
			break;
		default:
			return result;
		}
		if (string.IsNullOrEmpty(result))
		{
			result = drEffect.MidLevelAssetPath;
		}
		return result;
	}
}
