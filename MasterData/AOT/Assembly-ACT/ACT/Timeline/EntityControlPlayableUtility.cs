using ACT.Battle;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Timeline;

internal static class EntityControlPlayableUtility
{
	public static Entity ResolveEntity(object playerData)
	{
		if (!(playerData is MonoEntity monoEntity))
		{
			if (!(playerData is GameObject gameObject))
			{
				if (playerData is Component component)
				{
					return (component.GetComponent<MonoEntity>() ?? component.GetComponentInParent<MonoEntity>())?.entity ?? default(Entity);
				}
				return default;
			}
			return (gameObject.GetComponent<MonoEntity>() ?? gameObject.GetComponentInParent<MonoEntity>())?.entity ?? default(Entity);
		}
		return monoEntity.entity;
	}
}
