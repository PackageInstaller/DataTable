using System;
using System.Collections.Generic;

namespace Bamboo.ECS;

internal static class ComponentPoolRegistry
{
	internal interface IManagedPoolOps
	{
		object Get();

		void Release(object obj);
	}

	private class ManagedPoolOps<T> : IManagedPoolOps where T : class, IComponent, new()
	{
		public object Get()
		{
			return ComponentPool<T>.Get();
		}

		public void Release(object obj)
		{
			ComponentPool<T>.Release((T)obj);
		}
	}

	private static class Cache<T> where T : class, IComponent, new()
	{
		internal static readonly IManagedPoolOps Ops = RegisterOps<T>();
	}

	private static readonly Dictionary<Type, IManagedPoolOps> _ops = new Dictionary<Type, IManagedPoolOps>();

	public static bool IsManagedComponent(Type type)
	{
		if (typeof(IComponent).IsAssignableFrom(type))
		{
			return !type.IsValueType;
		}
		return false;
	}

	public static IManagedPoolOps GetOps<T>() where T : class, IComponent, new()
	{
		return Cache<T>.Ops;
	}

	public static IManagedPoolOps GetOps(Type type)
	{
		_ops.TryGetValue(type, out var value);
		return value;
	}

	public static void Release(Type type, object obj)
	{
		if (obj != null && IsManagedComponent(type) && _ops.TryGetValue(type, out var value))
		{
			value.Release(obj);
		}
	}

	private static IManagedPoolOps RegisterOps<T>() where T : class, IComponent, new()
	{
		Type typeFromHandle = typeof(T);
		if (!_ops.TryGetValue(typeFromHandle, out var value))
		{
			value = new ManagedPoolOps<T>();
			_ops[typeFromHandle] = value;
		}
		return value;
	}
}
