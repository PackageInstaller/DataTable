using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using Pathfinding.Serialization;
using Pathfinding.Util;
using Pathfinding.WindowsStore;
using UnityEngine;
using UnityEngine.Serialization;

namespace Pathfinding;

[Serializable]
public class AstarData
{
	[NonSerialized]
	public NavGraph[] graphs = new NavGraph[0];

	[SerializeField]
	private string dataString;

	[SerializeField]
	[FormerlySerializedAs("data")]
	private byte[] upgradeData;

	public byte[] data_backup;

	public byte[] data_cachedStartup;

	[SerializeField]
	public bool cacheStartup;

	private List<bool> graphStructureLocked = new List<bool>();

	public static AstarPath active => AstarPath.active;

	public NavMeshGraph navmesh { get; private set; }

	public GridGraph gridGraph { get; private set; }

	public LayerGridGraph layerGridGraph { get; private set; }

	public RecastGraph recastGraph { get; private set; }

	public Type[] graphTypes { get; private set; }

	private byte[] data
	{
		get
		{
			if (upgradeData != null && upgradeData.Length != 0)
			{
				data = upgradeData;
				upgradeData = null;
			}
			if (dataString == null)
			{
				return null;
			}
			return Convert.FromBase64String(dataString);
		}
		set
		{
			dataString = ((value != null) ? Convert.ToBase64String(value) : null);
		}
	}

	public byte[] GetData()
	{
		return data;
	}

	public void SetData(byte[] data)
	{
		this.data = data;
	}

	public void Awake()
	{
		graphs = new NavGraph[0];
		if (cacheStartup && data_cachedStartup != null)
		{
			LoadFromCache();
		}
		else
		{
			DeserializeGraphs();
		}
	}

	internal void LockGraphStructure(bool allowAddingGraphs = false)
	{
		graphStructureLocked.Add(allowAddingGraphs);
	}

	internal void UnlockGraphStructure()
	{
		if (graphStructureLocked.Count == 0)
		{
			throw new InvalidOperationException();
		}
		graphStructureLocked.RemoveAt(graphStructureLocked.Count - 1);
	}

	private PathProcessor.GraphUpdateLock AssertSafe(bool onlyAddingGraph = false)
	{
		if (graphStructureLocked.Count > 0)
		{
			bool flag = true;
			for (int i = 0; i < graphStructureLocked.Count; i++)
			{
				flag &= graphStructureLocked[i];
			}
			if (!(onlyAddingGraph & flag))
			{
				throw new InvalidOperationException("Graphs cannot be added, removed or serialized while the graph structure is locked. This is the case when a graph is currently being scanned and when executing graph updates and work items.\nHowever as a special case, graphs can be added inside work items.");
			}
		}
		PathProcessor.GraphUpdateLock result = active.PausePathfinding();
		if (!active.IsInsideWorkItem)
		{
			active.FlushWorkItems();
			active.pathReturnQueue.ReturnPaths(timeSlice: false);
		}
		return result;
	}

	public void UpdateShortcuts()
	{
		navmesh = (NavMeshGraph)FindGraphOfType(typeof(NavMeshGraph));
		gridGraph = (GridGraph)FindGraphOfType(typeof(GridGraph));
		layerGridGraph = (LayerGridGraph)FindGraphOfType(typeof(LayerGridGraph));
		recastGraph = (RecastGraph)FindGraphOfType(typeof(RecastGraph));
	}

	public void LoadFromCache()
	{
		PathProcessor.GraphUpdateLock graphUpdateLock = AssertSafe();
		if (data_cachedStartup != null)
		{
			DeserializeGraphs(data_cachedStartup);
			GraphModifier.TriggerEvent(GraphModifier.EventType.PostCacheLoad);
		}
		else
		{
			Debug.LogError((object)"Can't load from cache since the cache is empty");
		}
		graphUpdateLock.Release();
	}

	public byte[] SerializeGraphs()
	{
		return SerializeGraphs(SerializeSettings.Settings);
	}

	public byte[] SerializeGraphs(SerializeSettings settings)
	{
		uint checksum;
		return SerializeGraphs(settings, out checksum);
	}

	public byte[] SerializeGraphs(SerializeSettings settings, out uint checksum)
	{
		PathProcessor.GraphUpdateLock graphUpdateLock = AssertSafe();
		AstarSerializer astarSerializer = new AstarSerializer(this, settings);
		astarSerializer.OpenSerialize();
		SerializeGraphsPart(astarSerializer);
		byte[] result = astarSerializer.CloseSerialize();
		checksum = astarSerializer.GetChecksum();
		graphUpdateLock.Release();
		return result;
	}

	public void SerializeGraphsPart(AstarSerializer sr)
	{
		sr.SerializeGraphs(graphs);
		sr.SerializeExtraInfo();
	}

