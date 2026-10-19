using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;
using UnityEngine.Serialization;

namespace Battle.Configs.Ability.Action;

[AbilityTypeMetadata("添加碰撞体", "Action", new string[] { "add", "collider", "damage", "hit", "attack" })]
public class ActionAddCollider : ConfigAction
{
	public int layer;

	public Shape shape;

	public Vector3 boxCenter;

	public Vector3 size;

	[FormerlySerializedAs("center")]
	public Vector3 sphereCenter;

	public float radius;

	public string tag;

	public override void Do(ActionMemory memory)
	{
		MonoEntity mono = memory.target.entity.GetMono();
		Collider component = mono.gameObject.GetComponent<Collider>();
		if ((bool)component)
		{
			Object.DestroyImmediate(component);
		}
		switch (shape)
		{
		case Shape.Box:
		{
			BoxCollider boxCollider = mono.gameObject.AddComponent<BoxCollider>();
			boxCollider.center = boxCenter;
			boxCollider.size = size;
			break;
		}
		case Shape.Sphere:
		{
			SphereCollider sphereCollider = mono.gameObject.AddComponent<SphereCollider>();
			sphereCollider.center = sphereCenter;
			sphereCollider.radius = radius;
			break;
		}
		}
		mono.gameObject.layer = layer;
		if (!string.IsNullOrEmpty(tag))
		{
			mono.gameObject.tag = tag;
		}
	}
}
