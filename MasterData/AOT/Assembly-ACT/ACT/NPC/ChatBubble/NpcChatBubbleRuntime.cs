using System;
using ACT.Config;
using ACT.Core;
using ACT.Model.ChatBubbleModel;
using UnityEngine.Events;

namespace ACT.NPC.ChatBubble;

public sealed class NpcChatBubbleRuntime
{
	private readonly IBubbleData _bubbleData;

	private IBubbleObject _bubbleObject;

	private UnityAction<bool> _onConditionValueChanged;

	private bool _conditionBound;

	public NpcChatBubbleCollection Config { get; }

	public bool IsInArea { get; private set; }

	public float DistanceToShow => _bubbleData?.DistanceToShow ?? 10f;

	public float DistanceToHide => _bubbleData?.DistanceToHide ?? 50f;

	public NpcChatBubbleRuntime(NpcChatBubbleCollection config)
	{
		Config = config;
		_bubbleData = config;
	}

	public void Bind(IBubbleObject bubbleObject)
	{
		if (IsInArea && _bubbleObject == bubbleObject)
		{
			return;
		}
		if (IsInArea)
		{
			Clear();
		}
		IsInArea = true;
		_bubbleObject = bubbleObject;
		NpcCondition npcCondition = Config?.condition;
		if (npcCondition != null)
		{
			if (_onConditionValueChanged == null)
			{
				_onConditionValueChanged = OnConditionValueChanged;
			}
			npcCondition.OnValueChanged += _onConditionValueChanged;
			npcCondition.BindRuntimeContext();
			_conditionBound = true;
			npcCondition.IsPassWithoutCache();
		}
	}

	public void Clear()
	{
		if (_conditionBound)
		{
			_conditionBound = false;
			NpcCondition npcCondition = Config?.condition;
			if (npcCondition != null)
			{
				npcCondition.OnValueChanged -= _onConditionValueChanged;
				npcCondition.FreeRuntimeContext();
			}
		}
		IsInArea = false;
		_bubbleObject = null;
	}

	private void OnConditionValueChanged(bool isMet)
	{
		if (!isMet || _bubbleObject == null || Config == null)
		{
			return;
		}
		DialogueBubbleGroup data = CoreUtils.GetData(Config.bubbleGroupId, RuntimeConfigs.data.dialogueBubbleGroups);
		if (data != null)
		{
			switch (data.bubbleClass)
			{
			case 1:
				_bubbleObject.StartBubbleGroup(Config.bubbleGroupId);
				break;
			case 2:
				_bubbleObject.StartMultiNpcBubbleGroup(Config.bubbleGroupId);
				break;
			default:
				throw new NotImplementedException();
			}
		}
	}
}
