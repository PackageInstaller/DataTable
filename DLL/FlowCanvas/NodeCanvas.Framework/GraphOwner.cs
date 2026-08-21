using System;
using System.Collections.Generic;
using ParadoxNotion;
using UnityEngine;

namespace NodeCanvas.Framework;

public abstract class GraphOwner : MonoBehaviour
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

	[SerializeField]
	private string boundGraphSerialization;

	[SerializeField]
	private List<UnityEngine.Object> boundGraphObjectReferences;

	[HideInInspector]
	public EnableAction enableAction;

	[HideInInspector]
	public DisableAction disableAction;

	public static Action<GraphOwner> onOwnerBehaviourStateChange;

	private Dictionary<string, Graph> instances = new Dictionary<string, Graph>();

	private bool initialized;

	private bool startCalled;

	private static bool isQuiting;

	public abstract Graph graph { get; set; }

	public abstract IBlackboard blackboard { get; set; }

	public abstract Type graphType { get; }

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

	public Graph GetInstance(Graph originalGraph)
	{
		return originalGraph;
	}

	public void StartBehaviour()
	{
		StartBehaviour(autoUpdate: true, null);
	}

	public void StartBehaviour(Action<bool> callback)
	{
		StartBehaviour(autoUpdate: true, callback);
	}

	public void StartBehaviour(bool autoUpdate, Action<bool> callback)
	{
		graph = GetInstance(graph);
		if (graph != null)
		{
			graph.StartGraph(this, blackboard, autoUpdate, callback);
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

	public void StopBehaviour(bool success = true)
	{
		if (graph != null)
		{
			graph.Stop(success);
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
		SendEvent(new EventData(eventName), null);
	}

	public void SendEvent<T>(string eventName, T eventValue)
	{
		SendEvent(new EventData<T>(eventName, eventValue), null);
	}

	public void SendEvent(EventData eventData, object sender)
	{
		if (graph != null)
		{
			graph.SendEvent(eventData, sender);
		}
	}

	public void Initialize()
	{
		if (initialized)
		{
			return;
		}
		initialized = true;
		if (!string.IsNullOrEmpty(boundGraphSerialization))
		{
			if (graph == null)
			{
				graph = (Graph)ScriptableObject.CreateInstance(graphType);
				graph.name = base.name + " " + graphType.Name;
				graph.Deserialize(boundGraphSerialization, validate: true, boundGraphObjectReferences);
				instances[graph.name] = graph;
				if (Application.isPlaying)
				{
					boundGraphSerialization = string.Empty;
				}
				return;
			}
			graph.SetSerializationObjectReferences(boundGraphObjectReferences);
		}
		graph = GetInstance(graph);
	}

	protected void Awake()
	{
		Initialize();
	}

	protected void OnEnable()
	{
		if (startCalled && enableAction == EnableAction.EnableBehaviour)
		{
			StartBehaviour();
		}
	}

	protected void Start()
	{
		startCalled = true;
		if (enableAction == EnableAction.EnableBehaviour)
		{
			StartBehaviour();
		}
	}

	protected void OnDisable()
	{
		if (!isQuiting)
		{
			if (disableAction == DisableAction.DisableBehaviour)
			{
				StopBehaviour();
			}
			if (disableAction == DisableAction.PauseBehaviour)
			{
				PauseBehaviour();
			}
		}
	}

	protected void OnDestroy()
	{
		if (isQuiting)
		{
			return;
		}
		StopBehaviour();
		foreach (Graph value in instances.Values)
		{
			foreach (Graph allInstancedNestedGraph in value.GetAllInstancedNestedGraphs())
			{
				UnityEngine.Object.DestroyImmediate(allInstancedNestedGraph);
			}
			UnityEngine.Object.DestroyImmediate(value);
		}
	}

	protected void OnApplicationQuit()
	{
		isQuiting = true;
	}
}
public abstract class GraphOwner<T> : GraphOwner where T : Graph
{
	[SerializeField]
	private T _graph;

	[SerializeField]
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
			return _graph;
		}
		set
		{
			_graph = value;
		}
	}

	public sealed override IBlackboard blackboard
	{
		get
		{
			if (graph != null && graph.useLocalBlackboard)
			{
				return graph.localBlackboard;
			}
			if (_blackboard == null)
			{
				_blackboard = GetComponent<Blackboard>();
			}
			return _blackboard as IBlackboard;
		}
		set
		{
			if (_blackboard != value)
			{
				_blackboard = (Blackboard)value;
				if (graph != null && !graph.useLocalBlackboard)
				{
					graph.UpdateReferences(this, value);
				}
			}
		}
	}

	public sealed override Type graphType => typeof(T);

	public void StartBehaviour(T newGraph)
	{
		StartBehaviour(newGraph, autoUpdate: true, null);
	}

	public void StartBehaviour(T newGraph, Action<bool> callback)
	{
		StartBehaviour(newGraph, autoUpdate: true, callback);
	}

	public void StartBehaviour(T newGraph, bool autoUpdate, Action<bool> callback)
	{
		SwitchBehaviour(newGraph, autoUpdate, callback);
	}

	public void SwitchBehaviour(T newGraph)
	{
		SwitchBehaviour(newGraph, autoUpdate: true, null);
	}

	public void SwitchBehaviour(T newGraph, Action<bool> callback)
	{
		SwitchBehaviour(newGraph, autoUpdate: true, callback);
	}

	public void SwitchBehaviour(T newGraph, bool autoUpdate, Action<bool> callback)
	{
		StopBehaviour();
		graph = newGraph;
		StartBehaviour(autoUpdate, callback);
	}
}
