using System;

namespace Oath;

[Serializable]
public class OathInteractionExecute : OathInteractionNode
{
	public int logicChildCount;

	private int currentCount;

	public override void InitEvent(OathInterationTreeNode treeNode)
	{
		base.InitEvent(treeNode);
		currentCount = 0;
	}

	public override void StartEvent()
	{
		base.IsFinish = true;
	}

	public override void AddChildEvent()
	{
		SequenceChildEvent();
		currentCount++;
	}

	public void SequenceChildEvent()
	{
		int index = currentCount % logicChildCount;
		OathInteractionBaseData oathInteractionBaseData = child[index];
		if (oathInteractionBaseData != null)
		{
			oathInteractionBaseData.InitData();
			OathSceneLoader.Scene.context.interationManager.character.eventContext.AddEvent(oathInteractionBaseData);
		}
	}
}
