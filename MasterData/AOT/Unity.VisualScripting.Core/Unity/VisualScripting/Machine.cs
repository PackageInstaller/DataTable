using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

public abstract class Machine<TGraph, TMacro> : LudiqBehaviour, IMachine, IGraphRoot, IGraphParent, IGraphNester, IAotStubbable where TGraph : class, IGraph, new() where TMacro : Macro<TGraph>
{
	[DoNotSerialize]
	private bool _alive;

	[DoNotSerialize]
	private bool _enabled;

	[DoNotSerialize]
	private GameObject threadSafeGameObject;

	[DoNotSerialize]
	private bool isReferenceCached;

	[DoNotSerialize]
	private GraphReference _reference;

	[Serialize]
	public GraphNest<TGraph, TMacro> nest { get; private set; } = new GraphNest<TGraph, TMacro>();

	[DoNotSerialize]
	IGraphNest IGraphNester.nest => nest;

	[DoNotSerialize]
	GameObject IMachine.threadSafeGameObject => threadSafeGameObject;

	[DoNotSerialize]
	protected GraphReference reference
	{
		get
		{
			if (!isReferenceCached)
			{
				return GraphReference.New(this, ensureValid: false);
			}
			return _reference;
		}
	}

	[DoNotSerialize]
	protected bool hasGraph => reference != null;

	[DoNotSerialize]
	public TGraph graph => nest.graph;

	[DoNotSerialize]
	public IGraphData graphData { get; set; }

	[DoNotSerialize]
	bool IGraphParent.isSerializationRoot => true;

	[DoNotSerialize]
	Object IGraphParent.serializedObject => nest.source switch
	{
		GraphSource.Macro => (Object)nest.macro, 
		GraphSource.Embed => this, 
		_ => throw new UnexpectedEnumValueException<GraphSource>(nest.source), 
	};

	[DoNotSerialize]
	IGraph IGraphParent.childGraph => graph;

	public bool isDescriptionValid
	{
		get
		{
			return true;
		}
		set
		{
		}
	}

	protected Machine()
	{
		nest.nester = this;
		nest.source = GraphSource.Macro;
	}

	public IEnumerable<object> GetAotStubs(HashSet<object> visited)
	{
		return nest.GetAotStubs(visited);
	}

	protected virtual void Awake()
	{
		_alive = true;
		threadSafeGameObject = gameObject;
		nest.afterGraphChange += CacheReference;
		nest.beforeGraphChange += ClearCachedReference;
		CacheReference();
		if (graph != null)
		{
			graph.Prewarm();
			InstantiateNest();
		}
	}

	protected virtual void OnEnable()
	{
		_enabled = true;
	}

	protected virtual void OnInstantiateWhileEnabled()
	{
	}

	protected virtual void OnUninstantiateWhileEnabled()
	{
	}

	protected virtual void OnDisable()
	{
		_enabled = false;
	}

	protected virtual void OnDestroy()
	{
		ClearCachedReference();
		if (graph != null)
		{
			UninstantiateNest();
		}
		threadSafeGameObject = null;
		_alive = false;
	}

	protected virtual void OnValidate()
	{
		threadSafeGameObject = gameObject;
	}

	public GraphPointer GetReference()
	{
		return reference;
	}

	private void CacheReference()
	{
		_reference = GraphReference.New(this, ensureValid: false);
		isReferenceCached = true;
	}

	private void ClearCachedReference()
	{
		if (_reference != null)
		{
			_reference.Release();
			_reference = null;
		}
	}

	public virtual void InstantiateNest()
	{
		if (_alive)
		{
			GraphInstances.Instantiate(reference);
		}
		if (_enabled)
		{
			if (UnityThread.allowsAPI)
			{
				OnInstantiateWhileEnabled();
			}
			else
			{
				Debug.LogWarning("Could not run instantiation events on " + this.ToSafeString() + " because the Unity API is not available.\nThis can happen when undoing / redoing a graph source change.", this);
			}
		}
	}

	public virtual void UninstantiateNest()
	{
		if (_enabled)
		{
			if (UnityThread.allowsAPI)
			{
				OnUninstantiateWhileEnabled();
			}
			else
			{
				Debug.LogWarning("Could not run uninstantiation events on " + this.ToSafeString() + " because the Unity API is not available.\nThis can happen when undoing / redoing a graph source change.", this);
			}
		}
		if (!_alive)
		{
			return;
		}
		HashSet<GraphReference> hashSet = GraphInstances.ChildrenOfPooled(this);
		foreach (GraphReference item in hashSet)
		{
			GraphInstances.Uninstantiate(item);
		}
		hashSet.Free();
	}

	public virtual void TriggerAnimationEvent(AnimationEvent animationEvent)
	{
	}

	public virtual void TriggerUnityEvent(string name)
	{
	}

	public abstract TGraph DefaultGraph();

	IGraph IGraphParent.DefaultGraph()
	{
		return DefaultGraph();
	}
}
