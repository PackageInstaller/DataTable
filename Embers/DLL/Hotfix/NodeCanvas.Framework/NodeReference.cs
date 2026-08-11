using System;
using System.Linq;
using ParadoxNotion.Serialization.FullSerializer;
using UnityEngine;

namespace NodeCanvas.Framework;

[Serializable]
[fsForward("_targetNodeUID")]
[fsAutoInstance(true)]
public class NodeReference<T> : INodeReference where T : Node
{
	[SerializeField]
	private string _targetNodeUID;

	[NonSerialized]
	private WeakReference<T> _targetNodeRef;

	Type INodeReference.type => typeof(T);

	Node INodeReference.Get(Graph graph)
	{
		return Get(graph);
	}

	void INodeReference.Set(Node target)
	{
		Set(target as T);
	}

	public NodeReference()
	{
	}

	public NodeReference(T target)
	{
		Set(target);
	}

	public T Get(Graph graph)
	{
		T target;
		if (_targetNodeRef == null)
		{
			target = graph.GetAllNodesOfType<T>().FirstOrDefault((T x) => x.UID == _targetNodeUID);
			_targetNodeRef = new WeakReference<T>(target);
		}
		_targetNodeRef.TryGetTarget(out target);
		return target;
	}

	public void Set(T target)
	{
		if (_targetNodeRef == null)
		{
			_targetNodeRef = new WeakReference<T>(target);
		}
		_targetNodeRef.SetTarget(target);
		_targetNodeUID = target?.UID;
	}
}
