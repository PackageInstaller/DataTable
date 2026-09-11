using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Pathfinding.Ionic.Zip;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding.Serialization;

public class AstarSerializer
{
	private AstarData data;

	private ZipFile zip;

	private MemoryStream zipStream;

	private GraphMeta meta;

	private SerializeSettings settings;

	private NavGraph[] graphs;

	private Dictionary<NavGraph, int> graphIndexInZip;

	private int graphIndexOffset;

	private const string binaryExt = ".binary";

	private const string jsonExt = ".json";

	private uint checksum = uint.MaxValue;

	private UTF8Encoding encoding = new UTF8Encoding();

	private static StringBuilder _stringBuilder = new StringBuilder();

	public static readonly Version V3_8_3 = new Version(3, 8, 3);

	public static readonly Version V3_9_0 = new Version(3, 9, 0);

	public static readonly Version V4_1_0 = new Version(4, 1, 0);

	private static StringBuilder GetStringBuilder()
	{
		_stringBuilder.Length = 0;
		return _stringBuilder;
	}

	public AstarSerializer(AstarData data)
	{
		this.data = data;
		settings = SerializeSettings.Settings;
	}

	public AstarSerializer(AstarData data, SerializeSettings settings)
	{
		this.data = data;
		this.settings = settings;
	}

	public void SetGraphIndexOffset(int offset)
	{
		graphIndexOffset = offset;
	}

	private void AddChecksum(byte[] bytes)
	{
		checksum = Pathfinding.Util.Checksum.GetChecksum(bytes, checksum);
	}

	private void AddEntry(string name, byte[] bytes)
	{
		zip.AddEntry(name, bytes);
	}

	public uint GetChecksum()
	{
		return checksum;
	}

	public void OpenSerialize()
	{
		zipStream = new MemoryStream();
		zip = new ZipFile();
		zip.AlternateEncoding = Encoding.UTF8;
		zip.AlternateEncodingUsage = ZipOption.Always;
		meta = new GraphMeta();
	}

	public byte[] CloseSerialize()
	{
		byte[] bytes = SerializeMeta();
		AddChecksum(bytes);
		AddEntry("meta.json", bytes);
		DateTime dateTime = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
		foreach (ZipEntry entry in zip.Entries)
		{
			entry.AccessedTime = dateTime;
			entry.CreationTime = dateTime;
			entry.LastModified = dateTime;
			entry.ModifiedTime = dateTime;
		}
		zip.Save(zipStream);
		zip.Dispose();
		bytes = zipStream.ToArray();
		zip = null;
		zipStream = null;
		return bytes;
	}

	public void SerializeGraphs(NavGraph[] _graphs)
	{
		if (graphs != null)
		{
			throw new InvalidOperationException("Cannot serialize graphs multiple times.");
		}
		graphs = _graphs;
		if (zip == null)
		{
			throw new NullReferenceException("You must not call CloseSerialize before a call to this function");
		}
		if (graphs == null)
		{
			graphs = new NavGraph[0];
		}
		for (int i = 0; i < graphs.Length; i++)
		{
			if (graphs[i] != null)
			{
				byte[] bytes = Serialize(graphs[i]);
				AddChecksum(bytes);
				AddEntry("graph" + i + ".json", bytes);
			}
		}
	}

	private byte[] SerializeMeta()
	{
		if (graphs == null)
		{
			throw new Exception("No call to SerializeGraphs has been done");
		}
		meta.version = AstarPath.Version;
		meta.graphs = graphs.Length;
		meta.guids = new List<string>();
		meta.typeNames = new List<string>();
		for (int i = 0; i < graphs.Length; i++)
		{
			if (graphs[i] != null)
			{
				meta.guids.Add(graphs[i].guid.ToString());
				meta.typeNames.Add(graphs[i].GetType().FullName);
			}
			else
			{
				meta.guids.Add(null);
				meta.typeNames.Add(null);
			}
		}
		StringBuilder stringBuilder = GetStringBuilder();
		TinyJsonSerializer.Serialize(meta, stringBuilder);
		return encoding.GetBytes(stringBuilder.ToString());
	}

