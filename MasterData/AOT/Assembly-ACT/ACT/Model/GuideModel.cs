using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.BluePrint;
using ACT.Config;
using ACT.Core;
using ACT.Drama;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI;
using ACT.Utility;
using Bamboo.AssetField;
using Bamboo.Chronos;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Cysharp.Threading.Tasks.Linq;
using Fundamental;
using Google.Protobuf.Collections;
using Pb;
using UnityEngine;

namespace ACT.Model;

public class GuideModel : Model<GuideModel>
{
	private const string _guideConfigsPath = "GuideConfigs";

	private AssetLoadHandle _configHandle;

	private BPTriggerField triggerField;

	private CancellationTokenSource _openCts;

	private List<GuideQueueInfo> _guideQueue = new List<GuideQueueInfo>();

	private IDisposable _update;

	private GuideQueueInfo StartInfo;

	private List<GuideQueueInfo> UpdateQueue = new List<GuideQueueInfo>();

	private Dictionary<int, GuideState> _allGuide = new Dictionary<int, GuideState>();

	private Dictionary<int, Guide> _allSoftGuide = new Dictionary<int, Guide>();

	private List<Guide> UpdateSoftQueue = new List<Guide>();

	private Dictionary<string, SoftHighlightWidget> _createdGuideWidgets = new Dictionary<string, SoftHighlightWidget>();

	private Dictionary<string, int> _guideWidgetRefCounts = new Dictionary<string, int>();

	private bool _opentips;

	private int _characterTargetLevel;

	private IInputController CurrentController;

	private GuideConfigs _guideConfigs;

	private GuideData _guideData;

	private GuideStepData _stepData;

	private bool _inStrongGuide;

	private bool _guideCompleteSent;

	private ImageAssetStation _imageStation;

	private System.DateTime startTime;

	private System.DateTime stepStartTime;

	private CancellationTokenSource _tokenSource;

	private bool isgm;

	private bool _stopController;

	private Delayer _DeleteDelayer;

	private bool _waitPreCondition;

	private bool ishavetips;

	private const int NEW_GUIDE_STATUS_START = 1;

	private const int NEW_GUIDE_STATUS_END = 2;

	private Action<GuideStepData> _onStepStart;

	private Action<int> _onStepFinish;

	public ImageAssetStation ImageStation => _imageStation;

	public event Action<GuideStepData> OnStepStart
	{
		add
		{
			_onStepStart = (Action<GuideStepData>)Delegate.Combine(_onStepStart, value);
		}
		remove
		{
			_onStepStart = (Action<GuideStepData>)Delegate.Remove(_onStepStart, value);
		}
	}

	public event Action<int> OnStepFinish
	{
		add
		{
			_onStepFinish = (Action<int>)Delegate.Combine(_onStepFinish, value);
		}
		remove
		{
			_onStepFinish = (Action<int>)Delegate.Remove(_onStepFinish, value);
		}
	}

