using System;
using System.Buffers;
using System.Collections.Generic;
using System.Linq;
using FlowCanvas.Nodes;
using MessagePack;
using MessagePack.Resolvers;
using Nerdbank.Streams;
using NodeCanvas.Framework.Internal;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using ParadoxNotion.Services;
using UnityEngine;

namespace NodeCanvas.Framework;

[Serializable]
public abstract class Graph : ScriptableObject, ITaskSystem, ISerializationCallbackReceiver
{
	[NonSerialized]
	public SimContext mSimContext;

	[NonSerialized]
	public ISimulatorInferface mLogicEvent;

	[NonSerialized]
	public Dictionary<int, MapTrigger> mMapTriggers;

	[NonSerialized]
	private static MessagePackSerializerOptions _sGraphDefaultOpition;

	[NonSerialized]
	private static fsGraphFormatter customFormatter;

	[SerializeField]
	private string _serializedGraph;

	[SerializeField]
	private List<UnityEngine.Object> _objectReferences;

	[SerializeField]
	private bool _deserializationFailed;

	[SerializeField]
	public byte[] _serializedBinGraph;

	[NonSerialized]
	private bool hasDeserialized;

	private string _category = string.Empty;

	private string _comments = string.Empty;

	private Vector2 _translation = new Vector2(-5000f, -5000f);

	private float _zoomFactor = 1f;

	private List<Node> _nodes = new List<Node>();

	private Node _primeNode;

	private List<CanvasGroup> _canvasGroups;

	private BlackboardSource _localBlackboard;

	[NonSerialized]
	private Component _agent;

	[NonSerialized]
	private IBlackboard _blackboard;

	[NonSerialized]
	private static List<Graph> runningGraphs = new List<Graph>();

	[NonSerialized]
	private float timeStarted;

	[NonSerialized]
	private bool initialReferencesUpdated;

	[NonSerialized]
	private bool _isAutoUpdated;

	[NonSerialized]
	private bool _isRunning;

	[NonSerialized]
	private bool _isPaused;

	[NonSerialized]
	public static bool mToggleBinary = false;

	public static MessagePackSerializerOptions sGraphDefaultOpition
	{
		get
		{
			if (_sGraphDefaultOpition == null)
			{
				IFormatterResolver resolver = CompositeResolver.Create(GeneratedResolver.Instance, BuiltinResolver.Instance, StandardResolver.Instance, PrimitiveObjectResolver.Instance, fsResolver.Instance);
				_sGraphDefaultOpition = MessagePackSerializerOptions.Standard.WithResolver(resolver);
			}
			return _sGraphDefaultOpition;
		}
	}

	public string TempTest => _serializedGraph;

	public abstract Type baseNodeType { get; }

	public abstract bool requiresAgent { get; }

	public abstract bool requiresPrimeNode { get; }

	public abstract bool autoSort { get; }

	public abstract bool useLocalBlackboard { get; }

	public abstract bool canAcceptVariableDrops { get; }

	public new string name
	{
		get
		{
			return base.name;
		}
		set
		{
			base.name = value;
		}
	}

	public string category
	{
		get
		{
			return _category;
		}
		set
		{
			_category = value;
		}
	}

	public string comments
	{
		get
		{
			return _comments;
		}
		set
		{
			_comments = value;
		}
	}

	public float elapsedTime
	{
		get
		{
			if (!isRunning && !isPaused)
			{
				return 0f;
			}
			return Time.time - timeStarted;
		}
	}

	public bool isRunning
	{
		get
		{
			return _isRunning;
		}
		private set
		{
			_isRunning = value;
		}
	}

	public bool isPaused
	{
		get
		{
			return _isPaused;
		}
		private set
		{
			_isPaused = value;
		}
	}

	public bool isAutoUpdated
	{
		get
		{
			return _isAutoUpdated;
		}
		private set
		{
			_isAutoUpdated = value;
		}
	}

	public List<Node> allNodes
	{
		get
		{
			return _nodes;
		}
		private set
		{
			_nodes = value;
		}
	}

	public Node primeNode
	{
		get
		{
			return _primeNode;
		}
		set
		{
			if (_primeNode == value || (value != null && !value.allowAsPrime))
			{
				return;
			}
			if (isRunning)
			{
				if (_primeNode != null)
				{
					_primeNode.Reset();
				}
				value?.Reset();
			}
			RecordUndo("Set Start");
			_primeNode = value;
			UpdateNodeIDs(alsoReorderList: true);
		}
	}

