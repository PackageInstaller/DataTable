using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.MissionSystem;
using ACT.UI;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Pb;
using UnityEngine;

namespace ACT.Model;

public class SNSModel : Model<SNSModel>
{
	public class SnsContacts
	{
		public enum ContactState
		{
			AllFinish,
			OnGoing,
			NewReceive
		}

		public struct SessionInfo
		{
			public int SessionId;

			public SnsSession.SessionState State;

			public int SessionTimeStamp;
		}

		public class SessionInfosSorter : IComparer<SessionInfo>
		{
			public static class StatusPriority
			{
				public static int GetPriority(SnsSession.SessionState status)
				{
					return status switch
					{
						SnsSession.SessionState.NewReceive => 0, 
						SnsSession.SessionState.OnGoing => 1, 
						SnsSession.SessionState.Finish => 2, 
						_ => int.MaxValue, 
					};
				}
			}

			public int Compare(SessionInfo x, SessionInfo y)
			{
				int priority = StatusPriority.GetPriority(x.State);
				int priority2 = StatusPriority.GetPriority(y.State);
				int num = priority.CompareTo(priority2);
				if (num != 0)
				{
					return num;
				}
				MessageConversationGroup data = CoreUtils.GetData(x.SessionId, RuntimeConfigs.data.messageConversationGroups);
				MessageConversationGroup data2 = CoreUtils.GetData(y.SessionId, RuntimeConfigs.data.messageConversationGroups);
				int contentType = data.ContentType;
				int num2 = contentType.CompareTo(data2.ContentType);
				if (num2 != 0)
				{
					return num2;
				}
				return y.SessionTimeStamp.CompareTo(x.SessionTimeStamp);
			}
		}

		public int Id { get; }

		public LocalizeStringData Name { get; }

		public GroupImageData Icon { get; }

		public LocalizeStringData Signature { get; }

		public List<SessionInfo> SessionInfos { get; set; }

		public List<int> _OrderedSessionId { get; set; }

		public int LatestSessionTimeStamp { get; private set; }

		public ContactState Contactstate { get; private set; }

		public SnsContacts(MessageCharacterData characterData, SnsSession session)
		{
			Id = characterData.id;
			Name = new LocalizeStringData(LocalizeTable.ShortCommon, characterData.characterName);
			Icon = new GroupImageData(126, characterData.characterIcon);
			Signature = new LocalizeStringData(LocalizeTable.LongCommon, characterData.characterDes);
			SessionInfos = new List<SessionInfo>();
			_OrderedSessionId = new List<int>();
			AddSessionInfo(session);
			LatestSessionTimeStamp = session.GenerateTimeStamp;
			switch (session.GetSessionState())
			{
			case SnsSession.SessionState.Finish:
				Contactstate = ContactState.AllFinish;
				break;
			case SnsSession.SessionState.OnGoing:
				Contactstate = ContactState.OnGoing;
				break;
			case SnsSession.SessionState.NewReceive:
				Contactstate = ContactState.NewReceive;
				break;
			}
		}

		public void AddSessionInfo(SnsSession session)
		{
			foreach (SessionInfo sessionInfo in SessionInfos)
			{
				if (sessionInfo.SessionId == session.Id)
				{
					return;
				}
			}
			SessionInfo item = new SessionInfo
			{
				SessionId = session.Id,
				State = session.GetSessionState(),
				SessionTimeStamp = session.UpdateTimeStamp
			};
			SessionInfos.Add(item);
		}

		public void UpdateSessionInfo(SnsSession session)
		{
			int num = SessionInfos.FindIndex((SessionInfo s) => s.SessionId == session.Id);
			if (num != -1)
			{
				SessionInfo value = SessionInfos[num];
				value.State = session.GetSessionState();
				value.SessionTimeStamp = session.UpdateTimeStamp;
				SessionInfos[num] = value;
			}
		}

