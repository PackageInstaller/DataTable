using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using NodeCanvas.Framework.Internal;
using ParadoxNotion.Serialization;
using ParadoxNotion.Services;
using UnityEngine;
using UnityEngine.Serialization;

namespace NodeCanvas.Framework;

public abstract class GraphOwner : MonoBehaviour, ISerializationCallbackReceiver
{
	public enum EnableAction
	{
		EnableBehaviour,
		DoNothing
	}

	public enum DisableAction
	{
		DisableBehaviour,
		PauseBehaviour,
		DoNothing
	}

	public enum FirstActivation
	{
		OnEnable,
		OnStart,
		Async
	}

	[SerializeField]
	private SerializationPair[] _serializedExposedParameters;

	[SerializeField]
	[FormerlySerializedAs("boundGraphSerialization")]
	private string _boundGraphSerialization;

	[SerializeField]
	[FormerlySerializedAs("boundGraphObjectReferences")]
	private List<UnityEngine.Object> _boundGraphObjectReferences;

	[SerializeField]
	private GraphSource _boundGraphSource = new GraphSource();

	[SerializeField]
	[FormerlySerializedAs("firstActivation")]
	[Tooltip("When the graph will first activate. Async mode will load the graph on a separate thread (thus no spikes), but the graph will activate a few frames later.")]
	private FirstActivation _firstActivation;

	[SerializeField]
	[FormerlySerializedAs("enableAction")]
	[Tooltip("What will happen when the GraphOwner is enabled")]
	private EnableAction _enableAction;

	[SerializeField]
	[FormerlySerializedAs("disableAction")]
	[Tooltip("What will happen when the GraphOwner is disabled")]
	private DisableAction _disableAction;

	[SerializeField]
	[Tooltip("If enabled, bound graph prefab overrides in instances will not be possible")]
	private bool _lockBoundGraphPrefabOverrides = true;

	[SerializeField]
	[Tooltip("If enabled, all subgraphs will be pre-initialized in Awake along with the root graph, but this may have a loading performance cost")]
	private bool _preInitializeSubGraphs;

	[SerializeField]
	[Tooltip("Specify when (if) the behaviour is updated. Changes to this only work when the behaviour starts, or re-starts")]
	private Graph.UpdateMode _updateMode;

	public float TickTime;

	public float FrozenSpeed;

	public List<ExposedParameter> exposedParameters { get; set; }

	public abstract Graph graph { get; set; }

	public abstract IBlackboard blackboard { get; set; }

	public abstract Type graphType { get; }

	public bool initialized { get; private set; }

	public GraphSource boundGraphSource
	{
		get
		{
			return _boundGraphSource;
		}
		private set
		{
			_boundGraphSource = value;
		}
	}

	public string boundGraphSerialization
	{
		get
		{
			return _boundGraphSerialization;
		}
		private set
		{
			_boundGraphSerialization = value;
		}
	}

	public List<UnityEngine.Object> boundGraphObjectReferences
	{
		get
		{
			return _boundGraphObjectReferences;
		}
		private set
		{
			_boundGraphObjectReferences = value;
		}
	}

	public bool lockBoundGraphPrefabOverrides
	{
		get
		{
			if (_lockBoundGraphPrefabOverrides)
			{
				return graphIsBound;
			}
			return false;
		}
		set
		{
			_lockBoundGraphPrefabOverrides = value;
		}
	}

	public bool preInitializeSubGraphs
	{
		get
		{
			return _preInitializeSubGraphs;
		}
		set
		{
			_preInitializeSubGraphs = value;
		}
	}

	public FirstActivation firstActivation
	{
		get
		{
			return _firstActivation;
		}
		set
		{
			_firstActivation = value;
		}
	}

	public EnableAction enableAction
	{
		get
		{
			return _enableAction;
		}
		set
		{
			_enableAction = value;
		}
	}

	public DisableAction disableAction
	{
		get
		{
			return _disableAction;
		}
		set
		{
			_disableAction = value;
		}
	}

	public Graph.UpdateMode updateMode
	{
		get
		{
			return _updateMode;
		}
		set
		{
			_updateMode = value;
		}
	}

	public bool graphIsBound => !string.IsNullOrEmpty(boundGraphSerialization);

	public bool isRunning
	{
		get
		{
			if (!(graph != null))
			{
				return false;
			}
			return graph.isRunning;
		}
	}

	public bool isPaused
	{
		get
		{
			if (!(graph != null))
			{
				return false;
			}
			return graph.isPaused;
		}
	}

