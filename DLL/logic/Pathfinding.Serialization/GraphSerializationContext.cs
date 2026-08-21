using System;
using System.IO;
using UnityEngine;

namespace Pathfinding.Serialization;

public class GraphSerializationContext
{
	private readonly GraphNode[] id2NodeMapping;

	public readonly BinaryReader reader;

	public readonly BinaryWriter writer;

	public readonly uint graphIndex;

	public readonly GraphMeta meta;

	public GraphSerializationContext(BinaryReader reader, GraphNode[] id2NodeMapping, uint graphIndex, GraphMeta meta)
	{
		this.reader = reader;
		this.id2NodeMapping = id2NodeMapping;
		this.graphIndex = graphIndex;
		this.meta = meta;
	}

	public GraphSerializationContext(BinaryWriter writer)
	{
		this.writer = writer;
	}

	public void SerializeNodeReference(GraphNode node)
	{
		writer.Write(node?.NodeIndex ?? (-1));
	}

	public GraphNode DeserializeNodeReference()
	{
		int num = reader.ReadInt32();
		if (id2NodeMapping == null)
		{
			throw new Exception("Calling DeserializeNodeReference when serializing");
		}
		if (num == -1)
		{
			return null;
		}
		GraphNode graphNode = id2NodeMapping[num];
		if (graphNode == null)
		{
			throw new Exception("Invalid id (" + num + ")");
		}
		return graphNode;
	}

	public void SerializeVector3(Vector3 v)
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		writer.Write(v.x);
		writer.Write(v.y);
		writer.Write(v.z);
	}

	public Vector3 DeserializeVector3()
	{
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		return new Vector3(reader.ReadSingle(), reader.ReadSingle(), reader.ReadSingle());
	}

	public void SerializeInt3(Int3 v)
	{
		writer.Write(v.x);
		writer.Write(v.y);
		writer.Write(v.z);
	}

	public Int3 DeserializeInt3()
	{
		return new Int3(reader.ReadInt32(), reader.ReadInt32(), reader.ReadInt32());
	}

	public int DeserializeInt(int defaultValue)
	{
		if (reader.BaseStream.Position <= reader.BaseStream.Length - 4)
		{
			return reader.ReadInt32();
		}
		return defaultValue;
	}

	public float DeserializeFloat(float defaultValue)
	{
		if (reader.BaseStream.Position <= reader.BaseStream.Length - 4)
		{
			return reader.ReadSingle();
		}
		return defaultValue;
	}

	public Object DeserializeUnityObject()
	{
		int num = reader.ReadInt32();
		if (num == int.MaxValue)
		{
			return null;
		}
		string text = reader.ReadString();
		string text2 = reader.ReadString();
		string text3 = reader.ReadString();
		Type type = Type.GetType(text2);
		if (type == null)
		{
			Debug.LogError((object)("Could not find type '" + text2 + "'. Cannot deserialize Unity reference"));
			return null;
		}
		if (!string.IsNullOrEmpty(text3))
		{
			UnityReferenceHelper[] array = Object.FindObjectsOfType(typeof(UnityReferenceHelper)) as UnityReferenceHelper[];
			for (int i = 0; i < array.Length; i++)
			{
				if (array[i].GetGUID() == text3)
				{
					if (type == typeof(GameObject))
					{
						return (Object)(object)((Component)array[i]).gameObject;
					}
					return (Object)(object)((Component)array[i]).GetComponent(type);
				}
			}
		}
		Object[] array2 = Resources.LoadAll(text, type);
		for (int j = 0; j < array2.Length; j++)
		{
			if (array2[j].name == text || array2.Length == 1)
			{
				return array2[j];
			}
		}
		return null;
	}
}
