#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;

namespace Ase;

public static class Game
{
	[StaticField]
	private static readonly Dictionary<Type, ISingleton> singletonTypes = new Dictionary<Type, ISingleton>();

	[StaticField]
	private static readonly Stack<ISingleton> singletons = new Stack<ISingleton>();

	[StaticField]
	private static readonly Queue<ISingleton> updates = new Queue<ISingleton>();

	[StaticField]
	private static readonly Queue<ISingleton> fixedUpdates = new Queue<ISingleton>();

	[StaticField]
	private static readonly Queue<ISingleton> lateUpdates = new Queue<ISingleton>();

	[StaticField]
	private static readonly Queue<ISingleton> drawGizmos = new Queue<ISingleton>();

	public static T AddSingleton<T>() where T : Singleton<T>, new()
	{
		T val = new T();
		AddSingleton(val);
		return val;
	}

	public static void AddSingleton(ISingleton singleton)
	{
		Type type = singleton.GetType();
		if (singletonTypes.ContainsKey(type))
		{
			throw new Exception("already exist singleton: " + type.Name);
		}
		singletonTypes.Add(type, singleton);
		singletons.Push(singleton);
		singleton.Register();
		if (singleton is ISingletonAwake singletonAwake)
		{
			singletonAwake.Awake();
		}
		if (singleton is ISingletonUpdate)
		{
			updates.Enqueue(singleton);
		}
		if (singleton is ISingletonFixedUpdate)
		{
			fixedUpdates.Enqueue(singleton);
		}
		if (singleton is ISingletonLateUpdate)
		{
			lateUpdates.Enqueue(singleton);
		}
	}

	public static void RemoveSingleton<T>() where T : Singleton<T>, new()
	{
		Type typeFromHandle = typeof(T);
		singletonTypes.TryGetValue(typeFromHandle, out var value);
		if (value != null)
		{
			singletonTypes.Remove(typeFromHandle);
			value.Destroy();
		}
	}

	public static void Update()
	{
		int count = updates.Count;
		while (count-- > 0)
		{
			ISingleton singleton = updates.Dequeue();
			if (!singleton.IsDisposed() && singleton is ISingletonUpdate singletonUpdate)
			{
				updates.Enqueue(singleton);
				try
				{
					singletonUpdate.Update();
				}
				catch (Exception message)
				{
					Log.Error(message);
				}
			}
		}
	}

	public static void FixedUpdate()
	{
		int count = fixedUpdates.Count;
		while (count-- > 0)
		{
			ISingleton singleton = fixedUpdates.Dequeue();
			if (!singleton.IsDisposed() && singleton is ISingletonFixedUpdate singletonFixedUpdate)
			{
				fixedUpdates.Enqueue(singleton);
				try
				{
					singletonFixedUpdate.FixedUpdate();
				}
				catch (Exception message)
				{
					Log.Error(message);
				}
			}
		}
	}

	public static void LateUpdate()
	{
		int count = lateUpdates.Count;
		while (count-- > 0)
		{
			ISingleton singleton = lateUpdates.Dequeue();
			if (singleton != null && !singleton.IsDisposed() && singleton is ISingletonLateUpdate singletonLateUpdate)
			{
				lateUpdates.Enqueue(singleton);
				try
				{
					singletonLateUpdate.LateUpdate();
				}
				catch (Exception message)
				{
					Log.Error(message);
				}
			}
		}
	}

	public static void Close()
	{
		while (singletons.Count > 0)
		{
			singletons.Pop().Destroy();
		}
		singletonTypes.Clear();
	}

	public static void OnDrawGizmos()
	{
	}
}
