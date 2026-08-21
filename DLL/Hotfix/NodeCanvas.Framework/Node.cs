using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using ParadoxNotion.Serialization.FullSerializer;
using ParadoxNotion.Services;
using UnityEngine;
using UnityEngine.Scripting;

namespace NodeCanvas.Framework;

[Serializable]
[SpoofAOT]
[fsSerializeAsReference]
[fsDeserializeOverwrite]
[Preserve]
public abstract class Node : IGraphElement, ISerializationCollectable
{
	[AttributeUsage(AttributeTargets.Field)]
	protected class AutoSortWithChildrenConnections : Attribute
	{
	}

	[SerializeField]
	private string _UID;

	[SerializeField]
	private string _name;

	[SerializeField]
	private string _tag;

	[SerializeField]
	[fsIgnoreInBuild]
	private Vector2 _position;

	[SerializeField]
	[fsIgnoreInBuild]
	private string _comment;

	[SerializeField]
	[fsIgnoreInBuild]
	private bool _isBreakpoint;

	private Graph _graph;

	private int _ID;

	private List<Connection> _inConnections = new List<Connection>();

	private List<Connection> _outConnections = new List<Connection>();

	[NonSerialized]
	private Status _status = Status.Resting;

	[NonSerialized]
	private string _nameCache;

	[NonSerialized]
	private string _descriptionCache;

	[NonSerialized]
	private int _priorityCache = int.MinValue;

	public Graph graph
	{
		get
		{
			return _graph;
		}
		internal set
		{
			_graph = value;
		}
	}

	public int ID
	{
		get
		{
			return _ID;
		}
		internal set
		{
			_ID = value;
		}
	}

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

	public List<Connection> inConnections
	{
		get
		{
			return _inConnections;
		}
		protected set
		{
			_inConnections = value;
		}
	}

	public List<Connection> outConnections
	{
		get
		{
			return _outConnections;
		}
		protected set
		{
			_outConnections = value;
		}
	}

	public Vector2 position
	{
		get
		{
			return _position;
		}
		set
		{
			_position = value;
		}
	}

	private string customName
	{
		get
		{
			return _name;
		}
		set
		{
			_name = value;
		}
	}

	public string tag
	{
		get
		{
			return _tag;
		}
		set
		{
			_tag = value;
		}
	}

	public string comments
	{
		get
		{
			return _comment;
		}
		set
		{
			_comment = value;
		}
	}

	public bool isBreakpoint
	{
		get
		{
			return _isBreakpoint;
		}
		set
		{
			_isBreakpoint = value;
		}
	}

	public virtual string name
	{
		get
		{
			if (!string.IsNullOrEmpty(customName))
			{
				return customName;
			}
			if (string.IsNullOrEmpty(_nameCache))
			{
				NameAttribute nameAttribute = GetType().RTGetAttribute<NameAttribute>(inherited: true);
				_nameCache = ((nameAttribute != null) ? nameAttribute.name : GetType().FriendlyName().SplitCamelCase());
			}
			return _nameCache;
		}
		set
		{
			customName = value;
		}
	}

	public virtual string description
	{
		get
		{
			if (string.IsNullOrEmpty(_descriptionCache))
			{
				DescriptionAttribute descriptionAttribute = GetType().RTGetAttribute<DescriptionAttribute>(inherited: true);
				_descriptionCache = ((descriptionAttribute != null) ? descriptionAttribute.description : "No Description");
			}
			return _descriptionCache;
		}
	}

	public virtual int priority
	{
		get
		{
			if (_priorityCache == int.MinValue)
			{
				_priorityCache = GetType().RTGetAttribute<ExecutionPriorityAttribute>(inherited: true)?.priority ?? 0;
			}
			return _priorityCache;
		}
	}

	public abstract int maxInConnections { get; }

	public abstract int maxOutConnections { get; }

	public abstract Type outConnectionType { get; }

	public abstract bool allowAsPrime { get; }

	public abstract bool canSelfConnect { get; }

	public abstract Alignment2x2 commentsAlignment { get; }

	public abstract Alignment2x2 iconAlignment { get; }

	public Status status
	{
		get
		{
			return _status;
		}
		protected set
		{
			if (_status == Status.Resting && value == Status.Running)
			{
				timeStarted = graph.elapsedTime;
			}
			_status = value;
		}
	}