	public void DeserializeGraphs()
	{
		if (data != null)
		{
			DeserializeGraphs(data);
		}
	}

	private void ClearGraphs()
	{
		if (graphs == null)
		{
			return;
		}
		for (int i = 0; i < graphs.Length; i++)
		{
			if (graphs[i] != null)
			{
				graphs[i].OnDestroy();
				graphs[i].active = null;
			}
		}
		graphs = null;
		UpdateShortcuts();
	}

	public void OnDestroy()
	{
		ClearGraphs();
		if (navmesh != null)
		{
			Object.DestroyImmediate((Object)(object)navmesh.sourceMesh);
			navmesh.sourceMesh = null;
		}
	}

	public void DeserializeGraphs(byte[] bytes)
	{
		PathProcessor.GraphUpdateLock graphUpdateLock = AssertSafe();
		ClearGraphs();
		DeserializeGraphsAdditive(bytes);
		graphUpdateLock.Release();
	}

	public void DeserializeGraphsAdditive(byte[] bytes)
	{
		PathProcessor.GraphUpdateLock graphUpdateLock = AssertSafe();
		try
		{
			if (bytes == null)
			{
				throw new ArgumentNullException("bytes");
			}
			AstarSerializer astarSerializer = new AstarSerializer(this);
			if (astarSerializer.OpenDeserialize(bytes))
			{
				DeserializeGraphsPartAdditive(astarSerializer);
				astarSerializer.CloseDeserialize();
			}
			else
			{
				Debug.Log((object)"Invalid data file (cannot read zip).\nThe data is either corrupt or it was saved using a 3.0.x or earlier version of the system");
			}
			active.VerifyIntegrity();
		}
		catch (Exception ex)
		{
			Debug.LogError((object)("Caught exception while deserializing data.\n" + ex));
			graphs = new NavGraph[0];
			data_backup = bytes;
		}
		UpdateShortcuts();
		graphUpdateLock.Release();
	}

	public void DeserializeGraphsPart(AstarSerializer sr)
	{
		PathProcessor.GraphUpdateLock graphUpdateLock = AssertSafe();
		ClearGraphs();
		DeserializeGraphsPartAdditive(sr);
		graphUpdateLock.Release();
	}

	public void DeserializeGraphsPartAdditive(AstarSerializer sr)
	{
		if (graphs == null)
		{
			graphs = new NavGraph[0];
		}
		List<NavGraph> list = new List<NavGraph>(graphs);
		sr.SetGraphIndexOffset(list.Count);
		list.AddRange(sr.DeserializeGraphs());
		graphs = list.ToArray();
		sr.DeserializeExtraInfo();
		int i;
		for (i = 0; i < graphs.Length; i++)
		{
			if (graphs[i] != null)
			{
				graphs[i].GetNodes(delegate(GraphNode node)
				{
					node.GraphIndex = (uint)i;
				});
			}
		}
		for (int num = 0; num < graphs.Length; num++)
		{
			for (int num2 = num + 1; num2 < graphs.Length; num2++)
			{
				if (graphs[num] != null && graphs[num2] != null && graphs[num].guid == graphs[num2].guid)
				{
					Debug.LogWarning((object)"Guid Conflict when importing graphs additively. Imported graph will get a new Guid.\nThis message is (relatively) harmless.");
					graphs[num].guid = Pathfinding.Util.Guid.NewGuid();
					break;
				}
			}
		}
		sr.PostDeserialization();
	}

	public void FindGraphTypes()
	{
		Assembly assembly = WindowsStoreCompatibility.GetTypeInfo(typeof(AstarPath)).Assembly;
		Type[] types = assembly.GetTypes();
		List<Type> list = new List<Type>();
		Type[] array = types;
		foreach (Type type in array)
		{
			Type baseType = type.BaseType;
			while (baseType != null)
			{
				if (object.Equals(baseType, typeof(NavGraph)))
				{
					list.Add(type);
					break;
				}
				baseType = baseType.BaseType;
			}
		}
		graphTypes = list.ToArray();
	}

	[Obsolete("If really necessary. Use System.Type.GetType instead.")]
	public Type GetGraphType(string type)
	{
		for (int i = 0; i < graphTypes.Length; i++)
		{
			if (graphTypes[i].Name == type)
			{
				return graphTypes[i];
			}
		}
		return null;
	}

	[Obsolete("Use CreateGraph(System.Type) instead")]
	public NavGraph CreateGraph(string type)
	{
		Debug.Log((object)("Creating Graph of type '" + type + "'"));
		for (int i = 0; i < graphTypes.Length; i++)
		{
			if (graphTypes[i].Name == type)
			{
				return CreateGraph(graphTypes[i]);
			}
		}
		Debug.LogError((object)("Graph type (" + type + ") wasn't found"));
		return null;
	}

