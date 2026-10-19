using System;
using ACT.Config;
using Bamboo.Precache;
using UnityEngine;

namespace ACT.Model.ChatBubbleModel;

public class RuntimeChatBubbleGroupData
{
	public int bubbleIndex;

	public float totalTime;

	public float currentTime;

	public float currentProcessingBubbleRemainTime;

	public Action onSingleBubbleShow;

	public Action onSingleBubbleHide;

	public Action<int> onSingleBubbleComplete;

	public Action onBubbleGroupComplete;

	public GameObject bubbleGameObject;

	public DialogueBubbleGroup dialogueBubbleGroupData;

	public DialogueBubbleContent dialogueBubbleContentData;

	public InstanceHandle bubbleInstanceHandle;

	public int BubbleGroupId => dialogueBubbleGroupData.id;

	public int CurrentProcessingBubbleId => dialogueBubbleContentData.id;

	public bool IsValide
	{
		get
		{
			if (dialogueBubbleContentData != null && dialogueBubbleGroupData != null)
			{
				return bubbleGameObject;
			}
			return false;
		}
	}
}
