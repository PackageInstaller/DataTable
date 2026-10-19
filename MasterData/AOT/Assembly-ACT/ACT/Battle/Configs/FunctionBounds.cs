using System;
using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取边界", "Function", new string[] { "bounds", "vector", "position", "rotation", "quaternion" })]
public class FunctionBounds : ConfigFunction<Bounds>
{
	public CoordinateSystem coordinate;

	public bool useFaceDir;

	public Bounds bounds;

	protected override Bounds Evaluate(ActionMemory memory)
	{
		Entity entity = memory.target.entity;
		Vector3 vector = (useFaceDir ? VectorUtility.HorizontalDirection(entity.IsFaceLeft(), bounds.center) : bounds.center);
		return coordinate switch
		{
			CoordinateSystem.Local => new Bounds(entity.GetCompTransform().physicsPosition + vector, bounds.size), 
			CoordinateSystem.Collider => new Bounds(entity.GetCompTransform().colliderPosition + vector, bounds.size), 
			CoordinateSystem.Global => bounds, 
			_ => throw new NotImplementedException(), 
		};
	}
}