		public void ResetEverySession()
		{
			List<SessionInfo> list = new List<SessionInfo>();
			foreach (SessionInfo sessionInfo in SessionInfos)
			{
				Model<SNSModel>.Interface.GetSession(sessionInfo.SessionId).needShiftToTop = false;
				list.Add(new SessionInfo
				{
					SessionId = sessionInfo.SessionId,
					SessionTimeStamp = sessionInfo.SessionTimeStamp,
					State = Model<SNSModel>.Interface.GetSession(sessionInfo.SessionId).GetSessionState()
				});
			}
			SessionInfos = list;
		}

		public void SortSessions(bool needReset)
		{
			if (_OrderedSessionId.Count > 0)
			{
				_OrderedSessionId.Clear();
			}
			if (needReset)
			{
				ResetEverySession();
			}
			SessionInfos.Sort(new SessionInfosSorter());
			int num = int.MinValue;
			int num2 = int.MinValue;
			int num3 = int.MinValue;
			bool flag = false;
			for (int i = 0; i < SessionInfos.Count; i++)
			{
				SessionInfo sessionInfo = SessionInfos[i];
				SnsSession session = Model<SNSModel>.Interface.GetSession(sessionInfo.SessionId);
				bool flag2 = true;
				if (session != null && Model<SNSModel>.Interface.IsInteractionSession(sessionInfo.SessionId))
				{
					if (flag)
					{
						flag2 = false;
					}
					else
					{
						int interactionDisplaySessionId = Model<SNSModel>.Interface.GetInteractionDisplaySessionId(Id);
						if (interactionDisplaySessionId >= 0)
						{
							_OrderedSessionId.Add(interactionDisplaySessionId);
							flag = true;
						}
						else
						{
							flag2 = false;
						}
					}
				}
				if (flag2 && (session == null || !Model<SNSModel>.Interface.IsInteractionSession(sessionInfo.SessionId)))
				{
					_OrderedSessionId.Add(sessionInfo.SessionId);
				}
				switch ((SnsSession.SessionState)((session == null || !Model<SNSModel>.Interface.IsInteractionSession(session.Id)) ? ((int)sessionInfo.State) : ((!Model<SNSModel>.Interface.IsFinishedConversation(session)) ? 1 : 0)))
				{
				case SnsSession.SessionState.OnGoing:
					if (sessionInfo.SessionTimeStamp > num)
					{
						num = sessionInfo.SessionTimeStamp;
					}
					break;
				case SnsSession.SessionState.NewReceive:
					if (sessionInfo.SessionTimeStamp > num2)
					{
						num2 = sessionInfo.SessionTimeStamp;
					}
					break;
				case SnsSession.SessionState.Finish:
					if (sessionInfo.SessionTimeStamp > num3)
					{
						num3 = sessionInfo.SessionTimeStamp;
					}
					break;
				}
			}
			if (num != int.MinValue)
			{
				Contactstate = ContactState.OnGoing;
				LatestSessionTimeStamp = num;
			}
			else if (num2 != int.MinValue)
			{
				Contactstate = ContactState.NewReceive;
				LatestSessionTimeStamp = num2;
			}
			else if (num3 != int.MinValue)
			{
				Contactstate = ContactState.AllFinish;
				LatestSessionTimeStamp = num3;
			}
		}
	}

	public class SnsSession
	{
		public enum SessionState
		{
			Finish,
			OnGoing,
			NewReceive
		}

		public SessionState _SessionState;

		public int Id { get; }

		public int ContactsId { get; }

		public long ChoiceMessageId { get; private set; }

		public bool WaitChoice => ChoiceMessageId != -1;

		public int GenerateTimeStamp { get; set; }

		public int UpdateTimeStamp { get; set; }

		public bool IsUnlocked { get; }

		public List<long> messages { get; }

		public bool needShiftToTop { get; set; }

