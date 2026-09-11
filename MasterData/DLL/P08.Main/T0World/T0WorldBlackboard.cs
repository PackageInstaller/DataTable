using System.Collections.Generic;
using UnityEngine;

namespace T0World;

[DisallowMultipleComponent]
public class T0WorldBlackboard : MonoBehaviour, IT0WorldBlackboard
{
	[SerializeField]
	private int entityID;

	private T0InteractionEventContext eventContext;

	[SerializeField]
	public Dictionary<T0InterationTreeType, List<T0InterationTreeData>> interationList;

	public int EntityID
	{
		get
		{
			return entityID;
		}
		set
		{
			entityID = value;
		}
	}

	public T0InteractionEventContext EventContext
	{
		get
		{
			return eventContext;
		}
		set
		{
			eventContext = value;
		}
	}

	public void SetInterationData(List<T0InterationTreeData> treeList)
	{
		interationList = new Dictionary<T0InterationTreeType, List<T0InterationTreeData>>();
		for (int i = 0; i < treeList.Count; i++)
		{
			T0InterationTreeData t0InterationTreeData = treeList[i];
			if (!interationList.ContainsKey(t0InterationTreeData.interationType))
			{
				interationList.Add(t0InterationTreeData.interationType, new List<T0InterationTreeData>());
			}
			interationList[t0InterationTreeData.interationType].Add(t0InterationTreeData);
			for (int j = 0; j < t0InterationTreeData.treeNodeList.Count; j++)
			{
				T0InterationTreeNode t0InterationTreeNode = t0InterationTreeData.treeNodeList[j];
				t0InterationTreeNode.parentNode = null;
				t0InterationTreeNode.childNodeList = new List<T0InterationTreeNode>();
				for (int k = 0; k < t0InterationTreeData.treeNodeList.Count; k++)
				{
					int nodeID = t0InterationTreeData.treeNodeList[k].nodeID;
					if (nodeID == t0InterationTreeNode.parentTreeID)
					{
						t0InterationTreeNode.parentNode = t0InterationTreeData.treeNodeList[k];
					}
					for (int l = 0; l < t0InterationTreeNode.childTreeIDList.Count; l++)
					{
						if (t0InterationTreeNode.childTreeIDList[l] == nodeID)
						{
							if (t0InterationTreeNode.childNodeList.Count <= l)
							{
								t0InterationTreeNode.childNodeList.Add(t0InterationTreeData.treeNodeList[k]);
							}
							else
							{
								t0InterationTreeNode.childNodeList.Insert(l, t0InterationTreeData.treeNodeList[k]);
							}
						}
					}
				}
			}
		}
	}

	public virtual void InitBlackboard()
	{
		eventContext = new T0InteractionEventContext();
		eventContext.interationEventList = new List<T0InterationBaseData>();
	}

	public virtual void ResetBlackboard()
	{
	}

	public virtual void Dispose()
	{
		if (eventContext != null)
		{
			eventContext.interationEventList.Clear();
			eventContext.interationEventList = null;
		}
		eventContext = null;
	}
}
