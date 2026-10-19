using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Unity.VisualScripting;

public sealed class GraphReference : GraphPointer
{
	[DoNotSerialize]
	private int hashCode;

	private static readonly Dictionary<int, List<GraphReference>> internPool;

	static GraphReference()
	{
		internPool = new Dictionary<int, List<GraphReference>>();
		ReferenceCollector.onSceneUnloaded += FreeInvalidInterns;
	}

	private GraphReference()
	{
	}

	public static GraphReference New(IGraphRoot root, bool ensureValid)
	{
		if (!ensureValid && !GraphPointer.IsValidRoot(root))
		{
			return null;
		}
		GraphReference graphReference = new GraphReference();
		graphReference.Initialize(root);
		graphReference.Hash();
		return graphReference;
	}

	public static GraphReference New(IGraphRoot root, IEnumerable<IGraphParentElement> parentElements, bool ensureValid)
	{
		if (!ensureValid && !GraphPointer.IsValidRoot(root))
		{
			return null;
		}
		GraphReference graphReference = new GraphReference();
		graphReference.Initialize(root, parentElements, ensureValid);
		graphReference.Hash();
		return graphReference;
	}

	public static GraphReference New(UnityEngine.Object rootObject, IEnumerable<Guid> parentElementGuids, bool ensureValid)
	{
		if (!ensureValid && !GraphPointer.IsValidRoot(rootObject))
		{
			return null;
		}
		GraphReference graphReference = new GraphReference();
		graphReference.Initialize(rootObject, parentElementGuids, ensureValid);
		graphReference.Hash();
		return graphReference;
	}

	private static GraphReference New(GraphPointer model)
	{
		GraphReference graphReference = new GraphReference();
		graphReference.CopyFrom(model);
		return graphReference;
	}

	public override void CopyFrom(GraphPointer other)
	{
		base.CopyFrom(other);
		if (other is GraphReference graphReference)
		{
			hashCode = graphReference.hashCode;
		}
		else
		{
			Hash();
		}
	}

	public GraphReference Clone()
	{
		return New(this);
	}

	public override GraphReference AsReference()
	{
		return this;
	}

	public GraphStack ToStackPooled()
	{
		return GraphStack.New(this);
	}

	internal void Release()
	{
		GraphPointer.releaseDebugDataBinding?.Invoke(root);
	}

	public void CreateGraphData()
	{
		if (_data != null)
		{
			throw new GraphPointerException("Graph data already exists.", this);
		}
		if (isRoot)
		{
			if (machine == null)
			{
				throw new GraphPointerException("Root graph data can only be created on machines.", this);
			}
			IGraphData graphData = (machine.graphData = graph.CreateData());
			_data = graphData;
		}
		else
		{
			if (_parentData == null)
			{
				throw new GraphPointerException("Child graph data can only be created from parent graph data.", this);
			}
			_data = _parentData.CreateChildGraphData(parentElement);
		}
	}

	public void FreeGraphData()
	{
		if (_data == null)
		{
			throw new GraphPointerException("Graph data does not exist.", this);
		}
		if (isRoot)
		{
			if (machine == null)
			{
				throw new GraphPointerException("Root graph data can only be freed on machines.", this);
			}
			IGraphData graphData = (machine.graphData = null);
			_data = graphData;
		}
		else
		{
			if (_parentData == null)
			{
				throw new GraphPointerException("Child graph data can only be freed from parent graph data.", this);
			}
			_parentData.FreeChildGraphData(parentElement);
			_data = null;
		}
	}

	public override bool Equals(object obj)
	{
		if (!(obj is GraphReference other))
		{
			return false;
		}
		return InstanceEquals(other);
	}

	private void Hash()
	{
		hashCode = ComputeHashCode();
	}

	public override int GetHashCode()
	{
		return hashCode;
	}

	public static bool operator ==(GraphReference x, GraphReference y)
	{
		if ((object)x == y)
		{
			return true;
		}
		if ((object)x == null || (object)y == null)
		{
			return false;
		}
		return x.Equals(y);
	}

	public static bool operator !=(GraphReference x, GraphReference y)
	{
		return !(x == y);
	}

	public GraphReference ParentReference(bool ensureValid)
	{
		if (isRoot)
		{
			if (ensureValid)
			{
				throw new GraphPointerException("Trying to get parent graph reference of a root.", this);
			}
			return null;
		}
		GraphReference graphReference = Clone();
		graphReference.ExitParentElement();
		graphReference.Hash();
		return graphReference;
	}

	public GraphReference ChildReference(IGraphParentElement parentElement, bool ensureValid, int? maxRecursionDepth = null)
	{
		GraphReference graphReference = Clone();
		if (!graphReference.TryEnterParentElement(parentElement, out var error, maxRecursionDepth))
		{
			if (ensureValid)
			{
				throw new GraphPointerException(error, this);
			}
			return null;
		}
		graphReference.Hash();
		return graphReference;
	}

	public GraphReference Revalidate(bool ensureValid)
	{
		try
		{
			return New(rootObject, parentElementGuids, ensureValid);
		}
		catch (Exception ex)
		{
			if (ensureValid)
			{
				throw;
			}
			Debug.LogWarning("Failed to revalidate graph pointer: \n" + ex);
			return null;
		}
	}

	public IEnumerable<GraphReference> GetBreadcrumbs()
	{
		for (int depth = 0; depth < base.depth; depth++)
		{
			yield return New(root, parentElementStack.Take(depth), ensureValid: true);
		}
	}

	public static GraphReference Intern(GraphPointer pointer)
	{
		int key = pointer.ComputeHashCode();
		if (internPool.TryGetValue(key, out var value))
		{
			foreach (GraphReference item in value)
			{
				if (item.InstanceEquals(pointer))
				{
					return item;
				}
			}
			GraphReference graphReference = New(pointer);
			value.Add(graphReference);
			return graphReference;
		}
		GraphReference graphReference2 = New(pointer);
		internPool.Add(graphReference2.hashCode, new List<GraphReference> { graphReference2 });
		return graphReference2;
	}

	internal static void ClearIntern(GraphPointer pointer)
	{
		int key = pointer.ComputeHashCode();
		if (!internPool.TryGetValue(key, out var value))
		{
			return;
		}
		for (int num = value.Count - 1; num >= 0; num--)
		{
			if (value[num].InstanceEquals(pointer))
			{
				value.RemoveAt(num);
				break;
			}
		}
		if (value.Count == 0)
		{
			internPool.Remove(key);
		}
	}

	public static void FreeInvalidInterns()
	{
		List<int> list = ListPool<int>.New();
		foreach (KeyValuePair<int, List<GraphReference>> item in internPool)
		{
			int key = item.Key;
			List<GraphReference> value = item.Value;
			List<GraphReference> list2 = ListPool<GraphReference>.New();
			foreach (GraphReference item2 in value)
			{
				if (!item2.isValid)
				{
					list2.Add(item2);
				}
			}
			foreach (GraphReference item3 in list2)
			{
				value.Remove(item3);
			}
			if (value.Count == 0)
			{
				list.Add(key);
			}
			list2.Free();
		}
		foreach (int item4 in list)
		{
			internPool.Remove(item4);
		}
		list.Free();
	}
}