		public SnsSession(ContactCharacterSession session, int contactsId, long choiceMessageId = -1L)
		{
			Id = session.Id;
			ContactsId = contactsId;
			ChoiceMessageId = choiceMessageId;
			GenerateTimeStamp = session.GenerateTimeStamp;
			UpdateTimeStamp = session.UpdateTimeStamp;
			IsUnlocked = session.State != ContactSessionState.Lock;
			messages = new List<long>(session.MessagesInt64);
			needShiftToTop = false;
			switch (session.State)
			{
			case ContactSessionState.Finish:
				_SessionState = SessionState.Finish;
				messages.Add(0L);
				break;
			case ContactSessionState.Ongoing:
				if (GenerateTimeStamp == UpdateTimeStamp)
				{
					_SessionState = SessionState.NewReceive;
				}
				else
				{
					_SessionState = SessionState.OnGoing;
				}
				break;
			case ContactSessionState.Lock:
				_SessionState = SessionState.Finish;
				break;
			}
		}

		public void AddMessage(RepeatedField<long> newMessages, bool finish, int updateTimeStamp)
		{
			messages.AddRange(newMessages);
			UpdateTimeStamp = updateTimeStamp;
			if (finish)
			{
				_SessionState = SessionState.Finish;
				messages.Add(0L);
				if (!Model<SNSModel>.Interface.IsInteractionSession(Id))
				{
					needShiftToTop = true;
				}
			}
			else
			{
				_SessionState = SessionState.OnGoing;
			}
		}

		public SessionState GetSessionState()
		{
			if (needShiftToTop)
			{
				return SessionState.OnGoing;
			}
			return _SessionState;
		}

		public void SetChoiceMessageId(long choiceMessageId)
		{
			ChoiceMessageId = choiceMessageId;
		}

		public MessageConversation GetLatestMessage()
		{
			if (messages.Count > 0)
			{
				for (int num = messages.Count - 1; num >= 0; num--)
				{
					if (messages[num] != 0L)
					{
						return CoreUtils.GetData(messages[num], RuntimeConfigs.data.messageConversations);
					}
				}
			}
			return null;
		}

		public bool HasMessageTaskActive()
		{
			if (messages.Count > 0)
			{
				List<long> list = messages;
				MessageConversation data = CoreUtils.GetData(list[list.Count - 1], RuntimeConfigs.data.messageConversations);
				if (data.conversationType == 4)
				{
					int missionId = data.conversationParm[0];
					return !Singleton<MissionManager>.instance.IsFinished(missionId);
				}
			}
			return false;
		}
	}

	public enum MessageType
	{
		Text = 1,
		Image,
		SystemPrompt,
		Mission,
		Choice,
		Reward,
		File,
		End
	}

	public struct SpecificMsg
	{
		public int ContactId;

		public int SessionId;
	}

	private List<int> _contactsOrder;

	private Dictionary<int, SnsContacts> _contacts;

	private Dictionary<int, SnsSession> _sessions;

	private SpecificMsg _specificMsg;

	public Queue<SpecificMsg> NewMessagesQueue = new Queue<SpecificMsg>();

	private bool _isWaitingNewSNSMessageNotify;

	public override ContextType ContextType => ContextType.NET;

	public bool FocusMessageLock { get; set; }

	public event Action OnNewSNSMessageNotify;

	protected override void Init()
	{
		if (_contactsOrder == null)
		{
			_contactsOrder = new List<int>();
		}
		if (_contacts == null)
		{
			_contacts = new Dictionary<int, SnsContacts>();
		}
		if (_sessions == null)
		{
			_sessions = new Dictionary<int, SnsSession>();
		}
		_specificMsg = default;
		FocusMessageLock = false;
	}

	protected override void UnInit()
	{
		_contactsOrder.Clear();
		_contacts.Clear();
		_sessions.Clear();
		NewMessagesQueue.Clear();
		OnNewSNSMessageNotify = null;
	}

	protected override void OnDestroy()
	{
		_contactsOrder = null;
		_contacts = null;
		_sessions = null;
		NewMessagesQueue.Clear();
		OnNewSNSMessageNotify = null;
	}

	public void SortContacts(bool needReset, bool needSort)
	{
		foreach (int item in _contactsOrder)
		{
			_contacts[item].SortSessions(needReset);
		}
		if (needSort)
		{
			SortContactsBySessionState();
		}
	}

