using System.Collections.Generic;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.DialogueTrees;

[Category("SubGraphs")]
[Color("ffe4e1")]
public abstract class DTNodeNested<T> : DTNode, IGraphAssignable<T>, IGraphAssignable, IGraphElement where T : Graph
{
	[SerializeField]
	private List<BBMappingParameter> _variablesMap;

	[Name("冻帧是否影响行为树", 0)]
	public bool frozenFrameIsPauseTree;

	[SerializeField]
	public bool FrozenFrameIsPauseTree
	{
		get
		{
			return frozenFrameIsPauseTree;
		}
		set
		{
			frozenFrameIsPauseTree = value;
		}
	}

	public abstract T subGraph { get; set; }

	public abstract BBParameter subGraphParameter { get; }

	public T currentInstance { get; set; }

	public Dictionary<Graph, Graph> instances { get; set; }

	public List<BBMappingParameter> variablesMap
	{
		get
		{
			return _variablesMap;
		}
		set
		{
			_variablesMap = value;
		}
	}

	Graph IGraphAssignable.subGraph
	{
		get
		{
			return subGraph;
		}
		set
		{
			subGraph = (T)value;
		}
	}

	Graph IGraphAssignable.currentInstance
	{
		get
		{
			return currentInstance;
		}
		set
		{
			currentInstance = (T)value;
		}
	}
}
