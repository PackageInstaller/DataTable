using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class ColliderSwitcher : MonoBehaviour
{
	public Collider targetCollider;

	[Tooltip("如果勾选这个，在范围内按‘下’才会无视碰撞")]
	public bool downIgnore;

	private void OnTriggerEnter(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (component == null)
		{
			return;
		}
		CompPhysics component3;
		if (downIgnore)
		{
			if (component.entity.TryGetCompInput(out CompInput component2))
			{
				component2.onDownPressed.Add(OnDown);
			}
		}
		else if (component.entity.TryGetCompPhysics(out component3))
		{
			component3.characterMovement.IgnoreCollision(targetCollider);
		}
	}

	private void OnTriggerExit(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!(component == null))
		{
			if (downIgnore && component.entity.TryGetCompInput(out CompInput component2))
			{
				component2.onDownPressed.Remove(OnDown);
			}
			if (component.entity.TryGetCompPhysics(out CompPhysics component3))
			{
				component3.characterMovement.IgnoreCollision(targetCollider, ignore: false);
			}
		}
	}

	private void OnDown(Entity entity, float pressTime)
	{
		entity.GetCompPhysics().characterMovement.IgnoreCollision(targetCollider);
	}
}