	public float elapsedTime
	{
		get
		{
			if (!(graph != null))
			{
				return 0f;
			}
			return graph.elapsedTime;
		}
	}

	public static event Action<GraphOwner> onOwnerBehaviourStateChange;

	public event Action onMonoBehaviourStart;

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		if (exposedParameters == null || exposedParameters.Count == 0)
		{
			_serializedExposedParameters = null;
			return;
		}
		_serializedExposedParameters = new SerializationPair[exposedParameters.Count];
		for (int i = 0; i < _serializedExposedParameters.Length; i++)
		{
			SerializationPair serializationPair = new SerializationPair();
			serializationPair._json = JSONSerializer.Serialize(typeof(ExposedParameter), exposedParameters[i], null, serializationPair._references);
			_serializedExposedParameters[i] = serializationPair;
		}
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		if (_serializedExposedParameters != null)
		{
			if (exposedParameters == null)
			{
				exposedParameters = new List<ExposedParameter>();
			}
			else
			{
				exposedParameters.Clear();
			}
			for (int i = 0; i < _serializedExposedParameters.Length; i++)
			{
				ExposedParameter item = JSONSerializer.Deserialize<ExposedParameter>(_serializedExposedParameters[i]._json, _serializedExposedParameters[i].graphByteData, _serializedExposedParameters[i]._references);
				exposedParameters.Add(item);
			}
		}
	}

	protected Graph GetInstance(Graph originalGraph, GraphOwner graphOwner)
	{
		if (originalGraph == null)
		{
			return null;
		}
		if (!Application.isPlaying)
		{
			return originalGraph;
		}
		if (MonoManager.current == null)
		{
			return null;
		}
		return MonoManager.current.GetInstance(originalGraph, graphOwner);
	}

	public Graph EditorGetInstance()
	{
		return MonoManager.current.GetEditorInstance(graph, this);
	}

	public void StartBehaviour()
	{
		StartBehaviour(updateMode);
	}

	public void StartBehaviour(Action<bool> callback)
	{
		StartBehaviour(updateMode, callback);
	}

	public void StartBehaviour(Graph.UpdateMode updateMode, Action<bool> callback = null)
	{
		graph = GetInstance(graph, this);
		if (graph != null)
		{
			graph.StartGraph(this, blackboard, frozenFrameIsPauseTree: false, updateMode, callback);
			if (onOwnerBehaviourStateChange != null)
			{
				onOwnerBehaviourStateChange(this);
			}
		}
	}

	public void PauseBehaviour()
	{
		if (graph != null)
		{
			graph.Pause();
			if (onOwnerBehaviourStateChange != null)
			{
				onOwnerBehaviourStateChange(this);
			}
		}
	}

	public void StopBehaviour(bool success = true, bool isExecuteStopLogic = true, bool onStopIsReleaseAssets = false)
	{
		if (graph != null)
		{
			graph.Stop(success, isExecuteStopLogic);
			if (onOwnerBehaviourStateChange != null)
			{
				onOwnerBehaviourStateChange(this);
			}
		}
	}

	public void UpdateBehaviour()
	{
		if (graph != null)
		{
			graph.UpdateGraph();
		}
	}

	public void RestartBehaviour()
	{
		StopBehaviour();
		StartBehaviour();
	}

	public void SendEvent(string eventName)
	{
		if (graph != null)
		{
			graph.SendEvent(eventName, null, null);
		}
	}

	public void SendEvent(string eventName, object value, object sender)
	{
		if (graph != null)
		{
			graph.SendEvent(eventName, value, sender);
		}
	}

	public void SendEvent<T>(string eventName, T eventValue, object sender)
	{
		if (graph != null)
		{
			graph.SendEvent(eventName, eventValue, sender);
		}
	}

	public void SetExposedParameterValue<T>(string name, T value)
	{
		ExposedParameter exposedParameter = exposedParameters?.Find((ExposedParameter x) => x.varRefBoxed != null && x.varRefBoxed.name == name);
		if (exposedParameter == null)
		{
			exposedParameter = MakeNewExposedParameter<T>(name);
		}
		if (exposedParameter != null)
		{
			(exposedParameter as ExposedParameter<T>).value = value;
		}
	}

	public ExposedParameter MakeNewExposedParameter<T>(string name)
	{
		if (exposedParameters == null)
		{
			exposedParameters = new List<ExposedParameter>();
		}
		Variable<T> variable = graph.blackboard.GetVariable<T>(name);
		if (variable != null && variable.isExposedPublic && !variable.isPropertyBound)
		{
			ExposedParameter exposedParameter = ExposedParameter.CreateInstance(variable);
			exposedParameter.Bind(graph.blackboard);
			exposedParameters.Add(exposedParameter);
			return exposedParameter;
		}
		return null;
	}

	public void Initialize(int cacheNumber)
	{
		if (graphIsBound)
		{
			return;
		}
		cacheNumber = MonoManager.current.CheckGraphInitialized(this.graph, cacheNumber);
		if (cacheNumber != -1 && cacheNumber != 0 && (!(this.graph == null) || graphIsBound))
		{
			GraphLoadData data = GraphLoadData.Creat(this.graph, this, preInitializeSubGraphs: true);
			for (int i = 0; i < cacheNumber; i++)
			{
				Graph graph = (Graph)ScriptableObject.CreateInstance(graphType);
				graph.name = this.graph.name;
				graph.LoadOverwrite(data);
				MonoManager.current.SetInstance(graph.name, graph);
			}
			BindExposedParameters();
			initialized = true;
		}
	}

	public async System.Threading.Tasks.Task SyncInitialize(int cacheNumber)
	{
		if (graphIsBound)
		{
			return;
		}
		cacheNumber = MonoManager.current.CheckGraphInitialized(graph, cacheNumber);
		if (cacheNumber != -1 && cacheNumber != 0 && (!(graph == null) || graphIsBound))
		{
			GraphLoadData loadData = GraphLoadData.Creat(graph, this, preInitializeSubGraphs: true);
			for (int i = 0; i < cacheNumber; i++)
			{
				Graph newGraph = (Graph)ScriptableObject.CreateInstance(graphType);
				newGraph.name = graph.name;
				await newGraph.LoadOverwriteAsync(loadData);
				MonoManager.current.SetInstance(newGraph.name, newGraph);
			}
			BindExposedParameters();
			initialized = true;
		}
	}

	public void BindExposedParameters()
	{
		if (exposedParameters != null && graph != null)
		{
			for (int i = 0; i < exposedParameters.Count; i++)
			{
				exposedParameters[i].Bind(graph.blackboard);
			}
		}
	}

	public void UnBindExposedParameters()
	{
		if (exposedParameters != null)
		{
			for (int i = 0; i < exposedParameters.Count; i++)
			{
				exposedParameters[i].UnBind();
			}
		}
	}

	protected void OnDestroy()
	{
		if (Threader.applicationIsPlaying)
		{
			StopBehaviour(success: true, isExecuteStopLogic: false);
		}
	}

	public void OnBehaviourEnd(Graph runGraph)
	{
	}
}
public abstract class GraphOwner<T> : GraphOwner where T : Graph
{
	[SerializeField]
	[Tooltip("The graph to use.")]
	private T _graph;

