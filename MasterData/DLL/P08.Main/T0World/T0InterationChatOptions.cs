using System;
using System.Text;

namespace T0World;

[Serializable]
public class T0InterationChatOptions : T0InterationBaseData
{
	public string tipskey;

	public int order;

	public override bool isNeedSDK => true;

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		Action callback = delegate
		{
			base.IsFinish = true;
			callback = null;
		};
		LuaHelper.CallFunction("T0WorldEmitterEvent", "T0_WORLD_SHOW_CHAT_OPTIONS", true, nodeID, tipskey, order, callback);
	}

	public override void DisposeEvent()
	{
		LuaHelper.CallFunction("T0WorldEmitterEvent", "T0_WORLD_SHOW_CHAT_OPTIONS", false, nodeID);
	}

	public override void FinishEvent(T0WorldInteractionBehavior behaviour)
	{
		LuaHelper.CallFunction("T0WorldEmitterEvent", "T0_WORLD_SHOW_CHAT_OPTIONS", false, nodeID);
	}

	public override void SendSDK(T0WorldInteractionBehavior behaviour)
	{
		int num = 0;
		foreach (T0InterationBaseData item in parent.child)
		{
			if (item.isNeedSDK)
			{
				num++;
			}
		}
		if (num <= 1)
		{
			return;
		}
		StringBuilder stringBuilder = new StringBuilder();
		foreach (T0InterationBaseData item2 in parent.child)
		{
			stringBuilder.Append(item2.nodeID);
			num--;
			if (num > 0)
			{
				stringBuilder.Append(",");
			}
		}
		if (behaviour.mAgent is T0CharacterAgent t0CharacterAgent)
		{
			_ = t0CharacterAgent.CharacterBoard.characterID;
		}
		T0SDKData baseSDKData = GetBaseSDKData();
		baseSDKData.select_list = stringBuilder.ToString();
		T0SDKSystem.SendSDKData(behaviour, baseSDKData);
	}
}
