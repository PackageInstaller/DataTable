using System.Collections.Generic;
using UnityEngine;

public abstract class GraphModifier : IProcessor
{
	public enum EventType
	{
		PostScan = 1,
		PreScan = 2,
		LatePostScan = 4,
		PreUpdate = 8,
		PostUpdate = 0x10,
		PostCacheLoad = 0x20
	}

	private static GraphModifier root;

	private GraphModifier prev;

	private GraphModifier next;

	[SerializeField]
	[HideInInspector]
	protected ulong uniqueID;

	protected static Dictionary<ulong, GraphModifier> usedIDs = new Dictionary<ulong, GraphModifier>();

	protected static List<T> GetModifiersOfType<T>() where T : GraphModifier
	{
		GraphModifier graphModifier = root;
		List<T> list = new List<T>();
		while (graphModifier != null)
		{
			if (graphModifier is T item)
			{
				list.Add(item);
			}
			graphModifier = graphModifier.next;
		}
		return list;
	}

	public static void FindAllModifiers()
	{
	}

	protected virtual void OnEnable()
	{
		RemoveFromLinkedList();
		AddToLinkedList();
		ConfigureUniqueID();
	}

	protected virtual void OnDisable()
	{
		RemoveFromLinkedList();
	}

	public static void TriggerEvent(EventType type)
	{
		if (!Application.isPlaying)
		{
			FindAllModifiers();
		}
		GraphModifier graphModifier = root;
		switch (type)
		{
		case EventType.PreScan:
			while (graphModifier != null)
			{
				graphModifier.OnPreScan();
				graphModifier = graphModifier.next;
			}
			return;
		case EventType.PostScan:
			while (graphModifier != null)
			{
				graphModifier.OnPostScan();
				graphModifier = graphModifier.next;
			}
			return;
		case EventType.LatePostScan:
			while (graphModifier != null)
			{
				graphModifier.OnLatePostScan();
				graphModifier = graphModifier.next;
			}
			return;
		case EventType.PreUpdate:
			while (graphModifier != null)
			{
				graphModifier.OnGraphsPreUpdate();
				graphModifier = graphModifier.next;
			}
			return;
		case EventType.PostUpdate:
			while (graphModifier != null)
			{
				graphModifier.OnGraphsPostUpdate();
				graphModifier = graphModifier.next;
			}
			return;
		case EventType.PostCacheLoad:
			break;
		default:
			return;
		}
		while (graphModifier != null)
		{
			graphModifier.OnPostCacheLoad();
			graphModifier = graphModifier.next;
		}
	}

	public virtual void Initialize()
	{
		ConfigureUniqueID();
		RemoveFromLinkedList();
		AddToLinkedList();
		ConfigureUniqueID();
	}

	public virtual void Shutdown()
	{
		RemoveFromLinkedList();
		usedIDs.Remove(uniqueID);
	}

	private void ConfigureUniqueID()
	{
		if (usedIDs.TryGetValue(uniqueID, out var value) && value != this)
		{
			Reset();
		}
		usedIDs[uniqueID] = this;
	}

	private void AddToLinkedList()
	{
		if (root == null)
		{
			root = this;
			return;
		}
		next = root;
		root.prev = this;
		root = this;
	}

	private void RemoveFromLinkedList()
	{
		if (root == this)
		{
			root = next;
			if (root != null)
			{
				root.prev = null;
			}
		}
		else
		{
			if (prev != null)
			{
				prev.next = next;
			}
			if (next != null)
			{
				next.prev = prev;
			}
		}
		prev = null;
		next = null;
	}

	public virtual void OnPostScan()
	{
	}

	public virtual void OnPreScan()
	{
	}

	public virtual void OnLatePostScan()
	{
	}

	public virtual void OnPostCacheLoad()
	{
	}

	public virtual void OnGraphsPreUpdate()
	{
	}

	public virtual void OnGraphsPostUpdate()
	{
	}

	private void Reset()
	{
		ulong num = (ulong)Random.Range(0, int.MaxValue);
		ulong num2 = (ulong)((long)Random.Range(0, int.MaxValue) << 32);
		uniqueID = num | num2;
		usedIDs[uniqueID] = this;
	}
}
