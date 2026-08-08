using System;
using System.Collections.Generic;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

public abstract class NavmeshClipper : IProcessor
{
	private static Action<NavmeshClipper> OnEnableCallback;

	private static Action<NavmeshClipper> OnDisableCallback;

	private static readonly LinkedList<NavmeshClipper> all = new LinkedList<NavmeshClipper>();

	private readonly LinkedListNode<NavmeshClipper> node;

	public static bool AnyEnableListeners => OnEnableCallback != null;

	public NavmeshClipper()
	{
		node = new LinkedListNode<NavmeshClipper>(this);
	}

	public static void AddEnableCallback(Action<NavmeshClipper> onEnable, Action<NavmeshClipper> onDisable)
	{
		OnEnableCallback = (Action<NavmeshClipper>)Delegate.Combine(OnEnableCallback, onEnable);
		OnDisableCallback = (Action<NavmeshClipper>)Delegate.Combine(OnDisableCallback, onDisable);
		for (LinkedListNode<NavmeshClipper> linkedListNode = all.First; linkedListNode != null; linkedListNode = linkedListNode.Next)
		{
			onEnable(linkedListNode.Value);
		}
	}

	public static void RemoveEnableCallback(Action<NavmeshClipper> onEnable, Action<NavmeshClipper> onDisable)
	{
		OnEnableCallback = (Action<NavmeshClipper>)Delegate.Remove(OnEnableCallback, onEnable);
		OnDisableCallback = (Action<NavmeshClipper>)Delegate.Remove(OnDisableCallback, onDisable);
		for (LinkedListNode<NavmeshClipper> linkedListNode = all.First; linkedListNode != null; linkedListNode = linkedListNode.Next)
		{
			onDisable(linkedListNode.Value);
		}
	}

	public virtual void OnEnable()
	{
		all.AddFirst(node);
		if (OnEnableCallback != null)
		{
			OnEnableCallback(this);
		}
	}

	public virtual void OnDisable()
	{
		if (OnDisableCallback != null)
		{
			OnDisableCallback(this);
		}
		Debug.Log((object)("OnDisableCallback:" + OnDisableCallback));
		all.Remove(node);
	}

	internal abstract void NotifyUpdated();

	internal abstract Rect GetBounds(GraphTransform transform);

	public abstract bool RequiresUpdate();

	public abstract void ForceUpdate();

	public virtual void Initialize()
	{
	}

	public virtual void Shutdown()
	{
	}
}