	[SerializeField]
	[Tooltip("The GameObject Blackboard to use.")]
	private UnityEngine.Object _blackboard;

	public sealed override Graph graph
	{
		get
		{
			return _graph;
		}
		set
		{
			_graph = (T)value;
		}
	}

	public T behaviour
	{
		get
		{
			return (T)graph;
		}
		set
		{
			graph = value;
		}
	}

	public sealed override IBlackboard blackboard
	{
		get
		{
			if (!(_blackboard != null))
			{
				return null;
			}
			return _blackboard as IBlackboard;
		}
		set
		{
			if (_blackboard != value)
			{
				_blackboard = (UnityEngine.Object)value;
				if (graph != null)
				{
					graph.UpdateReferences(this, value);
				}
			}
		}
	}

	public sealed override Type graphType => typeof(T);

	public void StartBehaviour(T newGraph)
	{
		StartBehaviour(newGraph, base.updateMode);
	}

	public void StartBehaviour(T newGraph, Action<bool> callback)
	{
		StartBehaviour(newGraph, base.updateMode, callback);
	}

	public void StartBehaviour(T newGraph, Graph.UpdateMode updateMode, Action<bool> callback = null)
	{
		SwitchBehaviour(newGraph, updateMode, callback);
	}

	public void SwitchBehaviour(T newGraph)
	{
		SwitchBehaviour(newGraph, base.updateMode);
	}

	public void SwitchBehaviour(T newGraph, Action<bool> callback)
	{
		SwitchBehaviour(newGraph, base.updateMode, callback);
	}

	public void SwitchBehaviour(T newGraph, Graph.UpdateMode updateMode, Action<bool> callback = null)
	{
		StopBehaviour();
		graph = newGraph;
		StartBehaviour(updateMode, callback);
	}
}
