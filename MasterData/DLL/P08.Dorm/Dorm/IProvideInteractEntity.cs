using System.Collections.Generic;
using Dorm.Character;
using UnityEngine;

namespace Dorm;

public interface IProvideInteractEntity : IEidProvider, IInteractProvider
{
	Transform MainColliderTrs { get; }

	bool OccupyInteractArea { get; }

	void Bind(DormEntity providerEntity);

	void OnInteractBeingCanceled();

	static InteractAction? RndPickAction(IProvideInteractEntity provider, IEnumerable<InteractAction> actions, DormEntity entity)
	{
		List<InteractAction> list = new List<InteractAction>();
		if (actions == null)
		{
			return null;
		}
		foreach (InteractAction action in actions)
		{
			if (IInteractProvider.ActionPosIsNotBlocked(action, entity, provider.MainColliderTrs))
			{
				list.Add(action);
			}
		}
		if (list.Count > 0)
		{
			return list[Random.Range(0, list.Count)];
		}
		return null;
	}
}