	public byte[] Serialize(NavGraph graph)
	{
		StringBuilder stringBuilder = GetStringBuilder();
		TinyJsonSerializer.Serialize(graph, stringBuilder);
		return encoding.GetBytes(stringBuilder.ToString());
	}

	[Obsolete("Not used anymore. You can safely remove the call to this function.")]
	public void SerializeNodes()
	{
	}

	private static int GetMaxNodeIndexInAllGraphs(NavGraph[] graphs)
	{
		int maxIndex = 0;
		for (int i = 0; i < graphs.Length; i++)
		{
			if (graphs[i] == null)
			{
				continue;
			}
			graphs[i].GetNodes(delegate(GraphNode node)
			{
				maxIndex = Math.Max(node.NodeIndex, maxIndex);
				if (node.NodeIndex == -1)
				{
					Debug.LogError((object)"Graph contains destroyed nodes. This is a bug.");
				}
			});
		}
		return maxIndex;
	}

	private static byte[] SerializeNodeIndices(NavGraph[] graphs)
	{
		MemoryStream memoryStream = new MemoryStream();
		BinaryWriter writer = new BinaryWriter(memoryStream);
		int maxNodeIndexInAllGraphs = GetMaxNodeIndexInAllGraphs(graphs);
		writer.Write(maxNodeIndexInAllGraphs);
		int maxNodeIndex2 = 0;
		for (int i = 0; i < graphs.Length; i++)
		{
			if (graphs[i] != null)
			{
				graphs[i].GetNodes(delegate(GraphNode node)
				{
					maxNodeIndex2 = Math.Max(node.NodeIndex, maxNodeIndex2);
					writer.Write(node.NodeIndex);
				});
			}
		}
		if (maxNodeIndex2 != maxNodeIndexInAllGraphs)
		{
			throw new Exception("Some graphs are not consistent in their GetNodes calls, sequential calls give different results.");
		}
		byte[] result = memoryStream.ToArray();
		writer.Close();
		return result;
	}

	private static byte[] SerializeGraphExtraInfo(NavGraph graph)
	{
		MemoryStream memoryStream = new MemoryStream();
		BinaryWriter binaryWriter = new BinaryWriter(memoryStream);
		GraphSerializationContext ctx = new GraphSerializationContext(binaryWriter);
		graph.SerializeExtraInfo(ctx);
		byte[] result = memoryStream.ToArray();
		binaryWriter.Close();
		return result;
	}

	private static byte[] SerializeGraphNodeReferences(NavGraph graph)
	{
		MemoryStream memoryStream = new MemoryStream();
		BinaryWriter binaryWriter = new BinaryWriter(memoryStream);
		GraphSerializationContext ctx = new GraphSerializationContext(binaryWriter);
		graph.GetNodes(delegate(GraphNode node)
		{
			node.SerializeReferences(ctx);
		});
		binaryWriter.Close();
		return memoryStream.ToArray();
	}

	public void SerializeExtraInfo()
	{
		if (!settings.nodes)
		{
			return;
		}
		if (graphs == null)
		{
			throw new InvalidOperationException("Cannot serialize extra info with no serialized graphs (call SerializeGraphs first)");
		}
		byte[] bytes = SerializeNodeIndices(graphs);
		AddChecksum(bytes);
		AddEntry("graph_references.binary", bytes);
		for (int i = 0; i < graphs.Length; i++)
		{
			if (graphs[i] != null)
			{
				bytes = SerializeGraphExtraInfo(graphs[i]);
				AddChecksum(bytes);
				AddEntry("graph" + i + "_extra.binary", bytes);
				bytes = SerializeGraphNodeReferences(graphs[i]);
				AddChecksum(bytes);
				AddEntry("graph" + i + "_references.binary", bytes);
			}
		}
		bytes = SerializeNodeLinks();
		AddChecksum(bytes);
		AddEntry("node_link2.binary", bytes);
	}

	private byte[] SerializeNodeLinks()
	{
		MemoryStream memoryStream = new MemoryStream();
		BinaryWriter writer = new BinaryWriter(memoryStream);
		GraphSerializationContext ctx = new GraphSerializationContext(writer);
		NodeLink2.SerializeReferences(ctx);
		return memoryStream.ToArray();
	}

