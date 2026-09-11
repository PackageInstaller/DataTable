using System;
using MessagePack;
using NodeCanvas.Framework.Internal;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace NodeCanvas.Framework;

[SpoofAOT]
public abstract class Connection : IGraphElement
{
	[SerializeField]
	private Node _sourceNode;

	[SerializeField]
	private Node _targetNode;

	[SerializeField]
	private bool _isDisabled;

	[NonSerialized]
	private Status _status = Status.Resting;

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

	public virtual void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		int index = reader.ReadInt32();
		int index2 = reader.ReadInt32();
		reader.ReadBoolean();
		_sourceNode = fsSerializationContext.graphData.nodes[index];
		_targetNode = fsSerializationContext.graphData.nodes[index2];
	}

	public virtual void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		int value = fsSerializationContext.graphData.nodes.IndexOf(_sourceNode);
		int value2 = fsSerializationContext.graphData.nodes.IndexOf(_targetNode);
		writer.Write(value);
		writer.Write(value2);
		writer.Write(_isDisabled);
	}

	public Connection()
	{
	}

	public static Connection Create(Node source, Node target, int sourceIndex = -1, int targetIndex = -1)
	{
		if (source == null || target == null)
		{
			Debug.LogError("Can't Create a Connection without providing Source and Target Nodes");
			return null;
		}
		if (source is MissingNode)
		{
			Debug.LogError("Creating new Connections from a 'MissingNode' is not allowed. Please resolve the MissingNode node first");
			return null;
		}
		Connection obj = (Connection)Activator.CreateInstance(source.outConnectionType);
		if (source.graph != null)
		{
			source.graph.RecordUndo("Create Connection");
		}
		int sourceIndex2 = obj.SetSource(source, sourceIndex);
		int targetIndex2 = obj.SetTarget(target, targetIndex);
		obj.OnValidate(sourceIndex2, targetIndex2);
		obj.OnCreate(sourceIndex2, targetIndex2);
		return obj;
	}

	public Connection Duplicate(Node newSource, Node newTarget)
	{
		if (newSource == null || newTarget == null)
		{
			Debug.LogError("Can't Duplicate a Connection without providing NewSource and NewTarget Nodes");
			return null;
		}
		Connection connection = JSONSerializer.Clone(this);
		if (newSource.graph != null)
		{
			newSource.graph.RecordUndo("Duplicate Connection");
		}
		int sourceIndex = connection.SetSource(newSource);
		int targetIndex = connection.SetTarget(newTarget);
		if (this is ITaskAssignable { task: not null } taskAssignable)
		{
			(connection as ITaskAssignable).task = taskAssignable.task.Duplicate(newSource.graph);
		}
		connection.OnValidate(sourceIndex, targetIndex);
		return connection;
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

	public int SetSource(Node newSource, int index = -1)
	{
		if (sourceNode == newSource)
		{
			return -1;
		}
		if (graph != null)
		{
			graph.RecordUndo("Set Source");
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
		return index;
	}

	public int SetTarget(Node newTarget, int index = -1)
	{
		if (targetNode == newTarget)
		{
			return -1;
		}
		if (graph != null)
		{
			graph.RecordUndo("Set Target");
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
		return index;
	}

	public sealed override string ToString()
	{
		return GetType().FriendlyName();
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
				targetNode.Reset(recursively);
			}
		}
	}
}
