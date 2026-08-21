using System;
using System.Collections.Generic;

namespace GameFramework.DataNode;

internal sealed class DataNodeManager : GameFrameworkModule, IDataNodeManager
{
	private sealed class DataNode : IDataNode, IReference
	{
		private static readonly DataNode[] EmptyDataNodeArray = new DataNode[0];

		private string m_Name;

		private DataNodeVariable m_Data;

		private DataNode m_Parent;

		private List<DataNode> m_Childs;

		public string Name => m_Name;

		public string FullName => (m_Parent == null) ? m_Name : Utility.Text.Format("{0}{1}{2}", m_Parent.FullName, PathSplitSeparator[0], m_Name);

		public IDataNode Parent => m_Parent;

		public int ChildCount => (m_Childs != null) ? m_Childs.Count : 0;

		public DataNode()
		{
			m_Name = null;
			m_Data = null;
			m_Parent = null;
			m_Childs = null;
		}

		public static DataNode Create(string name, DataNode parent)
		{
			if (!IsValidName(name))
			{
				throw new GameFrameworkException("Name of data node is invalid.");
			}
			DataNode dataNode = ReferencePool.Acquire<DataNode>();
			dataNode.m_Name = name;
			dataNode.m_Parent = parent;
			return dataNode;
		}

		public T GetData<T>() where T : DataNodeVariable
		{
			return (T)m_Data;
		}

		public DataNodeVariable GetData()
		{
			return m_Data;
		}

		public void SetData<T>(T data) where T : DataNodeVariable
		{
			SetData((DataNodeVariable)data);
		}

		public void SetData(DataNodeVariable data)
		{
			if (m_Data != null)
			{
				ReferencePool.Release(m_Data);
			}
			m_Data = data;
		}

		public bool HasChild(int index)
		{
			return index >= 0 && index < ChildCount;
		}

		public bool HasChild(string name)
		{
			if (!IsValidName(name))
			{
				throw new GameFrameworkException("Name is invalid.");
			}
			if (m_Childs == null)
			{
				return false;
			}
			foreach (DataNode child in m_Childs)
			{
				if (child.Name == name)
				{
					return true;
				}
			}
			return false;
		}

		public IDataNode GetChild(int index)
		{
			return (index >= 0 && index < ChildCount) ? m_Childs[index] : null;
		}

		public IDataNode GetChild(string name)
		{
			if (!IsValidName(name))
			{
				throw new GameFrameworkException("Name is invalid.");
			}
			if (m_Childs == null)
			{
				return null;
			}
			foreach (DataNode child in m_Childs)
			{
				if (child.Name == name)
				{
					return child;
				}
			}
			return null;
		}

		public IDataNode GetOrAddChild(string name)
		{
			DataNode dataNode = (DataNode)GetChild(name);
			if (dataNode != null)
			{
				return dataNode;
			}
			dataNode = Create(name, this);
			if (m_Childs == null)
			{
				m_Childs = new List<DataNode>();
			}
			m_Childs.Add(dataNode);
			return dataNode;
		}

		public IDataNode[] GetAllChild()
		{
			if (m_Childs == null)
			{
				return EmptyDataNodeArray;
			}
			return m_Childs.ToArray();
		}

		public void GetAllChild(List<IDataNode> results)
		{
			if (results == null)
			{
				throw new GameFrameworkException("Results is invalid.");
			}
			results.Clear();
			if (m_Childs == null)
			{
				return;
			}
			foreach (DataNode child in m_Childs)
			{
				results.Add(child);
			}
		}

		public void RemoveChild(int index)
		{
			DataNode dataNode = (DataNode)GetChild(index);
			if (dataNode != null)
			{
				m_Childs.Remove(dataNode);
				ReferencePool.Release(dataNode);
			}
		}

		public void RemoveChild(string name)
		{
			DataNode dataNode = (DataNode)GetChild(name);
			if (dataNode != null)
			{
				m_Childs.Remove(dataNode);
				ReferencePool.Release(dataNode);
			}
		}

		public void Clear()
		{
			if (m_Data != null)
			{
				ReferencePool.Release(m_Data);
				m_Data = null;
			}
			if (m_Childs == null)
			{
				return;
			}
			foreach (DataNode child in m_Childs)
			{
				ReferencePool.Release(child);
			}
			m_Childs.Clear();
		}

		public override string ToString()
		{
			return Utility.Text.Format("{0}: {1}", FullName, ToDataString());
		}

