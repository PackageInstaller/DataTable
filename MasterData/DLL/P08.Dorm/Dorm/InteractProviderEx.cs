using Dorm.Character;
using UnityEngine;

namespace Dorm;

public static class InteractProviderEx
{
	public static bool AnyActionAvailable(this IInteractProvider provider, DormEntity entity)
	{
		Transform interactPos;
		Transform exitPos;
		return provider.ProvideAction(entity, out interactPos, out exitPos).HasValue;
	}
}
