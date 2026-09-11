using System;
using System.Collections.Generic;

namespace Oath;

[Serializable]
public class OathInteractionAndLogic : OathInteractionNode
{
	public List<OathInteractionBaseData> preConditionDataList;

	public List<int> preConditionNodeIDList;

	public void InitConditionEventList(List<OathInterationTreeNode> treeNodeList)
	{
		if (preConditionDataList == null)
		{
			preConditionDataList = new List<OathInteractionBaseData>();
		}
		else
		{
			preConditionDataList.Clear();
		}
		if (preConditionNodeIDList == null)
		{
			return;
		}
		foreach (int preConditionNodeID in preConditionNodeIDList)
		{
			foreach (OathInterationTreeNode treeNode in treeNodeList)
			{
				if (treeNode.nodeID == preConditionNodeID)
				{
					if (treeNode.interationData is OathInteractionBaseData item)
					{
						preConditionDataList.Add(item);
					}
					break;
				}
			}
		}
	}

	public override void StartEvent()
	{
	}

	public override void UpdateEvent()
	{
		if (preConditionDataList == null)
		{
			return;
		}
		foreach (OathInteractionBaseData preConditionData in preConditionDataList)
		{
			if (!preConditionData.IsFinish)
			{
				base.IsFinish = false;
				break;
			}
			base.IsFinish = true;
		}
	}
}
