#define ENABLE_FATAL_AND_ABOVE_LOG
using GameFramework.DataNode;
using UnityEngine;

namespace GameFramework.Runtime;

[AddComponentMenu("Game Framework/Data Node")]
[DisallowMultipleComponent]
public sealed class DataNodeComponent : GameFrameworkComponent
{
	private IDataNodeManager m_DataNodeManager = null;

	public IDataNode Root => m_DataNodeManager.Root;

	protected override void Awake()
	{
		base.Awake();
		m_DataNodeManager = GameFrameworkEntry.GetModule<IDataNodeManager>();
		if (m_DataNodeManager == null)
		{
			Log.Fatal("Data node manager is invalid.");
		}
	}

	private void Start()
	{
	}

	public T GetData<T>(string path) where T : DataNodeVariable
	{
		return m_DataNodeManager.GetData<T>(path);
	}

	public DataNodeVariable GetData(string path)
	{
		return m_DataNodeManager.GetData(path);
	}

	public T GetData<T>(string path, IDataNode node) where T : DataNodeVariable
	{
		return m_DataNodeManager.GetData<T>(path, node);
	}

	public DataNodeVariable GetData(string path, IDataNode node)
	{
		return m_DataNodeManager.GetData(path, node);
	}

	public void SetData<T>(string path, T data) where T : DataNodeVariable
	{
		m_DataNodeManager.SetData(path, data);
	}

	public void SetData(string path, DataNodeVariable data)
	{
		m_DataNodeManager.SetData(path, data);
	}

	public void SetData<T>(string path, T data, IDataNode node) where T : DataNodeVariable
	{
		m_DataNodeManager.SetData(path, data, node);
	}

	public void SetData(string path, DataNodeVariable data, IDataNode node)
	{
		m_DataNodeManager.SetData(path, data, node);
	}

	public IDataNode GetNode(string path)
	{
		return m_DataNodeManager.GetNode(path);
	}

	public IDataNode GetNode(string path, IDataNode node)
	{
		return m_DataNodeManager.GetNode(path, node);
	}

	public IDataNode GetOrAddNode(string path)
	{
		return m_DataNodeManager.GetOrAddNode(path);
	}

	public IDataNode GetOrAddNode(string path, IDataNode node)
	{
		return m_DataNodeManager.GetOrAddNode(path, node);
	}

	public void RemoveNode(string path)
	{
		m_DataNodeManager.RemoveNode(path);
	}

	public void RemoveNode(string path, IDataNode node)
	{
		m_DataNodeManager.RemoveNode(path, node);
	}

	public void Clear()
	{
		m_DataNodeManager.Clear();
	}
}
