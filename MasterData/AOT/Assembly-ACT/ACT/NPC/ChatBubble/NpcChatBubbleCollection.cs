using System;
using ACT.Condition.Interface;
using ACT.Core;
using ACT.Model.ChatBubbleModel;
using Sirenix.Serialization;

namespace ACT.NPC.ChatBubble;

[Serializable]
public class NpcChatBubbleCollection : IBubbleData
{
	[OdinSerialize]
	public float distanceToShowBubble = 10f;

	[OdinSerialize]
	public float distanceToHideBubble = 50f;

	[OdinSerialize]
	public int bubbleGroupId;

	[OdinSerialize]
	public NpcCondition condition = new NpcCondition();

	public bool IsLoop
	{
		get
		{
			if (RuntimeConfigs.data.dialogueBubbleGroups.TryGetValue(bubbleGroupId, out var value))
			{
				return value.bubbleLoop;
			}
			return false;
		}
	}

	public int BubbleGroupId => bubbleGroupId;

	public IValueChangeNotify Condition => condition;

	public NpcChatBubbleRuntime CreateRuntime()
	{
		return new NpcChatBubbleRuntime(this);
	}
}
