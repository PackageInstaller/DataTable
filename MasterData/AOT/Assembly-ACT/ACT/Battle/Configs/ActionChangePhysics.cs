using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改Physics", "Action", new string[] { "change", "physics" })]
public class ActionChangePhysics : ConfigAction
{
	public Vector2 size;

	public Vector3 offset;

	public override void Do(ActionMemory memory)
	{
		CompTransform? compTransform = memory.target.entity.GetCompTransform();
		compTransform.size = size;
		compTransform.center = offset;
	}
}