	public Component graphAgent
	{
		get
		{
			if (!(graph != null))
			{
				return null;
			}
			return graph.agent;
		}
	}

	public IBlackboard graphBlackboard
	{
		get
		{
			if (!(graph != null))
			{
				return null;
			}
			return graph.blackboard;
		}
	}

	public float elapsedTime
	{
		get
		{
			if (status != Status.Running)
			{
				return 0f;
			}
			return graph.elapsedTime - timeStarted;
		}
	}

	protected float timeStarted { get; set; }

	private bool isChecked { get; set; }

	private bool breakPointReached { get; set; }

	public static Node Create(Graph targetGraph, Type nodeType, Vector2 pos)
	{
		if (targetGraph == null)
		{
			return null;
		}
		if (nodeType.IsGenericTypeDefinition)
		{
			nodeType = nodeType.RTMakeGenericType(nodeType.GetFirstGenericParameterConstraintType());
		}
		Node obj = (Node)Activator.CreateInstance(nodeType);
		obj.graph = targetGraph;
		obj.position = pos;
		BBParameter.SetBBFields(obj, targetGraph.blackboard);
		obj.Validate(targetGraph);
		obj.OnCreate(targetGraph);
		return obj;
	}

	public Node Duplicate(Graph targetGraph)
	{
		if (targetGraph == null)
		{
			return null;
		}
		Node node = JSONSerializer.Clone(this);
		targetGraph.allNodes.Add(node);
		node.inConnections.Clear();
		node.outConnections.Clear();
		if (targetGraph == graph)
		{
			node.position += new Vector2(50f, 50f);
		}
		node._UID = null;
		node.graph = targetGraph;
		BBParameter.SetBBFields(node, targetGraph.blackboard);
		foreach (Task item in Graph.GetTasksInElement(node))
		{
			item.Validate(targetGraph);
		}
		node.Validate(targetGraph);
		return node;
	}

	public void Validate(Graph assignedGraph)
	{
		OnValidate(assignedGraph);
		GetHardError();
		if (this is IGraphAssignable)
		{
			(this as IGraphAssignable).ValidateSubGraphAndParameters();
		}
	}

	public Status Execute(Component agent, IBlackboard blackboard)
	{
		if (graph == null)
		{
			return Status.Success;
		}
		if (!graph.isRunning)
		{
			return status;
		}
		status = OnExecute(agent, blackboard);
		return status;
	}

	public void Reset(bool recursively = true)
	{
		if (status != Status.Resting && !isChecked)
		{
			OnReset();
			status = Status.Resting;
			isChecked = true;
			for (int i = 0; i < outConnections.Count; i++)
			{
				outConnections[i].Reset(recursively);
			}
			isChecked = false;
		}
	}

	private IEnumerator YieldBreak(Action resume)
	{
		Debug.Break();
		yield return null;
		resume();
	}

	public Status Error(object msg)
	{
		_ = msg is Exception;
		status = Status.Error;
		return Status.Error;
	}

	public Status Fail(string msg)
	{
		status = Status.Failure;
		return Status.Failure;
	}

	public void Warn(string msg)
	{
	}

	public void SetStatus(Status status)
	{
		_status = status;
	}

	protected void SendEvent(string eventName)
	{
		graph.SendEvent(eventName, null, this);
	}

	protected void SendEvent<T>(string eventName, T value)
	{
		graph.SendEvent(eventName, value, this);
	}

	public static bool IsNewConnectionAllowed(Node sourceNode, Node targetNode, Connection refConnection = null)
	{
		if (sourceNode == null || targetNode == null)
		{
			return false;
		}
		if (sourceNode == targetNode && !sourceNode.canSelfConnect)
		{
			return false;
		}
		if ((refConnection == null || refConnection.sourceNode != sourceNode) && sourceNode.outConnections.Count >= sourceNode.maxOutConnections && sourceNode.maxOutConnections != -1)
		{
			return false;
		}
		if ((refConnection == null || refConnection.targetNode != targetNode) && targetNode.maxInConnections <= targetNode.inConnections.Count && targetNode.maxInConnections != -1)
		{
			return false;
		}
		return (byte)(1u & (sourceNode.CanConnectToTarget(targetNode) ? 1u : 0u) & (targetNode.CanConnectFromSource(sourceNode) ? 1u : 0u)) != 0;
	}

