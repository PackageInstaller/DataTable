#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace ParadoxNotion.Services;

public class MonoManager : MonoBehaviour
{
	private static MonoManager _current;

	private Dictionary<string, Queue<Graph>> _oftenTree = new Dictionary<string, Queue<Graph>>();

	public static MonoManager current
	{
		get
		{
			if (_current == null)
			{
				_current = UnityEngine.Object.FindObjectOfType<MonoManager>();
				if (_current == null)
				{
					_current = new GameObject("_MonoManager").AddComponent<MonoManager>();
				}
			}
			return _current;
		}
	}

	protected void Awake()
	{
		if (_current != null && _current != this)
		{
			UnityEngine.Object.DestroyImmediate(base.gameObject);
			return;
		}
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
		_current = this;
	}

	public int CheckGraphInitialized(Graph originalGraph, int number)
	{
		if (originalGraph == null)
		{
			Log.Error("初始化行为树失败：行为树文件为空!");
			return -1;
		}
		if (_oftenTree.TryGetValue(originalGraph.name, out var value))
		{
			if (value.Count >= number)
			{
				return 0;
			}
			return number - value.Count;
		}
		return number;
	}

	public Graph GetInstance(Graph originalGraph, GraphOwner graphOwner)
	{
		if (originalGraph == null)
		{
			return null;
		}
		if (!Application.isPlaying)
		{
			return originalGraph;
		}
		if (!_oftenTree.TryGetValue(originalGraph.name, out var value))
		{
			value = new Queue<Graph>();
			GraphLoadData data = GraphLoadData.Creat(originalGraph, graphOwner, preInitializeSubGraphs: true);
			Graph graph = (Graph)ScriptableObject.CreateInstance(originalGraph.GetType());
			graph.name = originalGraph.name;
			graph.LoadOverwrite(data);
			value.Enqueue(graph);
			_oftenTree[originalGraph.name] = value;
			ErrorHint(originalGraph);
		}
		if (value.Count == 0)
		{
			GraphLoadData data2 = GraphLoadData.Creat(originalGraph, graphOwner, preInitializeSubGraphs: true);
			Graph graph2 = (Graph)ScriptableObject.CreateInstance(originalGraph.GetType());
			graph2.name = originalGraph.name;
			graph2.LoadOverwrite(data2);
			value.Enqueue(graph2);
			_oftenTree[originalGraph.name] = value;
			ErrorHint(originalGraph);
		}
		Graph graph3 = value.Dequeue();
		if (graph3.parentGraph != originalGraph.parentGraph)
		{
			graph3.parentGraph = originalGraph.parentGraph;
		}
		return graph3;
	}

	private void ErrorHint(Graph originalGraph)
	{
		_ = originalGraph == null;
	}

	public Graph GetEditorInstance(Graph originalGraph, GraphOwner graphOwner)
	{
		if (originalGraph == null)
		{
			return null;
		}
		if (!_oftenTree.TryGetValue(originalGraph.name, out var value))
		{
			value = new Queue<Graph>();
			GraphLoadData data = GraphLoadData.Creat(originalGraph, graphOwner, preInitializeSubGraphs: true);
			Graph graph = (Graph)ScriptableObject.CreateInstance(originalGraph.GetType());
			graph.name = originalGraph.name;
			graph.LoadOverwrite(data);
			value.Enqueue(graph);
			_oftenTree[originalGraph.name] = value;
		}
		if (value.Count == 0)
		{
			GraphLoadData data2 = GraphLoadData.Creat(originalGraph, graphOwner, preInitializeSubGraphs: true);
			Graph graph2 = (Graph)ScriptableObject.CreateInstance(originalGraph.GetType());
			graph2.name = originalGraph.name;
			graph2.LoadOverwrite(data2);
			value.Enqueue(graph2);
			_oftenTree[originalGraph.name] = value;
		}
		Graph graph3 = value.Dequeue();
		if (graph3.parentGraph != originalGraph.parentGraph)
		{
			graph3.parentGraph = originalGraph.parentGraph;
		}
		return graph3;
	}

	public void SetInstance(string graphName, Graph graphCopy)
	{
		if (_oftenTree.ContainsKey(graphCopy.name))
		{
			_oftenTree[graphName].Enqueue(graphCopy);
			return;
		}
		Queue<Graph> queue = new Queue<Graph>();
		queue.Enqueue(graphCopy);
		_oftenTree.Add(graphName, queue);
	}

	public void RecycleTree(Graph graphCopy, bool isReleaseGraph)
	{
		Queue<Graph> value;
		if (isReleaseGraph)
		{
			Release(graphCopy);
		}
		else if (_oftenTree.TryGetValue(graphCopy.name, out value))
		{
			value.Enqueue(graphCopy);
		}
	}

	public void ClearCache()
	{
		foreach (Queue<Graph> value in _oftenTree.Values)
		{
			foreach (Graph item in value)
			{
				Release(item);
			}
		}
		_oftenTree.Clear();
		JSONSerializer.ClearCache();
		GC.Collect();
	}

	private void Release(Graph graphCopy)
	{
		foreach (Graph allInstancedNestedGraph in graphCopy.GetAllInstancedNestedGraphs())
		{
			allInstancedNestedGraph.Clear();
			UnityEngine.Object.DestroyImmediate(allInstancedNestedGraph);
		}
		UnityEngine.Object.DestroyImmediate(graphCopy);
	}
}
