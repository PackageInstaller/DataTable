using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using FlowCanvas.Nodes;
using MessagePack;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using ParadoxNotion.Services;
using UnityEngine;

namespace NodeCanvas.Framework;

[Serializable]
[SpoofAOT]
public abstract class Node : IGraphElement
{
	[SerializeField]
	private string _UID;

	[SerializeField]
	private string _name;

	private Graph _graph;

	private List<Connection> _inConnections = new List<Connection>();

	private List<Connection> _outConnections = new List<Connection>();

	private int _ID;

	[NonSerialized]
	private Status _status = Status.Resting;

	[NonSerialized]
	private string _nameCache;

	[NonSerialized]
	private int _priorityCache = int.MinValue;

	[NonSerialized]
	private string _descriptionCache;

	public Graph graph
	{
		get
		{
			return _graph;
		}
		set
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
		set
		{
			_ID = value;
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
		set
		{
			_UID = value;
		}
	}

	public string UIDReadOnly => _UID;

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

	private bool isChecked { get; set; }

	public string graphName => graph.name;

	public SimContext mSimContext => graph.mSimContext;

	public ISimulatorInferface mLogicEvent => graph.mLogicEvent;

	public Dictionary<int, MapTrigger> mMapTriggers => graph.mMapTriggers;

	public Node()
	{
	}

	public virtual void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
	}

