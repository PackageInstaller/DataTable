using System.Collections.Generic;
using Dorm.Character;
using UnityEngine;

namespace Dorm;

public interface IInteractProvider
{
	int WaitInteractCount { get; }

	int InteractEntityCountLimit { get; }

	IEnumerable<InteractAction> Actions { get; }

	int? ProvideAction(DormEntity entity, out Transform interactPos, out Transform exitPos);

	static bool ActionPosIsNotBlocked(InteractAction action, DormEntity entity, Transform furnitureMainColliderTrs)
	{
		float radius = entity.radius;
		float height = entity.height;
		return ActionPosIsNotBlocked(furnitureMainColliderTrs, action.interactPos, action.exitPos, radius, height);
	}

	internal static bool ActionPosIsNotBlocked(Transform providerSelf, Transform interactPos, Transform exitPos, float radius, float height)
	{
		if ((bool)interactPos)
		{
			if (!DormLuaBridge.InDormSpawnBounds(interactPos.position))
			{
				return false;
			}
			Collider[] array = InteractAction.CalcColliderOverlappedOnPos(interactPos.position, radius, height);
			foreach (Collider obj in array)
			{
				IProvideInteractEntity component = obj.gameObject.GetComponent<IProvideInteractEntity>();
				bool flag = component != null && !component.OccupyInteractArea;
				if (!((obj.transform == providerSelf) | flag))
				{
					return false;
				}
			}
		}
		if ((bool)exitPos)
		{
			if (!DormLuaBridge.InDormSpawnBounds(exitPos.position))
			{
				return false;
			}
			Collider[] array2 = InteractAction.CalcColliderOverlappedOnPos(exitPos.position, radius, height);
			if (array2 != null && array2.Length != 0)
			{
				Collider[] array = array2;
				for (int i = 0; i < array.Length; i++)
				{
					IProvideInteractEntity component2 = array[i].gameObject.GetComponent<IProvideInteractEntity>();
					if (component2 == null || component2.OccupyInteractArea)
					{
						return false;
					}
				}
			}
		}
		return true;
	}
}
