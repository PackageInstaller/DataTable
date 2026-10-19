using System;
using ACT.Battle;
using ACT.Battle.ECS.System.SystemNPC;
using ACT.Config;
using ACT.Core;
using ACT.UI;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Model.ChatBubbleModel;

public static class ChatBubbleHelper
{
	public static void StartBubbleGroup(this IBubbleObject bubbleObject, int bubbleGroupId)
	{
		if (Model<ChatBubbleModel>.HasInstance())
		{
			Model<ChatBubbleModel>.Interface.StartBubbleGroup(bubbleObject, bubbleGroupId);
		}
	}

	public static void StopBubbleGroup(this IBubbleObject bubbleObject)
	{
		if (Model<ChatBubbleModel>.HasInstance())
		{
			Model<ChatBubbleModel>.Interface.StopBubbleGroup(bubbleObject);
		}
	}

	public static void StartMultiNpcBubbleGroup(this IBubbleObject bubbleObject, int bubbleGroupId)
	{
		if (!Model<ChatBubbleModel>.HasInstance())
		{
			return;
		}
		DialogueBubbleGroup bubbleGroupData = CoreUtils.GetData(bubbleGroupId, RuntimeConfigs.data.dialogueBubbleGroups);
		if (bubbleGroupData == null)
		{
			return;
		}
		int[] bubbleID = bubbleGroupData.bubbleID;
		for (int i = 0; i < bubbleID.Length; i++)
		{
			DialogueBubbleContent data = CoreUtils.GetData(bubbleID[i], RuntimeConfigs.data.dialogueBubbleContents);
			if (data != null)
			{
				int npcID = data.npcID;
				if (Singleton<RuntimeNpcManager>.instance.InstantiatedNpcDictionary.TryGetValue(npcID, out var value) && value.IsValid)
				{
					value.GetCompBubble().StopBubbleGroup();
				}
			}
		}
		IBubbleObject firstBubbleObject = GetBubbleObject(bubbleGroupData.bubbleID[0]) ?? bubbleObject;
		firstBubbleObject.StartBubbleGroup(bubbleGroupId);
		RuntimeChatBubbleGroupData runtimeChatBubbleGroupData = Model<ChatBubbleModel>.Interface.GetPlayingBubbleGroupData(firstBubbleObject);
		if (runtimeChatBubbleGroupData == null)
		{
			return;
		}
		RuntimeChatBubbleGroupData runtimeChatBubbleGroupData2 = runtimeChatBubbleGroupData;
		runtimeChatBubbleGroupData2.onSingleBubbleHide = (Action)Delegate.Combine(runtimeChatBubbleGroupData2.onSingleBubbleHide, (Action)(() =>
		{
			if (Model<ChatBubbleModel>.HasInstance() && Model<ChatBubbleModel>.Interface.GetPlayingBubbleGroupData(firstBubbleObject) == runtimeChatBubbleGroupData)
			{
				GameObject bubbleGameObject = runtimeChatBubbleGroupData.bubbleGameObject;
				if ((bool)bubbleGameObject)
				{
					MonoChatBubble component = bubbleGameObject.GetComponent<MonoChatBubble>();
					if ((bool)component)
					{
						int num = (runtimeChatBubbleGroupData.bubbleIndex + 1) % bubbleGroupData.bubbleID.Length;
						IBubbleObject bubbleObject2 = GetBubbleObject(bubbleGroupData.bubbleID[num]);
						if (bubbleObject2 != null)
						{
							component.BindBubbleObject(bubbleObject2);
						}
					}
				}
			}
		}));
	}

	private static IBubbleObject GetBubbleObject(int bubbleContentId)
	{
		DialogueBubbleContent data = CoreUtils.GetData(bubbleContentId, RuntimeConfigs.data.dialogueBubbleContents);
		if (data == null)
		{
			return null;
		}
		if (!Singleton<RuntimeNpcManager>.instance.InstantiatedNpcDictionary.TryGetValue(data.npcID, out var value) || !value.IsValid || !value.TryGetCompBubble(out CompBubble component))
		{
			return null;
		}
		return component;
	}
}
