using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class BulletSystem : BaseSystem
{
	private Dictionary<int, int> changeCreateBulletDic = new Dictionary<int, int>();

	private Dictionary<int, List<BulletChangeTagData>> bulletChangeTagDataDic = new Dictionary<int, List<BulletChangeTagData>>();

	private Dictionary<int, List<BulletChangeAdditionData>> bulletChangeAdditionDataDic = new Dictionary<int, List<BulletChangeAdditionData>>();

	private Dictionary<int, List<BulletChangeBuffData>> bulletChangeBuffDataDic = new Dictionary<int, List<BulletChangeBuffData>>();

	private Dictionary<int, List<BulletModifySiteLevelData>> bulletModifySiteLevelDataDic = new Dictionary<int, List<BulletModifySiteLevelData>>();

	protected override bool IsLogicSystem => true;

	public async Task<BulletEntity> CreateBulletEntity(BaseEntity ownerEntity, int bulletId, bool useSelfPoint, Vector3 bulletPoint, float rotationOffsetY, OffsetConfigurationType configurationType, Vector3 offset, float distance, float angle, float heightOffset, bool currentTickCreate, bool viewIsNeedLerp, float stableMovementSharpness, float stableRotationSharpness)
	{
		InitData(ref bulletId, isOnlyExecuteHit: false, ownerEntity, viewIsNeedLerp, stableMovementSharpness, stableRotationSharpness, out var drBullet, out var entityData, out var bulletData);
		if (drBullet == null)
		{
			return null;
		}
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.rotation = ownerEntity.transform.eulerAngles + new Vector3(0f, rotationOffsetY, 0f);
		Vector3 vector = (useSelfPoint ? ownerEntity.transform.position : bulletPoint);
		switch (configurationType)
		{
		case OffsetConfigurationType.Offset:
			entityPositionData.position = vector + ownerEntity.transform.rotation * offset + ownerEntity.transform.rotation * drBullet.PositionOffset.ToVector3();
			break;
		case OffsetConfigurationType.Direct:
			entityPositionData.position = vector + ownerEntity.transform.rotation * new Vector3(distance * Mathf.Sin(angle * (MathF.PI / 180f)), vector.y + heightOffset, distance * Mathf.Cos(angle * (MathF.PI / 180f))) + ownerEntity.transform.rotation * drBullet.PositionOffset.ToVector3();
			break;
		}
		entityPositionData.position.y += drBullet.OffsetHeight;
		GameObject entityObject = PlayBulletEffect(ownerEntity, drBullet);
		entityData.pointData = entityPositionData;
		entityData.userData = bulletData;
		entityData.parent = ownerEntity;
		entityData.entityObject = entityObject;
		entityData.currentTickCreate = currentTickCreate;
		return GetSystem<EntitySystem>().CreateEntity<BulletEntity>(bulletId, entityData, isSyncEntity: false, currentTickCreate);
	}

	public async Task<BulletEntity> CreateReboundBulletEntity(BaseEntity ownerEntity, int bulletId, bool useSelfPoint, Vector3 bulletPoint, float rotationOffsetY, OffsetConfigurationType configurationType, Vector3 offset, float distance, float angle, float heightOffset, bool currentTickCreate, int reboundCount, bool isReboundEndDead, bool viewIsNeedLerp, float stableMovementSharpness, float stableRotationSharpness)
	{
		InitData(ref bulletId, isOnlyExecuteHit: false, ownerEntity, viewIsNeedLerp, stableMovementSharpness, stableRotationSharpness, out var drBullet, out var entityData, out var bulletData);
		if (drBullet == null)
		{
			return null;
		}
		bulletData.extraData.reboundData = new BulletReboundData
		{
			reboundCount = reboundCount,
			isReboundEndDead = isReboundEndDead
		};
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.rotation = ownerEntity.transform.eulerAngles + new Vector3(0f, rotationOffsetY, 0f);
		Vector3 vector = (useSelfPoint ? ownerEntity.transform.position : bulletPoint);
		switch (configurationType)
		{
		case OffsetConfigurationType.Offset:
			entityPositionData.position = vector + ownerEntity.transform.rotation * offset + ownerEntity.transform.rotation * drBullet.PositionOffset.ToVector3();
			break;
		case OffsetConfigurationType.Direct:
			entityPositionData.position = vector + ownerEntity.transform.rotation * new Vector3(distance * Mathf.Sin(angle * (MathF.PI / 180f)), vector.y + heightOffset, distance * Mathf.Cos(angle * (MathF.PI / 180f))) + ownerEntity.transform.rotation * drBullet.PositionOffset.ToVector3();
			break;
		}
		entityPositionData.position.y += drBullet.OffsetHeight;
		GameObject entityObject = PlayBulletEffect(ownerEntity, drBullet);
		entityData.pointData = entityPositionData;
		entityData.userData = bulletData;
		entityData.parent = ownerEntity;
		entityData.entityObject = entityObject;
		entityData.currentTickCreate = currentTickCreate;
		return GetSystem<EntitySystem>().CreateEntity<BulletEntity>(bulletId, entityData, isSyncEntity: false, currentTickCreate);
	}

	public async Task<BulletEntity> CreateFixedPointBulletEntity(BaseEntity ownerEntity, int bulletId, Vector3 bulletPoint, float angle, bool currentTickCreate, bool viewIsNeedLerp, float stableMovementSharpness, float stableRotationSharpness)
	{
		InitData(ref bulletId, isOnlyExecuteHit: false, ownerEntity, viewIsNeedLerp, stableMovementSharpness, stableRotationSharpness, out var drBullet, out var entityData, out var bulletData);
		if (drBullet == null)
		{
			return null;
		}
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.position = bulletPoint;
		entityPositionData.rotation = new Vector3(0f, angle, 0f);
		entityPositionData.position += drBullet.PositionOffset.ToVector3();
		entityPositionData.position.y += drBullet.OffsetHeight;
		GameObject entityObject = PlayBulletEffect(ownerEntity, drBullet);
		entityData.pointData = entityPositionData;
		entityData.userData = bulletData;
		entityData.parent = ownerEntity;
		entityData.entityObject = entityObject;
		entityData.currentTickCreate = currentTickCreate;
		return GetSystem<EntitySystem>().CreateEntity<BulletEntity>(bulletId, entityData, isSyncEntity: false, currentTickCreate);
	}

	public async Task<BulletEntity> CreateMapBulletEntity(BaseEntity ownerEntity, int bulletId, bool useSelfPoint, Vector3 bulletPoint, float rotationOffsetY, OffsetConfigurationType configurationType, Vector3 offset, float distance, float angle, float heightOffset, BulletMapExData mapExData)
	{
		InitData(ref bulletId, isOnlyExecuteHit: false, ownerEntity, viewIsNeedLerp: false, 0.2f, 0.033f, out var drBullet, out var entityData, out var bulletData, null, mapExData);
		if (drBullet == null)
		{
			return null;
		}
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.rotation = ownerEntity.transform.eulerAngles + new Vector3(0f, rotationOffsetY, 0f);
		Vector3 vector = (useSelfPoint ? ownerEntity.transform.position : bulletPoint);
		switch (configurationType)
		{
		case OffsetConfigurationType.Offset:
			entityPositionData.position = vector + ownerEntity.transform.rotation * offset + ownerEntity.transform.rotation * drBullet.PositionOffset.ToVector3();
			break;
		case OffsetConfigurationType.Direct:
			entityPositionData.position = vector + ownerEntity.transform.rotation * new Vector3(distance * Mathf.Sin(angle * (MathF.PI / 180f)), vector.y + heightOffset, distance * Mathf.Cos(angle * (MathF.PI / 180f))) + ownerEntity.transform.rotation * drBullet.PositionOffset.ToVector3();
			break;
		}
		entityPositionData.position.y += drBullet.OffsetHeight;
		GameObject entityObject = PlayBulletEffect(ownerEntity, drBullet);
		entityData.pointData = entityPositionData;
		entityData.userData = bulletData;
		entityData.parent = ownerEntity;
		entityData.entityObject = entityObject;
		return GetSystem<EntitySystem>().CreateEntity<BulletEntity>(bulletId, entityData);
	}

	public async Task<BulletEntity> CreateTrackedBulletEntity(BaseEntity ownerEntity, int bulletId, bool useSelfPoint, bool useTargetIdPoint, Vector3 position, Vector3 offset, Vector3 eulerOffset, int targetId, Vector3 targetPoint, Vector3 targetOffset, List<BulletTrackedStageData> stageDataList, bool currentTickCreate, bool viewIsNeedLerp, float stableMovementSharpness, float stableRotationSharpness)
	{
		InitData(ref bulletId, isOnlyExecuteHit: false, ownerEntity, viewIsNeedLerp, stableMovementSharpness, stableRotationSharpness, out var drBullet, out var entityData, out var bulletData);
		if (drBullet == null)
		{
			return null;
		}
		if (drBullet.MovementTrajectoryTypeEnum != MovementTrajectoryTypeEnum.Tracked)
		{
			return null;
		}
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.rotation = ownerEntity.transform.eulerAngles + eulerOffset;
		entityPositionData.position = (useSelfPoint ? ownerEntity.transform.position : position);
		entityPositionData.position += ownerEntity.transform.rotation * offset + ownerEntity.transform.rotation * drBullet.PositionOffset.ToVector3();
		entityPositionData.position.y += drBullet.OffsetHeight;
		GameObject entityObject = PlayBulletEffect(ownerEntity, drBullet);
		bulletData.extraData.moveData = new BulletTrackedData
		{
			targetId = targetId,
			targetPos = targetPoint,
			useTargetIdPoint = useTargetIdPoint,
			targetOffset = targetOffset,
			stageDataList = stageDataList
		};
		entityData.pointData = entityPositionData;
		entityData.userData = bulletData;
		entityData.parent = ownerEntity;
		entityData.entityObject = entityObject;
		entityData.currentTickCreate = currentTickCreate;
		return GetSystem<EntitySystem>().CreateEntity<BulletEntity>(bulletId, entityData, isSyncEntity: false, currentTickCreate);
	}

	public async Task<BulletEntity> CreateBulletEntity(BaseEntity ownerEntity, int bulletId, Vector3 bornPoint, Vector3 bornEnu, bool currentTickCreate, BulletExtraData extraData = null, bool viewIsNeedLerp = false, float stableMovementSharpness = 0.2f, float stableRotationSharpness = 0.033f)
	{
		InitData(ref bulletId, isOnlyExecuteHit: false, ownerEntity, viewIsNeedLerp, stableMovementSharpness, stableRotationSharpness, out var drBullet, out var entityData, out var bulletData, extraData);
		if (drBullet == null)
		{
			return null;
		}
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.rotation = bornEnu;
		entityPositionData.position = bornPoint + ownerEntity.transform.rotation * drBullet.PositionOffset.ToVector3();
		entityPositionData.position.y += drBullet.OffsetHeight;
		GameObject entityObject = PlayBulletEffect(ownerEntity, drBullet);
		entityData.pointData = entityPositionData;
		entityData.userData = bulletData;
		entityData.parent = ownerEntity;
		entityData.entityObject = entityObject;
		entityData.currentTickCreate = currentTickCreate;
		return GetSystem<EntitySystem>().CreateEntity<BulletEntity>(bulletId, entityData, isSyncEntity: false, currentTickCreate);
	}

	public async Task<BulletEntity> CopyBulletEntity(BaseEntity ownerEntity, BulletEntity bullet, int bulletId)
	{
		DRBullet dataRow = GameEntry.DataTable.GetDataRow<DRBullet>(bulletId);
		if (dataRow == null)
		{
			return null;
		}
		EntityData entityData = bullet.EntityData.Clone();
		BulletData data = bullet.GetData<BulletData>("bulletData");
		if (data == null)
		{
			return null;
		}
		BulletData bulletData = ReferencePool.Acquire<BulletData>();
		bulletData.isOnlyExecuteHit = data.isOnlyExecuteHit;
		bulletData.cfg = dataRow;
		bulletData.configId = bulletId;
		bulletData.alert_hitColliderScale = data.alert_hitColliderScale;
		bulletData.alert_lifeTime = data.alert_lifeTime;
		bulletData.extraData = data.extraData.Clone();
		GameObject entityObject = PlayBulletEffect(ownerEntity, dataRow);
		entityData.userData = bulletData;
		entityData.parent = ownerEntity;
		entityData.entityObject = entityObject;
		return GetSystem<EntitySystem>().CreateEntity<BulletEntity>(bulletId, entityData);
	}

	public async Task<BulletEntity> CreateMapBulletEntity(BaseEntity ownerEntity, int bulletId, Vector3 bornPoint, Vector3 bornEnu, BulletMapExData mapExData = null)
	{
		InitData(ref bulletId, isOnlyExecuteHit: false, ownerEntity, viewIsNeedLerp: false, 0.2f, 0.033f, out var drBullet, out var entityData, out var bulletData, null, mapExData);
		if (drBullet == null)
		{
			return null;
		}
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.rotation = bornEnu;
		entityPositionData.position = bornPoint + ownerEntity.transform.rotation * drBullet.PositionOffset.ToVector3();
		entityPositionData.position.y += drBullet.OffsetHeight;
		GameObject entityObject = PlayBulletEffect(ownerEntity, drBullet);
		entityData.pointData = entityPositionData;
		entityData.userData = bulletData;
		entityData.parent = ownerEntity;
		entityData.entityObject = entityObject;
		return GetSystem<EntitySystem>().CreateEntity<BulletEntity>(bulletId, entityData);
	}

	public async Task<BulletEntity> CreateBulletEntity(BaseEntity ownerEntity, int bulletId, BaseEntity targetEntity, float rotationOffsetY, Vector3 targetPoint, float oriAngle, float radius, bool currentTickCreate, bool viewIsNeedLerp, float stableMovementSharpness, float stableRotationSharpness)
	{
		InitData(ref bulletId, isOnlyExecuteHit: false, ownerEntity, viewIsNeedLerp, stableMovementSharpness, stableRotationSharpness, out var drBullet, out var entityData, out var bulletData);
		if (drBullet == null)
		{
			return null;
		}
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		_ = Vector3.zero;
		_ = Vector3.zero;
		Vector3 position;
		if (targetEntity != null)
		{
			Vector3 vector = new Vector3(radius * Mathf.Sin(oriAngle * (MathF.PI / 180f)), 0f, radius * Mathf.Cos(oriAngle * (MathF.PI / 180f)));
			position = targetEntity.transform.position + vector;
			position += drBullet.PositionOffset.ToVector3();
		}
		else
		{
			Vector3 vector = new Vector3(radius * Mathf.Sin(oriAngle * (MathF.PI / 180f)), 0f, radius * Mathf.Cos(oriAngle * (MathF.PI / 180f)));
			position = targetPoint + vector;
		}
		entityPositionData.position = position;
		entityPositionData.rotation = ownerEntity.transform.eulerAngles + new Vector3(0f, rotationOffsetY, 0f);
		entityPositionData.position.y += drBullet.OffsetHeight;
		GameObject entityObject = PlayBulletEffect(ownerEntity, drBullet);
		entityData.pointData = entityPositionData;
		entityData.userData = bulletData;
		entityData.parent = ownerEntity;
		entityData.entityObject = entityObject;
		entityData.currentTickCreate = currentTickCreate;
		return GetSystem<EntitySystem>().CreateEntity<BulletEntity>(bulletId, entityData);
	}

	public AlertBulletEntity CreateAlertBulletEntity(float leadTime, BaseEntity ownerEntity, int bulletId, bool useSelfPoint, Vector3 bulletPoint, float rotationOffsetY, OffsetConfigurationType configurationType, Vector3 offset, float distance, float angle, float heightOffset, float hitColliderScale, float lifeTime, bool viewIsNeedLerp, bool currentTickCreate, float stableMovementSharpness, float stableRotationSharpness)
	{
		InitData(ref bulletId, isOnlyExecuteHit: false, ownerEntity, viewIsNeedLerp, stableMovementSharpness, stableRotationSharpness, out var drBullet, out var entityData, out var bulletData);
		if (drBullet == null)
		{
			return null;
		}
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.rotation = ownerEntity.transform.eulerAngles + new Vector3(0f, rotationOffsetY, 0f);
		Vector3 vector = (useSelfPoint ? ownerEntity.transform.position : bulletPoint);
		switch (configurationType)
		{
		case OffsetConfigurationType.Offset:
			entityPositionData.position = vector + ownerEntity.transform.rotation * offset + ownerEntity.transform.rotation * drBullet.PositionOffset.ToVector3();
			break;
		case OffsetConfigurationType.Direct:
			entityPositionData.position = vector + ownerEntity.transform.rotation * new Vector3(distance * Mathf.Sin(angle * (MathF.PI / 180f)), vector.y + heightOffset, distance * Mathf.Cos(angle * (MathF.PI / 180f))) + ownerEntity.transform.rotation * drBullet.PositionOffset.ToVector3();
			break;
		}
		entityPositionData.position.y += drBullet.OffsetHeight;
		entityData.pointData = entityPositionData;
		entityData.userData = bulletData;
		entityData.parent = ownerEntity;
		entityData.currentTickCreate = currentTickCreate;
		bulletData.alert_hitColliderScale = hitColliderScale;
		bulletData.alert_lifeTime = lifeTime;
		return GetSystem<EntitySystem>().CreateEntity<AlertBulletEntity>(bulletId, entityData);
	}

	public AlertBulletEntity CreateFixedPointAlertBulletEntity(float leadTime, BaseEntity ownerEntity, int bulletId, Vector3 bornPoint, float bornAngle, float hitColliderScale, float lifeTime, bool currentTickCreate, bool viewIsNeedLerp, float stableMovementSharpness, float stableRotationSharpness)
	{
		InitData(ref bulletId, isOnlyExecuteHit: false, ownerEntity, viewIsNeedLerp, stableMovementSharpness, stableRotationSharpness, out var drBullet, out var entityData, out var bulletData);
		if (drBullet == null)
		{
			return null;
		}
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.rotation = new Vector3(0f, bornAngle, 0f);
		entityPositionData.position = bornPoint;
		entityPositionData.position += drBullet.PositionOffset.ToVector3();
		entityPositionData.position.y += drBullet.OffsetHeight;
		entityData.pointData = entityPositionData;
		entityData.userData = bulletData;
		entityData.parent = ownerEntity;
		entityData.currentTickCreate = currentTickCreate;
		bulletData.alert_hitColliderScale = hitColliderScale;
		bulletData.alert_lifeTime = lifeTime;
		return GetSystem<EntitySystem>().CreateEntity<AlertBulletEntity>(bulletId, entityData);
	}

	public BulletEntity CreateConfigBulletEntity(BaseEntity ownerEntity, BaseEntity fromEntity, int bulletId)
	{
		if (ownerEntity == null || fromEntity == null)
		{
			return null;
		}
		InitData(ref bulletId, isOnlyExecuteHit: false, ownerEntity, viewIsNeedLerp: false, 0f, 0f, out var drBullet, out var entityData, out var bulletData);
		if (drBullet == null)
		{
			return null;
		}
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.position = ownerEntity.transform.position;
		entityPositionData.rotation = ownerEntity.transform.eulerAngles;
		entityPositionData.position += drBullet.PositionOffset.ToVector3();
		entityPositionData.position.y += drBullet.OffsetHeight;
		GameObject entityObject = PlayBulletEffect(ownerEntity, drBullet);
		entityData.pointData = entityPositionData;
		entityData.userData = bulletData;
		entityData.parent = fromEntity;
		entityData.entityObject = entityObject;
		entityData.currentTickCreate = false;
		if (drBullet.MovementTrajectoryTypeEnum == MovementTrajectoryTypeEnum.FollowMove)
		{
			bulletData.extraData.moveData = new BulletFollowMoveData
			{
				followTargetId = ownerEntity.Id
			};
		}
		return GetSystem<EntitySystem>().CreateEntity<BulletEntity>(bulletId, entityData);
	}

	public BulletEntity CreateEmptyBulletEntity(int bulletId, BaseEntity ownerEntity, BaseEntity targetEntity, Vector3 position)
	{
		InitData(ref bulletId, isOnlyExecuteHit: true, ownerEntity, viewIsNeedLerp: false, 0.2f, 0.033f, out var drBullet, out var entityData, out var bulletData);
		if (drBullet == null)
		{
			return null;
		}
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.rotation = targetEntity.transform.eulerAngles;
		entityPositionData.position = position;
		entityData.pointData = entityPositionData;
		entityData.userData = bulletData;
		entityData.parent = ownerEntity;
		return GetSystem<EntitySystem>().CreateEntity<BulletEntity>(bulletId, entityData);
	}

	private void InitData(ref int bulletId, bool isOnlyExecuteHit, BaseEntity ownerEntity, bool viewIsNeedLerp, float stableMovementSharpness, float stableRotationSharpness, out DRBullet drBullet, out EntityData entityData, out BulletData bulletData, BulletExtraData extraData = null, BulletMapExData mapExData = null)
	{
		if (ownerEntity == null)
		{
			entityData = null;
			drBullet = null;
			bulletData = null;
			return;
		}
		if (changeCreateBulletDic != null && changeCreateBulletDic.TryGetValue(bulletId, out var value))
		{
			bulletId = value;
		}
		drBullet = GameEntry.DataTable.GetDataRow<DRBullet>(bulletId);
		if (drBullet == null)
		{
			entityData = null;
			bulletData = null;
			return;
		}
		bulletData = ReferencePool.Acquire<BulletData>();
		bulletData.isOnlyExecuteHit = isOnlyExecuteHit;
		bulletData.cfg = drBullet;
		bulletData.configId = bulletId;
		bulletData.parentPosition = ownerEntity.transform.position;
		bulletData.ViewIsNeedLerp = viewIsNeedLerp;
		bulletData.StableMovementSharpness = stableMovementSharpness;
		bulletData.StableRotationSharpness = stableRotationSharpness;
		if (extraData == null)
		{
			extraData = CreateBulletExtraData(ownerEntity.Id, drBullet);
		}
		extraData.battleOnceData = new BulletBattleOnceData();
		extraData.bulletMapExData = mapExData;
		bulletData.extraData = extraData;
		entityData = ReferencePool.Acquire<EntityData>();
		entityData.logicType = ownerEntity.LogicType;
		entityData.updateType = ownerEntity.UpdateType;
	}

	public LogicBullet CreateBulletLogic(BaseEntity bullet, BulletData data)
	{
		if (data.isOnlyExecuteHit)
		{
			return null;
		}
		Type type = null;
		if (!CheckType(data.cfg.BulletRangeTypeEnum, ref type))
		{
			return null;
		}
		LogicBullet obj = (LogicBullet)ReferencePool.Acquire(type);
		obj.OnInit(bullet);
		return obj;
	}

	private bool CheckType(BulletRangeTypeEnum dataRangeType, ref Type type)
	{
		switch (dataRangeType)
		{
		case BulletRangeTypeEnum.Instant:
			type = typeof(InstantLogicBullet);
			return true;
		case BulletRangeTypeEnum.Persistent:
			type = typeof(PersistentLogicBullet);
			return true;
		default:
			return false;
		}
	}

	public LogicBullet CreateAlertBulletLogic(BaseEntity bullet, BulletData data)
	{
		Type type = null;
		if (!CheckAlertType(data.cfg.BulletRangeTypeEnum, ref type))
		{
			return null;
		}
		LogicBullet obj = (LogicBullet)ReferencePool.Acquire(type);
		obj.OnInit(bullet);
		return obj;
	}

	private bool CheckAlertType(BulletRangeTypeEnum dataRangeType, ref Type type)
	{
		switch (dataRangeType)
		{
		case BulletRangeTypeEnum.Instant:
			type = typeof(AlertInstantLogicBullet);
			return true;
		case BulletRangeTypeEnum.Persistent:
			type = typeof(AlertPersistentLogicBullet);
			return true;
		default:
			return false;
		}
	}

	private GameObject PlayBulletEffect(BaseEntity parentEntity, DRBullet bulletCfg)
	{
		return GetSystem<EffectSystem>().CreateBulletEffectGameObject(parentEntity, bulletCfg.SelfSfx);
	}

	private bool IsCanPlayEffect(BaseEntity ownerEntity, DREffect drEffect)
	{
		return false;
	}

	public override void OnDispose()
	{
		base.OnDispose();
		OnDisposeDataReplace();
	}

	public void AddChangeCreateBullet(int bulletId, int changedId)
	{
		if (changeCreateBulletDic.ContainsKey(bulletId))
		{
			changeCreateBulletDic[bulletId] = changedId;
		}
		else
		{
			changeCreateBulletDic.Add(bulletId, changedId);
		}
	}

	public void RemoveChangeCreateBullet(int bulletId)
	{
		if (changeCreateBulletDic.ContainsKey(bulletId))
		{
			changeCreateBulletDic.Remove(bulletId);
		}
	}

	public void AddChangeTagData(int entityId, BulletChangeTagData data)
	{
		if (!bulletChangeTagDataDic.TryGetValue(entityId, out var value))
		{
			value = new List<BulletChangeTagData>();
			bulletChangeTagDataDic.Add(entityId, value);
		}
		value.Add(data);
	}

	public void RemoveChangeTagData(int entityId, BulletChangeTagData data)
	{
		if (bulletChangeTagDataDic.TryGetValue(entityId, out var value))
		{
			value.Remove(data);
		}
	}

	public void AddChangeAdditionData(int entityId, BulletChangeAdditionData data)
	{
		if (!bulletChangeAdditionDataDic.TryGetValue(entityId, out var value))
		{
			value = new List<BulletChangeAdditionData>();
			bulletChangeAdditionDataDic.Add(entityId, value);
		}
		value.Add(data);
	}

	public void RemoveChangeAdditionData(int entityId, BulletChangeAdditionData data)
	{
		if (bulletChangeAdditionDataDic.TryGetValue(entityId, out var value))
		{
			value.Remove(data);
		}
	}

	public void AddChangeBuffData(int entityId, BulletChangeBuffData data)
	{
		if (!bulletChangeBuffDataDic.TryGetValue(entityId, out var value))
		{
			value = new List<BulletChangeBuffData>();
			bulletChangeBuffDataDic.Add(entityId, value);
		}
		value.Add(data);
	}

	public void RemoveChangeBuffData(int entityId, BulletChangeBuffData data)
	{
		if (bulletChangeBuffDataDic.TryGetValue(entityId, out var value))
		{
			value.Remove(data);
		}
	}

	public void AddModifySiteLevelData(int entityId, BulletModifySiteLevelData data)
	{
		if (!bulletModifySiteLevelDataDic.TryGetValue(entityId, out var value))
		{
			value = new List<BulletModifySiteLevelData>();
			bulletModifySiteLevelDataDic.Add(entityId, value);
		}
		value.Add(data);
	}

	public void RemoveModifySiteLevelData(int entityId, BulletModifySiteLevelData data)
	{
		if (bulletModifySiteLevelDataDic.TryGetValue(entityId, out var value))
		{
			value.Remove(data);
		}
	}

	public List<BulletChangeBuffData> GetChangeBuffDataList(int entityId)
	{
		if (bulletChangeBuffDataDic.TryGetValue(entityId, out var value))
		{
			return value;
		}
		return null;
	}

	public BulletExtraData CreateBulletExtraData(int entityId, DRBullet config)
	{
		BulletExtraData bulletExtraData = new BulletExtraData();
		bulletExtraData.runtimeConfigData = CreateBulletRuntimeConfigData(entityId, config);
		bulletExtraData.initData = CreateBulletInitData(entityId, config.Id, bulletExtraData.runtimeConfigData);
		return bulletExtraData;
	}

	private BulletInitData CreateBulletInitData(int entityId, int configId, BulletRuntimeConfigData runtimeConfigData)
	{
		BulletInitData bulletInitData = new BulletInitData();
		bulletInitData.modifySiteLevelEnum = BulletModifySiteLevelEnum.None;
		if (bulletModifySiteLevelDataDic.TryGetValue(entityId, out var value))
		{
			foreach (BulletModifySiteLevelData item in value)
			{
				if (CheckContainsBulletToModify(item, configId, runtimeConfigData))
				{
					bulletInitData.modifySiteLevelEnum = item.modifySiteLevelEnum;
				}
			}
		}
		return bulletInitData;
	}

	private BulletRuntimeConfigData CreateBulletRuntimeConfigData(int entityId, DRBullet config)
	{
		BulletRuntimeConfigData bulletRuntimeConfigData = new BulletRuntimeConfigData();
		bulletRuntimeConfigData.InitConfig(config);
		CheckHandleBulletTagData(entityId, config.Id, bulletRuntimeConfigData);
		CheckHandleBulletAdditionData(entityId, config.Id, bulletRuntimeConfigData);
		CheckHandleBulletBuffData(entityId, config.Id, bulletRuntimeConfigData);
		return bulletRuntimeConfigData;
	}

	private void CheckHandleBulletTagData(int entityId, int bulletId, BulletRuntimeConfigData runtimeConfigData)
	{
		if (!bulletChangeTagDataDic.TryGetValue(entityId, out var value))
		{
			return;
		}
		foreach (BulletChangeTagData item in value)
		{
			if (!CheckContainsBulletToModify(item, bulletId, runtimeConfigData))
			{
				continue;
			}
			if (item.changeType == ChangeType.Add)
			{
				foreach (string modifyTag in item.modifyTagList)
				{
					if (!runtimeConfigData.BulletLabel.Contains(modifyTag))
					{
						runtimeConfigData.BulletLabel.Add(modifyTag);
					}
				}
			}
			else
			{
				if (item.changeType != ChangeType.Dec)
				{
					continue;
				}
				foreach (string modifyTag2 in item.modifyTagList)
				{
					runtimeConfigData.BulletLabel.Remove(modifyTag2);
				}
			}
		}
	}

	private void CheckHandleBulletAdditionData(int entityId, int bulletId, BulletRuntimeConfigData runtimeConfigData)
	{
		if (!bulletChangeAdditionDataDic.TryGetValue(entityId, out var value))
		{
			return;
		}
		foreach (BulletChangeAdditionData item in value)
		{
			if (!CheckContainsBulletToModify(item, bulletId, runtimeConfigData))
			{
				continue;
			}
			if (item.modifyAdditionEnum == BulletAdditionEnum.DamageRadio)
			{
				if (!item.modifyValues.IsNullOrEmpty())
				{
					ModifyValue(runtimeConfigData.DamageRatio, item.modifyValues, item.changeType);
				}
			}
			else if (item.modifyAdditionEnum == BulletAdditionEnum.FixAddition)
			{
				ModifyValue(ref runtimeConfigData.FixAddition, item.modifyValues[0], item.changeType);
			}
			else if (item.modifyAdditionEnum == BulletAdditionEnum.AffectTenacity)
			{
				ModifyValue(ref runtimeConfigData.AffectTenacity, item.modifyValues[0], item.changeType);
			}
			else if (item.modifyAdditionEnum == BulletAdditionEnum.FixedAffectTenacity)
			{
				ModifyValue(ref runtimeConfigData.FixedAffectTenacity, item.modifyValues[0], item.changeType);
			}
		}
	}

	private void CheckHandleBulletBuffData(int entityId, int bulletId, BulletRuntimeConfigData runtimeConfigData)
	{
		if (!bulletChangeBuffDataDic.TryGetValue(entityId, out var value))
		{
			return;
		}
		foreach (BulletChangeBuffData item in value)
		{
			if (item.IsVaild() || !CheckContainsBulletToModify(item, bulletId, runtimeConfigData))
			{
				continue;
			}
			if (item.changeType == ChangeType.Add)
			{
				for (int i = 0; i < item.buffList.Count; i++)
				{
					if (!runtimeConfigData.AddBuff.Contains(item.buffList[i]))
					{
						runtimeConfigData.AddBuff.Add(item.buffList[i]);
						runtimeConfigData.BuffTarget.Add(item.targetList[i]);
					}
				}
			}
			else
			{
				if (item.changeType != ChangeType.Dec)
				{
					continue;
				}
				for (int j = 0; j < item.buffList.Count; j++)
				{
					int num = runtimeConfigData.AddBuff.IndexOf(item.buffList[j]);
					if (num >= 0)
					{
						runtimeConfigData.AddBuff.RemoveAt(num);
						runtimeConfigData.BuffTarget.RemoveAt(num);
					}
				}
			}
		}
	}

	private bool CheckContainsBulletToModify(BulletChangeTagData data, int bulletId, BulletRuntimeConfigData runtimeConfigData)
	{
		if (!data.checkTagList.IsNullOrEmpty() && data.checkTagList.HasCommonWith(runtimeConfigData.BulletLabel))
		{
			return true;
		}
		if (!data.checkConfigIdList.IsNullOrEmpty() && data.checkConfigIdList.Contains(bulletId))
		{
			return true;
		}
		return false;
	}

	private bool CheckContainsBulletToModify(BulletChangeAdditionData data, int bulletId, BulletRuntimeConfigData runtimeConfigData)
	{
		if (!data.checkTagList.IsNullOrEmpty() && data.checkTagList.HasCommonWith(runtimeConfigData.BulletLabel))
		{
			return true;
		}
		if (!data.checkConfigIdList.IsNullOrEmpty() && data.checkConfigIdList.Contains(bulletId))
		{
			return true;
		}
		return false;
	}

	private bool CheckContainsBulletToModify(BulletChangeBuffData data, int bulletId, BulletRuntimeConfigData runtimeConfigData)
	{
		if (data.modifyEnum == BulletModifyEnum.All)
		{
			return true;
		}
		if (data.modifyEnum == BulletModifyEnum.BulletID)
		{
			return data.bulletId == bulletId;
		}
		if (data.modifyEnum == BulletModifyEnum.BulletLabel)
		{
			return runtimeConfigData.BulletLabel.Contains(data.bulletLabel);
		}
		return false;
	}

	private bool CheckContainsBulletToModify(BulletModifySiteLevelData data, int bulletId, BulletRuntimeConfigData runtimeConfigData)
	{
		if (data.modifyEnum == BulletModifyEnum.All)
		{
			return true;
		}
		if (data.modifyEnum == BulletModifyEnum.BulletID)
		{
			return data.bulletId == bulletId;
		}
		if (data.modifyEnum == BulletModifyEnum.BulletLabel)
		{
			return runtimeConfigData.BulletLabel.Contains(data.bulletLabel);
		}
		return false;
	}

	protected void ModifyValue(List<float> values1, List<float> values2, ChangeType changeType)
	{
		switch (changeType)
		{
		case ChangeType.Add:
		{
			for (int l = 0; l < values1.Count; l++)
			{
				values1[l] += values2[l];
			}
			break;
		}
		case ChangeType.Dec:
		{
			for (int j = 0; j < values1.Count; j++)
			{
				values1[j] -= values2[j];
			}
			break;
		}
		case ChangeType.Mul:
		{
			for (int k = 0; k < values1.Count; k++)
			{
				values1[k] *= values2[k];
			}
			break;
		}
		case ChangeType.Div:
		{
			for (int i = 0; i < values1.Count; i++)
			{
				values1[i] /= values2[i];
			}
			break;
		}
		case ChangeType.Set:
			values1 = new List<float>(values2);
			break;
		}
	}

	protected void ModifyValue(ref float values1, float values2, ChangeType changeType)
	{
		switch (changeType)
		{
		case ChangeType.Add:
			values1 += values2;
			break;
		case ChangeType.Dec:
			values1 -= values2;
			break;
		case ChangeType.Mul:
			values1 *= values2;
			break;
		case ChangeType.Div:
			values1 /= values2;
			break;
		case ChangeType.Set:
			values1 = values2;
			break;
		}
	}

	private void OnDisposeDataReplace()
	{
		changeCreateBulletDic.Clear();
		bulletChangeTagDataDic.Clear();
		bulletChangeAdditionDataDic.Clear();
		bulletChangeBuffDataDic.Clear();
		bulletModifySiteLevelDataDic.Clear();
	}
}