	public void SortContactsBySessionState()
	{
		Dictionary<SnsContacts.ContactState, int> statePriority = new Dictionary<SnsContacts.ContactState, int>
		{
			{
				SnsContacts.ContactState.NewReceive,
				0
			},
			{
				SnsContacts.ContactState.OnGoing,
				1
			},
			{
				SnsContacts.ContactState.AllFinish,
				2
			}
		};
		_contactsOrder.Sort((int id1, int id2) =>
		{
			_contacts.TryGetValue(id1, out var value);
			_contacts.TryGetValue(id2, out var value2);
			SnsSession session = Model<SNSModel>.Interface.GetSession((Model<SNSModel>.Interface.GetInteractionDisplaySessionId(value.Id) >= 0) ? Model<SNSModel>.Interface.GetInteractionDisplaySessionId(value.Id) : value.SessionInfos[0].SessionId);
			bool flag = IsFinishedConversation(session);
			SnsSession session2 = Model<SNSModel>.Interface.GetSession((Model<SNSModel>.Interface.GetInteractionDisplaySessionId(value2.Id) >= 0) ? Model<SNSModel>.Interface.GetInteractionDisplaySessionId(value2.Id) : value2.SessionInfos[0].SessionId);
			bool flag2 = IsFinishedConversation(session2);
			if (flag && !flag2)
			{
				return 1;
			}
			if (!flag & flag2)
			{
				return -1;
			}
			int num = statePriority[value.Contactstate];
			int value3 = statePriority[value2.Contactstate];
			int num2 = num.CompareTo(value3);
			if (num2 != 0)
			{
				return num2;
			}
			MessageConversationGroup data = CoreUtils.GetData(session.Id, RuntimeConfigs.data.messageConversationGroups);
			MessageConversationGroup data2 = CoreUtils.GetData(session2.Id, RuntimeConfigs.data.messageConversationGroups);
			int type = data.Type;
			int num3 = type.CompareTo(data2.Type);
			return (num3 != 0) ? num3 : id1.CompareTo(id2);
		});
	}

	public SnsSession.SessionState GetSessionState(int sessionId)
	{
		if (IsInteractionSession(sessionId) && GetInteractionDisplaySessionId(GetSession(sessionId)?.ContactsId ?? 0) == sessionId)
		{
			SnsSession interactionPreviewSession = GetInteractionPreviewSession(GetSession(sessionId)?.ContactsId ?? 0);
			if (interactionPreviewSession == null)
			{
				return SnsSession.SessionState.Finish;
			}
			if (!IsFinishedConversation(interactionPreviewSession))
			{
				return SnsSession.SessionState.OnGoing;
			}
			return SnsSession.SessionState.Finish;
		}
		if (_sessions.TryGetValue(sessionId, out var value))
		{
			return value._SessionState;
		}
		return SnsSession.SessionState.NewReceive;
	}

	public bool IsInteractionSession(int sessionId)
	{
		MessageConversationGroup data = CoreUtils.GetData(sessionId, RuntimeConfigs.data.messageConversationGroups);
		if (data != null)
		{
			return data.ContentType == 4;
		}
		return false;
	}

	public int GetInteractionDisplaySessionId(int contactsId)
	{
		int num = int.MaxValue;
		foreach (SnsSession value in _sessions.Values)
		{
			if (value.ContactsId == contactsId && IsInteractionSession(value.Id))
			{
				num = Math.Min(num, value.Id);
			}
		}
		if (num != int.MaxValue)
		{
			return num;
		}
		return -1;
	}

	public List<SnsSession> GetInteractionSessions(int contactsId)
	{
		List<SnsSession> list = new List<SnsSession>();
		foreach (SnsSession value in _sessions.Values)
		{
			if (value.ContactsId == contactsId && IsInteractionSession(value.Id) && value.IsUnlocked)
			{
				list.Add(value);
			}
		}
		list.Sort((SnsSession left, SnsSession right) => left.Id.CompareTo(right.Id));
		return list;
	}

	public SnsSession GetInteractionPreviewSession(int contactsId)
	{
		List<SnsSession> interactionSessions = GetInteractionSessions(contactsId);
		foreach (SnsSession item in interactionSessions)
		{
			if (!IsFinishedConversation(item))
			{
				return item;
			}
		}
		if (interactionSessions.Count <= 0)
		{
			return null;
		}
		return interactionSessions[interactionSessions.Count - 1];
	}