	public void SerializeEditorSettings(GraphEditorBase[] editors)
	{
		if (editors == null || !settings.editorSettings)
		{
			return;
		}
		for (int i = 0; i < editors.Length && editors[i] != null; i++)
		{
			StringBuilder stringBuilder = GetStringBuilder();
			TinyJsonSerializer.Serialize(editors[i], stringBuilder);
			byte[] bytes = encoding.GetBytes(stringBuilder.ToString());
			if (bytes.Length > 2)
			{
				AddChecksum(bytes);
				AddEntry("graph" + i + "_editor.json", bytes);
			}
		}
	}

	private ZipEntry GetEntry(string name)
	{
		return zip.get_Item(name);
	}

	private bool ContainsEntry(string name)
	{
		return GetEntry(name) != null;
	}

	public bool OpenDeserialize(byte[] bytes)
	{
		zipStream = new MemoryStream();
		zipStream.Write(bytes, 0, bytes.Length);
		zipStream.Position = 0L;
		try
		{
			zip = ZipFile.Read(zipStream);
		}
		catch (Exception ex)
		{
			Debug.LogError((object)("Caught exception when loading from zip\n" + ex));
			zipStream.Dispose();
			return false;
		}
		if (ContainsEntry("meta.json"))
		{
			meta = DeserializeMeta(GetEntry("meta.json"));
		}
		else
		{
			if (!ContainsEntry("meta.binary"))
			{
				throw new Exception("No metadata found in serialized data.");
			}
			meta = DeserializeBinaryMeta(GetEntry("meta.binary"));
		}
		if (FullyDefinedVersion(meta.version) > FullyDefinedVersion(AstarPath.Version))
		{
			Debug.LogWarning((object)("Trying to load data from a newer version of the A* Pathfinding Project\nCurrent version: " + AstarPath.Version?.ToString() + " Data version: " + meta.version?.ToString() + "\nThis is usually fine as the stored data is usually backwards and forwards compatible.\nHowever node data (not settings) can get corrupted between versions (even though I try my best to keep compatibility), so it is recommended to recalculate any caches (those for faster startup) and resave any files. Even if it seems to load fine, it might cause subtle bugs.\n"));
		}
		else if (FullyDefinedVersion(meta.version) < FullyDefinedVersion(AstarPath.Version))
		{
			Debug.LogWarning((object)("Upgrading serialized pathfinding data from version " + meta.version?.ToString() + " to " + AstarPath.Version?.ToString() + "\nThis is usually fine, it just means you have upgraded to a new version.\nHowever node data (not settings) can get corrupted between versions (even though I try my best to keep compatibility), so it is recommended to recalculate any caches (those for faster startup) and resave any files. Even if it seems to load fine, it might cause subtle bugs.\n"));
		}
		return true;
	}

	private static Version FullyDefinedVersion(Version v)
	{
		return new Version(Mathf.Max(v.Major, 0), Mathf.Max(v.Minor, 0), Mathf.Max(v.Build, 0), Mathf.Max(v.Revision, 0));
	}

	public void CloseDeserialize()
	{
		zipStream.Dispose();
		zip.Dispose();
		zip = null;
		zipStream = null;
	}

	private NavGraph DeserializeGraph(int zipIndex, int graphIndex)
	{
		Type graphType = meta.GetGraphType(zipIndex);
		if (object.Equals(graphType, null))
		{
			return null;
		}
		NavGraph navGraph = data.CreateGraph(graphType);
		navGraph.graphIndex = (uint)graphIndex;
		string name = "graph" + zipIndex + ".json";
		string name2 = "graph" + zipIndex + ".binary";
		if (ContainsEntry(name))
		{
			TinyJsonDeserializer.Deserialize(GetString(GetEntry(name)), graphType, navGraph);
		}
		else
		{
			if (!ContainsEntry(name2))
			{
				throw new FileNotFoundException("Could not find data for graph " + zipIndex + " in zip. Entry 'graph" + zipIndex + ".json' does not exist");
			}
			BinaryReader binaryReader = GetBinaryReader(GetEntry(name2));
			GraphSerializationContext ctx = new GraphSerializationContext(binaryReader, null, navGraph.graphIndex, meta);
			navGraph.DeserializeSettingsCompatibility(ctx);
		}
		if (navGraph.guid.ToString() != meta.guids[zipIndex])
		{
			Pathfinding.Util.Guid guid = navGraph.guid;
			throw new Exception("Guid in graph file not equal to guid defined in meta file. Have you edited the data manually?\n" + guid.ToString() + " != " + meta.guids[zipIndex]);
		}
		return navGraph;
	}

