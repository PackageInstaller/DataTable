using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Model;
using ACT.UI.InputController;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Sirenix.Serialization;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class SNSBaseView : BaseUIView<SnsViewInputController>
{
	[SerializeField]
	public SNSContactsOSA contactsOsa;

	[SerializeField]
	public SessionDetailComp sessionDetailComp;

	public GamePadTipsComp gamePadTips;

	[OdinSerialize]
	public Dictionary<SNSSubController, ViewControlLayer> ViewControlLayers;

	protected SNSBaseViewData m_data;

	private List<GamePadTipsAction> _tipsActions = new List<GamePadTipsAction>();

	private Dictionary<string, GamePadTipsAction> actionDic = new Dictionary<string, GamePadTipsAction>();

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SNS_ContinueSession, OnSessionContinue);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SNS_UpdateContactView, OnConversationFinish);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SNS_ChooseOption, FocusLayerReset);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SNS_ContinueSession, OnSessionContinue);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SNS_UpdateContactView, OnConversationFinish);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SNS_ChooseOption, FocusLayerReset);
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		InitGameTipsDic();
	}

	protected override void Init()
	{
		base.Init();
		Model<SNSModel>.Interface.NewMessagesQueue?.Clear();
		contactsOsa.Reload(Station, OnSessionSelect);
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		SetGamePadTipsActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Message/Open");
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		SetGamePadTipsActive(mode == DeviceInputMode.Gamepad);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void OnInputControllerCreate()
	{
		base.OnInputControllerCreate();
	}

	private void InitGameTipsDic()
	{
		actionDic.Add("LargeMapView/Select", new GamePadTipsAction
		{
			inputAction = "LargeMapView/Select",
			localizeKey = 774,
			localizeTable = "Common"
		});
		actionDic.Add("UI/Back", new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		});
		actionDic.Add("UI/RSUpDownSelect", new GamePadTipsAction
		{
			inputAction = "UI/RSUpDownSelect",
			localizeKey = 2165,
			localizeTable = "Common"
		});
		actionDic.Add("UI/CommonSelect", new GamePadTipsAction
		{
			inputAction = "UI/CommonSelect"
		});
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		MessageConversationGroup data = CoreUtils.GetData(sessionDetailComp._sessionId, RuntimeConfigs.data.messageConversationGroups);
		if (data != null)
		{
			SNSModel.SnsSession.SessionState sessionState = Model<SNSModel>.Interface.GetSessionState(sessionDetailComp._sessionId);
			MessageEvent evt = EventTrackSolver.Instance.GetEvt<MessageEvent>();
			evt.conversationCharacterId = data.messageCharacterID;
			evt.conversationType = data.Type;
			evt.conversationId = data.id;
			evt.messageChooseId = 0;
			evt.messageId = 0L;
			evt.messageType = 0;
			MessageEvent messageEvent = evt;
			messageEvent.conversationStatus = sessionState switch
			{
				SNSModel.SnsSession.SessionState.Finish => 2, 
				SNSModel.SnsSession.SessionState.OnGoing => 1, 
				_ => 0, 
			};
			evt.status = 3;
			EventTrackSolver.Instance.Dispatch(evt);
		}
		actionDic.Clear();
		_tipsActions.Clear();
		sessionDetailComp.UnInit();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Message/Close");
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/List_Close");
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
	}

	protected override void PlayCloseAnimation()
	{
		contactsOsa.UnInit();
		sessionDetailComp.HideOptionGroup();
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void OnSessionSelect(int sessionId)
	{
		if (sessionId != sessionDetailComp._sessionId)
		{
			sessionDetailComp.UnInit();
			sessionDetailComp.Init(Model<SNSModel>.Interface.GetSession(sessionId), Station);
		}
		SNSSessionCompSelectUpdateEvt evt = Singleton<EventManager>.instance.GetEvt<SNSSessionCompSelectUpdateEvt>();
		evt.sessionId = sessionId;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.SNS_SelectLeftInfo, evt);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Message/Tab");
		MessageConversationGroup data = CoreUtils.GetData(sessionId, RuntimeConfigs.data.messageConversationGroups);
		SNSModel.SnsSession.SessionState sessionState = Model<SNSModel>.Interface.GetSessionState(sessionId);
		MessageEvent evt2 = EventTrackSolver.Instance.GetEvt<MessageEvent>();
		evt2.conversationCharacterId = data.messageCharacterID;
		evt2.conversationType = data.Type;
		evt2.conversationId = data.id;
		evt2.messageChooseId = 0;
		evt2.messageId = 0L;
		evt2.messageType = 0;
		MessageEvent messageEvent = evt2;
		messageEvent.conversationStatus = sessionState switch
		{
			SNSModel.SnsSession.SessionState.Finish => 2, 
			SNSModel.SnsSession.SessionState.OnGoing => 1, 
			_ => 0, 
		};
		evt2.status = 1;
		EventTrackSolver.Instance.Dispatch(evt2);
	}

	private void OnSessionContinue(BaseEventContent content)
	{
		if (content is SNSContinueSessionEvt sNSContinueSessionEvt)
		{
			contactsOsa.UpdateView(sNSContinueSessionEvt.sessionId, needReset: false);
			if (sNSContinueSessionEvt.finish)
			{
				contactsOsa.OnSessionFinish(sNSContinueSessionEvt.sessionId);
			}
		}
	}

	private void FocusLayerReset(BaseEventContent content)
	{
		if (content is SNSSessionChooseOptionEvt)
		{
			ChangeToGamePadInputState(SNSSubController.main);
		}
	}

	private void OnConversationFinish(BaseEventContent content)
	{
		if (content is SNSContactsViewUpdateEvt sNSContactsViewUpdateEvt)
		{
			contactsOsa.UpdateView(sNSContactsViewUpdateEvt.sessionId, sNSContactsViewUpdateEvt.needReset);
			contactsOsa.OnSessionFinish(sNSContactsViewUpdateEvt.sessionId);
			Model<SNSModel>.Interface.FocusMessageLock = false;
			MessageConversationGroup data = CoreUtils.GetData(sNSContactsViewUpdateEvt.sessionId, RuntimeConfigs.data.messageConversationGroups);
			MessageEvent evt = EventTrackSolver.Instance.GetEvt<MessageEvent>();
			evt.conversationCharacterId = data.messageCharacterID;
			evt.conversationType = data.Type;
			evt.conversationId = data.id;
			evt.conversationStatus = 2;
			evt.messageChooseId = 0;
			evt.messageId = 0L;
			evt.messageType = 0;
			evt.status = 2;
			EventTrackSolver.Instance.Dispatch(evt);
			ChangeToGamePadInputState(SNSSubController.main);
		}
	}

	public void SetGamePadTipsActive(bool active)
	{
		SnsViewInputController controller = GetController();
		if (((controller != null) & active) && active && MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			if (ViewControlLayers.TryGetValue(controller.ControllerType, out var value))
			{
				value.ReFocus();
			}
			GamePadTipsStatusChange(controller.ControllerType);
		}
	}

	public void GamePadTipsStatusChange(SNSSubController subController)
	{
		gamePadTips.ClearAllPrompts();
		_tipsActions.Clear();
		switch (subController)
		{
		case SNSSubController.SelectItem:
			_tipsActions.Add(actionDic["LargeMapView/Select"]);
			_tipsActions.Add(actionDic["UI/Back"]);
			_tipsActions.Add(actionDic["UI/RSUpDownSelect"]);
			gamePadTips.RegisterInputActions(_tipsActions);
			break;
		case SNSSubController.main:
			_tipsActions.Add(actionDic["LargeMapView/Select"]);
			_tipsActions.Add(actionDic["UI/Back"]);
			_tipsActions.Add(actionDic["UI/RSUpDownSelect"]);
			gamePadTips.RegisterInputActions(_tipsActions);
			break;
		}
	}

	public void ChangeToGamePadInputState(SNSSubController type, bool needFocusLayer = true)
	{
		SnsViewInputController controller = GetController();
		if (controller != null && controller.ControllerType != type)
		{
			controller.ControllerType = type;
			if (needFocusLayer && ViewControlLayers.TryGetValue(type, out var value))
			{
				value.ReFocus();
			}
			if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
			{
				GamePadTipsStatusChange(type);
			}
		}
	}

	public void HandleGamePadSelectButtonInput(SNSSubController type)
	{
		switch (type)
		{
		case SNSSubController.main:
			if (sessionDetailComp.optionGroup.gameObject.activeSelf)
			{
				ChangeToGamePadInputState(SNSSubController.SelectItem);
			}
			else
			{
				sessionDetailComp.QuickContinueSession();
			}
			break;
		case SNSSubController.SelectItem:
			if ((bool)EventSystemHelper.CurrentSelected && sessionDetailComp.optionGroup.gameObject.activeSelf)
			{
				ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
				{
					handler.OnSubmit(data);
				});
			}
			break;
		}
	}

	public void HandleGamePadReturnButtonInput(SNSSubController type)
	{
		switch (type)
		{
		case SNSSubController.main:
			if (!Model<SNSModel>.Interface.FocusMessageLock)
			{
				Close();
			}
			break;
		case SNSSubController.SelectItem:
			ChangeToGamePadInputState(SNSSubController.main);
			break;
		}
	}
}
