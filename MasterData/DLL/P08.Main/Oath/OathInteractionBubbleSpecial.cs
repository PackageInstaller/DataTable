using System;
using System.Collections.Generic;
using System.Text;

namespace Oath;

[Serializable]
public class OathInteractionBubbleSpecial : OathInteractionNode
{
	private int currentCount;

	public List<string> tipskeyList;

	public string iconPath;

	public int order;

	public override bool MustNeedSDK => true;

	public override void InitEvent(OathInterationTreeNode treeNode)
	{
		base.InitEvent(treeNode);
		currentCount = 0;
	}

	public override void StartEvent()
	{
		Action callback = delegate
		{
			base.IsFinish = true;
			callback = null;
		};
		LuaHelper.CallFunction("OathToLuaBridge.OathEmitterEvent", "OATH_SCENE_ADD_BUBBLE", true, nodeID, tipskeyList[currentCount % tipskeyList.Count], iconPath, order, callback, currentCount >= tipskeyList.Count);
	}

	public override void DisposeEvent()
	{
		LuaHelper.CallFunction("OathToLuaBridge.OathEmitterEvent", "OATH_SCENE_ADD_BUBBLE", false, nodeID);
	}

	public override void FinishEvent()
	{
		currentCount++;
		LuaHelper.CallFunction("OathToLuaBridge.OathEmitterEvent", "OATH_SCENE_ADD_BUBBLE", false, nodeID);
	}

	public override void SendSDK()
	{
		int num = 0;
		foreach (OathInteractionBaseData item in parent.child)
		{
			if (item.IsNeedSDK)
			{
				num++;
			}
		}
		if (num <= 1)
		{
			return;
		}
		StringBuilder stringBuilder = new StringBuilder();
		foreach (OathInteractionBaseData item2 in parent.child)
		{
			stringBuilder.Append(item2.nodeID);
			num--;
			if (num > 0)
			{
				stringBuilder.Append(",");
			}
		}
		LuaHelper.CallFunction("OathToLuaBridge.OathRecordSDK", nodeID, stringBuilder.ToString());
	}
}