	internal NavGraph CreateGraph(Type type)
	{
		NavGraph navGraph = Activator.CreateInstance(type) as NavGraph;
		navGraph.active = active;
		return navGraph;
	}

	[Obsolete("Use AddGraph(System.Type) instead")]
	public NavGraph AddGraph(string type)
	{
		NavGraph navGraph = null;
		for (int i = 0; i < graphTypes.Length; i++)
		{
			if (graphTypes[i].Name == type)
			{
				navGraph = CreateGraph(graphTypes[i]);
			}
		}
		if (navGraph == null)
		{
			Debug.LogError((object)("No NavGraph of type '" + type + "' could be found"));
			return null;
		}
		AddGraph(navGraph);
		return navGraph;
	}

	public NavGraph AddGraph(Type type)
	{
		NavGraph navGraph = null;
		for (int i = 0; i < graphTypes.Length; i++)
		{
			if (object.Equals(graphTypes[i], type))
			{
				navGraph = CreateGraph(graphTypes[i]);
			}
		}
		if (navGraph == null)
		{
			Debug.LogError((object)("No NavGraph of type '" + type?.ToString() + "' could be found, " + graphTypes.Length + " graph types are avaliable"));
			return null;
		}
		AddGraph(navGraph);
		return navGraph;
	}

	private void AddGraph(NavGraph graph)
	{
		PathProcessor.GraphUpdateLock graphUpdateLock = AssertSafe(onlyAddingGraph: true);
		bool flag = false;
		for (int i = 0; i < graphs.Length; i++)
		{
			if (graphs[i] == null)
			{
				graphs[i] = graph;
				graph.graphIndex = (uint)i;
				flag = true;
				break;
			}
		}
		if (!flag)
		{
			if (graphs != null && (long)graphs.Length >= 255L)
			{
				throw new Exception("Graph Count Limit Reached. You cannot have more than " + 255u + " graphs.");
			}
			List<NavGraph> list = new List<NavGraph>(graphs ?? new NavGraph[0]);
			list.Add(graph);
			graphs = list.ToArray();
			graph.graphIndex = (uint)(graphs.Length - 1);
		}
		UpdateShortcuts();
		graph.active = active;
		graphUpdateLock.Release();
	}

	public bool RemoveGraph(NavGraph graph)
	{
		PathProcessor.GraphUpdateLock graphUpdateLock = AssertSafe();
		graph.OnDestroy();
		graph.active = null;
		int num = Array.IndexOf(graphs, graph);
		if (num != -1)
		{
			graphs[num] = null;
		}
		UpdateShortcuts();
		graphUpdateLock.Release();
		return num != -1;
	}

	public static NavGraph GetGraph(GraphNode node)
	{
		if (node == null)
		{
			return null;
		}
		AstarPath astarPath = AstarPath.active;
		if (astarPath == null)
		{
			return null;
		}
		AstarData astarData = astarPath.data;
		if (astarData == null || astarData.graphs == null)
		{
			return null;
		}
		uint graphIndex = node.GraphIndex;
		if (graphIndex >= astarData.graphs.Length)
		{
			return null;
		}
		return astarData.graphs[graphIndex];
	}

	public NavGraph FindGraphOfType(Type type)
	{
		if (graphs != null)
		{
			for (int i = 0; i < graphs.Length; i++)
			{
				if (graphs[i] != null && object.Equals(graphs[i].GetType(), type))
				{
					return graphs[i];
				}
			}
		}
		return null;
	}

	public IEnumerable FindGraphsOfType(Type type)
	{
		if (graphs == null)
		{
			yield break;
		}
		for (int i = 0; i < graphs.Length; i++)
		{
			if (graphs[i] != null && object.Equals(graphs[i].GetType(), type))
			{
				yield return graphs[i];
			}
		}
	}

	public IEnumerable GetUpdateableGraphs()
	{
		if (graphs == null)
		{
			yield break;
		}
		for (int i = 0; i < graphs.Length; i++)
		{
			if (graphs[i] is IUpdatableGraph)
			{
				yield return graphs[i];
			}
		}
	}

	[Obsolete("Obsolete because it is not used by the package internally and the use cases are few. Iterate through the graphs array instead.")]
	public IEnumerable GetRaycastableGraphs()
	{
		if (graphs == null)
		{
			yield break;
		}
		for (int i = 0; i < graphs.Length; i++)
		{
			if (graphs[i] is IRaycastableGraph)
			{
				yield return graphs[i];
			}
		}
	}

	public int GetGraphIndex(NavGraph graph)
	{
		if (graph == null)
		{
			throw new ArgumentNullException("graph");
		}
		int num = -1;
		if (graphs != null)
		{
			num = Array.IndexOf(graphs, graph);
			if (num == -1)
			{
				Debug.LogError((object)"Graph doesn't exist");
			}
		}
		return num;
	}
}