	protected virtual bool CanConnectToTarget(Node targetNode)
	{
		return true;
	}

	protected virtual bool CanConnectFromSource(Node sourceNode)
	{
		return true;
	}

	public static bool AreNodesConnected(Node a, Node b)
	{
		bool num = a.outConnections.FirstOrDefault((Connection c) => c.targetNode == b) != null;
		bool flag = b.outConnections.FirstOrDefault((Connection c) => c.targetNode == a) != null;
		return num | flag;
	}

	public Coroutine StartCoroutine(IEnumerator routine)
	{
		if (!(MonoManager.current != null))
		{
			return null;
		}
		return MonoManager.current.StartCoroutine(routine);
	}

	public void StopCoroutine(Coroutine routine)
	{
		if (MonoManager.current != null)
		{
			MonoManager.current.StopCoroutine(routine);
		}
	}

	public void StartParallelTask(Action action)
	{
	}

	public void StopParallelTask(Action action)
	{
	}

	public IEnumerable<Node> GetParentNodes()
	{
		if (inConnections.Count != 0)
		{
			return inConnections.Select((Connection c) => c.sourceNode);
		}
		return new Node[0];
	}

	public IEnumerable<Node> GetChildNodes()
	{
		if (outConnections.Count != 0)
		{
			return outConnections.Select((Connection c) => c.targetNode);
		}
		return new Node[0];
	}

	public bool IsChildOf(Node parentNode)
	{
		return inConnections.Any((Connection c) => c.sourceNode == parentNode);
	}

	public bool IsParentOf(Node childNode)
	{
		return outConnections.Any((Connection c) => c.targetNode == childNode);
	}

	internal virtual string GetWarningOrError()
	{
		string hardError = GetHardError();
		if (hardError != null)
		{
			return "* " + hardError;
		}
		string result = null;
		if (this is ITaskAssignable { task: not null } taskAssignable)
		{
			result = taskAssignable.task.GetWarningOrError();
		}
		return result;
	}

	private string GetHardError()
	{
		if (this is IMissingRecoverable)
		{
			return $"Missing Node '{(this as IMissingRecoverable).missingType}'";
		}
		if (this is IReflectedWrapper)
		{
			ISerializedReflectedInfo serializedInfo = (this as IReflectedWrapper).GetSerializedInfo();
			if (serializedInfo != null && serializedInfo.AsMemberInfo() == null)
			{
				return $"Missing Reflected Info '{serializedInfo.AsString()}'";
			}
		}
		return null;
	}

	protected virtual Status OnExecute(Component agent, IBlackboard blackboard)
	{
		return status;
	}

	protected virtual void OnReset()
	{
	}

	public virtual void OnCreate(Graph assignedGraph)
	{
	}

	public virtual void OnValidate(Graph assignedGraph)
	{
	}

	public virtual void OnDestroy()
	{
	}

	public virtual void OnParentConnected(int connectionIndex)
	{
	}

	public virtual void OnParentDisconnected(int connectionIndex)
	{
	}

	public virtual void OnChildConnected(int connectionIndex)
	{
	}

	public virtual void OnChildDisconnected(int connectionIndex)
	{
	}

	public virtual void OnChildrenConnectionsSorted(int[] oldIndeces)
	{
	}

	public virtual void OnGraphStarted()
	{
	}

	public virtual void OnPostGraphStarted()
	{
	}

	public virtual void OnGraphStoped()
	{
	}

	public virtual void OnPostGraphStoped()
	{
	}

	public virtual void OnGraphPaused()
	{
	}

	public virtual void OnGraphUnpaused()
	{
	}

	public override string ToString()
	{
		string arg = name;
		if (this is IReflectedWrapper)
		{
			MemberInfo memberInfo = (this as IReflectedWrapper).GetSerializedInfo()?.AsMemberInfo();
			if (memberInfo != null)
			{
				arg = memberInfo.FriendlyName();
			}
		}
		if (this is IGraphAssignable)
		{
			Graph subGraph = (this as IGraphAssignable).subGraph;
			if (subGraph != null)
			{
				arg = subGraph.name;
			}
		}
		return string.Format("{0}{1}", arg, (!string.IsNullOrEmpty(tag)) ? (" (" + tag + ")") : "");
	}
}
