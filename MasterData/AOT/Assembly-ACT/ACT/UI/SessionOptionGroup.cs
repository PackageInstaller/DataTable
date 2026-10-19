using System;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class SessionOptionGroup : MonoBehaviour
{
	[SerializeField]
	private SessionOptionComp[] options;

	private long _messageId;

	private int _sessionId;

	private Action<int> _selectOptionAction;

	public void Show(long messageId, int sessionId, Action<int> selectOptionAction)
	{
		gameObject.SetActive(value: true);
		_messageId = messageId;
		_sessionId = sessionId;
		_selectOptionAction = selectOptionAction;
		MessageConversation data = CoreUtils.GetData(messageId, RuntimeConfigs.data.messageConversations);
		for (int i = 0; i < options.Length; i++)
		{
			if (i < data.conversationParm.Length)
			{
				MessageChoose data2 = CoreUtils.GetData(data.conversationParm[i], RuntimeConfigs.data.messageChooses);
				if (data2 != null)
				{
					options[i].Init(data2, OnSelectOption);
					continue;
				}
				string message = $"SessionOptionComp.Init: messageChoose is null.chooseId is {data.conversationParm[i]}";
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(message);
				}
			}
			options[i].gameObject.SetActive(value: false);
		}
	}

	public void Hide()
	{
		gameObject.SetActive(value: false);
	}

	private void OnSelectOption(int optionId)
	{
		MessageConversation data = CoreUtils.GetData(_messageId, RuntimeConfigs.data.messageConversations);
		MessageConversationGroup data2 = CoreUtils.GetData(_sessionId, RuntimeConfigs.data.messageConversationGroups);
		int num = -1;
		for (int i = 0; i < data.conversationParm.Length; i++)
		{
			if (data.conversationParm[i] == optionId)
			{
				num = i;
				break;
			}
		}
		if (num != -1)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Message/Send");
			_selectOptionAction(num);
			SNSSessionChooseOptionEvt evt = Singleton<EventManager>.instance.GetEvt<SNSSessionChooseOptionEvt>();
			evt.sessionId = _sessionId;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.SNS_ChooseOption, evt);
			MessageEvent evt2 = EventTrackSolver.Instance.GetEvt<MessageEvent>();
			evt2.conversationCharacterId = data2.messageCharacterID;
			evt2.conversationType = data2.Type;
			evt2.conversationId = data2.id;
			evt2.conversationStatus = 1;
			evt2.messageId = _messageId;
			evt2.messageType = data.conversationType;
			evt2.messageChooseId = optionId;
			evt2.status = 2;
			EventTrackSolver.Instance.Dispatch(evt2);
		}
	}
}