	protected override void Init()
	{
		Singleton<NewUIManager>.instance.GuideComp.Init();
		_characterTargetLevel = 0;
		_allGuide.Clear();
		_allSoftGuide.Clear();
		_configHandle = AssetStationManager.Root.Load<GuideConfigs>("GuideConfigs");
		_guideConfigs = _configHandle.As<GuideConfigs>();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Guide_StepFinish, OnStepSuccess);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_TP, OnTP);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterLeaveWorld, OnLeaveWorld);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AllCharacterDieEnd, OnAllDie);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.GM_Guide_Finsh, OnGmGuideFinsh);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ReconnectServer, OnReconnectServer);
		_update = UniTaskAsyncEnumerable.EveryUpdate().Subscribe((Action<AsyncUnit>)OnUpdate);
	}

	public void RefreshGuideNtf(MapField<int, GuideState> allGuide)
	{
		foreach (KeyValuePair<int, GuideState> item in allGuide)
		{
			_allGuide[item.Key] = item.Value;
		}
	}

	public void Begin()
	{
		foreach (KeyValuePair<int, GuideState> item in _allGuide)
		{
			if (item.Value.State == GuideStateEnum.GuideStateOngoing)
			{
				OnStartGuide(item.Value.Id);
			}
		}
	}

	public void AddGuideNtf(MapField<int, GuideState> allGuide)
	{
		_allGuide.AddRange(allGuide);
	}

	public void SendGuideUnlock(int guideId, Action<GuideUnlockAck> callback)
	{
		G.service.SendGuideUnlock(guideId, (GuideUnlockAck ack) =>
		{
			_allGuide.Add(guideId, new GuideState
			{
				Id = guideId,
				State = GuideStateEnum.GuideStateOngoing
			});
			callback?.Invoke(ack);
		});
	}

	public void SendGuideComplete(int guideId, Action<GuideCompleteAck> callback = null)
	{
		G.service.SendGuideComplete(guideId, (GuideCompleteAck ack) =>
		{
			if (_allGuide.TryGetValue(guideId, out var value))
			{
				value.State = GuideStateEnum.GuideStateComplete;
			}
			else
			{
				GuideState value2 = new GuideState
				{
					State = GuideStateEnum.GuideStateComplete
				};
				_allGuide.Add(guideId, value2);
			}
			callback?.Invoke(ack);
		});
	}

	private void OnUpdate(AsyncUnit _)
	{
		if (_inStrongGuide && _guideData != null && _stepData != null && _guideData.CheckAnyFinshCondition())
		{
			OnFinshGuide();
		}
		if (_guideQueue.Count > 0)
		{
			UpdateQueue.Clear();
			UpdateQueue.AddRange(_guideQueue);
			foreach (GuideQueueInfo item in UpdateQueue)
			{
				if (!TryFinishQueuedGuide(item) && GudieCheckAllCondition(item.guideId) && GuideDataPrepare(item.guideId))
				{
					StartInfo = item;
					OpenGuide(item.guideId, item.isgm).Forget();
					break;
				}
			}
		}
		if (_allSoftGuide.Count <= 0)
		{
			return;
		}
		UpdateSoftQueue.Clear();
		UpdateSoftQueue.AddRange(_allSoftGuide.Values);
		foreach (Guide item2 in UpdateSoftQueue)
		{
			if (item2.IsFinsh)
			{
				_allSoftGuide.Remove(item2.GuideId);
			}
			else
			{
				item2.Tick();
			}
		}
	}

	private bool TryFinishQueuedGuide(GuideQueueInfo info)
	{
		GuideConfig config = _guideConfigs.GetConfig(info.guideId);
		if (config == null || !GuideData.CheckAnyFinshCondition(config.FinshConditions))
		{
			return false;
		}
		if (_guideQueue.Remove(info) && !info.isgm)
		{
			SendGuideComplete(info.guideId);
			SendGuideFinshEvent(info.guideId);
		}
		return true;
	}

	private bool GudieCheckAllCondition(int guideId)
	{
		GuideConfig config = _guideConfigs.GetConfig(guideId);
		if (config == null)
		{
			return false;
		}
		GuideStepCondition[] conditions = new GuideData(config, MonoECS.instance.ispc).Conditions;
		foreach (GuideStepCondition guideStepCondition in conditions)
		{
			if (guideStepCondition == null)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError($"id: {guideId}，引导条件配置为空，检查配置");
				}
				return false;
			}
			if (!guideStepCondition.CheckCondition())
			{
				return false;
			}
		}
		return true;
	}

	private bool GuideDataPrepare(int guideId)
	{
		if (_inStrongGuide || Singleton<NewUIManager>.instance.IsActivePanelBusy() || Singleton<GameState>.instance.InSystemUnlock || MonoECS.instance.HasAnyPlayerTag(MonoECS.PlayerTag.TeleportMove | MonoECS.PlayerTag.TeleportRespawnAndTpMove) || !CheckStrongGudieCanOpen())
		{
			return false;
		}
		GuideData guideData = new GuideData(_guideConfigs.GetConfig(guideId), MonoECS.instance.ispc);
		bool result = false;
		if (guideData.ToFirstStep(out var stepData))
		{
			result = stepData.Prepare();
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"id: {guideData.Id}，引导步骤配置为空，检查配置");
		}
		return result;
	}

	private void ClearallSoftGuide()
	{
		foreach (KeyValuePair<int, Guide> item in _allSoftGuide)
		{
			item.Value.OnFail();
		}
		_allSoftGuide.Clear();
	}

	protected override void UnInit()
	{
		_update.Dispose();
		_openCts?.Cancel();
		_tokenSource?.Cancel();
		_allGuide.Clear();
		ClearallSoftGuide();
		Singleton<NewUIManager>.instance.GuideComp.UnInit();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Guide_StepFinish, OnStepSuccess);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_TP, OnTP);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AfterLeaveWorld, OnLeaveWorld);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AllCharacterDieEnd, OnAllDie);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.GM_Guide_Finsh, OnGmGuideFinsh);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ReconnectServer, OnReconnectServer);
		ishavetips = false;
		_waitPreCondition = false;
		isgm = false;
		_inStrongGuide = false;
		_characterTargetLevel = 0;
		if (_DeleteDelayer.IsValid())
		{
			_DeleteDelayer.Cancel();
		}
		if (_opentips)
		{
			CloseTips();
		}
		_guideQueue.Clear();
		_guideData = null;
		_stepData = null;
		_createdGuideWidgets.Clear();
		_guideWidgetRefCounts.Clear();
	}

	protected override void OnDestroy()
	{
		AssetStationManager.Root.Release(_configHandle);
		_guideConfigs = null;
		_inStrongGuide = false;
	}

	private void DispatchNewGuideEvent(int guideId, int status, int step, int stepType, bool skip, float eventDuration)
	{
		NewGuide evt = EventTrackSolver.Instance.GetEvt<NewGuide>();
		evt.id = guideId;
		evt.status = status;
		evt.step = step;
		evt.stepType = stepType;
		evt.skip = skip;
		evt.eventDuration = eventDuration;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	public bool InGuide(int guideId)
	{
		if (_guideData == null)
		{
			return false;
		}
		return _guideData.Id == guideId;
	}

	public GuideData GetCurrentGuide()
	{
		return _guideData;
	}

	public bool IsInStrongGuide()
	{
		return _inStrongGuide;
	}

	public UI_TYPE GetCurrentStepView()
	{
		return _stepData._precondition;
	}

	public string GetCurrentStepActionPath()
	{
		return _stepData._actionPath;
	}

	public int GetGuideStepById(int guideId)
	{
		G.localPlayer.InterfaceGuide.TryGetValue(guideId, out var value);
		return value;
	}

	public virtual void SetHandleActionActive(bool active)
	{
		Singleton<NewUIManager>.instance.SetHandleActionActive(in active, CurrentController);
	}

	public void SetHandeActionCallbackActive(string actionPath, bool active, IInputController controller)
	{
		Singleton<NewUIManager>.instance.SetHandeActionCallbackActive(actionPath, active, CurrentController);
	}

	public bool GuideHasTriggeredAndFinsh(int guideId)
	{
		if (_guideConfigs.GetConfig(guideId) == null)
		{
			return true;
		}
		if (_allGuide.TryGetValue(guideId, out var value))
		{
			return value.State == GuideStateEnum.GuideStateComplete;
		}
		return false;
	}

	public async UniTask<bool> OpenImageVideoTips(int tutorialId)
	{
		bool canopen = !_inStrongGuide && !Singleton<ConversationManager>.instance.IsPlaying;
		bool needopen = false;
		if (!Model<TutorialModel>.Interface.CanTriggerTutorial(tutorialId))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"id: {tutorialId}，触发过了不能触发");
			}
			return needopen;
		}
		if (CoreUtils.GetData(tutorialId, RuntimeConfigs.data.guideTutorials) == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"id: {tutorialId}，guideTutorials 表中没有对应数据");
			}
			return needopen;
		}
		bool isback = false;
		G.service.TriggerTutorial(tutorialId, (bool b) =>
		{
			isback = true;
			if (b && canopen)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_GUIDEIMAGEVIDEO, new GuideImageVideoViewData
				{
					tutorialId = tutorialId
				});
			}
			needopen = canopen & b;
		});
		await UniTask.WaitUntil(() => isback);
		return needopen;
	}

	private void TryDequeGuide()
	{
	}

	private async UniTaskVoid OpenGuide(int id, bool isGm)
	{
		_inStrongGuide = true;
		_guideCompleteSent = false;
		_guideQueue.Remove(StartInfo);
		isgm = false;
		GuideConfig config = _guideConfigs.GetConfig(id);
		_guideData = new GuideData(config, MonoECS.instance.ispc);
		_tokenSource?.Cancel();
		_tokenSource = new CancellationTokenSource();
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"id: {id}，开始强引导");
		}
		isgm = isGm;
		_imageStation = ImageManager.instance.GetAssetStation();
		if (config.guideType == GuideStepType.Highlight)
		{
			Singleton<GameState>.instance.SetInGuiding(inGuiding: true);
			Singleton<GameInputActionManager>.instance.SetGameInputState(GameInputState.Guide, active: true);
		}
		if (_guideData._guideType == GuideStepType.Highlight)
		{
			MonoECS.instance.PushPause();
		}
		startTime = System.DateTime.Now;
		DispatchNewGuideEvent(_guideData.Id, 1, 0, 0, skip: false, 0f);
		ToNextStep(_tokenSource.Token, _guideData);
	}

	public void CreateTriggerField(string name, Vector3 center, Vector3 size)
	{
		GameObject gameObject = new GameObject();
		gameObject.transform.position = center;
		gameObject.layer = 0;
		BoxCollider boxCollider = gameObject.AddComponent<BoxCollider>();
		boxCollider.size = size;
		boxCollider.isTrigger = true;
		BPTriggerField bPTriggerField = gameObject.AddComponent<BPTriggerField>();
		bPTriggerField.triggerName = name;
		bPTriggerField.onEnter = OnBPTriggerEnter;
		bPTriggerField.onExit = OnBPTriggerExit;
		triggerField = bPTriggerField;
	}

	private void OnBPTriggerEnter(string name)
	{
		if (_inStrongGuide)
		{
			FinishStep(tonext: false);
			FinishGuide();
		}
	}

	private void OnBPTriggerExit(string name)
	{
	}

	public void FinishGuide()
	{
		FinishGuide(isSkip: false);
	}

	private void FinishGuide(bool isSkip)
	{
		DispatchNewGuideEvent(_guideData.Id, 2, 0, 0, isSkip, (float)(System.DateTime.Now - startTime).TotalSeconds);
		if (_guideData._guideType == GuideStepType.Highlight)
		{
			MonoECS.instance.PopPause();
		}
		if (_guideData._guideType == GuideStepType.Highlight)
		{
			Singleton<GameState>.instance.SetInGuiding(inGuiding: false);
			Singleton<GameInputActionManager>.instance.SetGameInputState(GameInputState.Guide, active: false);
		}
		if (_imageStation != null)
		{
			ImageManager.instance.UnloadAssetStation(_imageStation);
			_imageStation = null;
		}
		if (_guideData.FinshActions.Length != 0)
		{
			GuideStepAction[] finshActions = _guideData.FinshActions;
			for (int i = 0; i < finshActions.Length; i++)
			{
				finshActions[i].Execute(null);
			}
		}
		SendCurrentGuideComplete();
		_tokenSource?.Cancel();
		SendGuideFinshEvent(_guideData.Id);
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"id: {_guideData.Id},强引导完成移除队列引导");
		}
		_guideData = null;
		_stepData = null;
		_inStrongGuide = false;
		isgm = false;
		if (!TryOpenNextGuideInQueueImmediately())
		{
			SetHandleActionActive(active: true);
			CurrentController = null;
		}
	}

	private void SendGuideFinshEvent(int id)
	{
		GuideFinishEvt evt = Singleton<EventManager>.instance.GetEvt<GuideFinishEvt>();
		evt.guideId = id;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Guide_Finish, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private bool TryOpenNextGuideInQueueImmediately()
	{
		if (_guideQueue.Count == 0)
		{
			return false;
		}
		UpdateQueue.Clear();
		UpdateQueue.AddRange(_guideQueue);
		foreach (GuideQueueInfo item in UpdateQueue)
		{
			if (!TryFinishQueuedGuide(item) && GudieCheckAllCondition(item.guideId) && GuideDataPrepare(item.guideId))
			{
				StartInfo = item;
				OpenGuide(item.guideId, item.isgm).Forget();
				return true;
			}
		}
		return false;
	}

	private void ToNextStep(CancellationToken token, GuideData guideData)
	{
		guideData.ToNextStep(out _stepData);
		if (_stepData != null)
		{
			StartStep(token, guideData, _stepData);
		}
		else
		{
			FinishGuide();
		}
	}

	public void SetController()
	{
		if (!(_stepData is HighlightStepData))
		{
			return;
		}
		_ = _stepData;
		if (Singleton<NewUIManager>.instance.TryGetFirstUIController(_stepData._precondition, out var ui))
		{
			CurrentController = ui.GetUIView().InputController;
			SetHandleActionActive(active: false);
			if (!string.IsNullOrEmpty(_stepData._actionPath) && !_stepData._actionPath.Equals("None"))
			{
				SetHandeActionCallbackActive(_stepData._actionPath, active: true, CurrentController);
			}
		}
	}

	private async void StartStep(CancellationToken token, GuideData guideData, GuideStepData stepData)
	{
		GamePlayerInput.GetCurrent().ClearEntityState(MonoECS.instance.mainEntity);
		_ = _stepData;
		if (guideData._guideType == GuideStepType.Highlight)
		{
			MonoECS.instance.PushPauseUIInput();
		}
		if (stepData.Actions.Length != 0)
		{
			GuideStepAction[] actions = stepData.Actions;
			for (int i = 0; i < actions.Length; i++)
			{
				actions[i].Execute(null);
			}
		}
		if (stepData._precondition != UI_TYPE.UI_NONE && !stepData.Prepare())
		{
			_waitPreCondition = true;
			await UniTask.WaitUntil(() => stepData.Prepare(), PlayerLoopTiming.Update, token).SuppressCancellationThrow();
			if (token.IsCancellationRequested)
			{
				_waitPreCondition = false;
				if (guideData._guideType == GuideStepType.Highlight)
				{
					MonoECS.instance.PopPauseUIInput();
				}
				Debug.Log("guidemodel WaitUntil _stepData.Prepare()  token IsCancellationRequested");
				return;
			}
			_waitPreCondition = false;
		}
		if (stepData.Type == GuideStepType.SoftHighlight && stepData is SoftHighlightStepData)
		{
			SoftHighlightStepData softHighlightStepData = stepData as SoftHighlightStepData;
			if (softHighlightStepData.DeleteTime > 0)
			{
				AddDeleteTime(softHighlightStepData.DeleteTime);
			}
		}
		stepData.OnStart();
		_onStepStart?.Invoke(stepData);
		SetController();
		if (guideData._guideType == GuideStepType.Highlight)
		{
			MonoECS.instance.PopPauseUIInput();
		}
		stepStartTime = System.DateTime.Now;
		if (guideData != null && stepData != null)
		{
			DispatchNewGuideEvent(guideData.Id, 1, stepData.Id, (int)stepData.Type, skip: false, 0f);
		}
	}

	private void AddDeleteTime(int DeleteTime)
	{
		if (_DeleteDelayer.IsValid())
		{
			_DeleteDelayer.Cancel();
		}
		_DeleteDelayer = UpdateTimer.Default.DelayMs(DeleteTime * 1000, () =>
		{
			OnFinshGuide();
		});
	}

	private void FinishStep(bool tonext = true, bool isSkip = false)
	{
		if (_DeleteDelayer.IsValid())
		{
			_DeleteDelayer.Cancel();
		}
		DispatchNewGuideEvent(_guideData.Id, 2, _stepData.Id, (int)_stepData.Type, isSkip, (float)(System.DateTime.Now - stepStartTime).TotalSeconds);
		if (_guideData._guideType == GuideStepType.Highlight)
		{
			if (!(_stepData is HighlightStepData))
			{
				return;
			}
			if (!string.IsNullOrEmpty(_stepData._actionPath))
			{
				if (!_stepData._actionPath.Equals("None"))
				{
					SetHandeActionCallbackActive(_stepData._actionPath, active: false, CurrentController);
				}
				SetHandleActionActive(active: true);
				CurrentController = null;
			}
			HighlightStepData highlightStepData = _stepData as HighlightStepData;
			if (highlightStepData.FinshActions.Length != 0)
			{
				GuideStepAction[] finshActions = highlightStepData.FinshActions;
				for (int i = 0; i < finshActions.Length; i++)
				{
					finshActions[i].Execute(null);
				}
			}
		}
		_stepData.OnFinish();
		_onStepFinish?.Invoke(_stepData.Id);
		if (_guideData._finishStepIndex >= 0 && _guideData._curStepIndex == _guideData._finishStepIndex)
		{
			SendCurrentGuideComplete();
		}
		if (tonext)
		{
			ToNextStep(_tokenSource.Token, _guideData);
		}
	}

	private void SendCurrentGuideComplete()
	{
		if (!isgm && !_guideCompleteSent)
		{
			_guideCompleteSent = true;
			SendGuideComplete(_guideData.Id);
		}
	}

	public void OpenTips(int id)
	{
		_opentips = true;
		UIUtility.OpenGuideTipView(id);
	}

	public void CloseTips(bool hideNotComplete = false)
	{
		if (_opentips)
		{
			UIUtility.CloseGuideTipView(hideNotComplete);
			_opentips = false;
		}
	}

	private void OnLeaveWorld(BaseEventContent obj)
	{
		if (_stepData != null)
		{
			OnFinshGuide();
		}
	}

	private void OnAllDie(BaseEventContent obj)
	{
		if (_stepData != null)
		{
			OnFinshGuide();
		}
	}

	private void OnReconnectServer(BaseEventContent obj)
	{
		foreach (KeyValuePair<int, Guide> item in _allSoftGuide)
		{
			if (GuideHasTriggeredAndFinsh(item.Value.GuideId))
			{
				item.Value.OnFinish();
				item.Value.FinishGuide();
			}
		}
	}

	private void OnGmGuideFinsh(BaseEventContent obj)
	{
		if (!(obj is GmToolGuideFinishEvt gmToolGuideFinishEvt))
		{
			return;
		}
		if (gmToolGuideFinishEvt.isAllFinsh)
		{
			FinshAllSoftGuide();
			for (int i = 0; i < _guideConfigs.guideConfigs.Count; i++)
			{
				SendGuideComplete(_guideConfigs.guideConfigs[i].id);
			}
			if (_guideData != null)
			{
				OnFinshGuide();
			}
			_guideQueue.Clear();
		}
		if (gmToolGuideFinishEvt.finshCurrent)
		{
			if (_guideData != null)
			{
				OnFinshGuide();
			}
			FinshAllSoftGuide();
		}
		if (gmToolGuideFinishEvt.guideId == 0)
		{
			return;
		}
		GuideConfig config = _guideConfigs.GetConfig(gmToolGuideFinishEvt.guideId);
		if (config == null)
		{
			return;
		}
		Guide value;
		if (config.guideType == GuideStepType.Highlight)
		{
			if (_guideData?.Id == gmToolGuideFinishEvt.guideId)
			{
				OnFinshGuide();
				return;
			}
			for (int j = 0; j < _guideQueue.Count; j++)
			{
				if (_guideQueue[j].guideId == gmToolGuideFinishEvt.guideId)
				{
					_guideQueue.RemoveAt(j);
					SendGuideComplete(gmToolGuideFinishEvt.guideId);
				}
			}
		}
		else if (_allSoftGuide.TryGetValue(gmToolGuideFinishEvt.guideId, out value))
		{
			value.OnFinish();
			value.FinishGuide();
		}
		else
		{
			SendGuideComplete(gmToolGuideFinishEvt.guideId);
		}
	}

	private void FinshAllSoftGuide()
	{
		foreach (KeyValuePair<int, Guide> item in _allSoftGuide)
		{
			item.Value.OnFinish();
			item.Value.FinishGuide();
		}
	}

	private void OnTP(BaseEventContent obj)
	{
		if (_stepData != null)
		{
			OnFinshGuide();
		}
	}

	private void OnStepSuccess(BaseEventContent content)
	{
		if (content is GuideStepFinishEvt content2 && _stepData != null)
		{
			OnReceiveEvent(new HighlightSuccessEvent(), content2);
		}
	}

	private void OnUIOpen(BaseEventContent evt)
	{
		_ = evt is UIEvent;
	}

	private void OnUIClose(BaseEventContent evt)
	{
		_ = evt is UIEvent;
	}

	private void OnBacktoBattlemain(BaseEventContent obj)
	{
	}

	private void OnDeleteTimeFinshGuide(BaseEventContent content)
	{
		if (content is GuideDeleteTimeFinshEvt guideDeleteTimeFinshEvt && _stepData != null && guideDeleteTimeFinshEvt.stepId == _stepData.Id)
		{
			OnFinshGuide();
		}
	}

	private void OnFinshGuide(bool isSkip = false)
	{
		FinishStep(tonext: false, isSkip);
		FinishGuide(isSkip);
	}

	private void OnReceiveEvent(GuideSuccessEventData eventData, GuideStepFinishEvt content)
	{
		if (content.Iserror)
		{
			_ = LuminApplication.LogEnabled;
			OnFinshGuide();
		}
		else if (_stepData.IsSuccess(eventData) && _stepData._guideType == content.type)
		{
			FinishStep();
		}
	}

	private void OnPlayerWorldLevelChange(BaseEventContent evt)
	{
		if (evt is ExpChangesEvt)
		{
			GuideConfig unlockConfig = _guideConfigs.GetUnlockConfig();
			if (unlockConfig != null)
			{
				StartGuide(unlockConfig.id);
			}
		}
	}

	public void StartGuide(int id, bool isGm = false)
	{
		if (!RuntimeConfigs.data.softHighLightSystems.ContainsKey(id))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"id: {id},没有配置,无法调用");
			}
		}
		else if (isGm)
		{
			OnStartGuide(id, isGm);
		}
		else
		{
			OnStartGuide(id, isGm);
			SendGuideUnlock(id, (GuideUnlockAck ack) =>
			{
			});
		}
	}

	private void OnStartGuide(int id, bool isGm = false)
	{
		GuideConfig config = _guideConfigs.GetConfig(id);
		if (config == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"id: {id},没有配置,无法调用");
			}
		}
		else if (GuideHasTriggeredAndFinsh(id) && !isGm)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"id: {id},已经触发过且不是gm触发,无法调用");
			}
		}
		else if (config.guideType == GuideStepType.Highlight)
		{
			StrongGuidance(id, isGm);
		}
		else if (config.guideType == GuideStepType.SoftHighlight)
		{
			SoftGuidance(id, isGm);
		}
	}

	private void StrongGuidance(int id, bool isGm)
	{
		GuideQueueInfo guideQueueInfo = new GuideQueueInfo
		{
			guideId = id,
			isgm = isGm
		};
		GuideData guideData = new GuideData(_guideConfigs.GetConfig(id), MonoECS.instance.ispc);
		guideData.ToFirstStep(out var _);
		if (guideData.Actions.Length != 0)
		{
			GuideStepAction[] actions = guideData.Actions;
			for (int i = 0; i < actions.Length; i++)
			{
				actions[i].Execute(null);
			}
		}
		if (GudieCheckAllCondition(guideQueueInfo.guideId) && GuideDataPrepare(guideQueueInfo.guideId))
		{
			StartInfo = guideQueueInfo;
			OpenGuide(guideQueueInfo.guideId, guideQueueInfo.isgm).Forget();
		}
		else if (!_guideQueue.Contains(guideQueueInfo))
		{
			_guideQueue.Add(guideQueueInfo);
			if (LuminApplication.LogEnabled)
			{
				int num = ((_guideData != null) ? _guideData.Id : 0);
				Debug.Log($"id: {id}，强引导进入队列,当前引导id:{num}");
			}
		}
	}

	private void SoftGuidance(int id, bool isGm)
	{
		if (_allSoftGuide.ContainsKey(id))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"id: {id}，在触发列表里不能重复添加");
			}
		}
		else
		{
			GuideConfig config = _guideConfigs.GetConfig(id);
			GuideData guideData = new GuideData(config, MonoECS.instance.ispc);
			Guide guide = new Guide(config, guideData);
			guide.StartGuide();
			_allSoftGuide.Add(id, guide);
		}
	}

	public static string GenerateGuideWidgetKey(UI_TYPE uiType, CharacterViewScene.CvSceneType secondViewType, FindHighlightObjAction findAction)
	{
		string text = $"{uiType}_{secondViewType}";
		if (findAction != null)
		{
			text = text + "_" + findAction.GetType().Name;
			if (!string.IsNullOrEmpty(findAction.path))
			{
				text = text + "_" + findAction.path;
			}
			if (findAction is FindObjInLayoutGroup findObjInLayoutGroup)
			{
				text += $"_{findObjInLayoutGroup.index}";
			}
		}
		return text;
	}

	public SoftHighlightWidget GetOrCreateGuideWidget(string key)
	{
		if (_createdGuideWidgets.TryGetValue(key, out var value))
		{
			return value;
		}
		return null;
	}

	public void RegisterGuideWidget(string key, SoftHighlightWidget widget)
	{
		if (widget != null)
		{
			_createdGuideWidgets[key] = widget;
			if (_guideWidgetRefCounts.ContainsKey(key))
			{
				_guideWidgetRefCounts[key]++;
			}
			else
			{
				_guideWidgetRefCounts[key] = 1;
			}
		}
	}

	public bool UnregisterGuideWidget(string key)
	{
		if (_guideWidgetRefCounts.ContainsKey(key))
		{
			_guideWidgetRefCounts[key]--;
			if (_guideWidgetRefCounts[key] <= 0)
			{
				if (_createdGuideWidgets.TryGetValue(key, out var value))
				{
					value?.UnInit();
					_createdGuideWidgets.Remove(key);
				}
				_guideWidgetRefCounts.Remove(key);
				return true;
			}
		}
		return false;
	}

	public void SetCharacterTargetLevel(int level)
	{
		_characterTargetLevel = level;
	}

	public int GetCharacterTargetLevel()
	{
		return _characterTargetLevel;
	}

	public GuideConfigs GetGuideConfigs()
	{
		return _guideConfigs;
	}

	public void SkipCurrentStrongGuide()
	{
		if (IsInStrongGuide() && _guideData != null)
		{
			OnFinshGuide(isSkip: true);
		}
	}

	private bool CheckStrongGudieCanOpen()
	{
		if (!Singleton<ConversationManager>.instance.IsPlaying && Singleton<ProtagonistManager>.instance.PlayerControlState != PlayerControlState.Protagonist)
		{
			return !Model<BattleMainModel>.Interface.IsBack;
		}
		return false;
	}
}
