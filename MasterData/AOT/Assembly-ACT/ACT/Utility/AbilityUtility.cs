using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Utility;

public static class AbilityUtility
{
	public const float LaneBodyBehindWidth = 4f;

	public const float LaneBodyBehindRayDistance = 20f;

	private const float LaneBodyBehindEdgeInset = 0.02f;

	private const float LaneBodyBehindExitSkin = 0.05f;

	public static Entity SearchEnemyNearest(SystemAbility systemAbility, Entity behave, Vector3 point, Vector3 halfExtents, float angle, bool ignoreBack = true)
	{
		Entity result = Entity.Invalid;
		Collider[] cacheColliders = PhysicsUtility.cacheColliders;
		int num = Physics.OverlapBoxNonAlloc(point, halfExtents, cacheColliders, Quaternion.identity, BattleConsts.entityMask);
		if (num > 0)
		{
			float num2 = float.MaxValue;
			for (int i = 0; i < num; i++)
			{
				MonoEntity componentInParent = cacheColliders[i].GetComponentInParent<MonoEntity>();
				if (componentInParent != null && systemAbility.CanAttack(behave, componentInParent.id, out var target))
				{
					CompTransform compTransform = behave.GetCompTransform();
					CompTransform? compTransform2 = target.GetCompTransform();
					CompInput compInput = behave.GetCompInput();
					float num3 = compTransform2.physicsPosition.x - compTransform.physicsPosition.x;
					float num4 = Mathf.Abs(num3);
					if (num4 < num2 && (!ignoreBack || (float)((compInput.dirX == EInputDir.Left) ? (-1) : ((compInput.dirX == EInputDir.Right) ? 1 : 0)) * num3 >= 0f))
					{
						num2 = num4;
						result = target;
					}
				}
			}
		}
		PhysicsUtility.Release(cacheColliders);
		return result;
	}

	public static Entity SearchEnemyFarthest(SystemAbility systemAbility, Entity behave, Vector3 point, Vector3 halfExtents, float angle, bool ignoreBack = true)
	{
		Entity result = Entity.Invalid;
		Collider[] cacheColliders = PhysicsUtility.cacheColliders;
		int num = Physics.OverlapBoxNonAlloc(point, halfExtents, cacheColliders, Quaternion.identity, BattleConsts.entityMask);
		if (num > 0)
		{
			float num2 = 0f;
			for (int i = 0; i < num; i++)
			{
				MonoEntity componentInParent = cacheColliders[i].GetComponentInParent<MonoEntity>();
				if (componentInParent != null && systemAbility.CanAttack(behave, componentInParent.id, out var target))
				{
					float num3 = target.GetCompTransform().physicsPosition.x - behave.GetCompTransform().physicsPosition.x;
					float num4 = Mathf.Abs(num3);
					CompInput compInput = behave.GetCompInput();
					if (num4 > num2 && (!ignoreBack || (float)((compInput.dirX == EInputDir.Left) ? (-1) : ((compInput.dirX == EInputDir.Right) ? 1 : 0)) * num3 >= 0f))
					{
						num2 = num4;
						result = target;
					}
				}
			}
		}
		PhysicsUtility.Release(cacheColliders);
		return result;
	}

	public static Vector3 GetTargetPosition(Entity entity, PosSourceType posSourceType)
	{
		CompTransform compTransform = entity.GetCompTransform();
		switch (posSourceType)
		{
		case PosSourceType.wrapFootPos:
			return compTransform.physicsPosition;
		case PosSourceType.WaistPos:
		{
			MonoEntity mono = entity.GetMono();
			if ((object)mono != null && mono.TryGetAttachPoint(BattleConsts.AIM_ATTACH_POINT, out var attackPoint))
			{
				return attackPoint.position;
			}
			return compTransform.physicsPosition;
		}
		case PosSourceType.lastGroundPoint:
		{
			CompPhysics compPhysics = entity.GetCompPhysics();
			if (compPhysics != null)
			{
				return new Vector3(compTransform.physicsPosition.x, compPhysics.lastGroundPoint.y, compTransform.physicsPosition.z);
			}
			return compTransform.physicsPosition;
		}
		default:
			return compTransform.physicsPosition;
		}
	}

