using System;

namespace Bamboo.ECS;

internal static class ComponentTypeCache<T> where T : IComponent
{
	internal static readonly ComponentTypeId TypeId = ComponentTypeRegistry.GetTypeId<T>();

	internal static readonly int TypeIndex = TypeId.Id;

	internal static readonly ulong Mask = BuildMask(TypeId);

	private static ulong BuildMask(ComponentTypeId typeId)
	{
		int id = typeId.Id;
		if ((uint)id >= 64u)
		{
			throw new InvalidOperationException($"Bamboo ECS 64-bit component signature supports type ids 0..63, but got {id}.");
		}
		return (ulong)(1L << id);
	}
}
