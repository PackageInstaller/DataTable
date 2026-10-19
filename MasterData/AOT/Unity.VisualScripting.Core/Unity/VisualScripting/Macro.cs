using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

[DisableAnnotation]
public abstract class Macro<TGraph> : MacroScriptableObject, IMacro, IGraphRoot, IGraphParent, ISerializationDependency, ISerializationCallbackReceiver, IAotStubbable where TGraph : class, IGraph, new()
{
	[SerializeAs("graph")]
	private TGraph _graph = new TGraph();

	[DoNotSerialize]
	private GraphReference _reference;

	[DoNotSerialize]
	public TGraph graph
	{
		get
		{
			return _graph;
		}
		set
		{
			if (value == null)
			{
				throw new InvalidOperationException("Macros must have a graph.");
			}
			if (value != graph)
			{
				_graph = value;
			}
		}
	}

	[DoNotSerialize]
	IGraph IMacro.graph
	{
		get
		{
			return graph;
		}
		set
		{
			graph = (TGraph)value;
		}
	}

	[DoNotSerialize]
	IGraph IGraphParent.childGraph => graph;

	[DoNotSerialize]
	bool IGraphParent.isSerializationRoot => true;

	[DoNotSerialize]
	UnityEngine.Object IGraphParent.serializedObject => this;

	[DoNotSerialize]
	protected GraphReference reference
	{
		get
		{
			if (!(_reference == null))
			{
				return _reference;
			}
			return GraphReference.New(this, ensureValid: false);
		}
	}

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

	bool ISerializationDependency.IsDeserialized { get; set; }

	public IEnumerable<object> GetAotStubs(HashSet<object> visited)
	{
		return graph.GetAotStubs(visited);
	}

	protected override void OnBeforeDeserialize()
	{
		base.OnBeforeDeserialize();
		Serialization.NotifyDependencyDeserializing(this);
	}

	protected override void OnAfterDeserialize()
	{
		base.OnAfterDeserialize();
		Serialization.NotifyDependencyDeserialized(this);
	}

	public abstract TGraph DefaultGraph();

	IGraph IGraphParent.DefaultGraph()
	{
		return DefaultGraph();
	}

	protected virtual void OnEnable()
	{
		Serialization.NotifyDependencyAvailable(this);
	}

	protected virtual void OnDisable()
	{
		Serialization.NotifyDependencyUnavailable(this);
	}

	public GraphPointer GetReference()
	{
		return reference;
	}
}