	public bool AreAllInteractionSessionsFinished(int contactsId)
	{
		List<SnsSession> interactionSessions = GetInteractionSessions(contactsId);
		if (interactionSessions.Count == 0)
		{
			return false;
		}
		foreach (SnsSession item in interactionSessions)
		{
			if (!IsFinishedConversation(item))
			{
				return false;
			}
		}
		return true;
	}

	public List<(int SessionId, long MessageId)> GetInteractionDisplayMessages(int contactsId)
	{
		List<(int, long)> list = new List<(int, long)>();
		List<SnsSession> interactionSessions = GetInteractionSessions(contactsId);
		SnsSession interactionPreviewSession = GetInteractionPreviewSession(contactsId);
		foreach (SnsSession item in interactionSessions)
		{
			if (!IsFinishedConversation(item) && item != interactionPreviewSession)
			{
				continue;
			}
			foreach (long message in item.messages)
			{
				list.Add((item.Id, message));
			}
		}
		return list;
	}

	public int ResolveSessionId(int sessionId)
	{
		if (!IsInteractionSession(sessionId))
		{
			return sessionId;
		}
		SnsSession session = GetSession(sessionId);
		if (session == null || GetInteractionDisplaySessionId(session.ContactsId) != sessionId)
		{
			return sessionId;
		}
		return GetInteractionPreviewSession(session.ContactsId)?.Id ?? sessionId;
	}

	public bool IsSameInteractionDisplay(int firstSessionId, int secondSessionId)
	{
		if (!IsInteractionSession(firstSessionId) || !IsInteractionSession(secondSessionId))
		{
			return false;
		}
		SnsSession session = GetSession(firstSessionId);
		SnsSession session2 = GetSession(secondSessionId);
		if (session == null || session2 == null || session.ContactsId != session2.ContactsId)
		{
			return false;
		}
		int interactionDisplaySessionId = GetInteractionDisplaySessionId(session.ContactsId);
		if (interactionDisplaySessionId != firstSessionId)
		{
			return interactionDisplaySessionId == secondSessionId;
		}
		return true;
	}

	public int GetSessionIdForMessage(long messageId, int fallbackSessionId)
	{
		foreach (SnsSession value in _sessions.Values)
		{
			if (value.messages.Contains(messageId))
			{
				return value.Id;
			}
		}
		return ResolveSessionId(fallbackSessionId);
	}