	public NavGraph[] DeserializeGraphs()
	{
		List<NavGraph> list = new List<NavGraph>();
		graphIndexInZip = new Dictionary<NavGraph, int>();
		for (int i = 0; i < meta.graphs; i++)
		{
			int graphIndex = list.Count + graphIndexOffset;
			NavGraph navGraph = DeserializeGraph(i, graphIndex);
			if (navGraph != null)
			{
				list.Add(navGraph);
				graphIndexInZip[navGraph] = i;
			}
		}
		graphs = list.ToArray();
		return graphs;
	}

	private bool DeserializeExtraInfo(NavGraph graph)
	{
		ZipEntry entry = GetEntry("graph" + graphIndexInZip[graph] + "_extra.binary");
		if (entry == null)
		{
			return false;
		}
		BinaryReader binaryReader = GetBinaryReader(entry);
		GraphSerializationContext ctx = new GraphSerializationContext(binaryReader, null, graph.graphIndex, meta);
		graph.DeserializeExtraInfo(ctx);
		return true;
	}

	private bool AnyDestroyedNodesInGraphs()
	{
		bool result = false;
		for (int i = 0; i < graphs.Length; i++)
		{
			graphs[i].GetNodes(delegate(GraphNode node)
			{
				if (node.Destroyed)
				{
					result = true;
				}
			});
		}
		return result;
	}

	private GraphNode[] DeserializeNodeReferenceMap()
	{
		ZipEntry entry = GetEntry("graph_references.binary");
		if (entry == null)
		{
			throw new Exception("Node references not found in the data. Was this loaded from an older version of the A* Pathfinding Project?");
		}
		BinaryReader reader = GetBinaryReader(entry);
		int num = reader.ReadInt32();
		GraphNode[] int2Node = new GraphNode[num + 1];
		try
		{
			for (int i = 0; i < graphs.Length; i++)
			{
				graphs[i].GetNodes(delegate(GraphNode node)
				{
					int num2 = reader.ReadInt32();
					int2Node[num2] = node;
				});
			}
		}
		catch (Exception innerException)
		{
			throw new Exception("Some graph(s) has thrown an exception during GetNodes, or some graph(s) have deserialized more or fewer nodes than were serialized", innerException);
		}
		if (reader.BaseStream.Position != reader.BaseStream.Length)
		{
			throw new Exception(reader.BaseStream.Length / 4 + " nodes were serialized, but only data for " + reader.BaseStream.Position / 4 + " nodes was found. The data looks corrupt.");
		}
		reader.Close();
		return int2Node;
	}

	private void DeserializeNodeReferences(NavGraph graph, GraphNode[] int2Node)
	{
		int num = graphIndexInZip[graph];
		ZipEntry entry = GetEntry("graph" + num + "_references.binary");
		if (entry == null)
		{
			throw new Exception("Node references for graph " + num + " not found in the data. Was this loaded from an older version of the A* Pathfinding Project?");
		}
		BinaryReader binaryReader = GetBinaryReader(entry);
		GraphSerializationContext ctx = new GraphSerializationContext(binaryReader, int2Node, graph.graphIndex, meta);
		graph.GetNodes(delegate(GraphNode node)
		{
			node.DeserializeReferences(ctx);
		});
	}

	public void DeserializeExtraInfo()
	{
		bool flag = false;
		for (int i = 0; i < graphs.Length; i++)
		{
			flag |= DeserializeExtraInfo(graphs[i]);
		}
		if (flag)
		{
			if (AnyDestroyedNodesInGraphs())
			{
				Debug.LogError((object)"Graph contains destroyed nodes. This is a bug.");
			}
			GraphNode[] int2Node = DeserializeNodeReferenceMap();
			for (int j = 0; j < graphs.Length; j++)
			{
				DeserializeNodeReferences(graphs[j], int2Node);
			}
			DeserializeNodeLinks(int2Node);
		}
	}

