using System.Collections.Generic;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class BulletHitJudgmentComponent : BaseComponent
{
	private BulletData bulletData;

	private BulletParentPropertyData _bulletParentPropertyData;

	private List<int> hitEntityList;

	public bool IsHitEntity()
	{
		List<int> list = hitEntityList;
		if (list == null)
		{
			return false;
		}
		return list.Count > 0;
	}

	public void AddHitEntity(int entityId)
	{
		hitEntityList?.Add(entityId);
	}

	public override void OnAwake(object data = null)
	{
		bulletData = GetData<BulletData>("bulletData");
		_bulletParentPropertyData = GetData<BulletParentPropertyData>("bulletParentPropertyData");
		hitEntityList = CollectionPool<List<int>, int>.Get();
	}

	public bool CheckEntityHitJudgment(BaseEntity entity)
	{
		if (entity.GetEntityType() == EntityType.INTERACTIVE)
		{
			if (!IsInteractiveAbleToExecuteHit(entity))
			{
				return false;
			}
			ExecuteInteractiveHit(entity);
			return true;
		}
		if (!IsAbleToExecuteHit(entity))
		{
			return false;
		}
		LockstepData.Instance?.WriteAuthorityEntityId($" 检测实体命中判定 攻击者 ： {mBaseEntity.Parent.Id} 受击者 ： {entity?.Id}  子弹ID ： {base.Entity.EntityId}", entity);
		ExecuteHit(entity);
		return true;
	}

	public bool ExecuteEntityHitJudgement(BaseEntity entity)
	{
		if (!IsAbleToExecuteHitCampType(entity))
		{
			return false;
		}
		LockstepData.Instance?.WriteAuthorityEntityId($" 忽略免疫检测实体命中判定 攻击者 ： {mBaseEntity.Parent.Id} 受击者 ： {entity?.Id}  子弹ID ： {base.Entity.EntityId}", entity);
		ExecuteHit(entity);
		return true;
	}

	private bool IsAbleToExecuteHit(BaseEntity entity)
	{
		StateComponent component = entity.GetComponent<StateComponent>();
		if (component == null)
		{
			return IsAbleToExecuteHitCampType(entity);
		}
		if (component.ImmuneHitCollider(mBaseEntity.Parent, entity, bulletData.cfg.IgnoreImmunityOnBulletHit))
		{
			return false;
		}
		return IsAbleToExecuteHitCampType(entity);
	}

	private bool IsAbleToExecuteHitCampType(BaseEntity entity)
	{
		if (bulletData.cfg == null)
		{
			return false;
		}
		if (IsIgnoreSummonedExecuteToHit(entity, out var result))
		{
			return !result;
		}
		int relation = (int)AIUtility.GetRelation(mBaseEntity.Parent, entity);
		if (bulletData.cfg.RelationType.IndexOf(relation) == -1)
		{
			return false;
		}
		return true;
	}

	private bool IsIgnoreSummonedExecuteToHit(BaseEntity entity, out bool result)
	{
		if (entity is SummonedEntity defender)
		{
			result = IsIgnoreSummonedHit(mBaseEntity.Parent, defender);
			return true;
		}
		result = false;
		return false;
	}

	private bool IsIgnoreSummonedHit(BaseEntity attacker, SummonedEntity defender)
	{
		List<int> beHitBulletId = defender.SummonedConfig.BeHitBulletId;
		if (beHitBulletId != null && beHitBulletId.Count > 0)
		{
			return !beHitBulletId.Contains(bulletData.cfg.Id);
		}
		return false;
	}

	private void ExecuteHit(BaseEntity entity)
	{
		LockstepData.Instance?.WriteAuthorityEntityId($" 执行子弹击中 攻击者 ： {mBaseEntity.Parent.Id} 受击者 ： {entity?.Id}  子弹ID ： {base.Entity.EntityId}", entity);
		mBaseEntity.GetComponent<BulletTriggerComponent>().ReduceTriggerCount(entity);
		AddHitEntity(entity.Id);
		if (!mBaseEntity.Parent.IsCanExecuteLogic)
		{
			return;
		}
		HitColliderVariableData hitVariableData = entity.GetComponent<HitColliderComponent>().GetHitVariableData(mBaseEntity.Id, bulletData, mBaseEntity, _bulletParentPropertyData.AttackerPos, out var hitVolume);
		if (bulletData.cfg.IsMelee && hitVariableData == null)
		{
			return;
		}
		LockstepData.Instance?.WriteAuthorityEntityId($"击中受击盒 ： {hitVolume?.Key}  攻击者 ： {mBaseEntity.Parent.Id} 攻击者位置 ： {_bulletParentPropertyData.AttackerPos} 子弹ID ： {base.Entity.EntityId}", entity);
		BulletAttackData bulletAttackData = BulletAttackData.Create(mBaseEntity.Id, bulletData, mBaseEntity.GetComponent<BulletLifeComponent>().LifeTime, CalculateHitDirect(entity), mBaseEntity.transform.position, hitVolume, hitVariableData, _bulletParentPropertyData);
		StateComponent component = entity.GetComponent<StateComponent>();
		if (component == null || !component.IsNearDeathState())
		{
			BuffSystem system = mBaseEntity.GetSystem<BuffSystem>();
			if (system != null)
			{
				bulletAttackData.addBuffList = CollectionPool<List<Buff>, Buff>.Get();
				ExecuteExtraBuff(entity, bulletAttackData, system);
				ExecuteModVelBuff(entity, bulletAttackData, system);
				ExecuteHealBuff(entity, bulletAttackData, system);
				if (!bulletAttackData.addBuffList.IsNullOrEmpty())
				{
					foreach (Buff addBuff in bulletAttackData.addBuffList)
					{
						BuffBulletRuntimeData buffBulletRuntimeData = ReferencePool.Acquire<BuffBulletRuntimeData>();
						buffBulletRuntimeData.toEntity = mBaseEntity.Parent;
						buffBulletRuntimeData.bulletConfigId = bulletData.configId;
						buffBulletRuntimeData.skillConfigId = bulletData.cfg.SkillId;
						buffBulletRuntimeData.bulletPos = mBaseEntity.transform.position;
						buffBulletRuntimeData.variableData = hitVariableData;
						buffBulletRuntimeData.hitVolume = hitVolume;
						addBuff.AddBuffRuntimeData(buffBulletRuntimeData);
					}
				}
			}
			mBaseEntity.GetSystem<BattleDamageProgressSystem>()?.EnterBulletDamageProgress(mBaseEntity.Parent, entity, bulletAttackData);
			CreateBulletAfterHit();
		}
		else
		{
			entity.GetSystem<BattleDamageProgressSystem>().EnterBulletDamageProgress(mBaseEntity.Parent, entity, bulletAttackData);
		}
		mBaseEntity.GetComponent<BulletDisplayComponent>()?.OnDisplay("HitCamera");
		RecodeHitDataBefore(entity);
	}

	public void ExecuteHit(BaseEntity entity, HitColliderVariableData variableData, HitVolume hitVolume)
	{
		mBaseEntity.GetComponent<BulletTriggerComponent>().ReduceTriggerCount(entity);
		AddHitEntity(entity.Id);
		if (!mBaseEntity.Parent.IsCanExecuteLogic || (bulletData.cfg.IsMelee && variableData == null) || hitVolume == null)
		{
			return;
		}
		LockstepData.Instance?.WriteAuthorityEntityId($"击中受击盒 ： {hitVolume?.Key}  攻击者 ： {mBaseEntity.Parent.Id} 攻击者位置 ： {_bulletParentPropertyData.AttackerPos} 子弹ID ： {base.Entity.EntityId}", entity);
		BulletAttackData bulletAttackData = BulletAttackData.Create(mBaseEntity.Id, bulletData, mBaseEntity.GetComponent<BulletLifeComponent>().LifeTime, CalculateHitDirect(entity), mBaseEntity.transform.position, hitVolume, variableData, _bulletParentPropertyData);
		StateComponent component = entity.GetComponent<StateComponent>();
		if (component == null || !component.IsNearDeathState())
		{
			BuffSystem system = mBaseEntity.GetSystem<BuffSystem>();
			if (system != null)
			{
				bulletAttackData.addBuffList = CollectionPool<List<Buff>, Buff>.Get();
				ExecuteExtraBuff(entity, bulletAttackData, system);
				ExecuteModVelBuff(entity, bulletAttackData, system);
				ExecuteHealBuff(entity, bulletAttackData, system);
				if (!bulletAttackData.addBuffList.IsNullOrEmpty())
				{
					foreach (Buff addBuff in bulletAttackData.addBuffList)
					{
						BuffBulletRuntimeData buffBulletRuntimeData = ReferencePool.Acquire<BuffBulletRuntimeData>();
						buffBulletRuntimeData.toEntity = mBaseEntity.Parent;
						buffBulletRuntimeData.bulletConfigId = bulletData.configId;
						buffBulletRuntimeData.skillConfigId = bulletData.cfg.SkillId;
						buffBulletRuntimeData.bulletPos = mBaseEntity.transform.position;
						buffBulletRuntimeData.variableData = variableData;
						buffBulletRuntimeData.hitVolume = hitVolume;
						addBuff.AddBuffRuntimeData(buffBulletRuntimeData);
					}
				}
			}
			mBaseEntity.GetSystem<BattleDamageProgressSystem>()?.EnterBulletDamageProgress(mBaseEntity.Parent, entity, bulletAttackData);
			CreateBulletAfterHit();
		}
		else
		{
			entity.GetSystem<BattleDamageProgressSystem>().EnterBulletDamageProgress(mBaseEntity.Parent, entity, bulletAttackData);
		}
		mBaseEntity.GetComponent<BulletDisplayComponent>()?.OnDisplay("HitCamera");
		RecodeHitDataBefore(entity);
	}

	private void RecodeHitDataBefore(BaseEntity entity)
	{
		if (!bulletData.cfg.IsIgnoreHit)
		{
			entity.GetComponent<HitComponent>()?.SetEntityInjuredByDamageBefore(mBaseEntity.Parent.Id, bulletData.cfg.BulletBuffTypeEnum);
		}
	}

	private void HandleDamageCumulative(HitColliderVariableData variableData, BulletAttackData bulletAttackData, BaseEntity attackerEntity, BaseEntity hitEntity)
	{
		if (variableData != null && bulletAttackData != null)
		{
			_ = attackerEntity is HeroEntity;
		}
	}

	private void ExecuteModVelBuff(BaseEntity entity, BulletAttackData bulletAttackData, BuffSystem buffSystem)
	{
		if (bulletData.cfg.Attraction.Count <= 0)
		{
			return;
		}
		if (bulletData.cfg.Attraction.Count == 1)
		{
			Buff buff = buffSystem.CreateBulletModifyVelBuff(mBaseEntity.Parent, entity, bulletData.cfg.Attraction[0], (mBaseEntity.transform.position - entity.transform.position).normalized);
			if (buff != null)
			{
				bulletAttackData.addBuffList.Add(buff);
			}
			return;
		}
		Vector3 normalized = new Vector3(bulletData.cfg.Attraction[1], 0f, (bulletData.cfg.Attraction.Count <= 2) ? 0f : bulletData.cfg.Attraction[2]).normalized;
		if (bulletData.cfg.Attraction.Count <= 3 || (bulletData.cfg.Attraction.Count >= 4 && bulletData.cfg.Attraction[3] != 1f))
		{
			buffSystem.AcquireBulletModifyVelBuff(mBaseEntity.Parent, entity, bulletData.cfg.Attraction[0], (mBaseEntity.transform.rotation * normalized).normalized);
			return;
		}
		Buff buff2 = buffSystem.CreateBulletModifyVelBuff(mBaseEntity.Parent, entity, bulletData.cfg.Attraction[0], normalized.normalized);
		if (buff2 != null)
		{
			bulletAttackData.addBuffList.Add(buff2);
		}
	}

	private void ExecuteHealBuff(BaseEntity entity, BulletAttackData bulletAttackData, BuffSystem buffSystem)
	{
		if (bulletData.cfg.HealRatio.Count <= 0)
		{
			return;
		}
		List<int> teamEntityId = mBaseEntity.GetSystem<EntitySystem>().GetTeamEntityId(0, isIncludeEntity: true, mBaseEntity.LogicType);
		for (int i = 0; i < bulletData.cfg.HealTarget.Count; i++)
		{
			if (bulletData.cfg.HealTarget[i] == 0)
			{
				BaseEntity parent = mBaseEntity.Parent;
				if (parent != null)
				{
					Buff buff = buffSystem.CreateBulletHealBuff(parent, parent, bulletData.cfg);
					if (buff != null)
					{
						bulletAttackData.addBuffList.Add(buff);
					}
				}
			}
			else if (bulletData.cfg.HealTarget[i] == 1)
			{
				BaseEntity parent = entity;
				if (parent != null)
				{
					Buff buff2 = buffSystem.CreateBulletHealBuff(mBaseEntity.Parent, parent, bulletData.cfg);
					if (buff2 != null)
					{
						bulletAttackData.addBuffList.Add(buff2);
					}
				}
			}
			else
			{
				if (bulletData.cfg.HealTarget[i] != 2 || (entity.LogicType != EntityLogicType.Logic && entity.LogicType != EntityLogicType.None))
				{
					continue;
				}
				for (int j = 0; j < teamEntityId.Count; j++)
				{
					if (teamEntityId[j] == mBaseEntity.Parent.Id)
					{
						continue;
					}
					BaseEntity parent = mBaseEntity.GetSystem<EntitySystem>().GetEntity(teamEntityId[j]);
					if (parent != null)
					{
						Buff buff3 = buffSystem.CreateBulletHealBuff(mBaseEntity.Parent, parent, bulletData.cfg);
						if (buff3 != null)
						{
							bulletAttackData.addBuffList.Add(buff3);
						}
					}
				}
			}
		}
		CollectionPool<List<int>, int>.Release(teamEntityId);
	}

	private void ExecuteExtraBuff(BaseEntity entity, BulletAttackData bulletAttackData, BuffSystem buffSystem)
	{
		if (bulletData.extraData.runtimeConfigData == null)
		{
			return;
		}
		List<int> addBuff = bulletData.extraData.runtimeConfigData.AddBuff;
		List<int> buffTarget = bulletData.extraData.runtimeConfigData.BuffTarget;
		if (addBuff.Count != buffTarget.Count)
		{
			return;
		}
		List<Buff> list = new List<Buff>();
		List<int> teamEntityId = mBaseEntity.GetSystem<EntitySystem>().GetTeamEntityId(0, isIncludeEntity: true, entity.LogicType);
		for (int i = 0; i < buffTarget.Count; i++)
		{
			if (buffTarget[i] == 0)
			{
				BaseEntity parent = mBaseEntity.Parent;
				if (parent != null)
				{
					Buff buff = buffSystem.CreateBuff(mBaseEntity.Parent, parent, addBuff[i]);
					if (buff != null)
					{
						list.Add(buff);
					}
					if (LockstepData.Instance != null)
					{
						LockstepData.Instance?.WriteAuthorityEntityId($"子弹添加的额外Buff 给自己添加  施加方 ： {mBaseEntity.Parent.Id}  接受方 ： {parent.Id}", parent);
					}
				}
			}
			else if (buffTarget[i] == 1)
			{
				BaseEntity parent = entity;
				Buff buff2 = buffSystem.CreateBuff(mBaseEntity.Parent, parent, addBuff[i]);
				if (buff2 != null)
				{
					list.Add(buff2);
				}
				if (LockstepData.Instance != null)
				{
					LockstepData.Instance?.WriteAuthorityEntityId($"子弹添加的额外Buff 给受击者添加  施加方 ： {mBaseEntity.Parent.Id}  接受方 ： {parent.Id}", parent);
				}
			}
			else if (buffTarget[i] == 2)
			{
				Buff buff3 = buffSystem.CreateModifyBuff(mBaseEntity.Parent, entity, addBuff[i], bulletAttackData);
				if (buff3 != null)
				{
					list.Add(buff3);
				}
			}
			else
			{
				if (buffTarget[i] != 3 || (entity.LogicType != EntityLogicType.Logic && entity.LogicType != EntityLogicType.None))
				{
					continue;
				}
				for (int j = 0; j < teamEntityId.Count; j++)
				{
					if (teamEntityId[j] == mBaseEntity.Parent.Id)
					{
						continue;
					}
					BaseEntity parent = mBaseEntity.GetSystem<EntitySystem>().GetEntity(teamEntityId[j]);
					if (parent != null)
					{
						Buff buff4 = buffSystem.CreateBuff(mBaseEntity.Parent, parent, addBuff[i]);
						if (buff4 != null)
						{
							list.Add(buff4);
						}
						if (LockstepData.Instance != null)
						{
							LockstepData.Instance.WriteAuthorityEntityId($"子弹添加的额外Buff 给队友添加  施加方 ： {mBaseEntity.Parent.Id}  接受方 ： {parent.Id}", parent);
						}
					}
				}
			}
		}
		bulletAttackData.addBuffList.AddRange(list);
		CollectionPool<List<int>, int>.Release(teamEntityId);
	}

	private Vector3 CalculateHitDirect(BaseEntity targetEntity)
	{
		Vector3 zero = Vector3.zero;
		if (bulletData.cfg.IsMelee)
		{
			zero = (targetEntity.transform.position - mBaseEntity.Parent.transform.position).normalized;
			zero.y = 0f;
			return zero;
		}
		if (bulletData.cfg.MovementTrajectoryTypeEnum == MovementTrajectoryTypeEnum.NoMove)
		{
			zero = (targetEntity.transform.position - mBaseEntity.transform.position).normalized;
			zero.y = 0f;
			return zero;
		}
		zero = mBaseEntity.GetComponent<BulletMoveComponent>().MovementTrajectoryData?.Tangent ?? Vector3.zero;
		zero.y = 0f;
		return zero;
	}

	private void CreateBulletAfterHit()
	{
		BulletSystem system = mBaseEntity.GetSystem<BulletSystem>();
		if (system != null)
		{
			for (int i = 0; i < bulletData.cfg.CreateAfterHit.Count; i++)
			{
				system.CreateBulletEntity(mBaseEntity.Parent, bulletData.cfg.CreateAfterHit[i], mBaseEntity.transform.position, mBaseEntity.transform.eulerAngles, mBaseEntity.EntityData.currentTickCreate, null, mBaseEntity.ViewNeedLerp, mBaseEntity.ViewMovementSharpness, mBaseEntity.ViewRotationSharpness);
			}
		}
	}

	public bool CheckEntityShadowHitJudgment(BaseEntity entity)
	{
		if (entity.GetEntityType() == EntityType.INTERACTIVE)
		{
			if (!IsInteractiveAbleToExecuteHit(entity))
			{
				return false;
			}
			return true;
		}
		if (!IsAbleToExecuteHit(entity))
		{
			return false;
		}
		ExecuteShadowHit(entity);
		return true;
	}

	private void ExecuteShadowHit(BaseEntity entity)
	{
		if (entity is HeroEntity)
		{
			entity.GetSystem<AlertHitInfoSystem>()?.StoreAlertHitInfo(mBaseEntity, bulletData.leadTime, _bulletParentPropertyData.CreateId, bulletData.cfg, mBaseEntity.transform.position, CalculateHitDirect(entity), entity);
		}
	}

	public override void OnDispose()
	{
		bulletData = null;
		_bulletParentPropertyData = null;
		if (hitEntityList != null)
		{
			CollectionPool<List<int>, int>.Release(hitEntityList);
		}
		base.OnDispose();
	}

	private bool IsInteractiveAbleToExecuteHit(BaseEntity entity)
	{
		return IsAbleToExecuteHitCampType(entity);
	}

	private void ExecuteInteractiveHit(BaseEntity entity)
	{
		BulletAttackData bulletAttackData = BulletAttackData.Create(mBaseEntity.Id, bulletData, mBaseEntity.GetComponent<BulletLifeComponent>().LifeTime, CalculateHitDirect(entity), mBaseEntity.transform.position);
		mBaseEntity.GetComponent<BulletRayComponent>().ExcuteHit(entity);
		entity.GetSystem<BattleDamageProgressSystem>().EnterBulletDamageProgress(mBaseEntity.Parent, entity, bulletAttackData);
	}
}