	public void OnReceiveContactNtf(Contact contact)
	{
		foreach (var (num2, contactCharacterSession2) in contact.CharacterSessions)
		{
			MessageConversationGroup data = CoreUtils.GetData(num2, RuntimeConfigs.data.messageConversationGroups);
			if (data == null)
			{
				Debug.Log($"<color=cyan>sessionId数据异常,值为: {num2}</color>");
				continue;
			}
			MessageCharacterData data2 = CoreUtils.GetData(data.messageCharacterID, RuntimeConfigs.data.messageCharacterDatas);
			if (data2 == null)
			{
				Debug.Log($"<color=cyan>conversation.messageCharacterID数据异常,值为: {data.messageCharacterID}</color>");
				continue;
			}
			long choiceMessageId = RemoveLastChoiceMessage(contactCharacterSession2.MessagesInt64);
			_sessions[contactCharacterSession2.Id] = new SnsSession(contactCharacterSession2, data2.id, choiceMessageId);
			if (_contacts.TryGetValue(data2.id, out var value))
			{
				value.AddSessionInfo(_sessions[contactCharacterSession2.Id]);
				string nodeFullPath = RedDotPathDefine.SNSMain + $"|{data2.id}" + $"|{contactCharacterSession2.Id}";
				if (!Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath))
				{
					Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath, active: false, 1030);
				}
				Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, !IsInteractionSession(contactCharacterSession2.Id) && !IsFinishedConversation(_sessions[contactCharacterSession2.Id]));
				continue;
			}
			_contacts[data2.id] = new SnsContacts(data2, _sessions[contactCharacterSession2.Id]);
			_contactsOrder.Add(data2.id);
			string nodeFullPath2 = RedDotPathDefine.SNSMain + $"|{data2.id}" + $"|{contactCharacterSession2.Id}";
			if (!Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath2))
			{
				Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath2, active: false, 1030);
			}
			Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath2, !IsInteractionSession(contactCharacterSession2.Id) && !IsFinishedConversation(_sessions[contactCharacterSession2.Id]));
		}
	}

	public void OnNewTriggerSession(RepeatedField<ContactCharacterSession> sessions, ContactGMMode gmMode = ContactGMMode.None)
	{
		foreach (ContactCharacterSession session in sessions)
		{
			MessageConversationGroup data = CoreUtils.GetData(session.Id, RuntimeConfigs.data.messageConversationGroups);
			if (data == null)
			{
				continue;
			}
			MessageCharacterData data2 = CoreUtils.GetData(data.messageCharacterID, RuntimeConfigs.data.messageCharacterDatas);
			long choiceMessageId = RemoveLastChoiceMessage(session.MessagesInt64);
			_sessions[session.Id] = new SnsSession(session, data2.id, choiceMessageId);
			if (_contacts.TryGetValue(data2.id, out var value))
			{
				value.AddSessionInfo(_sessions[session.Id]);
				string nodeFullPath = RedDotPathDefine.SNSMain + $"|{data2.id}" + $"|{session.Id}";
				if (!Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath))
				{
					Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath, active: false, 1030);
				}
				Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, !IsInteractionSession(session.Id) && !IsFinishedConversation(_sessions[session.Id]));
				continue;
			}
			_contacts[data2.id] = new SnsContacts(data2, _sessions[session.Id]);
			_contactsOrder.Add(data2.id);
			string nodeFullPath2 = RedDotPathDefine.SNSMain + $"|{data2.id}" + $"|{session.Id}";
			if (!Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath2))
			{
				Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath2, active: false, 1030);
			}
			Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath2, !IsInteractionSession(session.Id) && !IsFinishedConversation(_sessions[session.Id]));
		}
		if (gmMode == ContactGMMode.OpenUi)
		{
			foreach (ContactCharacterSession session2 in sessions)
			{
				MessageConversationGroup data3 = CoreUtils.GetData(session2.Id, RuntimeConfigs.data.messageConversationGroups);
				if (data3 != null)
				{
					MessageCharacterData data4 = CoreUtils.GetData(data3.messageCharacterID, RuntimeConfigs.data.messageCharacterDatas);
					SNSPreOpenView.Enqueue(new SpecificMsg
					{
						ContactId = data4.id,
						SessionId = session2.Id
					});
				}
			}
			SNSPreOpenView.OpenView();
			return;
		}
		foreach (ContactCharacterSession session3 in sessions)
		{
			MessageConversationGroup data5 = CoreUtils.GetData(session3.Id, RuntimeConfigs.data.messageConversationGroups);
			if (data5 != null && data5.ContentType != 4)
			{
				MessageCharacterData data6 = CoreUtils.GetData(data5.messageCharacterID, RuntimeConfigs.data.messageCharacterDatas);
				SpecificMsg item = new SpecificMsg
				{
					ContactId = data6.id,
					SessionId = session3.Id
				};
				NewMessagesQueue.Enqueue(item);
			}
		}
		if (!_isWaitingNewSNSMessageNotify)
		{
			WaitForNewSNSMessageNotify().Forget();
		}
	}

	private async UniTaskVoid WaitForNewSNSMessageNotify()
	{
		_isWaitingNewSNSMessageNotify = true;
		await UniTask.WaitUntil(() => InBattleMain() && NewMessagesQueue.Count > 0);
		_isWaitingNewSNSMessageNotify = false;
		OnNewSNSMessageNotify?.Invoke();
	}

	public bool InBattleMain()
	{
		if (!Singleton<NewUIManager>.HasInstance())
		{
			return false;
		}
		if (!Singleton<NewUIManager>.instance.TryGetFirstUIController(UI_TYPE.UI_BATTLEMAIN, out var ui))
		{
			return false;
		}
		if (ui.State != UIState.Opened)
		{
			return false;
		}
		return true;
	}

	public void OnContinueSession(int sessionId, RepeatedField<long> newMessages, bool sessionFinish, int updatetimStamp)
	{
		if (!_sessions.TryGetValue(sessionId, out var value))
		{
			return;
		}
		long choiceMessageId = RemoveLastChoiceMessage(newMessages);
		value.AddMessage(newMessages, sessionFinish, updatetimStamp);
		value.SetChoiceMessageId(choiceMessageId);
		MessageCharacterData data = CoreUtils.GetData(CoreUtils.GetData(sessionId, RuntimeConfigs.data.messageConversationGroups).messageCharacterID, RuntimeConfigs.data.messageCharacterDatas);
		_contacts[data.id].UpdateSessionInfo(value);
		string nodeFullPath = RedDotPathDefine.SNSMain + $"|{data.id}" + $"|{value.Id}";
		Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, !IsInteractionSession(value.Id) && !IsFinishedConversation(_sessions[value.Id]));
		UpdateInteractionRedDot(data.id);
		SNSContinueSessionEvt evt = Singleton<EventManager>.instance.GetEvt<SNSContinueSessionEvt>();
		MessageConversationGroup data2 = CoreUtils.GetData(sessionId, RuntimeConfigs.data.messageConversationGroups);
		bool num = data2 != null && data2.ContentType == 4;
		if (sessionFinish)
		{
			newMessages.Add(0L);
		}
		List<long> list = new List<long>(newMessages);
		int sessionId2 = sessionId;
		bool waitChoice = value.WaitChoice;
		long choiceMessageId2 = value.ChoiceMessageId;
		bool finish = value.GetSessionState() == SnsSession.SessionState.Finish;
		if (num)
		{
			sessionId2 = GetInteractionDisplaySessionId(value.ContactsId);
			finish = true;
			foreach (SnsSession interactionSession in GetInteractionSessions(value.ContactsId))
			{
				if (!IsFinishedConversation(interactionSession))
				{
					finish = false;
					break;
				}
			}
			if (IsFinishedConversation(value))
			{
				SnsSession interactionPreviewSession = GetInteractionPreviewSession(value.ContactsId);
				if (interactionPreviewSession != null && interactionPreviewSession.Id != value.Id && !IsFinishedConversation(interactionPreviewSession))
				{
					list.AddRange(interactionPreviewSession.messages);
					waitChoice = interactionPreviewSession.WaitChoice;
					choiceMessageId2 = interactionPreviewSession.ChoiceMessageId;
					finish = false;
				}
			}
		}
		evt.sessionId = sessionId2;
		evt.messageIds = list;
		evt.waitChoice = waitChoice;
		evt.choiceMessageId = choiceMessageId2;
		evt.finish = finish;
		evt.needReset = false;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.SNS_ContinueSession, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void UpdateRedTreeBySessionFinish()
	{
		foreach (var (id, snsSession2) in _sessions)
		{
			MessageConversationGroup data = CoreUtils.GetData(id, RuntimeConfigs.data.messageConversationGroups);
			if (data != null)
			{
				string nodeFullPath = RedDotPathDefine.SNSMain + $"|{data.messageCharacterID}" + $"|{snsSession2.Id}";
				if (!Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath))
				{
					Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath, active: false, 1030);
				}
				Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, !IsInteractionSession(snsSession2.Id) && !IsFinishedConversation(_sessions[snsSession2.Id]));
			}
		}
		foreach (SnsContacts value in _contacts.Values)
		{
			UpdateInteractionRedDot(value.Id);
		}
	}

	private void UpdateInteractionRedDot(int contactsId)
	{
		int interactionDisplaySessionId = GetInteractionDisplaySessionId(contactsId);
		if (interactionDisplaySessionId >= 0)
		{
			string nodeFullPath = RedDotPathDefine.SNSMain + $"|{contactsId}|{interactionDisplaySessionId}";
			if (!Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath))
			{
				Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath, active: false, 1030);
			}
			Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, active: false);
		}
	}

	public bool IsFinishedConversation(SnsSession session)
	{
		if (session == null || !session.IsUnlocked)
		{
			return false;
		}
		if (session.GetLatestMessage() != null && 4 == session.GetLatestMessage().conversationType)
		{
			int missionId = session.GetLatestMessage().conversationParm[0];
			if (session.GetSessionState() != SnsSession.SessionState.Finish)
			{
				return Singleton<MissionManager>.instance.IsFinished(missionId);
			}
			return true;
		}
		return session.GetSessionState() == SnsSession.SessionState.Finish;
	}

	private long RemoveLastChoiceMessage(IList<long> messages)
	{
		long result = -1L;
		if (messages == null || messages.Count == 0)
		{
			return result;
		}
		if (CoreUtils.GetData(messages[messages.Count - 1], RuntimeConfigs.data.messageConversations).conversationType == 5)
		{
			result = messages[messages.Count - 1];
			messages.RemoveAt(messages.Count - 1);
		}
		return result;
	}

	private void TryPlayNewMessageSound()
	{
		IBaseUIController topActivePanel = Singleton<NewUIManager>.instance.GetTopActivePanel();
		if (topActivePanel != null && topActivePanel.UIType == UI_TYPE.UI_BATTLEMAIN)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Message/NewMessage");
		}
	}

	public List<SnsContacts> GetAllContacts(bool needReset, bool needSort = false)
	{
		if (_contacts == null)
		{
			return null;
		}
		SortContacts(needReset, needSort);
		List<SnsContacts> list = new List<SnsContacts>(_contacts.Count);
		foreach (int item in _contactsOrder)
		{
			list.Add(_contacts[item]);
		}
		return list;
	}

	public SnsContacts GetContacts(int contactsId)
	{
		return _contacts?.GetValueOrDefault(contactsId);
	}

	public int GetContactsIndex(int contactsId)
	{
		return _contactsOrder.IndexOf(contactsId);
	}

	public bool GetContactsFinish(int contactsId)
	{
		SnsContacts snsContacts = _contacts?.GetValueOrDefault(contactsId);
		if (snsContacts == null)
		{
			return true;
		}
		foreach (SnsContacts.SessionInfo sessionInfo in snsContacts.SessionInfos)
		{
			SnsSession session = GetSession(sessionInfo.SessionId);
			if (session != null && session.IsUnlocked && !IsFinishedConversation(session))
			{
				return false;
			}
		}
		return true;
	}

	public SnsSession GetSession(int sessionId)
	{
		return _sessions?.GetValueOrDefault(sessionId);
	}

	public SpecificMsg UseSpecificMsg()
	{
		SpecificMsg specificMsg = _specificMsg;
		_specificMsg = default;
		return specificMsg;
	}

	public void SendSNSFinish(int sessionId)
	{
		SNSFinish evt = Singleton<EventManager>.instance.GetEvt<SNSFinish>();
		evt.id = ResolveSessionId(sessionId);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.SNS_Finish, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public bool SetSpecificMsg(SpecificMsg msg, bool needUnlock = false)
	{
		if (IsInteractionSession(msg.SessionId) && _sessions.TryGetValue(msg.SessionId, out var value))
		{
			msg.SessionId = GetInteractionDisplaySessionId(value.ContactsId);
		}
		if (_contacts.ContainsKey(msg.ContactId) && _sessions.ContainsKey(msg.SessionId))
		{
			_specificMsg = msg;
			if (GetSession(msg.SessionId)._SessionState != SnsSession.SessionState.Finish && !needUnlock)
			{
				FocusMessageLock = true;
			}
			return true;
		}
		return false;
	}

	public void ClearSpecificMsg()
	{
		_specificMsg = default;
	}

	public bool IsSessionFinished(int contactsId, int sessionId, int msgId)
	{
		if (_sessions.TryGetValue(sessionId, out var value))
		{
			return value.messages.Contains(msgId);
		}
		return false;
	}

	public int GetUnreadCount()
	{
		int num = 0;
		foreach (var (_, session) in _sessions)
		{
			if (!IsFinishedConversation(session))
			{
				num++;
			}
		}
		return num;
	}
}