		public string ToDataString()
		{
			if (m_Data == null)
			{
				return "<Null>";
			}
			return Utility.Text.Format("[{0}] {1}", m_Data.Type.Name, m_Data);
		}

		private static bool IsValidName(string name)
		{
			if (string.IsNullOrEmpty(name))
			{
				return false;
			}
			string[] pathSplitSeparator = PathSplitSeparator;
			foreach (string value in pathSplitSeparator)
			{
				if (name.Contains(value))
				{
					return false;
				}
			}
			return true;
		}

		void IReference.Clear()
		{
			m_Name = null;
			m_Parent = null;
			Clear();
		}
	}

	private static readonly string[] EmptyStringArray = new string[0];

	private static readonly string[] PathSplitSeparator = new string[3] { ".", "/", "\\" };

	private const string RootName = "<Root>";

	private DataNode m_Root;

	public IDataNode Root => m_Root;

	public DataNodeManager()
	{
		m_Root = DataNode.Create("<Root>", null);
	}

	internal override void Update(float elapseSeconds, float realElapseSeconds)
	{
	}

	internal override void Shutdown()
	{
		ReferencePool.Release(m_Root);
		m_Root = null;
	}

	public T GetData<T>(string path) where T : DataNodeVariable
	{
		return GetData<T>(path, null);
	}

	public DataNodeVariable GetData(string path)
	{
		return GetData(path, null);
	}

	public T GetData<T>(string path, IDataNode node) where T : DataNodeVariable
	{
		IDataNode node2 = GetNode(path, node);
		if (node2 == null)
		{
			throw new GameFrameworkException(Utility.Text.Format("Data node is not exist, path '{0}', node '{1}'.", path, (node != null) ? node.FullName : string.Empty));
		}
		return node2.GetData<T>();
	}

	public DataNodeVariable GetData(string path, IDataNode node)
	{
		IDataNode node2 = GetNode(path, node);
		if (node2 == null)
		{
			throw new GameFrameworkException(Utility.Text.Format("Data node is not exist, path '{0}', node '{1}'.", path, (node != null) ? node.FullName : string.Empty));
		}
		return node2.GetData();
	}

	public void SetData<T>(string path, T data) where T : DataNodeVariable
	{
		SetData(path, data, null);
	}

	public void SetData(string path, DataNodeVariable data)
	{
		SetData(path, data, null);
	}

	public void SetData<T>(string path, T data, IDataNode node) where T : DataNodeVariable
	{
		IDataNode orAddNode = GetOrAddNode(path, node);
		orAddNode.SetData(data);
	}

	public void SetData(string path, DataNodeVariable data, IDataNode node)
	{
		IDataNode orAddNode = GetOrAddNode(path, node);
		orAddNode.SetData(data);
	}

	public IDataNode GetNode(string path)
	{
		return GetNode(path, null);
	}

	public IDataNode GetNode(string path, IDataNode node)
	{
		IDataNode dataNode = node ?? m_Root;
		string[] splitedPath = GetSplitedPath(path);
		string[] array = splitedPath;
		foreach (string name in array)
		{
			dataNode = dataNode.GetChild(name);
			if (dataNode == null)
			{
				return null;
			}
		}
		return dataNode;
	}

	public IDataNode GetOrAddNode(string path)
	{
		return GetOrAddNode(path, null);
	}

	public IDataNode GetOrAddNode(string path, IDataNode node)
	{
		IDataNode dataNode = node ?? m_Root;
		string[] splitedPath = GetSplitedPath(path);
		string[] array = splitedPath;
		foreach (string name in array)
		{
			dataNode = dataNode.GetOrAddChild(name);
		}
		return dataNode;
	}

	public void RemoveNode(string path)
	{
		RemoveNode(path, null);
	}

	public void RemoveNode(string path, IDataNode node)
	{
		IDataNode dataNode = node ?? m_Root;
		IDataNode dataNode2 = dataNode.Parent;
		string[] splitedPath = GetSplitedPath(path);
		string[] array = splitedPath;
		foreach (string name in array)
		{
			dataNode2 = dataNode;
			dataNode = dataNode.GetChild(name);
			if (dataNode == null)
			{
				return;
			}
		}
		dataNode2?.RemoveChild(dataNode.Name);
	}

	public void Clear()
	{
		m_Root.Clear();
	}

	private static string[] GetSplitedPath(string path)
	{
		if (string.IsNullOrEmpty(path))
		{
			return EmptyStringArray;
		}
		return path.Split(PathSplitSeparator, StringSplitOptions.RemoveEmptyEntries);
	}
}