	private void DeserializeNodeLinks(GraphNode[] int2Node)
	{
		ZipEntry entry = GetEntry("node_link2.binary");
		if (entry != null)
		{
			BinaryReader binaryReader = GetBinaryReader(entry);
			GraphSerializationContext ctx = new GraphSerializationContext(binaryReader, int2Node, 0u, meta);
			NodeLink2.DeserializeReferences(ctx);
		}
	}

	public void PostDeserialization()
	{
		for (int i = 0; i < graphs.Length; i++)
		{
			graphs[i].PostDeserialization();
		}
	}

	public void DeserializeEditorSettings(GraphEditorBase[] graphEditors)
	{
		if (graphEditors == null)
		{
			return;
		}
		for (int i = 0; i < graphEditors.Length; i++)
		{
			if (graphEditors[i] == null)
			{
				continue;
			}
			for (int j = 0; j < graphs.Length; j++)
			{
				if (graphEditors[i].target == graphs[j])
				{
					ZipEntry entry = GetEntry("graph" + graphIndexInZip[graphs[j]] + "_editor.json");
					if (entry != null)
					{
						TinyJsonDeserializer.Deserialize(GetString(entry), graphEditors[i].GetType(), graphEditors[i]);
						break;
					}
				}
			}
		}
	}

	private static BinaryReader GetBinaryReader(ZipEntry entry)
	{
		MemoryStream memoryStream = new MemoryStream();
		entry.Extract(memoryStream);
		memoryStream.Position = 0L;
		return new BinaryReader(memoryStream);
	}

	private static string GetString(ZipEntry entry)
	{
		MemoryStream memoryStream = new MemoryStream();
		entry.Extract(memoryStream);
		memoryStream.Position = 0L;
		StreamReader streamReader = new StreamReader(memoryStream);
		string result = streamReader.ReadToEnd();
		streamReader.Dispose();
		return result;
	}

	private GraphMeta DeserializeMeta(ZipEntry entry)
	{
		return TinyJsonDeserializer.Deserialize(GetString(entry), typeof(GraphMeta)) as GraphMeta;
	}

	private GraphMeta DeserializeBinaryMeta(ZipEntry entry)
	{
		GraphMeta graphMeta = new GraphMeta();
		BinaryReader binaryReader = GetBinaryReader(entry);
		if (binaryReader.ReadString() != "A*")
		{
			throw new Exception("Invalid magic number in saved data");
		}
		int num = binaryReader.ReadInt32();
		int num2 = binaryReader.ReadInt32();
		int num3 = binaryReader.ReadInt32();
		int num4 = binaryReader.ReadInt32();
		if (num < 0)
		{
			graphMeta.version = new Version(0, 0);
		}
		else if (num2 < 0)
		{
			graphMeta.version = new Version(num, 0);
		}
		else if (num3 < 0)
		{
			graphMeta.version = new Version(num, num2);
		}
		else if (num4 < 0)
		{
			graphMeta.version = new Version(num, num2, num3);
		}
		else
		{
			graphMeta.version = new Version(num, num2, num3, num4);
		}
		graphMeta.graphs = binaryReader.ReadInt32();
		graphMeta.guids = new List<string>();
		int num5 = binaryReader.ReadInt32();
		for (int i = 0; i < num5; i++)
		{
			graphMeta.guids.Add(binaryReader.ReadString());
		}
		graphMeta.typeNames = new List<string>();
		num5 = binaryReader.ReadInt32();
		for (int j = 0; j < num5; j++)
		{
			graphMeta.typeNames.Add(binaryReader.ReadString());
		}
		return graphMeta;
	}

	public static void SaveToFile(string path, byte[] data)
	{
		using FileStream fileStream = new FileStream(path, FileMode.Create);
		fileStream.Write(data, 0, data.Length);
	}

	public static byte[] LoadFromFile(string path)
	{
		using FileStream fileStream = new FileStream(path, FileMode.Open);
		byte[] array = new byte[(int)fileStream.Length];
		fileStream.Read(array, 0, (int)fileStream.Length);
		return array;
	}
}
