using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断碰撞", "Predicate", new string[] { "check", "collision", "predicate", "condition" })]
public class CheckCollision : ConfigPredicate
{
	public ConfigFunction<Vector3> startPointFunction;

	public RaycastType raycastType;

	public Vector3[] directions;

	public float distance;

	public bool noFaceDir;

	[Tooltip("配置后，检测会跳过环境层上使用该Unity Tag的Collider")]
	public string ignoreEnvironmentCollisionTag;

	public Bounds size;

	public float radius;

	public override bool Check(ActionMemory memory)
	{
		Vector3 vector = startPointFunction.Return(memory);
		bool result = false;
		switch (raycastType)
		{
		case RaycastType.Ray:
		{
			Vector3[] array = directions;
			foreach (Vector3 vector3 in array)
			{
				Vector3 direction2 = ((!noFaceDir && memory.target.entity.IsFaceLeft()) ? (-vector3) : vector3);
				if (HasEnvironmentCollision(vector, direction2, Quaternion.identity))
				{
					result = true;
					break;
				}
			}
			break;
		}
		case RaycastType.Box:
		{
			Vector3[] array = directions;
			foreach (Vector3 vector4 in array)
			{
				Vector3 direction3 = (memory.target.entity.IsFaceLeft() ? (-vector4) : vector4);
				Quaternion quaternion = memory.target.entity.GetCompPhysics()?.faceDirRot ?? memory.target.entity.GetRootTransform().rotation;
				Vector3 vector5 = quaternion * size.center;
				if (!HasEnvironmentCollision(vector + vector5, direction3, quaternion))
				{
					result = true;
					break;
				}
			}
			break;
		}
		case RaycastType.Sphere:
		{
			Vector3[] array = directions;
			foreach (Vector3 vector2 in array)
			{
				Vector3 direction = (memory.target.entity.IsFaceLeft() ? vector2 : (-vector2));
				if (!HasEnvironmentCollision(vector, direction, Quaternion.identity))
				{
					result = true;
					break;
				}
			}
			break;
		}
		}
		return result;
	}

	private bool HasEnvironmentCollision(Vector3 startPoint, Vector3 direction, Quaternion rotation)
	{
		RaycastHit hitInfo;
		if (string.IsNullOrEmpty(ignoreEnvironmentCollisionTag))
		{
			return raycastType switch
			{
				RaycastType.Ray => Physics.Raycast(startPoint, direction, distance, BattleConsts.enviromentMask), 
				RaycastType.Box => Physics.BoxCast(startPoint, size.extents, direction, rotation, distance, BattleConsts.enviromentMask), 
				RaycastType.Sphere => Physics.SphereCast(startPoint, radius, direction, out hitInfo, distance, BattleConsts.enviromentMask), 
				_ => false, 
			};
		}
		RaycastHit[] cacheHits = PhysicsUtility.cacheHits;
		try
		{
			int num = raycastType switch
			{
				RaycastType.Ray => Physics.RaycastNonAlloc(startPoint, direction, cacheHits, distance, BattleConsts.enviromentMask), 
				RaycastType.Box => Physics.BoxCastNonAlloc(startPoint, size.extents, direction, cacheHits, rotation, distance, BattleConsts.enviromentMask), 
				RaycastType.Sphere => Physics.SphereCastNonAlloc(startPoint, radius, direction, cacheHits, distance, BattleConsts.enviromentMask), 
				_ => 0, 
			};
			for (int i = 0; i < num; i++)
			{
				Collider collider = cacheHits[i].collider;
				if (collider != null && !collider.CompareTag(ignoreEnvironmentCollisionTag))
				{
					return true;
				}
			}
			return num >= cacheHits.Length;
		}
		finally
		{
			PhysicsUtility.Release(cacheHits);
		}
	}
}
