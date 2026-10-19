using System;
using System.Collections.Generic;

namespace Bamboo.ECS;

internal static class ComponentTypeRegistry
{
	private static class Cache<T> where T : IComponent
	{
		internal static readonly ComponentTypeId Id = RegisterType(typeof(T));
	}

	private static readonly Dictionary<Type, ComponentTypeId> _typeToId = new Dictionary<Type, ComponentTypeId>();

	private static readonly List<Type> _idToType = new List<Type>();

	private static int _nextId = 0;

	public static int Count => _idToType.Count;

	public static ComponentTypeId GetTypeId<T>() where T : IComponent
	{
		return Cache<T>.Id;
	}

	public static Type GetType(ComponentTypeId id)
	{
		if (id.Id < 0 || id.Id >= _idToType.Count)
		{
			return null;
		}
		return _idToType[id.Id];
	}

	private static ComponentTypeId RegisterType(Type type)
	{
		if (!_typeToId.TryGetValue(type, out var value))
		{
			value = new ComponentTypeId(_nextId++);
			_typeToId[type] = value;
			_idToType.Add(type);
		}
		return value;
	}
}
