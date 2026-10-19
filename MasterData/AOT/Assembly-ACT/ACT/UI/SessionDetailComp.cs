using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Model;
using ACT.Utility;
using Bamboo.Chronos;
using Bamboo.Command;
using Bamboo.HeartBeat;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class SessionDetailComp : MonoBehaviour
{
	private sealed class ShowMessageAssignment : DurativeAssignment
	{
		private SNSSessionOSA _sessionOsa;

		private long _messageId;

		private int _sessionId;

		private Delayer _finishDelay;

		public ShowMessageAssignment(SNSSessionOSA sessionOsa, long messageId, int sessionId)
		{
			_sessionOsa = sessionOsa;
			_messageId = messageId;
			_sessionId = sessionId;
		}

		protected override void OnEnter()
		{
			_sessionOsa.InsertNewMessage(_messageId, _sessionId, out var extraDelay);
			_finishDelay = UpdateTimer.Default.DelayMs(1500 + extraDelay, OnNewMessageShowFinish);
		}

		protected override void OnUpdate(int delta)
		{
		}

		protected override void OnExit()
		{
			if (_finishDelay.IsValid())
			{
				_finishDelay.Cancel();
			}
		}

		public override void ForceExecute()
		{
			if (_finishDelay.IsValid())
			{
				_finishDelay.Cancel();
			}
			_finishDelay = UpdateTimer.Default.DelayMs(66, OnNewMessageShowFinish);
		}

		private void OnNewMessageShowFinish()
		{
			Release();
		}
	}

	private sealed class ShowOptionAssignment : OnceAssignment
	{
		private SNSSessionOSA _sessionOsa;

		private long _choiceMessageId;

		private Action<long> _showOptionAction;

		public ShowOptionAssignment(SNSSessionOSA sessionOsa, long choiceMessageId, Action<long> showOptionAction)
		{
			_sessionOsa = sessionOsa;
			_choiceMessageId = choiceMessageId;
			_showOptionAction = showOptionAction;
		}

		protected override void OnExecute()
		{
			_showOptionAction(_choiceMessageId);
		}
	}

	[SerializeField]
	public LocalizeStringEvent nameLocalize;

	[SerializeField]
	public LocalizeStringEvent signatureLocalize;

	[SerializeField]
	public SNSSessionOSA sessionOsa;

	[SerializeField]
	public SessionOptionGroup optionGroup;

	[SerializeField]
	public TextMeshProUGUI signatureTxt;

	public int _sessionId;

	private Worker _worker;

	private List<int> _imageIds = new List<int>();

	public void Init(SNSModel.SnsSession session, ImageAssetStation imageAssetStation)
	{
		if (session.Id != _sessionId)
		{
			_sessionId = session.Id;
			_worker = new Worker(BaseDriver<UpdateTimeDriver>.Instance.Common);
			_worker.Active();
			SNSModel.SnsContacts contacts = Model<SNSModel>.Interface.GetContacts(session.ContactsId);
			nameLocalize.SetReference(contacts.Name);
			if (contacts.Signature.Id == 0)
			{
				signatureLocalize.enabled = false;
				signatureTxt.text = "";
			}
			else
			{
				signatureLocalize.enabled = true;
				signatureLocalize.SetReference(contacts.Signature);
			}
			sessionOsa.Reload(session, imageAssetStation);
			SNSModel.SnsSession snsSession = (Model<SNSModel>.Interface.IsInteractionSession(session.Id) ? Model<SNSModel>.Interface.GetInteractionPreviewSession(session.ContactsId) : session);
			if (snsSession != null && snsSession.WaitChoice)
			{
				optionGroup.Show(snsSession.ChoiceMessageId, _sessionId, SelectOption);
				sessionOsa.OnOptionShow();
			}
			else
			{
				optionGroup.Hide();
				sessionOsa.OnOptionHide();
			}
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.SNS_ContinueSession, OnContinueSession);
		}
	}

	public void GamePadOpenImageViewList()
	{
		if (sessionOsa.data.Count == 0)
		{
			return;
		}
		_imageIds.Clear();
		for (int i = 0; i < sessionOsa.data.Count; i++)
		{
			if (sessionOsa.data[i] is SNSSessionOSA.ImageMessageModel imageMessageModel)
			{
				MessageConversation data = CoreUtils.GetData(imageMessageModel.MessageId, RuntimeConfigs.data.messageConversations);
				_imageIds.Add(data.conversationParm[0]);
			}
		}
		if (_imageIds.Count != 0)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPIMAGEVIEW, new PopUpImageViewBaseViewData
			{
				imageIds = _imageIds
			});
		}
	}

	public void GamePadOpenMission()
	{
		if (sessionOsa.data.Count == 0)
		{
			return;
		}
		for (int i = 0; i < sessionOsa.data.Count; i++)
		{
			if (sessionOsa.data[i] is SNSSessionOSA.MissionMessageModel model)
			{
				sessionOsa.OnClickMission(model);
				break;
			}
		}
	}

	public void UnInit()
	{
		_sessionId = 0;
		_worker?.Unactive();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SNS_ContinueSession, OnContinueSession);
	}

	private void OnDestroy()
	{
		UnInit();
	}

	public void HideOptionGroup()
	{
		optionGroup.Hide();
	}

	private void ShowOptionGroup(long choiceMessageId)
	{
		optionGroup.Show(choiceMessageId, _sessionId, SelectOption);
		sessionOsa.OnOptionShow();
	}

	public void SelectOption(int selectOptionIndex)
	{
		G.service.ContactChooseOption(Model<SNSModel>.Interface.ResolveSessionId(_sessionId), selectOptionIndex, (bool b) =>
		{
			if (b)
			{
				optionGroup.Hide();
				sessionOsa.OnOptionHide();
			}
		});
	}

	public void OnContinueSession(BaseEventContent content)
	{
		if (!(content is SNSContinueSessionEvt sNSContinueSessionEvt))
		{
			return;
		}
		MessageConversationGroup data = CoreUtils.GetData(sNSContinueSessionEvt.sessionId, RuntimeConfigs.data.messageConversationGroups);
		bool flag = data != null && data.ContentType == 4;
		if (sNSContinueSessionEvt.sessionId != _sessionId && !flag)
		{
			return;
		}
		SerialAssignmentGroup serialAssignmentGroup = new SerialAssignmentGroup();
		foreach (long messageId in sNSContinueSessionEvt.messageIds)
		{
			serialAssignmentGroup.Add(new ShowMessageAssignment(sessionOsa, messageId, _sessionId));
		}
		if (sNSContinueSessionEvt.waitChoice)
		{
			serialAssignmentGroup.Add(new ShowOptionAssignment(sessionOsa, sNSContinueSessionEvt.choiceMessageId, ShowOptionGroup));
		}
		_worker.Accept(serialAssignmentGroup);
	}

	public void QuickContinueSession()
	{
		if (_worker != null && !optionGroup.gameObject.activeSelf && _worker.ExecutingAssignment != null && _worker.ExecutingAssignment is SerialAssignmentGroup serialAssignmentGroup)
		{
			serialAssignmentGroup.ForceNewMessageShow();
		}
	}
}
