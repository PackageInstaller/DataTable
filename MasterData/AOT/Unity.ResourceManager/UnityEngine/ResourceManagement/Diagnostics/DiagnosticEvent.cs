using System;
using System.Text;

namespace UnityEngine.ResourceManagement.Diagnostics;

[Serializable]
public struct DiagnosticEvent
{
	[SerializeField]
	private string m_Graph;

	[SerializeField]
	private int[] m_Dependencies;

	[SerializeField]
	private int m_ObjectId;

	[SerializeField]
	private string m_DisplayName;

	[SerializeField]
	private int m_Stream;

	[SerializeField]
	private int m_Frame;

	[SerializeField]
	private int m_Value;

	public string Graph => m_Graph;

	public int ObjectId => m_ObjectId;

	public string DisplayName => m_DisplayName;

	public int[] Dependencies => m_Dependencies;

	public int Stream => m_Stream;

	public int Frame => m_Frame;

	public int Value => m_Value;

	public DiagnosticEvent(string graph, string name, int id, int stream, int frame, int value, int[] deps)
	{
		m_Graph = graph;
		m_DisplayName = name;
		m_ObjectId = id;
		m_Stream = stream;
		m_Frame = frame;
		m_Value = value;
		m_Dependencies = deps;
	}

	internal byte[] Serialize()
	{
		return Encoding.ASCII.GetBytes(JsonUtility.ToJson(this));
	}

	public static DiagnosticEvent Deserialize(byte[] data)
	{
		return JsonUtility.FromJson<DiagnosticEvent>(Encoding.ASCII.GetString(data));
	}
}