	public List<CanvasGroup> canvasGroups
	{
		get
		{
			return _canvasGroups;
		}
		set
		{
			_canvasGroups = value;
		}
	}

	public Vector2 translation
	{
		get
		{
			return _translation;
		}
		set
		{
			_translation = value;
		}
	}

	public float zoomFactor
	{
		get
		{
			return _zoomFactor;
		}
		set
		{
			_zoomFactor = value;
		}
	}

	public Component agent
	{
		get
		{
			return _agent;
		}
		private set
		{
			_agent = value;
		}
	}

	public IBlackboard blackboard
	{
		get
		{
			if (useLocalBlackboard)
			{
				return localBlackboard;
			}
			return _blackboard;
		}
		private set
		{
			if (_blackboard != value && !isRunning && !useLocalBlackboard)
			{
				_blackboard = value;
			}
		}
	}

	public BlackboardSource localBlackboard
	{
		get
		{
			if (_localBlackboard == null)
			{
				_localBlackboard = new BlackboardSource();
				_localBlackboard.name = "Local Blackboard";
			}
			return _localBlackboard;
		}
	}

	UnityEngine.Object ITaskSystem.contextObject => this;

	public event Action<bool> onFinish;

	public List<UnityEngine.Object> GetObjectRefs()
	{
		return _objectReferences;
	}

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		Serialize();
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		Deserialize();
	}

	protected void OnEnable()
	{
		if (hasDeserialized)
		{
			Validate();
		}
	}

	protected void OnDisable()
	{
	}

	protected void OnDestroy()
	{
		Destroy();
	}

	protected void OnValidate()
	{
	}

	public void Serialize()
	{
	}

	public void Deserialize(bool validate = false)
	{
		if (!hasDeserialized || !JSONSerializer.applicationPlaying)
		{
			hasDeserialized = true;
			if (!mToggleBinary || _serializedBinGraph == null)
			{
				Deserialize(_serializedGraph, validate, _objectReferences);
			}
			else
			{
				Deserialize(_serializedBinGraph, validate, _objectReferences);
			}
		}
	}

	public GraphSerializationData Deserialize(byte[] serializedGraph, bool validate, List<UnityEngine.Object> objectReferences)
	{
		if (serializedGraph == null)
		{
			Debug.LogError("二进制数据为空");
			return null;
		}
		if (objectReferences == null)
		{
			objectReferences = _objectReferences;
		}
		try
		{
			MessagePackReader reader = new MessagePackReader(serializedGraph);
			if (customFormatter == null)
			{
				customFormatter = (fsGraphFormatter)sGraphDefaultOpition.Resolver.GetFormatterWithVerify<GraphSerializationData>();
			}
			fsSerializationContext.mUnityReferences = objectReferences;
			GraphSerializationData graphSerializationData = customFormatter.Deserialize(ref reader, sGraphDefaultOpition);
			if (LoadGraphData(graphSerializationData, validate))
			{
				_deserializationFailed = false;
				_serializedBinGraph = serializedGraph;
				_objectReferences = objectReferences;
				return graphSerializationData;
			}
			return null;
		}
		catch (Exception exception)
		{
			ParadoxNotion.Services.Logger.LogException(exception, "NodeCanvas", this);
			_deserializationFailed = true;
			return null;
		}
	}

	public byte[] Serialize(List<UnityEngine.Object> objectReferences)
	{
		if (_deserializationFailed)
		{
			_deserializationFailed = false;
			return _serializedBinGraph;
		}
		if (objectReferences == null)
		{
			objectReferences = (_objectReferences = new List<UnityEngine.Object>());
		}
		UpdateNodeIDs(alsoReorderList: true);
		using Sequence<byte> sequence = new Sequence<byte>();
		MessagePackWriter writer = new MessagePackWriter(sequence);
		if (customFormatter == null)
		{
			customFormatter = (fsGraphFormatter)sGraphDefaultOpition.Resolver.GetFormatterWithVerify<GraphSerializationData>();
		}
		fsSerializationContext.mUnityReferences = objectReferences;
		customFormatter.Serialize(ref writer, new GraphSerializationData(this), sGraphDefaultOpition);
		writer.Flush();
		return sequence.AsReadOnlySequence.ToArray<byte>();
	}

	public string Serialize(bool pretyJson, List<UnityEngine.Object> objectReferences)
	{
		if (_deserializationFailed)
		{
			_deserializationFailed = false;
			return _serializedGraph;
		}
		if (objectReferences == null)
		{
			objectReferences = (_objectReferences = new List<UnityEngine.Object>());
		}
		UpdateNodeIDs(alsoReorderList: true);
		return JSONSerializer.Serialize(typeof(GraphSerializationData), new GraphSerializationData(this), pretyJson, objectReferences);
	}

	public GraphSerializationData Deserialize(string serializedGraph, bool validate, List<UnityEngine.Object> objectReferences)
	{
		if (string.IsNullOrEmpty(serializedGraph))
		{
			return null;
		}
		if (objectReferences == null)
		{
			objectReferences = _objectReferences;
		}
		try
		{
			GraphSerializationData graphSerializationData = JSONSerializer.Deserialize<GraphSerializationData>(serializedGraph, objectReferences);
			if (LoadGraphData(graphSerializationData, validate))
			{
				_deserializationFailed = false;
				_serializedGraph = serializedGraph;
				_objectReferences = objectReferences;
				return graphSerializationData;
			}
			_deserializationFailed = true;
			return null;
		}
		catch (Exception exception)
		{
			ParadoxNotion.Services.Logger.LogException(exception, "NodeCanvas", this);
			_deserializationFailed = true;
			return null;
		}
	}

	public bool LoadGraphData(GraphSerializationData data, bool validate)
	{
		if (data == null)
		{
			ParadoxNotion.Services.Logger.LogError("Can't Load graph, cause of null GraphSerializationData provided", "Serialization", this);
			return false;
		}
		if (data.type != GetType())
		{
			ParadoxNotion.Services.Logger.LogError("Can't Load graph, cause of different Graph type serialized and required", "Serialization", this);
			return false;
		}
		data.Reconstruct(this);
		_category = data.category;
		_comments = data.comments;
		_translation = data.translation;
		_zoomFactor = data.zoomFactor;
		_nodes = data.nodes;
		_canvasGroups = data.canvasGroups;
		_localBlackboard = data.localBlackboard;
		Node node = data.nodes.FirstOrDefault();
		if (node != null && node.allowAsPrime)
		{
			_primeNode = node;
		}
		if (validate)
		{
			Validate();
		}
		return true;
	}

	public virtual object OnDerivedDataSerialization()
	{
		return null;
	}

	public virtual void OnDerivedDataDeserialization(object data)
	{
	}

	public void GetSerializationData(out string json, out List<UnityEngine.Object> references)
	{
		json = _serializedGraph;
		references = ((_objectReferences != null) ? new List<UnityEngine.Object>(_objectReferences) : null);
	}

	public void SetSerializationObjectReferences(List<UnityEngine.Object> references)
	{
		_objectReferences = references;
	}

	public static T Clone<T>(T graph) where T : Graph
	{
		T val = UnityEngine.Object.Instantiate(graph);
		val.name = val.name.Replace("(Clone)", "");
		return val;
	}

	public static List<Graph> GetRunningGraphs()
	{
		return runningGraphs;
	}

	public string SerializeLocalBlackboard()
	{
		return JSONSerializer.Serialize(typeof(BlackboardSource), _localBlackboard, pretyJson: false, _objectReferences);
	}

	public bool DeserializeLocalBlackboard(string json)
	{
		try
		{
			_localBlackboard = JSONSerializer.Deserialize<BlackboardSource>(json, _objectReferences);
			if (_localBlackboard == null)
			{
				_localBlackboard = new BlackboardSource();
			}
			return true;
		}
		catch (Exception exception)
		{
			ParadoxNotion.Services.Logger.LogException(exception, "Serialization", this);
			return false;
		}
	}

	public void CopySerialized(Graph target)
	{
		string serializedGraph = Serialize(pretyJson: false, target._objectReferences);
		target.Deserialize(serializedGraph, validate: true, _objectReferences);
	}

	public void Destroy()
	{
		for (int i = 0; i < allNodes.Count; i++)
		{
			try
			{
				allNodes[i].OnDestroy();
			}
			catch (Exception exception)
			{
				ParadoxNotion.Services.Logger.LogException(exception, "OnDestroy", allNodes[i]);
			}
		}
	}

	public void Validate()
	{
		for (int i = 0; i < allNodes.Count; i++)
		{
			try
			{
				allNodes[i].OnValidate(this);
			}
			catch (Exception exception)
			{
				ParadoxNotion.Services.Logger.LogException(exception, "Validation", allNodes[i]);
			}
		}
		List<Task> allTasksOfType = GetAllTasksOfType<Task>();
		for (int j = 0; j < allTasksOfType.Count; j++)
		{
			try
			{
				allTasksOfType[j].OnValidate(this);
			}
			catch (Exception exception2)
			{
				ParadoxNotion.Services.Logger.LogException(exception2, "Validation", allTasksOfType[j]);
			}
		}
		OnGraphValidate();
		if (Application.isPlaying && useLocalBlackboard)
		{
			localBlackboard.InitializePropertiesBinding(null, callSetter: false);
		}
	}

	protected virtual void OnGraphValidate()
	{
	}

	public static List<Node> CloneNodes(List<Node> originalNodes, Graph targetGraph = null, Vector2 originPosition = default(Vector2))
	{
		if (targetGraph != null && originalNodes.Any((Node n) => !n.GetType().IsSubclassOf(targetGraph.baseNodeType)))
		{
			return null;
		}
		List<Node> list = new List<Node>();
		Dictionary<Connection, KeyValuePair<int, int>> dictionary = new Dictionary<Connection, KeyValuePair<int, int>>();
		foreach (Node originalNode in originalNodes)
		{
			Node node = null;
			if (targetGraph != null)
			{
				node = originalNode.Duplicate(targetGraph);
				if (targetGraph != originalNode.graph && originalNode.graph != null && originalNode == originalNode.graph.primeNode)
				{
					targetGraph.primeNode = node;
				}
			}
			else
			{
				node = JSONSerializer.Clone(originalNode);
			}
			list.Add(node);
			foreach (Connection outConnection in originalNode.outConnections)
			{
				int key = originalNodes.IndexOf(outConnection.sourceNode);
				int value = originalNodes.IndexOf(outConnection.targetNode);
				dictionary[outConnection] = new KeyValuePair<int, int>(key, value);
			}
		}
		foreach (KeyValuePair<Connection, KeyValuePair<int, int>> item in dictionary)
		{
			if (item.Value.Value != -1)
			{
				Node newSource = list[item.Value.Key];
				Node newTarget = list[item.Value.Value];
				if (targetGraph != null)
				{
					item.Key.Duplicate(newSource, newTarget);
					continue;
				}
				Connection connection = JSONSerializer.Clone(item.Key);
				connection.SetSource(newSource);
				connection.SetTarget(newTarget);
			}
		}
		if (targetGraph != null)
		{
			for (int num = 0; num < list.Count; num++)
			{
				list[num].OnValidate(targetGraph);
			}
		}
		return list;
	}

	public void UpdateReferencesFromOwner(GraphOwner owner)
	{
		UpdateReferences(owner, (owner != null) ? owner.blackboard : null);
	}

	public void UpdateReferences(Component newAgent, IBlackboard newBlackboard)
	{
		if (agent != newAgent || blackboard != newBlackboard || !initialReferencesUpdated)
		{
			initialReferencesUpdated = true;
			agent = newAgent;
			blackboard = newBlackboard;
			UpdateNodeBBFields();
			SendTaskOwnerDefaults();
		}
	}

	private void UpdateNodeBBFields()
	{
		for (int i = 0; i < allNodes.Count; i++)
		{
			BBParameter.SetBBFields(allNodes[i], blackboard);
		}
	}

	public void SendTaskOwnerDefaults()
	{
		List<Task> allTasksOfType = GetAllTasksOfType<Task>();
		for (int i = 0; i < allTasksOfType.Count; i++)
		{
			allTasksOfType[i].SetOwnerSystem(this);
		}
	}

	public void UpdateNodeIDs(bool alsoReorderList)
	{
		if (allNodes.Count != 0)
		{
			int lastID = -1;
			Node[] parsed = new Node[allNodes.Count];
			if (primeNode != null)
			{
				lastID = AssignNodeID(primeNode, lastID, ref parsed);
			}
			List<Node> list = (from n in allNodes
				orderby n.inConnections.Count != 0
				orderby n.priority * -1
				select n).ToList();
			for (int num = 0; num < list.Count; num++)
			{
				lastID = AssignNodeID(list[num], lastID, ref parsed);
			}
			if (alsoReorderList)
			{
				allNodes = parsed.ToList();
			}
		}
	}

	private int AssignNodeID(Node node, int lastID, ref Node[] parsed)
	{
		if (!parsed.Contains(node))
		{
			lastID++;
			node.ID = lastID;
			parsed[lastID] = node;
			for (int i = 0; i < node.outConnections.Count; i++)
			{
				Node targetNode = node.outConnections[i].targetNode;
				lastID = AssignNodeID(targetNode, lastID, ref parsed);
			}
		}
		return lastID;
	}

	public void StartGraph(Component agent, IBlackboard blackboard, bool autoUpdate, Action<bool> callback = null)
	{
		if (isRunning)
		{
			if (callback != null)
			{
				onFinish += callback;
			}
			ParadoxNotion.Services.Logger.LogWarning("Graph is already Active.", "NodeCanvas", this);
			return;
		}
		if (agent == null && requiresAgent)
		{
			ParadoxNotion.Services.Logger.LogWarning("You've tried to start a graph with null Agent.", "NodeCanvas", this);
			return;
		}
		if (primeNode == null && requiresPrimeNode)
		{
			ParadoxNotion.Services.Logger.LogWarning("You've tried to start graph without a 'Start' node.", "NodeCanvas", this);
			return;
		}
		if (blackboard == null)
		{
			if (agent != null)
			{
				ParadoxNotion.Services.Logger.Log("Graph started without blackboard. Looking for blackboard on agent '" + agent.gameObject?.ToString() + "'...", "NodeCanvas", this);
				blackboard = agent.GetComponent(typeof(IBlackboard)) as IBlackboard;
			}
			if (blackboard == null)
			{
				ParadoxNotion.Services.Logger.LogWarning("Started with null Blackboard. Using Local Blackboard instead.", "NodeCanvas", this);
				_blackboard = localBlackboard;
			}
		}
		UpdateReferences(agent, blackboard);
		if (callback != null)
		{
			onFinish = callback;
		}
		isRunning = true;
		if (Application.isPlaying)
		{
			_serializedGraph = string.Empty;
		}
		runningGraphs.Add(this);
		if (!isPaused)
		{
			timeStarted = Time.time;
			OnGraphStarted();
		}
		else
		{
			OnGraphUnpaused();
		}
		for (int i = 0; i < allNodes.Count; i++)
		{
			if (!isPaused)
			{
				allNodes[i].OnGraphStarted();
			}
			else
			{
				allNodes[i].OnGraphUnpaused();
			}
		}
		isPaused = false;
		isAutoUpdated = autoUpdate;
		if (autoUpdate)
		{
			MonoManager.current.onUpdate += UpdateGraph;
			UpdateGraph();
		}
	}

	public void Stop(bool success = true)
	{
		if (isRunning || isPaused)
		{
			runningGraphs.Remove(this);
			if (isAutoUpdated)
			{
				MonoManager.current.onUpdate -= UpdateGraph;
			}
			isRunning = false;
			isPaused = false;
			for (int i = 0; i < allNodes.Count; i++)
			{
				allNodes[i].Reset(recursively: false);
				allNodes[i].OnGraphStoped();
			}
			OnGraphStoped();
			if (onFinish != null)
			{
				onFinish(success);
				onFinish = null;
			}
		}
	}

	public void Pause()
	{
		if (isRunning)
		{
			runningGraphs.Remove(this);
			if (isAutoUpdated)
			{
				MonoManager.current.onUpdate -= UpdateGraph;
			}
			isRunning = false;
			isPaused = true;
			for (int i = 0; i < allNodes.Count; i++)
			{
				allNodes[i].OnGraphPaused();
			}
			OnGraphPaused();
		}
	}

	public void UpdateGraph()
	{
		if (isRunning)
		{
			OnGraphUpdate();
		}
	}

	public void UpdateAIGraph(int creationIndex, int aiID)
	{
		if (isRunning)
		{
			OnGraphLogicAIUpdate(creationIndex, aiID);
		}
	}

	public void UpdateLogicGraph()
	{
		if (isRunning)
		{
			OnGraphLogicUpdate();
		}
	}

	public void UpdateAbilityGraph(SimEntity caster, int abilityID)
	{
		if (isRunning)
		{
			OnGraphLogicAbilityUpdate(caster, abilityID);
		}
	}

	public void UpdateBuffGraph(int ownerID, int buffIndex, int buffClass, EBuffLife buffLife)
	{
		if (isRunning)
		{
			OnGraphLogicBuffUpdate(ownerID, buffIndex, buffClass, buffLife);
		}
	}

	public void UpdateAbilityBrokenGraph(int entityID, int abilityID, int logicTime)
	{
		if (isRunning)
		{
			OnGraphLogicAbilityBrokenUpdate(entityID, abilityID, logicTime);
		}
	}

	public void CreateHPTipsGraph(int causeDamageAbilityID, int injuredEntityID, long value, DamageType type, int causeDamageEntityID, Vector3 position)
	{
		if (isRunning)
		{
			OnGraphRenderCreateHPTips(causeDamageAbilityID, injuredEntityID, value, type, causeDamageEntityID, position);
		}
	}

	protected virtual void OnGraphStarted()
	{
	}

	protected virtual void OnGraphUpdate()
	{
	}

	protected virtual void OnGraphLogicAIUpdate(int creationIndex, int aiID)
	{
	}

	protected virtual void OnGraphLogicUpdate()
	{
	}

	protected virtual void OnGraphLogicAbilityUpdate(SimEntity simEntity, int abilityID)
	{
	}

	protected virtual void OnGraphLogicBuffUpdate(int ownerID, int buffIndex, int buffClass, EBuffLife buffLife)
	{
	}

	protected virtual void OnGraphLogicAbilityBrokenUpdate(int entityID, int abilityID, int logicTime)
	{
	}

	protected virtual void OnGraphRenderCreateHPTips(int causeDamageAbilityID, int injuredEntityID, long value, DamageType type, int causeDamageEntityID, Vector3 position)
	{
	}

	protected virtual void OnGraphStoped()
	{
	}

	protected virtual void OnGraphPaused()
	{
	}

	protected virtual void OnGraphUnpaused()
	{
	}

	public void SendEvent(EventData eventData, object sender)
	{
		if (isRunning && eventData != null && !(agent == null))
		{
			MessageRouter component = agent.GetComponent<MessageRouter>();
			if (component != null)
			{
				component.Dispatch("OnCustomEvent", eventData, sender);
				component.Dispatch(eventData.name, eventData.value, sender);
			}
		}
	}

	public static void SendGlobalEvent(EventData eventData, object sender)
	{
		List<GameObject> list = new List<GameObject>();
		Graph[] array = runningGraphs.ToArray();
		foreach (Graph graph in array)
		{
			if (graph.agent != null && !list.Contains(graph.agent.gameObject))
			{
				list.Add(graph.agent.gameObject);
				graph.SendEvent(eventData, sender);
			}
		}
	}

	public Node GetNodeWithID(int searchID)
	{
		if (searchID < allNodes.Count && searchID >= 0)
		{
			return allNodes.Find((Node n) => n.ID == searchID);
		}
		return null;
	}

	public List<T> GetAllNodesOfType<T>() where T : Node
	{
		return allNodes.OfType<T>().ToList();
	}

	public List<Node> GetRootNodes()
	{
		return allNodes.Where((Node n) => n.inConnections.Count == 0).ToList();
	}

	public List<Node> GetLeafNodes()
	{
		return allNodes.Where((Node n) => n.outConnections.Count == 0).ToList();
	}

	public List<T> GetAllNestedGraphs<T>(bool recursive) where T : Graph
	{
		List<T> list = new List<T>();
		foreach (IGraphAssignable item in allNodes.OfType<IGraphAssignable>())
		{
			if (item.nestedGraph is T)
			{
				if (!list.Contains((T)item.nestedGraph))
				{
					list.Add((T)item.nestedGraph);
				}
				if (recursive)
				{
					list.AddRange(item.nestedGraph.GetAllNestedGraphs<T>(recursive));
				}
			}
		}
		return list;
	}

	public List<Graph> GetAllInstancedNestedGraphs()
	{
		List<Graph> list = new List<Graph>();
		foreach (IGraphAssignable item in allNodes.OfType<IGraphAssignable>())
		{
			Graph[] instances = item.GetInstances();
			list.AddRange(instances);
			Graph[] array = instances;
			foreach (Graph graph in array)
			{
				list.AddRange(graph.GetAllInstancedNestedGraphs());
			}
		}
		return list;
	}

	public static Graph GetElementGraph(object obj)
	{
		if (obj is GraphOwner)
		{
			return (obj as GraphOwner).graph;
		}
		if (obj is Graph)
		{
			return (Graph)obj;
		}
		if (obj is Node)
		{
			return (obj as Node).graph;
		}
		if (obj is Connection)
		{
			return (obj as Connection).graph;
		}
		if (obj is Task)
		{
			return (obj as Task).ownerSystem as Graph;
		}
		return null;
	}

	public List<T> GetAllTasksOfType<T>() where T : Task
	{
		List<Task> tasks = new List<Task>();
		List<T> tasks2 = new List<T>();
		for (int i = 0; i < allNodes.Count; i++)
		{
			GetObjectTasks(allNodes[i], ref tasks);
			for (int j = 0; j < allNodes[i].outConnections.Count; j++)
			{
				GetObjectTasks(allNodes[i].outConnections[j], ref tasks);
			}
		}
		for (int k = 0; k < tasks.Count; k++)
		{
			if (tasks[k] is T)
			{
				tasks2.Add((T)tasks[k]);
			}
			GetObjectTasks(tasks[k], ref tasks2);
		}
		return tasks2;
	}

	private void GetObjectTasks<T>(object obj, ref List<T> tasks) where T : Task
	{
		if (obj is ITaskAssignable && (obj as ITaskAssignable).task is T)
		{
			tasks.Add((T)(obj as ITaskAssignable).task);
		}
		if (obj is ISubTasksContainer)
		{
			tasks.AddRange((obj as ISubTasksContainer).GetSubTasks().OfType<T>());
		}
	}

	public virtual HierarchyTree.Element GetFlatGraphHierarchy()
	{
		HierarchyTree.Element element = new HierarchyTree.Element(this);
		int lastID = 0;
		for (int i = 0; i < allNodes.Count; i++)
		{
			element.AddChild(GetTreeNodeElement(allNodes[i], recurse: false, ref lastID));
		}
		return element;
	}

	public HierarchyTree.Element GetFullGraphHierarchy()
	{
		HierarchyTree.Element element = new HierarchyTree.Element(this);
		int lastID = 0;
		if (primeNode != null)
		{
			element.AddChild(GetTreeNodeElement(primeNode, recurse: true, ref lastID));
		}
		for (int i = 0; i < allNodes.Count; i++)
		{
			Node node = allNodes[i];
			if (node.ID > lastID && node.inConnections.Count == 0)
			{
				element.AddChild(GetTreeNodeElement(node, recurse: true, ref lastID));
			}
		}
		return element;
	}

	public HierarchyTree.Element GetTreeNodeElement(Node node, bool recurse, ref int lastID)
	{
		HierarchyTree.Element taskAndParametersStructureInTarget = GetTaskAndParametersStructureInTarget(node);
		for (int i = 0; i < node.outConnections.Count; i++)
		{
			HierarchyTree.Element taskAndParametersStructureInTarget2 = GetTaskAndParametersStructureInTarget(node.outConnections[i]);
			taskAndParametersStructureInTarget.AddChild(taskAndParametersStructureInTarget2);
			if (recurse)
			{
				Node targetNode = node.outConnections[i].targetNode;
				if (targetNode.ID > node.ID)
				{
					taskAndParametersStructureInTarget2.AddChild(GetTreeNodeElement(targetNode, recurse, ref lastID));
				}
			}
		}
		lastID = node.ID;
		return taskAndParametersStructureInTarget;
	}

	public static HierarchyTree.Element GetTaskAndParametersStructureInTarget(object obj)
	{
		HierarchyTree.Element element = new HierarchyTree.Element(obj);
		List<object> list = new List<object>();
		if (obj is ITaskAssignable && (obj as ITaskAssignable).task != null)
		{
			list.Add((obj as ITaskAssignable).task);
		}
		if (obj is ISubTasksContainer)
		{
			Task[] subTasks = (obj as ISubTasksContainer).GetSubTasks();
			if (subTasks != null)
			{
				list.AddRange(subTasks);
			}
		}
		list.AddRange(BBParameter.GetObjectBBParameters(obj).ToArray());
		for (int i = 0; i < list.Count; i++)
		{
			element.AddChild(GetTaskAndParametersStructureInTarget(list[i]));
		}
		return element;
	}

	public IGraphElement GetTaskParentElement(Task targetTask)
	{
		return GetFlatGraphHierarchy().FindReferenceElement(targetTask)?.GetFirstParentReferenceOfType<IGraphElement>();
	}

	public IGraphElement GetParameterParentElement(BBParameter targetParameter)
	{
		return GetFlatGraphHierarchy().FindReferenceElement(targetParameter)?.GetFirstParentReferenceOfType<IGraphElement>();
	}

	public static Task[] GetTasksInElement(IGraphElement target)
	{
		return GetTaskAndParametersStructureInTarget(target).GetAllChildrenReferencesOfType<Task>().ToArray();
	}

	public static BBParameter[] GetParametersInElement(IGraphElement target)
	{
		return GetTaskAndParametersStructureInTarget(target).GetAllChildrenReferencesOfType<BBParameter>().ToArray();
	}

	public BBParameter[] GetDefinedParameters()
	{
		return (from p in GetFlatGraphHierarchy().GetAllChildrenReferencesOfType<BBParameter>()
			where p?.isDefined ?? false
			select p).ToArray();
	}

	public void PromoteDefinedParametersToVariables(IBlackboard bb)
	{
		BBParameter[] definedParameters = GetDefinedParameters();
		for (int i = 0; i < definedParameters.Length; i++)
		{
			definedParameters[i].PromoteToVariable(bb);
		}
	}

	public T AddNode<T>() where T : Node
	{
		return (T)AddNode(typeof(T));
	}

	public T AddNode<T>(Vector2 pos) where T : Node
	{
		return (T)AddNode(typeof(T), pos);
	}

	public Node AddNode(Type nodeType)
	{
		return AddNode(nodeType, new Vector2(0f - translation.x + 100f, 0f - translation.y + 100f));
	}

	public Node AddNode(Type nodeType, Vector2 pos)
	{
		if (nodeType.IsGenericTypeDefinition)
		{
			nodeType = nodeType.RTMakeGenericType(nodeType.GetFirstGenericParameterConstraintType());
		}
		if (!nodeType.RTIsSubclassOf(baseNodeType))
		{
			ParadoxNotion.Services.Logger.LogWarning(nodeType?.ToString() + " can't be added to " + GetType().FriendlyName() + " graph.", "NodeCanvas", this);
			return null;
		}
		Node node = Node.Create(this, nodeType, pos);
		RecordUndo("New Node");
		allNodes.Add(node);
		if (primeNode == null)
		{
			primeNode = node;
		}
		UpdateNodeIDs(alsoReorderList: false);
		return node;
	}

	public void RemoveNode(Node node, bool recordUndo = true, bool force = false)
	{
		if (!force && node.GetType().RTIsDefined<ProtectedSingletonAttribute>(inherited: true) && allNodes.Where((Node n) => n.GetType() == node.GetType()).ToArray().Length == 1)
		{
			return;
		}
		if (!allNodes.Contains(node))
		{
			ParadoxNotion.Services.Logger.LogWarning("Node is not part of this graph.", "NodeCanvas", this);
			return;
		}
		node.OnDestroy();
		Connection[] array = node.inConnections.ToArray();
		foreach (Connection connection in array)
		{
			RemoveConnection(connection);
		}
		array = node.outConnections.ToArray();
		foreach (Connection connection2 in array)
		{
			RemoveConnection(connection2);
		}
		if (recordUndo)
		{
			RecordUndo("Delete Node");
		}
		allNodes.Remove(node);
		if (node == primeNode)
		{
			primeNode = GetNodeWithID(primeNode.ID + 1);
		}
		UpdateNodeIDs(alsoReorderList: false);
	}

	public Connection ConnectNodes(Node sourceNode, Node targetNode, int sourceIndex = -1, int targetIndex = -1)
	{
		if (!Node.IsNewConnectionAllowed(sourceNode, targetNode))
		{
			return null;
		}
		RecordUndo("New Connection");
		Connection result = Connection.Create(sourceNode, targetNode, sourceIndex, targetIndex);
		UpdateNodeIDs(alsoReorderList: false);
		return result;
	}

	public void RemoveConnection(Connection connection, bool recordUndo = true)
	{
		if (Application.isPlaying)
		{
			connection.Reset();
		}
		if (recordUndo)
		{
			RecordUndo("Delete Connection");
		}
		connection.OnDestroy();
		connection.sourceNode.OnChildDisconnected(connection.sourceNode.outConnections.IndexOf(connection));
		connection.targetNode.OnParentDisconnected(connection.targetNode.inConnections.IndexOf(connection));
		connection.sourceNode.outConnections.Remove(connection);
		connection.targetNode.inConnections.Remove(connection);
		UpdateNodeIDs(alsoReorderList: false);
	}

	public void RecordUndo(string name)
	{
	}

	public void ClearGraph()
	{
		canvasGroups = null;
		Node[] array = allNodes.ToArray();
		foreach (Node node in array)
		{
			RemoveNode(node);
		}
	}
}
