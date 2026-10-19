using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;
using UnityEngine.Serialization;

namespace Battle.Configs.Ability.Action;

[AbilityTypeMetadata("执行轨迹碰撞体", "Action", new string[] { "trajectory", "add", "collider", "damage", "hit", "attack" })]
public class ActionTrajectoryAddCollider : ConfigAction
{
	public Shape shape;

	public Vector3 boxCenter;

	public Vector3 size;

	[FormerlySerializedAs("center")]
	public Vector3 sphereCenter;

	public float radius;

	public string tag;

	public override void Do(ActionMemory memory)
	{
		Entity entity = memory.target.entity;
		if (memory.target.entity.IsTrajectory())
		{
			GameObject root = entity.GetRoot();
			Collider component = root.GetComponent<Collider>();
			if ((bool)component)
			{
				Object.DestroyImmediate(component);
			}
			switch (shape)
			{
			case Shape.Box:
			{
				BoxCollider boxCollider = root.AddComponent<BoxCollider>();
				boxCollider.center = boxCenter;
				boxCollider.size = size;
				break;
			}
			case Shape.Sphere:
			{
				SphereCollider sphereCollider = root.AddComponent<SphereCollider>();
				sphereCollider.center = sphereCenter;
				sphereCollider.radius = radius;
				break;
			}
			}
			TrajectoryCollider component2 = root.GetComponent<TrajectoryCollider>();
			if ((bool)component2)
			{
				Object.DestroyImmediate(component2);
			}
			component2 = root.gameObject.AddComponent<TrajectoryCollider>();
			component2.Init(entity);
			if (!string.IsNullOrEmpty(tag))
			{
				root.tag = tag;
			}
		}
	}
}
