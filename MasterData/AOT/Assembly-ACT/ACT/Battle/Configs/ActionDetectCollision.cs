using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行Detect碰撞", "Action", new string[] { "detect", "collision", "damage", "hit", "attack" })]
public class ActionDetectCollision : ConfigAction
{
	public ConfigFunction<Vector3> startPointFunction;

	public RaycastType raycastType;

	public Vector3[] directions;

	public float distance;

	public Bounds size;

	public float radius;

	public ConfigAction[] actionsWhenOnHit;

	public ConfigAction[] actionsNoHit;

	private Vector3 startPoint;

	public override void Do(ActionMemory memory)
	{
		startPoint = startPointFunction.Return(memory);
		bool flag = false;
		switch (raycastType)
		{
		case RaycastType.Ray:
		{
			Vector3[] array = directions;
			foreach (Vector3 vector2 in array)
			{
				Vector3 direction2 = (memory.target.entity.IsFaceLeft() ? (-vector2) : vector2);
				if (Physics.Raycast(startPoint, direction2, distance, BattleConsts.enviromentMask))
				{
					flag = true;
				}
			}
			break;
		}
		case RaycastType.Box:
		{
			Vector3[] array = directions;
			foreach (Vector3 vector3 in array)
			{
				Vector3 direction3 = (memory.target.entity.IsFaceLeft() ? vector3 : (-vector3));
				if (Physics.BoxCast(startPoint, size.extents, direction3, Quaternion.identity, distance, BattleConsts.enviromentMask))
				{
					flag = true;
				}
			}
			break;
		}
		case RaycastType.Sphere:
		{
			Vector3[] array = directions;
			foreach (Vector3 vector in array)
			{
				Vector3 direction = (memory.target.entity.IsFaceLeft() ? vector : (-vector));
				if (Physics.SphereCast(startPoint, radius, direction, out var _, distance, BattleConsts.enviromentMask))
				{
					flag = true;
				}
			}
			break;
		}
		}
		if (flag)
		{
			SystemAbility.DoActions(memory, actionsWhenOnHit);
		}
		else
		{
			SystemAbility.DoActions(memory, actionsNoHit);
		}
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, actionsWhenOnHit, ab);
		ConfigAbility.CacheActionList(list, actionsNoHit, ab);
	}
}
