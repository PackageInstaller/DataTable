using System;
using System.Text;

namespace Oath;

[Serializable]
public class OathInteractionBubble : OathInteractionNode
{
	public string tipskey;

	public string iconPath;

	public int order;

	public override bool MustNeedSDK => true;

	public override void StartEvent()
	{
		Action callback = delegate
		{
			base.IsFinish = true;
			callback = null;
		};
		LuaHelper.CallFunction("OathToLuaBridge.OathEmitterEvent", "OATH_SCENE_ADD_BUBBLE", true, nodeID, tipskey, iconPath, order, callback);
	}

	public override void DisposeEvent()
	{
		LuaHelper.CallFunction("OathToLuaBridge.OathEmitterEvent", "OATH_SCENE_ADD_BUBBLE", false, nodeID);
	}

	public override void FinishEvent()
	{
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
