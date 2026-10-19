using System;
using System.Collections.Generic;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取向量3", "Function", new string[] { "vector3", "vector", "position", "rotation", "quaternion" })]
public class FunctionVector3 : ConfigFunction<Vector3>
{
	public bool useInherit;

	public ConfigFunction<Vector3> baseValue;

	public CoordinateSystem coordinate;

	[Tooltip("搜索朝向参考")]
	public BaseFindTargets findTargets;

	public WhereTargets whereTargets;

	[Tooltip("使用目标半径")]
	public bool useSize;

	public Vector3 offest;

	protected override Vector3 Evaluate(ActionMemory memory)
	{
		Vector3 offset = offest;
		Entity entity = memory.target.entity;
		if (findTargets != null)
		{
			List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
			findTargets.FindTargets(memory.owner, list);
			whereTargets.FindTargets(list, memory.owner);
			if (list.Count > 0)
			{
				entity = list[0].entity;
				if (useSize)
				{
					offset.x += (float)GameUtility.Dir(offset.x) * (memory.target.entity.GetCompTransform().size.x / 2f + list[0].entity.GetCompTransform().size.x / 2f);
				}
			}
			ListPool<FindTargetResult>.Release(list);
		}
		if (useInherit)
		{
			return baseValue.Return(memory) + entity.GetCompTransform().FaceDirOffest(offset);
		}
		return coordinate switch
		{
			CoordinateSystem.Local => memory.target.entity.GetCompTransform().physicsPosition + entity.GetCompTransform().FaceDirOffest(offset), 
			CoordinateSystem.Collider => memory.target.entity.GetCompTransform().colliderPosition + entity.GetCompTransform().FaceDirOffest(offset), 
			CoordinateSystem.Global => entity.GetCompTransform().FaceDirOffest(offset), 
			_ => throw new NotImplementedException(), 
		};
	}
}
