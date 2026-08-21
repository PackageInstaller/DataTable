using System;
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public static class MathModelCalcArea
{
	private class PredicatePlayerEntity<T> : IPredicate<T>, IReference where T : BaseEntity
	{
		public bool Predicate(T item)
		{
			if (item != null && item is HeroEntity heroEntity)
			{
				return !heroEntity.IsAi;
			}
			return false;
		}

		public void Clear()
		{
		}
	}

	public static bool CheckInArea(MathModelCalcParameter target, MathModelCalcParameter self, ColliderParam colliderParam, bool UseModelRadius = false)
	{
		return colliderParam.ShapeEnum switch
		{
			ShapeEnum.Box => CheckRect(target, self, colliderParam, UseModelRadius), 
			ShapeEnum.Circle => CheckCircle(target, self, colliderParam, UseModelRadius), 
			ShapeEnum.Sector => CheckSector(target, self, colliderParam, UseModelRadius), 
			_ => false, 
		};
	}

	public static void GetAllRoleByArea(BaseEntity ownerEntity, ShapeEnum colliderType, float angle, float param1, float param2, TargetTeamEnum calculationType, List<int> enemies, float yAxleLimit, Vector2 offset)
	{
		EntitySystem system = ownerEntity.GetSystem<EntitySystem>();
		List<BaseEntity> list = null;
		switch (calculationType)
		{
		case TargetTeamEnum.Friend:
			list = system.FindAllRelationEntities(ownerEntity, RelationTypeEnum.Friendly);
			break;
		case TargetTeamEnum.Enemy:
			list = system.FindAllRelationEntities(ownerEntity);
			break;
		case TargetTeamEnum.Self:
			list = system.FindAllRelationEntities(ownerEntity, RelationTypeEnum.Self);
			break;
		case TargetTeamEnum.All:
			list = system.FindAllSurvivalTargetEntities();
			break;
		case TargetTeamEnum.Player:
		{
			PredicatePlayerEntity<BaseEntity> predicatePlayerEntity = ReferencePool.Acquire<PredicatePlayerEntity<BaseEntity>>();
			list = system.FindAllSurvivalTargetEntities(predicatePlayerEntity);
			ReferencePool.Release(predicatePlayerEntity);
			break;
		}
		}
		if (list != null)
		{
			ColliderParam colliderParam = new ColliderParam
			{
				Param = new Vector2(param1, param2),
				ShapeEnum = colliderType
			};
			Vector3 vector = ownerEntity.transform.rotation * new Vector3(offset.x, 0f, offset.y);
			MathModelCalcParameter self = new MathModelCalcParameter
			{
				Pos = ownerEntity.transform.position.ToVector2() + new Vector2(vector.x, vector.z),
				Rotate = ownerEntity.transform.eulerAngles.y + angle
			};
			HitColliderComponent component = ownerEntity.GetComponent<HitColliderComponent>();
			if (component != null)
			{
				self.ShapeEnum = component.PrimitiveInfo.Type;
				Vector3 colliderParam2 = component.GetColliderParam();
				self.DetectColliderParam = new Vector2(colliderParam2.x, colliderParam2.z);
			}
			MathModelCalcParameter target = default(MathModelCalcParameter);
			foreach (BaseEntity item in list)
			{
				if ((!(item is HeroEntity) && !(item is MonsterEntity)) || Mathf.Abs(item.transform.position.y - ownerEntity.transform.position.y) > yAxleLimit)
				{
					continue;
				}
				List<HitVolume> list2 = ownerEntity.GetSystem<VolumeSystem>()?.GetEntityVolumes(item.Id);
				if (list2.IsNullOrEmpty())
				{
					continue;
				}
				foreach (HitVolume item2 in list2)
				{
					if (item2 != null)
					{
						target.Pos.x = item2.PrimitiveInfo.Center.x;
						target.Pos.y = item2.PrimitiveInfo.Center.z;
						target.Rotate = item2.PrimitiveInfo.Quaternion.y;
						target.ShapeEnum = item2.PrimitiveInfo.Type;
						Vector3 colliderParam3 = item2.GetColliderParam();
						target.DetectColliderParam = new Vector2(colliderParam3.x, colliderParam3.z);
						if (CheckInArea(target, self, colliderParam))
						{
							enemies?.Add(item.Id);
							break;
						}
					}
				}
			}
		}
		if (list != null)
		{
			CollectionPool<List<BaseEntity>, BaseEntity>.Release(list);
		}
	}

	public static void GetAllMonsterByAreaAndPower(BaseEntity ownerEntity, ShapeEnum colliderType, float angle, float param1, float param2, int power, List<int> enemies, float yAxleLimit, Vector2 offset)
	{
		List<BaseEntity> list = ownerEntity.GetSystem<EntitySystem>().FindAllMonsterEntities();
		if (list == null)
		{
			return;
		}
		ColliderParam colliderParam = new ColliderParam
		{
			Param = new Vector2(param1, param2),
			ShapeEnum = colliderType
		};
		Vector3 vector = ownerEntity.transform.rotation * new Vector3(offset.x, 0f, offset.y);
		MathModelCalcParameter self = new MathModelCalcParameter
		{
			Pos = ownerEntity.transform.position.ToVector2() + new Vector2(vector.x, vector.z),
			Rotate = ownerEntity.transform.eulerAngles.y + angle
		};
		HitColliderComponent component = ownerEntity.GetComponent<HitColliderComponent>();
		if (component != null)
		{
			self.ShapeEnum = component.PrimitiveInfo.Type;
			Vector3 colliderParam2 = component.GetColliderParam();
			self.DetectColliderParam = new Vector2(colliderParam2.x, colliderParam2.z);
		}
		MathModelCalcParameter target = default(MathModelCalcParameter);
		foreach (BaseEntity item in list)
		{
			if (!(item is MonsterEntity { MonsterTypeConfig: not null } monsterEntity) || monsterEntity.MonsterTypeConfig.MobPower != power || Mathf.Abs(item.transform.position.y - ownerEntity.transform.position.y) > yAxleLimit)
			{
				continue;
			}
			List<HitVolume> list2 = ownerEntity.GetSystem<VolumeSystem>()?.GetEntityVolumes(item.Id);
			if (list2.IsNullOrEmpty())
			{
				continue;
			}
			foreach (HitVolume item2 in list2)
			{
				if (item2 != null)
				{
					target.Pos.x = item2.PrimitiveInfo.Center.x;
					target.Pos.y = item2.PrimitiveInfo.Center.z;
					target.Rotate = item2.PrimitiveInfo.Quaternion.y;
					target.ShapeEnum = item2.PrimitiveInfo.Type;
					Vector3 colliderParam3 = item2.GetColliderParam();
					target.DetectColliderParam = new Vector2(colliderParam3.x, colliderParam3.z);
					if (CheckInArea(target, self, colliderParam))
					{
						enemies?.Add(item.Id);
						break;
					}
				}
			}
		}
		CollectionPool<List<BaseEntity>, BaseEntity>.Release(list);
	}

	private static bool CheckCircle(MathModelCalcParameter target, MathModelCalcParameter self, ColliderParam colliderParam, bool useModelRadius)
	{
		Vector2 vector = target.Pos - self.Pos;
		if (useModelRadius)
		{
			float transformRadius = GetTransformRadius(target);
			if (Mathf.Sqrt(vector.x * vector.x + vector.y * vector.y) < colliderParam.Param.x + transformRadius)
			{
				return true;
			}
			return false;
		}
		if (vector.x * vector.x + vector.y * vector.y < Mathf.Pow(colliderParam.Param.x, 2f))
		{
			return true;
		}
		return false;
	}

	private static bool CheckRect(MathModelCalcParameter target, MathModelCalcParameter self, ColliderParam colliderParam, bool useModelRadius)
	{
		Vector2 targetVec = target.Pos - self.Pos;
		float num = Mathf.Pow(colliderParam.Param.x, 2f) + Mathf.Pow(colliderParam.Param.y, 2f);
		float num2 = targetVec.x * targetVec.x + targetVec.y * targetVec.y;
		if (useModelRadius)
		{
			float transformRadius = GetTransformRadius(target);
			if (Mathf.Pow(Mathf.Abs(Mathf.Sqrt(num2) - transformRadius), 2f) > num)
			{
				return false;
			}
		}
		else if (num2 > num)
		{
			return false;
		}
		Vector2 vector = TSUtil.Vec2RotateAAngle(targetVec, 0f - self.Rotate);
		if (Mathf.Abs(vector.x) < colliderParam.Param.x / 2f && Mathf.Abs(vector.y) < colliderParam.Param.y / 2f)
		{
			return true;
		}
		return false;
	}

	private static bool CheckSector(MathModelCalcParameter target, MathModelCalcParameter self, ColliderParam colliderParam, bool useModelRadius)
	{
		Vector3 vector = new Vector3(target.Pos.x - self.Pos.x, 0f, target.Pos.y - self.Pos.y);
		float sqrMagnitude = vector.sqrMagnitude;
		float x = colliderParam.Param.x;
		float num = colliderParam.Param.y * 0.5f;
		if (useModelRadius)
		{
			float transformRadius = GetTransformRadius(target);
			if (sqrMagnitude > (x + transformRadius) * (x + transformRadius))
			{
				return false;
			}
		}
		else if (sqrMagnitude > x * x)
		{
			return false;
		}
		Vector3 vector2 = Quaternion.Euler(0f, self.Rotate, 0f) * Vector3.forward;
		Vector3 normalized = vector.normalized;
		float num2 = Vector3.Dot(vector2.normalized, normalized);
		float num3 = Mathf.Cos(num * (MathF.PI / 180f));
		return num2 >= num3;
	}

	private static float GetTransformRadius(MathModelCalcParameter target)
	{
		switch (target.ShapeEnum)
		{
		case PrimitiveEnum.BoxPrimitive:
			return (target.DetectColliderParam.x + target.DetectColliderParam.y) * 0.5f;
		case PrimitiveEnum.SpherePrimitive:
		case PrimitiveEnum.SectorPrimitive:
			return target.DetectColliderParam.x;
		default:
			return 0f;
		}
	}
}
