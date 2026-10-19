using System.Collections.Generic;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取实体位置", "Function", new string[] { "entity", "position", "vector", "rotation", "quaternion" })]
public class FunctionEntityPosition : ConfigFunction<Vector3>
{
	[Tooltip("搜索目标,只会选中第一个结果")]
	public BaseFindTargets findTargets;

	public ConfigPredicate predicate = new WhereTargetsPredicate();

	public ConfigFunction<Vector3> fallback;

	public bool disSort;

	public bool useNewPreSet = true;

	public PosSourceType endPosType;

	public string attachPointName;

	public bool useAimPosition;

	public bool dontUseTargetDir;

	public bool useOwnerDir;

	public bool useAttachPoint;

	public bool useAttachPointForward;

	[Tooltip("挂点")]
	public string attachPoint = BattleConsts.AIM_ATTACH_POINT;

	[Tooltip("地面Offset")]
	public Vector3 groundOffset;

	public Vector3 offest;

	public Vector3 targetOffest;

	public bool useGroundPosition;

	[Tooltip("投影到地面的检测距离")]
	public float rayDistance;

	public bool useBodyFront;

	public bool checkCollider;

	protected override Vector3 Evaluate(ActionMemory memory)
	{
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		findTargets.FindTargets(memory.owner, list);
		if (predicate != null)
		{
			BaseFindTargets.Where(memory.owner, list, predicate);
		}
		if (list.Count > 0)
		{
			if (disSort && list.Count > 1)
			{
				list.Sort((FindTargetResult a, FindTargetResult b) =>
				{
					Vector3 physicsPosition2 = memory.owner.GetCompTransform().physicsPosition;
					float sqrMagnitude = (a.entity.GetCompTransform().physicsPosition - physicsPosition2).sqrMagnitude;
					float sqrMagnitude2 = (b.entity.GetCompTransform().physicsPosition - physicsPosition2).sqrMagnitude;
					return sqrMagnitude.CompareTo(sqrMagnitude2);
				});
			}
			FindTargetResult findResult = list[0];
			Entity entity = list[0].entity;
			ListPool<FindTargetResult>.Release(list);
			Vector3 zero = Vector3.zero;
			if (useNewPreSet)
			{
				zero = AbilityUtility.GetTargetPosition(memory, findResult, endPosType, attachPointName);
				zero += memory.owner.GetCompTransform().FaceRotation.normalized * offest;
				zero += findResult.entity.GetCompTransform().FaceRotation.normalized * targetOffest;
			}
			else
			{
				if (useAimPosition)
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogWarning($"{memory.target.entity} 的 {memory.ability} 的configfunction 使用了 useAimPosition选项,应该停止使用这个选项");
					}
					zero = entity.GetCompAim().aimTargetPosition;
				}
				else if (useAttachPoint)
				{
					zero = entity.GetMono().GetAttachPointPosition(attachPoint);
				}
				else if (useAttachPointForward)
				{
					zero = entity.GetMono().GetAttachPointPosition(attachPoint);
				}
				else
				{
					zero = entity.GetCompTransform().physicsPosition;
					if (entity.IsMonster() && entity.GetConfig().monsterWeigtType == MonsterWeigtType.Giant)
					{
						zero = findResult.SourcePosition;
					}
				}
				CompPhysics component;
				if (dontUseTargetDir)
				{
					zero += offest;
				}
				else if (useOwnerDir)
				{
					zero += memory.owner.GetCompTransform().FaceRotation.normalized * offest;
				}
				else if (entity.TryGetCompPhysics(out component))
				{
					zero += component.faceDirRot.normalized * offest;
				}
			}
			CompTransform compTransform = entity.GetCompTransform();
			if (useGroundPosition)
			{
				zero = GroundPosition(zero, rayDistance) + (dontUseTargetDir ? groundOffset : (compTransform.FaceRotation.normalized * groundOffset));
			}
			if (useBodyFront && !entity.IsCollection())
			{
				float num = zero.x - compTransform.size.x / 2f;
				float num2 = zero.x + compTransform.size.x / 2f;
				float x = zero.x;
				if (Mathf.Abs(x - num) < Mathf.Abs(x - num2))
				{
					zero.x = num;
				}
				else
				{
					zero.x = num2;
				}
			}
			if (checkCollider)
			{
				Vector3 physicsPosition = memory.owner.GetCompTransform().physicsPosition;
				Vector3 vector = zero - physicsPosition;
				float magnitude = vector.magnitude;
				vector /= magnitude;
				RaycastHit raycastHit = PhysicsUtility.CapsuleCast(memory.owner.GetCompTransform().colliderPosition, memory.owner.GetCompTransform().size, vector, magnitude);
				if (raycastHit.collider != null)
				{
					return physicsPosition + raycastHit.distance * vector;
				}
				return zero;
			}
			return zero;
		}
		ListPool<FindTargetResult>.Release(list);
		if (fallback == null)
		{
			return memory.owner.GetCompTransform().physicsPosition;
		}
		return fallback.Return(memory);
	}

	public static Vector3 GroundPosition(Vector3 position, float distance)
	{
		Vector3 down = Vector3.down;
		if (Physics.Raycast(new Ray(position, down), out var hitInfo, distance, BattleConsts.enviromentMask))
		{
			return hitInfo.point;
		}
		return position;
	}

	public bool TryEvaluateLaneBodyBehind(ActionMemory memory, out Vector3 targetPos)
	{
		targetPos = default;
		if (!useNewPreSet || endPosType != PosSourceType.BodyBehind || findTargets == null)
		{
			return false;
		}
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		findTargets.FindTargets(memory.owner, list);
		if (predicate != null)
		{
			BaseFindTargets.Where(memory.owner, list, predicate);
		}
		if (disSort && list.Count > 1)
		{
			list.Sort((FindTargetResult a, FindTargetResult b) =>
			{
				Vector3 physicsPosition2 = memory.owner.GetCompTransform().physicsPosition;
				float sqrMagnitude = (a.entity.GetCompTransform().physicsPosition - physicsPosition2).sqrMagnitude;
				float sqrMagnitude2 = (b.entity.GetCompTransform().physicsPosition - physicsPosition2).sqrMagnitude;
				return sqrMagnitude.CompareTo(sqrMagnitude2);
			});
		}
		bool flag = false;
		FindTargetResult findTargetResult = default;
		for (int num = 0; num < list.Count; num++)
		{
			if (AbilityUtility.TryGetLaneBodyBehindPosition(memory, list[num], out targetPos))
			{
				findTargetResult = list[num];
				flag = true;
				break;
			}
		}
		ListPool<FindTargetResult>.Release(list);
		if (!flag)
		{
			return false;
		}
		targetPos += memory.owner.GetCompTransform().FaceRotation.normalized * offest;
		targetPos += findTargetResult.entity.GetCompTransform().FaceRotation.normalized * targetOffest;
		Entity entity = findTargetResult.entity;
		CompTransform compTransform = entity.GetCompTransform();
		if (useGroundPosition)
		{
			targetPos = GroundPosition(targetPos, rayDistance) + (dontUseTargetDir ? groundOffset : (compTransform.FaceRotation.normalized * groundOffset));
		}
		if (useBodyFront && !entity.IsCollection())
		{
			float num2 = targetPos.x - compTransform.size.x / 2f;
			float num3 = targetPos.x + compTransform.size.x / 2f;
			if (Mathf.Abs(targetPos.x - num2) < Mathf.Abs(targetPos.x - num3))
			{
				targetPos.x = num2;
			}
			else
			{
				targetPos.x = num3;
			}
		}
		if (checkCollider)
		{
			Vector3 physicsPosition = memory.owner.GetCompTransform().physicsPosition;
			Vector3 vector = targetPos - physicsPosition;
			float magnitude = vector.magnitude;
			if (magnitude > 0.0001f)
			{
				vector /= magnitude;
				RaycastHit raycastHit = PhysicsUtility.CapsuleCast(memory.owner.GetCompTransform().colliderPosition, memory.owner.GetCompTransform().size, vector, magnitude);
				if (raycastHit.collider != null)
				{
					targetPos = physicsPosition + raycastHit.distance * vector;
				}
			}
		}
		return true;
	}
}
