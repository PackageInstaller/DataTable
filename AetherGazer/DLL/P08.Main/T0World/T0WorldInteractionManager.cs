using System.Collections.Generic;

namespace T0World;

public class T0WorldInteractionManager
{
	private T0InterationMgrContext interactContext;

	private Dictionary<int, bool> nodeDataIsRegisterDict;

	public T0InterationMgrContext InteractContext
	{
		get
		{
			return interactContext;
		}
		set
		{
			interactContext = value;
		}
	}

	public void RegisterEvent(T0InterationTreeData treeData)
	{
		for (int i = 0; i < treeData.treeNodeList.Count; i++)
		{
			(treeData.treeNodeList[i].interationData as T0InterationBaseData).InitEvent(treeData.treeNodeList[i]);
		}
		(treeData.treeNodeList[treeData.beginTreeNodeIndex - 1].interationData as T0InterationBaseData).AddAgentEvent();
	}

	public void RegisterNodeDataBegin(T0InterationTreeNode nodeData)
	{
		if (nodeDataIsRegisterDict == null)
		{
			nodeDataIsRegisterDict = new Dictionary<int, bool>();
		}
		nodeDataIsRegisterDict.Clear();
		RegisterNodeData(nodeData);
		(nodeData.interationData as T0InterationBaseData).AddAgentEvent();
	}

	public void RegisterNodeData(T0InterationTreeNode nodeData)
	{
		if (nodeDataIsRegisterDict.ContainsKey(nodeData.nodeID))
		{
			return;
		}
		nodeDataIsRegisterDict.Add(nodeData.nodeID, value: true);
		(nodeData.interationData as T0InterationBaseData).InitEvent(nodeData);
		if (nodeData.childNodeList.Count <= 0)
		{
			return;
		}
		foreach (T0InterationTreeNode childNode in nodeData.childNodeList)
		{
			RegisterNodeData(childNode);
		}
	}

	public void Init()
	{
		if (InteractContext == null)
		{
			InteractContext = new T0InterationMgrContext();
		}
	}

	public void Dispose()
	{
		InteractContext?.ClearFocusEvent();
		InteractContext = null;
	}

	public void TriggerTargetInteraction(int treeID, int nodeID)
	{
		foreach (T0WorldAgent agent in T0WorldScene.Scene.agentManager.agents)
		{
			if (!(agent.Blackboard != null) || agent.Blackboard.interationList == null)
			{
				continue;
			}
			foreach (List<T0InterationTreeData> value in agent.Blackboard.interationList.Values)
			{
				foreach (T0InterationTreeData item in value)
				{
					if (item.treeID != treeID)
					{
						continue;
					}
					for (int i = 0; i < item.treeNodeList.Count; i++)
					{
						if (item.treeNodeList[i].nodeID == nodeID)
						{
							RegisterNodeDataBegin(item.treeNodeList[i]);
							break;
						}
					}
				}
			}
		}
	}
}
