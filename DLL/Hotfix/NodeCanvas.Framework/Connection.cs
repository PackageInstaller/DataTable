using System;
using NodeCanvas.Framework.Internal;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using ParadoxNotion.Serialization.FullSerializer;
using UnityEngine;
using UnityEngine.Scripting;

namespace NodeCanvas.Framework;

[Serializable]
[SpoofAOT]
[fsDeserializeOverwrite]
[Preserve]
public abstract class Connection : IGraphElement, ISerializationCollectable
{
	[SerializeField]
	[fsSerializeAsReference]
	private Node _sourceNode;

	[SerializeField]
	[fsSerializeAsReference]
	private Node _targetNode;

	[SerializeField]
	private string _UID;

	[SerializeField]
	private bool _isDisabled;

	[NonSerialized]
	private Status _status = Status.Resting;

	[SerializeField]
	private string m_condition;

	[SerializeField]
	private bool isDefault;

	public string UID
	{
		get
		{
			if (!string.IsNullOrEmpty(_UID))
			{
				return _UID;
			}
			return _UID = Guid.NewGuid().ToString();
		}
	}

	public Node sourceNode
	{
		get
		{
			return _sourceNode;
		}
		protected set
		{
			_sourceNode = value;
		}
	}

	public Node targetNode
	{
		get
		{
			return _targetNode;
		}
		protected set
		{
			_targetNode = value;
		}
	}

	string IGraphElement.name => "Connection";

	public bool isActive
	{
		get
		{
			return !_isDisabled;
		}
		set
		{
			if (!_isDisabled && !value)
			{
				Reset();
			}
			_isDisabled = !value;
		}
	}

	public bool IsDefault
	{
		get
		{
			return isDefault;
		}
		set
		{
			isDefault = value;
		}
	}

	public string condition
	{
		get
		{
			return m_condition;
		}
		set
		{
			m_condition = value;
		}
	}

	public Status status
	{
		get
		{
			return _status;
		}
		set
		{
			_status = value;
		}
	}

	public Graph graph
	{
		get
		{
			if (sourceNode == null)
			{
				return null;
			}
			return sourceNode.graph;
		}
	}

	public static Connection Create(Node source, Node target, int sourceIndex = -1, int targetIndex = -1)
	{
		if (source == null || target == null)
		{
			return null;
		}
		if (source is MissingNode)
		{
			return null;
		}
		Connection obj = (Connection)Activator.CreateInstance(source.outConnectionType);
		int sourceIndex2 = obj.SetSourceNode(source, sourceIndex);
		int targetIndex2 = obj.SetTargetNode(target, targetIndex);
		obj.OnValidate(sourceIndex2, targetIndex2);
		obj.OnCreate(sourceIndex2, targetIndex2);
		return obj;
	}

	public Connection Duplicate(Node newSource, Node newTarget)
	{
		if (newSource == null || newTarget == null)
		{
			return null;
		}
		Connection connection = JSONSerializer.Clone(this);
		connection._UID = null;
		connection.sourceNode = newSource;
		connection.targetNode = newTarget;
		newSource.outConnections.Add(connection);
		newTarget.inConnections.Add(connection);
		if (newSource.graph != null)
		{
			foreach (Task item in Graph.GetTasksInElement(connection))
			{
				item.Validate(newSource.graph);
			}
		}
		connection.OnValidate(newSource.outConnections.Count - 1, newTarget.inConnections.Count - 1);
		return connection;
	}

	public int SetSourceNode(Node newSource, int index = -1)
	{
		if (sourceNode == newSource)
		{
			return -1;
		}
		if (sourceNode != null && sourceNode.outConnections.Contains(this))
		{
			int connectionIndex = sourceNode.outConnections.IndexOf(this);
			sourceNode.OnChildDisconnected(connectionIndex);
			sourceNode.outConnections.Remove(this);
		}
		index = ((index == -1) ? newSource.outConnections.Count : index);
		newSource.outConnections.Insert(index, this);
		newSource.OnChildConnected(index);
		sourceNode = newSource;
		OnValidate(index, (targetNode != null) ? targetNode.inConnections.IndexOf(this) : (-1));
		return index;
	}

	public int SetTargetNode(Node newTarget, int index = -1)
	{
		if (targetNode == newTarget)
		{
			return -1;
		}
		if (targetNode != null && targetNode.inConnections.Contains(this))
		{
			int connectionIndex = targetNode.inConnections.IndexOf(this);
			targetNode.OnParentDisconnected(connectionIndex);
			targetNode.inConnections.Remove(this);
		}
		index = ((index == -1) ? newTarget.inConnections.Count : index);
		newTarget.inConnections.Insert(index, this);
		newTarget.OnParentConnected(index);
		targetNode = newTarget;
		OnValidate((sourceNode != null) ? sourceNode.outConnections.IndexOf(this) : (-1), index);
		return index;
	}

	public Status Execute(Component agent, IBlackboard blackboard)
	{
		if (!isActive)
		{
			return Status.Optional;
		}
		status = targetNode.Execute(agent, blackboard);
		return status;
	}

	public void Reset(bool recursively = true)
	{
		if (status != Status.Resting)
		{
			status = Status.Resting;
			if (recursively)
			{
				targetNode.Reset();
			}
		}
	}

	public virtual void OnCreate(int sourceIndex, int targetIndex)
	{
	}

	public virtual void OnValidate(int sourceIndex, int targetIndex)
	{
	}

	public virtual void OnDestroy()
	{
	}

	public override string ToString()
	{
		return GetType().FriendlyName();
	}
}