	public virtual void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
	}

	public static Node Create(Graph targetGraph, Type nodeType, Vector2 pos)
	{
		if (targetGraph == null)
		{
			ParadoxNotion.Services.Logger.LogError("Can't Create a Node without providing a Target Graph", "NodeCanvas");
			return null;
		}
		Node obj = (Node)Activator.CreateInstance(nodeType);
		if (targetGraph != null)
		{
			targetGraph.RecordUndo("Create Node");
		}
		obj.graph = targetGraph;
		BBParameter.SetBBFields(obj, targetGraph.blackboard);
		obj.OnValidate(targetGraph);
		obj.OnCreate(targetGraph);
		return obj;
	}

	public Node Duplicate(Graph targetGraph)
	{
		if (targetGraph == null)
		{
			ParadoxNotion.Services.Logger.LogError("Can't duplicate a Node without providing a Target Graph", "NodeCanvas");
			return null;
		}
		Node node = JSONSerializer.Clone(this);
		if (targetGraph != null)
		{
			targetGraph.RecordUndo("Duplicate Node");
		}
		targetGraph.allNodes.Add(node);
		node.inConnections.Clear();
		node.outConnections.Clear();
		node._UID = null;
		node.graph = targetGraph;
		BBParameter.SetBBFields(node, targetGraph.blackboard);
		if (this is ITaskAssignable { task: not null } taskAssignable)
		{
			(node as ITaskAssignable).task = taskAssignable.task.Duplicate(targetGraph);
		}
		node.OnValidate(targetGraph);
		return node;
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

	public Status Execute(Component agent, IBlackboard blackboard)
	{
		if (isChecked)
		{
			return Error("Please check for previous errors that may have caused this in the log before this.");
		}
		isChecked = true;
		status = OnExecute(agent, blackboard);
		isChecked = false;
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

	protected Status Error(string msg)
	{
		ParadoxNotion.Services.Logger.LogError($"{msg} | On Node '{name}' | ID '{ID}' | Graph '{graph.name}'", "Execution", this);
		status = Status.Error;
		return Status.Error;
	}

	protected Status Error(Exception e)
	{
		ParadoxNotion.Services.Logger.LogException(e, "Execution", this);
		status = Status.Error;
		return Status.Error;
	}

	public Status Fail(string msg)
	{
		ParadoxNotion.Services.Logger.LogError($"{msg} | On Node '{name}' | ID '{ID}' | Graph '{graph.name}'", "Execution", this);
		status = Status.Failure;
		return Status.Failure;
	}

	public Status Fail(Exception e)
	{
		ParadoxNotion.Services.Logger.LogException(e, "Execution", this);
		status = Status.Failure;
		return Status.Failure;
	}

	public void SetStatus(Status status)
	{
		this.status = status;
	}

	protected void SendEvent(EventData eventData)
	{
		graph.SendEvent(eventData, this);
	}

	public void RegisterEvents(params string[] eventNames)
	{
		RegisterEvents(graphAgent, eventNames);
	}

	public void RegisterEvents(Component targetAgent, params string[] eventNames)
	{
		if (targetAgent == null)
		{
			ParadoxNotion.Services.Logger.LogError("Null Agent provided for event registration", "Events", this);
			return;
		}
		MessageRouter messageRouter = targetAgent.GetComponent<MessageRouter>();
		if (messageRouter == null)
		{
			messageRouter = targetAgent.gameObject.AddComponent<MessageRouter>();
		}
		messageRouter.Register(this, eventNames);
	}

	public void UnRegisterEvents(params string[] eventNames)
	{
		UnRegisterEvents(graphAgent, eventNames);
	}

	public void UnRegisterEvents(Component targetAgent, params string[] eventNames)
	{
		if (!(targetAgent == null))
		{
			MessageRouter component = targetAgent.GetComponent<MessageRouter>();
			if (component != null)
			{
				component.UnRegister(this, eventNames);
			}
		}
	}

	public void UnregisterAllEvents()
	{
		UnregisterAllEvents(graphAgent);
	}

	public void UnregisterAllEvents(Component targetAgent)
	{
		if (!(targetAgent == null))
		{
			MessageRouter component = targetAgent.GetComponent<MessageRouter>();
			if (component != null)
			{
				component.UnRegister(this);
			}
		}
	}

	public static bool IsNewConnectionAllowed(Node sourceNode, Node targetNode, Connection refConnection = null)
	{
		if (sourceNode == null || targetNode == null)
		{
			ParadoxNotion.Services.Logger.LogWarning("A Node Provided is null.", "Editor", targetNode);
			return false;
		}
		if (sourceNode == targetNode)
		{
			ParadoxNotion.Services.Logger.LogWarning("Node can't connect to itself.", "Editor", targetNode);
			return false;
		}
		if ((refConnection == null || refConnection.sourceNode != sourceNode) && sourceNode.outConnections.Count >= sourceNode.maxOutConnections && sourceNode.maxOutConnections != -1)
		{
			ParadoxNotion.Services.Logger.LogWarning("Source node can have no more out connections.", "Editor", sourceNode);
			return false;
		}
		if (refConnection == null || refConnection.targetNode != targetNode)
		{
			if (targetNode.maxInConnections <= targetNode.inConnections.Count && targetNode.maxInConnections != -1)
			{
				ParadoxNotion.Services.Logger.LogWarning("Target node can have no more in connections.", "Editor", targetNode);
				return false;
			}
			if (targetNode == targetNode.graph.primeNode && targetNode.maxInConnections == 1)
			{
				ParadoxNotion.Services.Logger.LogWarning("Target node can have no more in connections.", "Editor", targetNode);
				return false;
			}
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
		bool num = a != null && a.outConnections.FirstOrDefault((Connection c) => c.targetNode == b) != null;
		bool flag = b != null && b.outConnections.FirstOrDefault((Connection c) => c.targetNode == a) != null;
		return num | flag;
	}

	protected Coroutine StartCoroutine(IEnumerator routine)
	{
		return MonoManager.current.StartCoroutine(routine);
	}

	protected void StopCoroutine(Coroutine routine)
	{
		MonoManager.current.StopCoroutine(routine);
	}

	public Node[] GetParentNodes()
	{
		if (inConnections.Count != 0)
		{
			return inConnections.Select((Connection c) => c.sourceNode).ToArray();
		}
		return new Node[0];
	}

	public Node[] GetChildNodes()
	{
		if (outConnections.Count != 0)
		{
			return outConnections.Select((Connection c) => c.targetNode).ToArray();
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

	protected virtual Status OnExecute(Component agent, IBlackboard blackboard)
	{
		return status;
	}

	protected virtual void OnReset()
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

	public virtual void OnGraphStarted()
	{
	}

	public virtual void OnGraphStoped()
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
		string result = name;
		if (this is IReflectedWrapper)
		{
			MemberInfo memberInfo = (this as IReflectedWrapper).GetMemberInfo();
			if (memberInfo != null)
			{
				result = memberInfo.FriendlyName();
			}
		}
		return result;
	}

	public void OnDrawGizmos()
	{
		if (this is ITaskAssignable && (this as ITaskAssignable).task != null)
		{
			(this as ITaskAssignable).task.OnDrawGizmos();
		}
	}

	public void OnDrawGizmosSelected()
	{
		if (this is ITaskAssignable && (this as ITaskAssignable).task != null)
		{
			(this as ITaskAssignable).task.OnDrawGizmosSelected();
		}
	}
}