	public static Vector3 GetTargetPosition(ActionMemory memory, FindTargetResult findResult, PosSourceType posSourceType, string attachPointName = null)
	{
		CompTransform compTransform = memory.owner.GetCompTransform();
		Entity entity = findResult.entity;
		if (!entity.IsValid)
		{
			return compTransform.physicsPosition;
		}
		CompTransform compTransform2 = entity.GetCompTransform();
		MonoEntity mono = entity.GetMono();
		ConfigCharacter config = entity.GetConfig();
		Vector3 result = Vector3.zero;
		switch (posSourceType)
		{
		case PosSourceType.wrapFootPos:
			result = compTransform2.physicsPosition;
			break;
		case PosSourceType.WrapHeadPos:
			if (!entity.IsCollection())
			{
				result = compTransform2.physicsPosition;
				result.y += compTransform2.size.y;
			}
			else if (!LuminApplication.LogEnabled)
			{
			}
			break;
		case PosSourceType.BodyNear:
		{
			if (!entity.IsBehaveEntity() && !entity.IsCharacter())
			{
				_ = LuminApplication.LogEnabled;
			}
			if (findResult.entity.GetConfig() == null)
			{
				_ = LuminApplication.LogEnabled;
				return entity.GetCompTransform().physicsPosition;
			}
			MonsterWeigtType monsterWeigtType = config.monsterWeigtType;
			if (monsterWeigtType == MonsterWeigtType.Small || monsterWeigtType == MonsterWeigtType.Normal)
			{
				if (!entity.IsCollection())
				{
					result = compTransform2.physicsPosition;
				}
				else if (!LuminApplication.LogEnabled)
				{
				}
				break;
			}
			int num3 = Mathf.Max(findResult.bodyIndex, 1);
			MonoBodyPart monoBodyPart3 = mono.bodyParts[num3 - 1];
			if (!entity.IsCollection())
			{
				CompPhysics compPhysics = entity.GetCompPhysics();
				float num4 = ((compPhysics != null && compPhysics.overlapEntityMode == OverlapEntityMode.Uncrossable) ? (memory.owner.GetCompTransform().size.x / 2f) : 0f);
				Vector3 center2 = monoBodyPart3.myCollider.bounds.center;
				center2.x -= monoBodyPart3.myCollider.bounds.extents.x + num4;
				Vector3 position2 = monoBodyPart3.myCollider.transform.position;
				position2.x += monoBodyPart3.myCollider.bounds.extents.x + num4;
				result = VectorUtility.GetClosestPoint(compTransform.physicsPosition, center2, position2);
			}
			else if (!LuminApplication.LogEnabled)
			{
			}
			break;
		}
		case PosSourceType.WaistPos:
			result = mono.GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT);
			break;
		case PosSourceType.ExtraAttachPos:
			result = mono.GetAttachPointPosition(attachPointName);
			break;
		case PosSourceType.ExtraAttackDir:
		{
			mono.TryGetAttachPoint(attachPointName, out var attackPoint);
			result = attackPoint.rotation.eulerAngles;
			break;
		}
		case PosSourceType.VerticalBodyNear:
		{
			if (!entity.IsBehaveEntity() && !entity.IsCharacter())
			{
				_ = LuminApplication.LogEnabled;
			}
			int num2 = Mathf.Max(findResult.bodyIndex, 1);
			MonoBodyPart monoBodyPart2 = mono.bodyParts[num2 - 1];
			if (!entity.IsCollection())
			{
				Vector3 center = monoBodyPart2.myCollider.bounds.center;
				center.y -= monoBodyPart2.myCollider.bounds.extents.y;
				Vector3 position = monoBodyPart2.myCollider.transform.position;
				position.y += monoBodyPart2.myCollider.bounds.extents.y;
				result = VectorUtility.GetClosestPoint(compTransform.physicsPosition, center, position);
			}
			else if (!LuminApplication.LogEnabled)
			{
			}
			break;
		}
		case PosSourceType.targetXZAndSlefY:
			result = compTransform2.physicsPosition;
			result.y = compTransform.physicsPosition.y;
			break;
		case PosSourceType.BodyBehind:
		{
			if (!entity.IsBehaveEntity() && !entity.IsCharacter())
			{
				_ = LuminApplication.LogEnabled;
			}
			int num = Mathf.Max(findResult.bodyIndex, 1);
			MonoBodyPart monoBodyPart = mono.bodyParts[num - 1];
			Bounds sonColliderBounds = mono.SonColliderBounds;
			if (!entity.IsCollection())
			{
				bool flag = sonColliderBounds.size != Vector3.zero;
				Vector3 physicsPosition = compTransform2.physicsPosition;
				Vector3 vector = (flag ? physicsPosition : monoBodyPart.myCollider.bounds.center);
				vector.x -= (flag ? sonColliderBounds.extents.x : monoBodyPart.myCollider.bounds.extents.x);
				Vector3 vector2 = (flag ? physicsPosition : monoBodyPart.myCollider.bounds.center);
				vector2.x += (flag ? sonColliderBounds.extents.x : monoBodyPart.myCollider.bounds.extents.x);
				if (memory.owner.IsFaceLeft())
				{
					result.x = vector.x;
				}
				else
				{
					result.x = vector2.x;
				}
			}
			else if (!LuminApplication.LogEnabled)
			{
			}
			break;
		}
		default:
			result = compTransform2.physicsPosition;
			break;
		}
		return result;
	}

	public static bool TryGetLaneBodyBehindPosition(ActionMemory memory, FindTargetResult findResult, out Vector3 behindPos)
	{
		behindPos = default;
		Entity owner = memory.owner;
		Entity entity = findResult.entity;
		if (!owner.IsValid || !entity.IsValid || entity.IsCollection())
		{
			return false;
		}
		if (!entity.IsBehaveEntity() && !entity.IsCharacter())
		{
			return false;
		}
		CompTransform compTransform = owner.GetCompTransform();
		CompTransform? compTransform2 = entity.GetCompTransform();
		Vector3 physicsPosition = compTransform.physicsPosition;
		float num = 2f;
		if (Mathf.Abs(compTransform2.physicsPosition.z - physicsPosition.z) > num)
		{
			return false;
		}
		MonoEntity mono = entity.GetMono();
		if (mono == null)
		{
			return false;
		}
		float num2 = (owner.IsFaceRight() ? 1f : (-1f));
		Vector3 rayDir = new Vector3(0f - num2, 0f, 0f);
		Vector3 colliderPosition = compTransform.colliderPosition;
		float bodyHalfHeight = compTransform.size.y * 0.5f;
		float bestDistance = float.MaxValue;
		Vector3 bestPoint = Vector3.zero;
		bool anyHit = false;
		bool flag = false;
		SonCollider[] sonColliders = mono.sonColliders;
		if (sonColliders != null)
		{
			foreach (SonCollider sonCollider in sonColliders)
			{
				if (!(sonCollider == null))
				{
					Collider component = sonCollider.GetComponent<Collider>();
					if (!(component == null))
					{
						flag = true;
						TryRaycastLaneCollider(component, colliderPosition, bodyHalfHeight, num, num2, rayDir, ref anyHit, ref bestDistance, ref bestPoint);
					}
				}
			}
		}
		if (!flag)
		{
			MonoBodyPart[] bodyParts = mono.bodyParts;
			if (bodyParts != null)
			{
				foreach (MonoBodyPart monoBodyPart in bodyParts)
				{
					if (!(monoBodyPart == null))
					{
						TryRaycastLaneCollider(monoBodyPart.myCollider, colliderPosition, bodyHalfHeight, num, num2, rayDir, ref anyHit, ref bestDistance, ref bestPoint);
					}
				}
			}
		}
		if (!anyHit)
		{
			TryRaycastLaneCollider(findResult.Collider, colliderPosition, bodyHalfHeight, num, num2, rayDir, ref anyHit, ref bestDistance, ref bestPoint);
		}
		if (!anyHit)
		{
			return false;
		}
		behindPos = bestPoint;
		behindPos.x += num2 * (compTransform.size.x + 0.05f);
		behindPos.y = physicsPosition.y;
		behindPos.z = physicsPosition.z;
		return (behindPos.x - physicsPosition.x) * num2 > 0f;
	}

	private static void TryRaycastLaneCollider(Collider collider, Vector3 bodyCenter, float bodyHalfHeight, float laneHalfZ, float dirX, Vector3 rayDir, ref bool anyHit, ref float bestDistance, ref Vector3 bestPoint)
	{
		if (collider == null || !collider.enabled)
		{
			return;
		}
		Bounds bounds = collider.bounds;
		float min = Mathf.Max(bodyCenter.z - laneHalfZ, bounds.min.z);
		float max = Mathf.Min(bodyCenter.z + laneHalfZ, bounds.max.z);
		float min2 = Mathf.Max(bodyCenter.y - bodyHalfHeight, bounds.min.y);
		float max2 = Mathf.Min(bodyCenter.y + bodyHalfHeight, bounds.max.y);
		if (max < min || max2 < min2)
		{
			return;
		}
		InsetLaneRange(ref min2, ref max2, 0.02f);
		InsetLaneRange(ref min, ref max, 0.02f);
		float x = bodyCenter.x + dirX * 20f;
		int num = ((!(max2 - min2 > 0.02f)) ? 1 : 3);
		int num2 = ((!(max - min > 0.02f)) ? 1 : 3);
		for (int i = 0; i < num; i++)
		{
			float y = Mathf.Lerp(min2, max2, (num == 1) ? 0.5f : ((float)i * 0.5f));
			for (int j = 0; j < num2; j++)
			{
				float z = Mathf.Lerp(min, max, (num2 == 1) ? 0.5f : ((float)j * 0.5f));
				Ray ray = new Ray(new Vector3(x, y, z), rayDir);
				if (collider.Raycast(ray, out var hitInfo, 40f) && !(hitInfo.distance >= bestDistance))
				{
					bestDistance = hitInfo.distance;
					bestPoint = hitInfo.point;
					anyHit = true;
				}
			}
		}
	}

	private static void InsetLaneRange(ref float min, ref float max, float inset)
	{
		if (max - min <= inset * 2f)
		{
			float num = (min + max) * 0.5f;
			min = (max = num);
		}
		else
		{
			min += inset;
			max -= inset;
		}
	}

	public static float GetTwoPointDistance(Entity a, Entity b, DistanceType distanceType)
	{
		CompTransform compTransform = a.GetCompTransform();
		CompTransform compTransform2 = b.GetCompTransform();
		switch (distanceType)
		{
		case DistanceType.horizontal:
			return Mathf.Abs(compTransform.lastPhysicsPosition.x - compTransform2.physicsPosition.x);
		case DistanceType.vertical:
			return Mathf.Abs(compTransform.lastPhysicsPosition.y - compTransform2.physicsPosition.y);
		case DistanceType.line:
		{
			float num = Mathf.Abs(compTransform.lastPhysicsPosition.x - compTransform2.physicsPosition.x);
			float num2 = num * num;
			float num3 = Mathf.Abs(compTransform.lastPhysicsPosition.y - compTransform2.physicsPosition.y);
			num3 *= num3;
			return Mathf.Sqrt(num2 + num3);
		}
		case DistanceType.horizontalAddColliderRadius:
			return Mathf.Abs(compTransform.lastPhysicsPosition.x - compTransform2.physicsPosition.x) - (compTransform.size.x / 2f + compTransform2.size.x / 2f);
		case DistanceType.verticalWithOutAbs:
			return compTransform2.lastPhysicsPosition.y - compTransform.physicsPosition.y;
		default:
			return float.MaxValue;
		}
	}

	public static bool GetTwoFloatCondition(float a, float b, ACT.Battle.Condition condition)
	{
		bool result = false;
		switch (condition)
		{
		case ACT.Battle.Condition.Greater:
			if (a > b)
			{
				result = true;
			}
			break;
		case ACT.Battle.Condition.Less:
			if (a < b)
			{
				result = true;
			}
			break;
		case ACT.Battle.Condition.Equal:
			if (Mathf.Approximately(a, b))
			{
				result = true;
			}
			break;
		case ACT.Battle.Condition.GreaterAndEqual:
			if (a - b >= 0f)
			{
				result = true;
			}
			break;
		case ACT.Battle.Condition.LessAndEqual:
			if (a - b <= 0f)
			{
				result = true;
			}
			break;
		}
		return result;
	}
}
