using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.MissionSystem;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class SessionComp : MonoBehaviour
{
	[SerializeField]
	private BImage finishIcon;

	[SerializeField]
	private BImage sessionTypeIcon;

	[SerializeField]
	private LocalizeStringEvent sessionMessage;

	[SerializeField]
	private ActButton btn;

	[SerializeField]
	private RedDotItem redDot;

	[SerializeField]
	private Color finishedTextColor;

	[SerializeField]
	private Color unFinishedTextColor;

	[SerializeField]
	private GameObject selectedBoard;

	[SerializeField]
	private GameObject normalBoard;

	[SerializeField]
	private TextMeshProUGUI text;

	[SerializeField]
	private BetterAnimation _animation;

	private int _sessionId;

	private Color white = Color.white;

	private Color black = Color.black;

	private MessageConversation _message;

	private int _lastMessageIndex = -1;

	private ImageAssetStation _imageAssetStation;

	private string _redDotPath;

	private const int Main = 1;

	private const int other = 2;

	private const int person = 3;

	private const int Message = 4;

	private const int Gift = 5;

	private const int ChatWithHer = 2835;

	private const string SwitchShow = "SwitchShow";

	private const string Show = "Show";

	private const string Hide = "Hide";

	public ActButton Btn => btn;

	public int SessionId => _sessionId;

	public void Init(int sessionId, bool selected, ImageAssetStation station)
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SNS_UpdateLeftInfo, UpdateWhileTalking);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SNS_SelectLeftInfo, UpdateWhileSelected);
		_sessionId = sessionId;
		_imageAssetStation = station;
		SelectStatus(selected);
		SNSModel.SnsSession session = Model<SNSModel>.Interface.GetSession(_sessionId);
		_message = GetPreviewMessage(session);
		_lastMessageIndex = -1;
		_redDotPath = RedDotPathDefine.SNSMain + $"|{session.ContactsId}" + $"|{_sessionId}";
		if (redDot != null)
		{
			redDot.fullPath = _redDotPath.Split("|").ToList();
			redDot.BindTrieNode();
			redDot.UpdateDisplay();
		}
		Refresh();
	}

	public void UnInit()
	{
		_lastMessageIndex = -1;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SNS_UpdateLeftInfo, UpdateWhileTalking);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SNS_SelectLeftInfo, UpdateWhileSelected);
	}

	public void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SNS_UpdateLeftInfo, UpdateWhileTalking);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SNS_SelectLeftInfo, UpdateWhileSelected);
	}

	public bool Refresh()
	{
		bool flag = false;
		MessageConversationGroup data = CoreUtils.GetData(_sessionId, RuntimeConfigs.data.messageConversationGroups);
		if (data != null && data.ContentType == 4)
		{
			SNSModel.SnsSession session = Model<SNSModel>.Interface.GetSession(_sessionId);
			flag = session != null && _message != null && _message.nextConversation.Length == 0 && Model<SNSModel>.Interface.AreAllInteractionSessionsFinished(session.ContactsId);
			finishIcon.icon.gameObject.SetActive(flag);
			sessionTypeIcon.icon.gameObject.SetActive(!flag);
			LocalizeStringData localizeStringData = new LocalizeStringData(LocalizeTable.Common, 2835);
			if (localizeStringData != null)
			{
				sessionMessage.SetReference(localizeStringData);
			}
		}
		else
		{
			switch (_message.conversationType)
			{
			case 3:
			case 7:
			{
				flag = _message.nextConversation.Length == 0;
				finishIcon.icon.gameObject.SetActive(flag);
				sessionTypeIcon.icon.gameObject.SetActive(!flag);
				LocalizeStringData localizeStringData = new LocalizeStringData(LocalizeTable.MainStory, _message.content);
				if (localizeStringData != null)
				{
					sessionMessage.SetReference(localizeStringData);
				}
				break;
			}
			case 1:
			{
				flag = _message.nextConversation.Length == 0;
				finishIcon.icon.gameObject.SetActive(flag);
				sessionTypeIcon.icon.gameObject.SetActive(!flag);
				LocalizeStringData localizeStringData = new LocalizeStringData(LocalizeTable.MainStory, _message.content);
				if (localizeStringData != null)
				{
					sessionMessage.SetReference(localizeStringData);
				}
				break;
			}
			case 2:
			{
				flag = _message.nextConversation.Length == 0;
				finishIcon.icon.gameObject.SetActive(flag);
				sessionTypeIcon.icon.gameObject.SetActive(!flag);
				LocalizeStringData localizeStringData = new LocalizeStringData(LocalizeTable.MainStory, _message.content);
				if (localizeStringData != null)
				{
					sessionMessage.SetReference(localizeStringData);
				}
				break;
			}
			case 4:
			{
				int num = _message.conversationParm[0];
				MissionBase data3 = CoreUtils.GetData(num, RuntimeConfigs.data.missionBases);
				flag = Singleton<MissionManager>.instance.IsFinished(num) || _message.nextConversation.Length == 0;
				finishIcon.icon.gameObject.SetActive(flag);
				sessionTypeIcon.icon.gameObject.SetActive(!flag);
				LocalizeStringData localizeStringData = new LocalizeStringData(LocalizeTable.ShortCommon, data3.name);
				if (localizeStringData != null)
				{
					sessionMessage.SetReference(localizeStringData);
				}
				break;
			}
			case 6:
			{
				_imageAssetStation.LoadImage(147, 5, sessionTypeIcon);
				flag = _message.nextConversation.Length == 0;
				finishIcon.icon.gameObject.SetActive(flag);
				sessionTypeIcon.icon.gameObject.SetActive(!flag);
				List<Item> list = new List<Item>();
				foreach (ItemKv item2 in RuntimeConfigs.data.collections[_message.conversationParm[0]].certain)
				{
					Item item = new Item
					{
						Id = item2.id,
						Count = item2.count
					};
					list.Add(item);
				}
				if (list.Count > 0)
				{
					ItemData data2 = CoreUtils.GetData(list[0].Id, RuntimeConfigs.data.itemDatas);
					LocalizeStringData localizeStringData = new LocalizeStringData(LocalizeTable.ShortCommon, data2.nameLocal);
					if (localizeStringData != null)
					{
						sessionMessage.SetReference(localizeStringData);
					}
				}
				break;
			}
			}
		}
		if (flag)
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(_redDotPath, active: false);
		}
		redDot.UpdateDisplay();
		return flag;
	}

	public void UpdateWhileTalking(BaseEventContent obj)
	{
		if (!(obj is SNSSessionCompUpdateEvt sNSSessionCompUpdateEvt) || (_sessionId != sNSSessionCompUpdateEvt.sessionId && !Model<SNSModel>.Interface.IsSameInteractionDisplay(_sessionId, sNSSessionCompUpdateEvt.sessionId)))
		{
			return;
		}
		long messageId = sNSSessionCompUpdateEvt.messageId;
		MessageConversation data = CoreUtils.GetData(messageId, RuntimeConfigs.data.messageConversations);
		if (data == null)
		{
			return;
		}
		int messageIndex = GetMessageIndex(messageId);
		if (messageIndex < 0 || _lastMessageIndex <= messageIndex)
		{
			_message = data;
			if (messageIndex >= 0)
			{
				_lastMessageIndex = messageIndex;
			}
			if (Refresh())
			{
				SNSContactsViewUpdateEvt evt = Singleton<EventManager>.instance.GetEvt<SNSContactsViewUpdateEvt>();
				evt.sessionId = _sessionId;
				evt.needReset = true;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.SNS_UpdateContactView, evt);
			}
		}
	}

	public void UpdateWhileSelected(BaseEventContent obj)
	{
		if (obj is SNSSessionCompSelectUpdateEvt sNSSessionCompSelectUpdateEvt && _sessionId == sNSSessionCompSelectUpdateEvt.sessionId)
		{
			SNSModel.SnsSession session = Model<SNSModel>.Interface.GetSession(_sessionId);
			_message = GetPreviewMessage(session);
			_lastMessageIndex = -1;
			Refresh();
		}
	}

	private int GetMessageIndex(long messageId)
	{
		return Model<SNSModel>.Interface.GetSession(_sessionId)?.messages?.IndexOf(messageId) ?? (-1);
	}

	public void SetRedDot()
	{
		SNSModel.SnsSession session = Model<SNSModel>.Interface.GetSession(_sessionId);
		bool flag = session != null && (Model<SNSModel>.Interface.IsInteractionSession(_sessionId) ? Model<SNSModel>.Interface.AreAllInteractionSessionsFinished(session.ContactsId) : (session.GetSessionState() == SNSModel.SnsSession.SessionState.Finish));
		finishIcon.icon.gameObject.SetActive(flag);
		sessionTypeIcon.icon.gameObject.SetActive(!flag);
	}

	private static MessageConversation GetPreviewMessage(SNSModel.SnsSession session)
	{
		if (session == null)
		{
			return null;
		}
		if (Model<SNSModel>.Interface.IsInteractionSession(session.Id))
		{
			return Model<SNSModel>.Interface.GetInteractionPreviewSession(session.ContactsId)?.GetLatestMessage();
		}
		return session.GetLatestMessage();
	}

	public void PlayAnimation(bool selected)
	{
		SelectStatus(selected);
		_animation.GetSequence("SwitchShow").Play();
	}

	public void PlayInitAnimation(bool selected)
	{
		SelectStatus(selected);
		_animation.GetSequence("Show").Play();
	}

	private void SelectStatus(bool selected)
	{
		selectedBoard.SetActive(selected);
		normalBoard.SetActive(!selected);
		text.color = (selected ? finishedTextColor : unFinishedTextColor);
		sessionTypeIcon.icon.color = (selected ? black : white);
		finishIcon.icon.color = (selected ? black : white);
	}

	public void PlayUnInitAnimation()
	{
		_animation.GetSequence("Hide").Play();
	}
}
