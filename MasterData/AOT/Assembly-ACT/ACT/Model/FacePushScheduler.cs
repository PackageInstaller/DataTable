using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Config;
using ACT.Drama;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model.Jump;
using ACT.UI;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Battle.ChaseBattle;
using UnityEngine;

namespace ACT.Model;

public sealed class FacePushScheduler
{
	private const int ShowingFacePushTimeoutMilliseconds = 60000;

	private const int WaitingJumpTargetTimeoutMilliseconds = 180000;

	private const int ConfigPendingDataRetryMilliseconds = 200;

	private const float ConfigPendingDataTimeoutSeconds = 10f;

	private const int FacePushUIReadyRetryMilliseconds = 200;

	private const float ChaseBossBattleWaitTimeoutSeconds = 120f;

	private const int WorldEntryFacePushDelayMilliseconds = 1500;

	private const int AvgEndFacePushDelayMilliseconds = 1500;

	private readonly FacePushModel _model;

	private readonly HashSet<int> _handledInCurrentRun = new HashSet<int>();

	private readonly HashSet<int> _handledMonthCardPassesInCurrentRun = new HashSet<int>();

	private FacePushSchedulerState _state;

	private FacePushSourceType _currentSourceType;

	private PopUp _currentConfig;

	private UI_TYPE _waitingTargetUI;

	private bool _waitingWorldReload;

	private bool _currentConfigShowRecorded;

	private float _configPendingDataStartRealtime = -1f;

	private bool _configPendingDataRetryScheduled;

	private int _configPendingDataRetryVersion;

	private bool _facePushUIReadyRetryScheduled;

	private int _facePushUIReadyRetryVersion;

	private bool _shopMonthCardRetryScheduled;

	private int _shopMonthCardRetryVersion;

	private bool _hasPendingCheck;

	private bool _isChecking;

	private int _nextSessionId;

	private int _currentSessionId;

	private CancellationTokenSource _timeoutCts;

	private bool _isAvgPlaying;

	private bool _isConversationPlaying;

	private float _facePushBlockedUntilRealtime = -1f;

	private int _facePushDelayVersion;

	private bool _isWaitingNextFacePush;

	private bool _isWaitingForChaseBossBattle;

	private bool _isHandlingTeamDeath;

	private bool _hasEnteredChaseBossBattle;

	private float _chaseBossBattleWaitUntilRealtime = -1f;

	private bool _focusLostForDailyRefresh;

	private System.DateTime _focusLostRefreshDate;

	private System.DateTime _lastFacePushRefreshDate;

	private string _openBlockReason;

	private string _monthCardSkipReason;

	private string _jumpFailReason;

	public FacePushSchedulerState State => _state;

	public FacePushSourceType CurrentSourceType => _currentSourceType;

	public PopUp CurrentConfig => _currentConfig;

	public FacePushSession CurrentSession { get; private set; }

	public bool IsHudQueueBlocked { get; private set; }

	public bool IsShortcutInputBlocked
	{
		get
		{
			if (_state != FacePushSchedulerState.ShowingFacePush)
			{
				return _isWaitingNextFacePush;
			}
			return true;
		}
	}

	public event Action<PopUp> OpenRequested;

	public FacePushScheduler(FacePushModel model)
	{
		_model = model;
	}

	public void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Open, OnUIChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Close, OnUIChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_AfterShowAni, OnUIChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Guide_Finish, OnGuideFinished);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterEnterWorld, OnAfterEnterWorld);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SystemUnLockHudOver, OnSystemUnlockHudOver);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_RefreshActivityCenter, OnFacePushDataChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_UpdateActivitySignInInfo, OnFacePushDataChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Conversation_AVG_Start, OnAVGStarted);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Conversation_AVG_End, OnAVGEnded);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ChaseBattleFailed, OnChaseBattleFailed);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ChaseBattleFinished, OnChaseBattleFinished);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleStateChange, OnBattleStateChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Team_RespawnCompelete, OnTeamRespawnComplete);
		MonoECS.instance.playerStateChange += new Action<PlayState, PlayState>(OnPlayerStateChange);
		MonoECS.instance.OnApplicationFocusChanged += OnApplicationFocusChanged;
	}

	public void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Open, OnUIChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Close, OnUIChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_AfterShowAni, OnUIChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Guide_Finish, OnGuideFinished);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AfterEnterWorld, OnAfterEnterWorld);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SystemUnLockHudOver, OnSystemUnlockHudOver);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_RefreshActivityCenter, OnFacePushDataChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_UpdateActivitySignInInfo, OnFacePushDataChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Conversation_AVG_Start, OnAVGStarted);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Conversation_AVG_End, OnAVGEnded);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ChaseBattleFailed, OnChaseBattleFailed);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ChaseBattleFinished, OnChaseBattleFinished);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleStateChange, OnBattleStateChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Team_RespawnCompelete, OnTeamRespawnComplete);
		if (MonoECS.instance != null)
		{
			MonoECS.instance.playerStateChange -= new Action<PlayState, PlayState>(OnPlayerStateChange);
			MonoECS.instance.OnApplicationFocusChanged -= OnApplicationFocusChanged;
		}
		_isHandlingTeamDeath = false;
		_handledInCurrentRun.Clear();
		_handledMonthCardPassesInCurrentRun.Clear();
		_currentSourceType = FacePushSourceType.None;
		_currentConfig = null;
		_currentConfigShowRecorded = false;
		CurrentSession = null;
		_currentSessionId = 0;
		_nextSessionId = 0;
		_waitingTargetUI = UI_TYPE.UI_NONE;
		_waitingWorldReload = false;
		ResetConfigPendingDataState(cancelScheduledRetry: true);
		CancelFacePushUIReadyRetry();
		CancelShopMonthCardFacePushRetry();
		_hasPendingCheck = false;
		_isChecking = false;
		_isAvgPlaying = false;
		_isConversationPlaying = false;
		CancelFacePushStartDelay();
		CancelStateTimeout();
		_state = FacePushSchedulerState.Idle;
		_isWaitingNextFacePush = false;
		ClearChaseBossBattleWait();
		_focusLostForDailyRefresh = false;
		_focusLostRefreshDate = default;
		_lastFacePushRefreshDate = default;
		IsHudQueueBlocked = false;
		OpenRequested = null;
	}

	private void OnApplicationFocusChanged(bool hasFocus)
	{
		if (hasFocus)
		{
			if (_focusLostForDailyRefresh)
			{
				_focusLostForDailyRefresh = false;
				if (GetFacePushRefreshDate() != _focusLostRefreshDate)
				{
					RequestCheck();
				}
			}
		}
		else if (!_focusLostForDailyRefresh)
		{
			_focusLostForDailyRefresh = true;
			_focusLostRefreshDate = GetFacePushRefreshDate();
		}
	}

	private static System.DateTime GetFacePushRefreshDate()
	{
		return TimeManager.ServerTime.Now.AddHours(-4.0).Date;
	}

	private void RefreshDailyFacePushState()
	{
		System.DateTime facePushRefreshDate = GetFacePushRefreshDate();
		if (_lastFacePushRefreshDate == default(System.DateTime))
		{
			_lastFacePushRefreshDate = facePushRefreshDate;
		}
		else if (!(_lastFacePushRefreshDate == facePushRefreshDate))
		{
			_lastFacePushRefreshDate = facePushRefreshDate;
			_handledInCurrentRun.Clear();
			_handledMonthCardPassesInCurrentRun.Clear();
			_hasPendingCheck = true;
		}
	}

	public void RequestCheck()
	{
		bool flag = _model.HasPendingShopMonthlyPassFacePush();
		if (!_model.CanRequestCheckInCurrentScene())
		{
			FacePushFlowLog.Fail("请求拍脸检查", _model.SceneCheckBlockReason);
			if (flag)
			{
				ScheduleShopMonthCardFacePushRetry();
			}
			EndHudQueueBlock();
			return;
		}
		_hasPendingCheck = true;
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.FacePush))
		{
			_hasPendingCheck = false;
			EndHudQueueBlock();
			FacePushFlowLog.Fail("请求拍脸检查", "拍脸系统未解锁");
			return;
		}
		BeginHudQueueBlock();
		if (IsFacePushStartDelayed())
		{
			ScheduleFacePushStartDelayRetry();
			FacePushFlowLog.Fail("请求拍脸检查", "拍脸启动延迟未结束");
		}
		else
		{
			FacePushFlowLog.Success("请求拍脸检查", "已进入调度");
			TryContinue();
		}
	}

	public bool TryOpenMonthCardRewardDirect()
	{
		if (_isChecking || _state == FacePushSchedulerState.ShowingFacePush || _state == FacePushSchedulerState.WaitingJumpTargetClose)
		{
			FacePushFlowLog.Fail("背包月卡拍脸", $"调度器正忙，当前状态 {_state}");
			return false;
		}
		return TryRequestOpenMonthCardReward(allowCoveringCurrentPanel: true);
	}

	public void NotifyLoadingDone()
	{
		if (_state != FacePushSchedulerState.WaitingJumpTargetClose)
		{
			BeginFacePushStartDelay(1500);
		}
	}

	public void NotifyCurrentFacePushClosed()
	{
		if (_state != FacePushSchedulerState.ShowingFacePush)
		{
			FacePushFlowLog.Fail("处理拍脸关闭", $"当前状态是 {_state}，不是展示中");
			return;
		}
		_isWaitingNextFacePush = true;
		switch (_currentSourceType)
		{
		case FacePushSourceType.ConfigPopUp:
			if (_currentConfig == null)
			{
				FacePushFlowLog.FailAlways("处理拍脸关闭", "当前配置为空");
				return;
			}
			RecordCurrentConfigShownIfNeeded();
			MarkCurrentHandled();
			break;
		default:
			FacePushFlowLog.FailAlways("处理拍脸关闭", $"来源 {_currentSourceType} 没有后续关闭流程");
			return;
		case FacePushSourceType.MonthCardReward:
			break;
		}
		ClearCurrent();
		FacePushFlowLog.SuccessAlways("处理拍脸关闭", "已继续检查下一条");
		RequestCheck();
	}

	public bool TryRefreshCurrentFacePushWithSameUI(UI_TYPE uiType)
	{
		if (_state != FacePushSchedulerState.ShowingFacePush || _currentSourceType != FacePushSourceType.ConfigPopUp || _currentConfig == null)
		{
			FacePushFlowLog.Fail("同界面刷新", $"当前不能刷新，状态 {_state}，来源 {_currentSourceType}");
			return false;
		}
		RecordCurrentConfigShownIfNeeded();
		MarkCurrentHandled();
		_model.Refresh();
		PopUp popUp = null;
		IReadOnlyList<PopUp> sortedFacePushes = _model.SortedFacePushes;
		for (int i = 0; i < sortedFacePushes.Count; i++)
		{
			PopUp popUp2 = sortedFacePushes[i];
			switch (GetConfigCheckResult(popUp2))
			{
			case FacePushConfigCheckResult.PendingData:
				FacePushFlowLog.Fail("同界面刷新", _model.ConfigCheckReason);
				return false;
			case FacePushConfigCheckResult.CanShow:
				popUp = popUp2;
				break;
			case FacePushConfigCheckResult.CannotShow:
				continue;
			}
			break;
		}
		if (popUp == null)
		{
			FacePushFlowLog.Fail("同界面刷新", "没有下一条可复用的配置");
			return false;
		}
		if (!_model.TryGetFacePushUIType(popUp, out var uiType2))
		{
			FacePushFlowLog.Fail("同界面刷新", $"配置 {popUp.id} 无法解析界面类型");
			return false;
		}
		if (uiType2 != uiType)
		{
			FacePushFlowLog.Fail("同界面刷新", $"下一条界面是 {uiType2}，不是 {uiType}");
			return false;
		}
		PopUp currentConfig = _currentConfig;
		FacePushSession currentSession = CurrentSession;
		int currentSessionId = _currentSessionId;
		bool currentConfigShowRecorded = _currentConfigShowRecorded;
		_currentConfig = popUp;
		_currentConfigShowRecorded = false;
		CurrentSession = CreateCurrentSession(FacePushSourceType.ConfigPopUp, popUp);
		StartStateTimeout(FacePushSchedulerState.ShowingFacePush, 60000);
		if (_model.TryRefreshCurrentFacePushView(popUp, CurrentSession))
		{
			FacePushFlowLog.SuccessAlways("同界面刷新", $"配置 {popUp.id}");
			return true;
		}
		_currentConfig = currentConfig;
		_currentConfigShowRecorded = currentConfigShowRecorded;
		CurrentSession = currentSession;
		_currentSessionId = currentSessionId;
		StartStateTimeout(FacePushSchedulerState.ShowingFacePush, 60000);
		FacePushFlowLog.Fail("同界面刷新", $"配置 {popUp.id} 的界面拒绝刷新");
		return false;
	}

	public void NotifyCurrentFacePushJumpClicked()
	{
		if (_state != FacePushSchedulerState.ShowingFacePush || _currentSourceType != FacePushSourceType.ConfigPopUp || _currentConfig == null)
		{
			FacePushFlowLog.Fail("拍脸跳转", $"当前不能跳转，状态 {_state}，来源 {_currentSourceType}");
			return;
		}
		_isWaitingNextFacePush = false;
		PopUp currentConfig = _currentConfig;
		RecordCurrentConfigShownIfNeeded();
		MarkCurrentHandled();
		ClearCurrent();
		if (!TryJumpAndWait(currentConfig))
		{
			FacePushFlowLog.FailAlways("拍脸跳转", $"配置 {currentConfig?.id} 跳转未开始：{_jumpFailReason}");
			RequestCheck();
		}
	}

	public void NotifyCurrentFacePushOpenFailed()
	{
		if (_state != FacePushSchedulerState.ShowingFacePush)
		{
			FacePushFlowLog.Fail("处理打开失败", $"当前状态是 {_state}，不是展示中");
			return;
		}
		string text = CurrentSession?.OpenFailReason;
		if (string.IsNullOrEmpty(text))
		{
			text = "未提供具体原因";
		}
		FacePushFlowLog.FailAlways("弹出拍脸", $"来源 {_currentSourceType}，配置 {_currentConfig?.id}，原因：{text}");
		if (_currentSourceType == FacePushSourceType.ConfigPopUp)
		{
			MarkCurrentHandled();
		}
		ClearCurrent();
		RequestCheck();
	}

	public bool IsShowingMonthCardReward()
	{
		if (_state == FacePushSchedulerState.ShowingFacePush)
		{
			return _currentSourceType == FacePushSourceType.MonthCardReward;
		}
		return false;
	}

	public void RefreshHudQueueBlockState()
	{
		if (IsChaseBattleInProgress())
		{
			IsHudQueueBlocked = false;
		}
		else if (IsSubWorldActive())
		{
			IsHudQueueBlocked = false;
		}
		else if (IsBossBattleInProgress())
		{
			IsHudQueueBlocked = false;
		}
		else if (IsHudQueueBlocked)
		{
			TryContinue();
		}
	}

	internal bool NotifySessionClosed(FacePushSession session)
	{
		if (!IsCurrentSession(session))
		{
			return false;
		}
		NotifyCurrentFacePushClosed();
		return true;
	}

	internal bool NotifySessionCloseTransitionStarted(FacePushSession session)
	{
		if (!IsCurrentSession(session))
		{
			return false;
		}
		NotifyCurrentFacePushClosed();
		return true;
	}

	internal bool NotifySessionJumpClicked(FacePushSession session)
	{
		if (!IsCurrentSession(session))
		{
			return false;
		}
		NotifyCurrentFacePushJumpClicked();
		return true;
	}

	internal bool NotifySessionOpenFailed(FacePushSession session)
	{
		if (!IsCurrentSession(session))
		{
			return false;
		}
		NotifyCurrentFacePushOpenFailed();
		return true;
	}

	internal bool NotifySessionShown(FacePushSession session)
	{
		if (!IsCurrentSession(session))
		{
			FacePushFlowLog.Fail("拍脸展示", "会话已过期");
			return false;
		}
		FacePushFlowLog.SuccessAlways("拍脸展示", $"来源 {session.SourceType}，配置 {session.Config?.id}");
		RecordCurrentConfigShownIfNeeded();
		_model.RecordFacePushShownForCurrentDay();
		return true;
	}

	private void OnUIChanged(BaseEventContent content)
	{
		if (IsConversationPlaying())
		{
			_isConversationPlaying = true;
			CancelFacePushStartDelay();
			AbortCurrentFacePushForConversation();
			return;
		}
		if (_isConversationPlaying)
		{
			_isConversationPlaying = false;
			BeginFacePushStartDelay(1500);
		}
		TryContinue();
	}

	private void OnGuideFinished(BaseEventContent content)
	{
		RequestCheck();
	}

	private void OnSystemUnlockHudOver(BaseEventContent content)
	{
		RequestCheck();
	}

	private void OnFacePushDataChanged(BaseEventContent content)
	{
		CancelConfigPendingDataRetry();
		RequestCheck();
	}

	private void OnAfterEnterWorld(BaseEventContent content)
	{
		if (_state == FacePushSchedulerState.WaitingJumpTargetClose && _waitingWorldReload)
		{
			_waitingWorldReload = false;
			_waitingTargetUI = UI_TYPE.UI_NONE;
			_state = FacePushSchedulerState.Idle;
		}
		else
		{
			BeginFacePushStartDelay(1500);
		}
		RequestCheck();
	}

	private void OnAVGStarted(BaseEventContent content)
	{
		_isAvgPlaying = true;
		CancelFacePushStartDelay();
		AbortCurrentFacePushForConversation();
	}

	private void OnAVGEnded(BaseEventContent content)
	{
		_isAvgPlaying = false;
		BeginFacePushStartDelay(1500);
	}

	private void OnChaseBattleFailed(BaseEventContent content)
	{
		BeginChaseBossBattleWait();
	}

	private void OnChaseBattleFinished(BaseEventContent content)
	{
		BeginChaseBossBattleWait();
	}

	private void OnBattleStateChanged(BaseEventContent content)
	{
		if (content is BattleStateChange battleStateChange)
		{
			if (battleStateChange.to == BattleState.Boss)
			{
				IsHudQueueBlocked = false;
			}
			else if (battleStateChange.from == BattleState.Boss)
			{
				RequestCheckAfterPlayerStateChanged().Forget();
			}
		}
	}

	private void BeginChaseBossBattleWait()
	{
		_isWaitingForChaseBossBattle = true;
		_hasEnteredChaseBossBattle = false;
		_chaseBossBattleWaitUntilRealtime = Time.realtimeSinceStartup + 120f;
	}

	private void OnPlayerStateChange(PlayState from, PlayState to)
	{
		if (to == PlayState.Death)
		{
			CloseFacePushForTeamDeath();
		}
		if (_isWaitingForChaseBossBattle)
		{
			if (to == PlayState.Battle)
			{
				_hasEnteredChaseBossBattle = true;
			}
			else if (_hasEnteredChaseBossBattle && to == PlayState.UnBattle)
			{
				ClearChaseBossBattleWait();
				RequestCheckAfterPlayerStateChanged().Forget();
			}
		}
	}

	private void TryContinue()
	{
		try
		{
			TryContinueInternal();
		}
		catch (Exception exception)
		{
			HandleUnexpectedException(exception);
		}
	}

	private void TryContinueInternal()
	{
		RefreshDailyFacePushState();
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.FacePush) || _isChecking)
		{
			return;
		}
		if (_state == FacePushSchedulerState.WaitingJumpTargetClose)
		{
			TryFinishWaitingJump();
		}
		else
		{
			if (_state == FacePushSchedulerState.ShowingFacePush)
			{
				return;
			}
			if (!_hasPendingCheck && _state == FacePushSchedulerState.Idle && _model.HasPendingShopMonthlyPassFacePush())
			{
				_hasPendingCheck = true;
				BeginHudQueueBlock();
			}
			if (!_hasPendingCheck)
			{
				if (_state == FacePushSchedulerState.Idle)
				{
					EndHudQueueBlock();
				}
				return;
			}
			if (CanOpenFacePushNow())
			{
				_isChecking = true;
				_state = FacePushSchedulerState.CheckingNext;
				try
				{
					_hasPendingCheck = false;
					_model.Refresh();
					IReadOnlyList<PopUp> sortedFacePushes = _model.SortedFacePushes;
					bool flag = false;
					bool flag2 = false;
					for (int i = 0; i < sortedFacePushes.Count; i++)
					{
						PopUp popUp = sortedFacePushes[i];
						switch (GetConfigCheckResult(popUp))
						{
						case FacePushConfigCheckResult.CannotShow:
							FacePushFlowLog.Fail($"配置 {popUp?.id} 筛选", _model.ConfigCheckReason);
							continue;
						case FacePushConfigCheckResult.PendingData:
							FacePushFlowLog.Fail($"配置 {popUp?.id} 筛选", _model.ConfigCheckReason);
							if (!WaitConfigPendingDataAndRetry(popUp))
							{
								continue;
							}
							flag2 = true;
							break;
						}
						if (flag2)
						{
							break;
						}
						FacePushFlowLog.Success($"配置 {popUp.id} 筛选", _model.ConfigCheckReason);
						if (TryRequestOpenConfig(popUp))
						{
							return;
						}
						flag = true;
						break;
					}
					if (!flag | flag2)
					{
						if (!flag2)
						{
							ResetConfigPendingDataState(cancelScheduledRetry: true);
						}
						if (TryRequestOpenMonthCardReward())
						{
							return;
						}
						if (_model.IsSupplementaryFacePushSuppressedForCurrentLogin)
						{
							FacePushFlowLog.Fail("时效性道具拍脸", "本次登录的补充拍脸被抑制");
						}
						else if (TryRequestOpenLimitItemTips())
						{
							if (flag2)
							{
								ScheduleConfigPendingDataRetry();
							}
							return;
						}
					}
					if (flag && !flag2 && TryRequestOpenMonthCardReward())
					{
						return;
					}
					if (flag2)
					{
						_state = FacePushSchedulerState.Idle;
						FacePushFlowLog.Fail("本轮拍脸", "高优先级配置仍在等待服务器数据");
						if (ShouldRetryShopMonthlyPassFacePush())
						{
							ScheduleShopMonthCardFacePushRetry();
						}
					}
					else if (ShouldRetryShopMonthlyPassFacePush())
					{
						_state = FacePushSchedulerState.Idle;
						ScheduleShopMonthCardFacePushRetry();
						FacePushFlowLog.Fail("商店月卡拍脸", "数据未就绪或这一帧未打开，稍后重试");
					}
					else
					{
						_state = FacePushSchedulerState.Idle;
						EndHudQueueBlock();
						FacePushFlowLog.Fail("本轮拍脸", "没有可弹出的配置、月卡或时效性道具");
					}
					return;
				}
				finally
				{
					_isChecking = false;
					if (_hasPendingCheck && _state == FacePushSchedulerState.Idle)
					{
						if (IsFacePushUIWaitingForReady())
						{
							ScheduleFacePushUIReadyRetry();
						}
						else
						{
							TryContinue();
						}
					}
				}
			}
			FacePushFlowLog.Fail("等待可弹时机", _openBlockReason);
			if (_hasPendingCheck && IsFacePushUIWaitingForReady())
			{
				ScheduleFacePushUIReadyRetry();
			}
			if (ShouldRetryShopMonthlyPassFacePush())
			{
				ScheduleShopMonthCardFacePushRetry();
			}
		}
	}

	private bool TryRequestOpenConfig(PopUp config)
	{
		if (OpenRequested == null)
		{
			_state = FacePushSchedulerState.Idle;
			FacePushFlowLog.Fail($"打开配置 {config?.id}", "UI层未订阅打开事件");
			return false;
		}
		_currentSourceType = FacePushSourceType.ConfigPopUp;
		_currentConfig = config;
		_currentConfigShowRecorded = false;
		_state = FacePushSchedulerState.ShowingFacePush;
		_isWaitingNextFacePush = false;
		ResetConfigPendingDataState(cancelScheduledRetry: true);
		CancelFacePushUIReadyRetry();
		CurrentSession = CreateCurrentSession(FacePushSourceType.ConfigPopUp, config);
		StartStateTimeout(FacePushSchedulerState.ShowingFacePush, 60000);
		CloseActiveHudQueueDisplays();
		if (!CanOpenFacePushNow())
		{
			FacePushFlowLog.Fail($"打开配置 {config?.id}", _openBlockReason + "，已延后重试");
			return DeferCurrentFacePushOpenForUI();
		}
		try
		{
			OpenRequested(config);
		}
		catch (Exception ex)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(ex);
			}
			ClearCurrent();
			FacePushFlowLog.FailAlways($"打开配置 {config?.id}", "打开事件异常：" + ex.Message);
			return false;
		}
		FacePushFlowLog.Success($"打开配置 {config?.id}", "已通知UI层打开");
		return true;
	}

	private bool TryRequestOpenMonthCardReward(bool allowCoveringCurrentPanel = false)
	{
		if (!TryResolveMonthCardRewardPassId(allowCoveringCurrentPanel, out var monthlyPassId))
		{
			FacePushFlowLog.Fail("月卡拍脸", _monthCardSkipReason);
			return false;
		}
		if (!CanOpenFacePushNow(allowCoveringCurrentPanel))
		{
			if (allowCoveringCurrentPanel)
			{
				FacePushFlowLog.Fail("月卡拍脸", _openBlockReason);
				return false;
			}
			FacePushFlowLog.Fail("月卡拍脸", _openBlockReason + "，已延后重试");
			return DeferCurrentFacePushOpenForUI();
		}
		_handledMonthCardPassesInCurrentRun.Add(monthlyPassId);
		_currentSourceType = FacePushSourceType.MonthCardReward;
		_state = FacePushSchedulerState.ShowingFacePush;
		_isWaitingNextFacePush = false;
		CurrentSession = CreateCurrentSession(FacePushSourceType.MonthCardReward, null);
		StartStateTimeout(FacePushSchedulerState.ShowingFacePush, 60000);
		CloseActiveHudQueueDisplays();
		try
		{
			if (!Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_MONTHCARDREWARD, new MonthCardRewardViewData
			{
				monthlyPassId = monthlyPassId,
				FacePushSession = CurrentSession
			}).IsValid)
			{
				_handledMonthCardPassesInCurrentRun.Remove(monthlyPassId);
				ClearCurrent();
				FacePushFlowLog.FailAlways("月卡拍脸", $"月卡 {monthlyPassId} OpenUI 无效");
				return false;
			}
		}
		catch (Exception ex)
		{
			_handledMonthCardPassesInCurrentRun.Remove(monthlyPassId);
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(ex);
			}
			ClearCurrent();
			FacePushFlowLog.FailAlways("月卡拍脸", $"月卡 {monthlyPassId} 打开异常：{ex.Message}");
			return false;
		}
		_model.ClearPendingShopMonthlyPassFacePush(monthlyPassId);
		FacePushFlowLog.SuccessAlways("月卡拍脸", $"已打开月卡 {monthlyPassId}");
		return true;
	}

	private bool TryRequestOpenLimitItemTips()
	{
		if (!Model<InventoryModel>.HasInstance() || !Model<InventoryModel>.Interface.HasLimitItemTips())
		{
			FacePushFlowLog.Fail("时效性道具拍脸", "没有待提示的时效性道具");
			return false;
		}
		_currentSourceType = FacePushSourceType.LimitItemTips;
		_state = FacePushSchedulerState.ShowingFacePush;
		_isWaitingNextFacePush = false;
		CloseActiveHudQueueDisplays();
		if (!CanOpenFacePushNow())
		{
			FacePushFlowLog.Fail("时效性道具拍脸", _openBlockReason + "，已延后重试");
			return DeferCurrentFacePushOpenForUI();
		}
		try
		{
			Model<InventoryModel>.Interface.PopupLimitItemTips();
			_model.RecordFacePushShownForCurrentDay();
		}
		catch (Exception ex)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(ex);
			}
			ClearCurrent();
			FacePushFlowLog.FailAlways("时效性道具拍脸", "打开异常：" + ex.Message);
			return false;
		}
		ClearCurrent();
		EndHudQueueBlock();
		FacePushFlowLog.SuccessAlways("时效性道具拍脸", "已打开提示");
		return true;
	}

	private bool TryGetMonthCardRewardPassId(out int monthlyPassId)
	{
		monthlyPassId = 0;
		if (Model<ShopModel>.HasInstance())
		{
			Dictionary<int, MonthlyPassEntry> monthlyPassData = Model<ShopModel>.Interface.MonthlyPassData;
			if (monthlyPassData != null && monthlyPassData.Count > 0)
			{
				bool flag = false;
				bool flag2 = false;
				foreach (KeyValuePair<int, MonthlyPassEntry> monthlyPassDatum in Model<ShopModel>.Interface.MonthlyPassData)
				{
					MonthlyPassEntry value = monthlyPassDatum.Value;
					if (value == null || _handledMonthCardPassesInCurrentRun.Contains(value.PassId))
					{
						flag = value != null;
						continue;
					}
					if (!Model<ShopModel>.Interface.MonthlyPassValid(value.PassId) || !Model<ShopModel>.Interface.IsNeedPopPassDailyReward(value.PassId))
					{
						flag2 = true;
						continue;
					}
					monthlyPassId = value.PassId;
					return true;
				}
				if (flag)
				{
					_monthCardSkipReason = "本轮月卡奖励已经弹过";
				}
				else if (flag2)
				{
					_monthCardSkipReason = "月卡未生效或今天不需要弹每日奖励";
				}
				else
				{
					_monthCardSkipReason = "没有可弹的月卡";
				}
				return false;
			}
		}
		_monthCardSkipReason = "没有月卡数据";
		return false;
	}

	private bool TryResolveMonthCardRewardPassId(bool allowCoveringCurrentPanel, out int monthlyPassId)
	{
		if (!allowCoveringCurrentPanel && TryGetShopPurchaseMonthCardPassId(out monthlyPassId))
		{
			return true;
		}
		string monthCardSkipReason = _monthCardSkipReason;
		if (TryGetMonthCardRewardPassId(out monthlyPassId))
		{
			return true;
		}
		if (!allowCoveringCurrentPanel && _model.HasPendingShopMonthlyPassFacePush() && !string.IsNullOrEmpty(monthCardSkipReason))
		{
			_monthCardSkipReason = monthCardSkipReason;
		}
		return false;
	}

	private bool TryGetShopPurchaseMonthCardPassId(out int monthlyPassId)
	{
		monthlyPassId = 0;
		if (!_model.TryGetPendingShopMonthlyPassId(out var passId))
		{
			_monthCardSkipReason = "没有商店购买待弹月卡";
			return false;
		}
		if (_handledMonthCardPassesInCurrentRun.Contains(passId))
		{
			_monthCardSkipReason = $"商店月卡 {passId} 本轮已经弹过";
			return false;
		}
		if (!Model<ShopModel>.HasInstance() || Model<ShopModel>.Interface.MonthlyPassData == null)
		{
			_monthCardSkipReason = $"商店月卡 {passId} 的存档未就绪";
			return false;
		}
		if (!Model<ShopModel>.Interface.MonthlyPassData.TryGetValue(passId, out var value) || value == null)
		{
			_monthCardSkipReason = $"商店月卡 {passId} 的数据未下发";
			return false;
		}
		if (!Model<ShopModel>.Interface.MonthlyPassValid(passId))
		{
			_model.ClearPendingShopMonthlyPassFacePush(passId);
			_monthCardSkipReason = $"商店月卡 {passId} 已失效";
			return false;
		}
		monthlyPassId = passId;
		return true;
	}

	private bool ShouldRetryShopMonthlyPassFacePush()
	{
		if (!_model.TryGetPendingShopMonthlyPassId(out var passId) || _handledMonthCardPassesInCurrentRun.Contains(passId))
		{
			return false;
		}
		if (Model<ShopModel>.HasInstance() && Model<ShopModel>.Interface.MonthlyPassData != null && Model<ShopModel>.Interface.MonthlyPassData.TryGetValue(passId, out var value) && value != null && !Model<ShopModel>.Interface.MonthlyPassValid(passId))
		{
			_model.ClearPendingShopMonthlyPassFacePush(passId);
			return false;
		}
		return true;
	}

	private bool CanOpenFacePushNow(bool allowCoveringCurrentPanel = false)
	{
		_openBlockReason = null;
		NewUIManager instance = Singleton<NewUIManager>.instance;
		if (instance == null || instance.IsUIManagerBusy())
		{
			_openBlockReason = ((instance == null) ? "UI管理器未初始化" : "UI管理器正忙");
			return false;
		}
		bool flag = _isConversationPlaying || IsConversationPlaying();
		if (_isAvgPlaying | flag)
		{
			_openBlockReason = (_isAvgPlaying ? "AVG播放中" : "对话播放中");
			return false;
		}
		if (!allowCoveringCurrentPanel && IsFacePushStartDelayed())
		{
			_openBlockReason = "拍脸启动延迟未结束";
			return false;
		}
		IBaseUIController topActivePanel = instance.GetTopActivePanel();
		if (topActivePanel == null || topActivePanel.State != UIState.Opened || topActivePanel.ExpectedState != UIExpectedState.Open || topActivePanel.IsInHideRoot)
		{
			_openBlockReason = ((topActivePanel == null) ? "没有打开的顶层界面" : $"顶层界面 {topActivePanel.UIType} 未稳定打开，state={topActivePanel.State}，expected={topActivePanel.ExpectedState}");
			return false;
		}
		if (!allowCoveringCurrentPanel && topActivePanel.UIType != UI_TYPE.UI_BATTLEMAIN)
		{
			_openBlockReason = $"顶层界面是 {topActivePanel.UIType}，不是主界面";
			return false;
		}
		if (!allowCoveringCurrentPanel)
		{
			IBaseUIController topActiveUI = instance.GetTopActiveUI();
			if (topActiveUI == null || topActiveUI.UIType != UI_TYPE.UI_BATTLEMAIN)
			{
				_openBlockReason = ((topActiveUI == null) ? "没有顶层UI" : $"顶层UI是 {topActiveUI.UIType}，不是主界面");
				return false;
			}
		}
		if (Singleton<GameState>.instance != null && Singleton<GameState>.instance.InSystemUnlock)
		{
			_openBlockReason = "系统解锁表现播放中";
			return false;
		}
		if (Singleton<SystemUnlockManager>.instance != null && Singleton<SystemUnlockManager>.instance.SystemUnlockUiEvtHasContent())
		{
			_openBlockReason = "系统解锁队列未播完";
			return false;
		}
		if (Model<GuideModel>.HasInstance() && Model<GuideModel>.Interface.IsInStrongGuide())
		{
			_openBlockReason = "强引导进行中";
			return false;
		}
		if (Singleton<GameState>.instance != null && Singleton<GameState>.instance.InGuiding)
		{
			_openBlockReason = "引导进行中";
			return false;
		}
		if (Singleton<ConversationManager>.instance != null && Singleton<ConversationManager>.instance.IsPlaying)
		{
			_openBlockReason = "普通对话播放中";
			return false;
		}
		if (Singleton<TimelineConversationManager>.HasInstance() && Singleton<TimelineConversationManager>.instance.Playing)
		{
			_openBlockReason = "Timeline对话播放中";
			return false;
		}
		if (IsWaitingForChaseBossBattle())
		{
			_openBlockReason = "等待追逐战后的Boss战";
			return false;
		}
		if (IsTeamDeathOrRespawn())
		{
			_openBlockReason = "全队死亡或复活中，等待复活界面";
			return false;
		}
		if (IsBossBattleInProgress())
		{
			_openBlockReason = "Boss战进行中";
			return false;
		}
		if (Singleton<ChaseBattleManager>.HasInstance() && Singleton<ChaseBattleManager>.instance.IsInChaseBattle)
		{
			_openBlockReason = "追逐战进行中";
			return false;
		}
		return true;
	}

	private bool IsWaitingForChaseBossBattle()
	{
		if (!_isWaitingForChaseBossBattle)
		{
			return false;
		}
		if (_hasEnteredChaseBossBattle)
		{
			return true;
		}
		if (Time.realtimeSinceStartup < _chaseBossBattleWaitUntilRealtime)
		{
			return true;
		}
		ClearChaseBossBattleWait();
		return false;
	}

	private void ClearChaseBossBattleWait()
	{
		_isWaitingForChaseBossBattle = false;
		_hasEnteredChaseBossBattle = false;
		_chaseBossBattleWaitUntilRealtime = -1f;
	}

	private bool IsFacePushUIWaitingForReady()
	{
		NewUIManager instance = Singleton<NewUIManager>.instance;
		if (instance == null)
		{
			return false;
		}
		if (instance.IsUIManagerBusy())
		{
			return true;
		}
		return instance.GetTopActivePanel()?.IsInHideRoot ?? true;
	}

	private void ScheduleFacePushUIReadyRetry()
	{
		if (!_facePushUIReadyRetryScheduled)
		{
			_facePushUIReadyRetryScheduled = true;
			RetryFacePushUIReadyAsync(++_facePushUIReadyRetryVersion).Forget();
		}
	}

	private async UniTaskVoid RetryFacePushUIReadyAsync(int retryVersion)
	{
		await UniTask.Delay(200);
		if (retryVersion == _facePushUIReadyRetryVersion)
		{
			_facePushUIReadyRetryScheduled = false;
			if (_hasPendingCheck && _state == FacePushSchedulerState.Idle)
			{
				RequestCheck();
			}
		}
	}

	private void CancelFacePushUIReadyRetry()
	{
		_facePushUIReadyRetryScheduled = false;
		_facePushUIReadyRetryVersion++;
	}

	private bool DeferCurrentFacePushOpenForUI()
	{
		ClearCurrent();
		_hasPendingCheck = true;
		BeginHudQueueBlock();
		ScheduleFacePushUIReadyRetry();
		return true;
	}

	private void ScheduleShopMonthCardFacePushRetry()
	{
		if (!_shopMonthCardRetryScheduled && ShouldRetryShopMonthlyPassFacePush())
		{
			_shopMonthCardRetryScheduled = true;
			RetryShopMonthCardFacePushAsync(++_shopMonthCardRetryVersion).Forget();
		}
	}

	private async UniTaskVoid RetryShopMonthCardFacePushAsync(int retryVersion)
	{
		await UniTask.Delay(200);
		if (retryVersion != _shopMonthCardRetryVersion)
		{
			return;
		}
		_shopMonthCardRetryScheduled = false;
		if (ShouldRetryShopMonthlyPassFacePush())
		{
			if (_state != FacePushSchedulerState.Idle)
			{
				ScheduleShopMonthCardFacePushRetry();
			}
			else if (!_model.CanRequestCheckInCurrentScene() || Singleton<SystemUnlockManager>.instance == null || !Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.FacePush))
			{
				ScheduleShopMonthCardFacePushRetry();
			}
			else
			{
				RequestCheck();
			}
		}
	}

	private void CancelShopMonthCardFacePushRetry()
	{
		_shopMonthCardRetryScheduled = false;
		_shopMonthCardRetryVersion++;
	}

	private async UniTaskVoid RequestCheckAfterPlayerStateChanged()
	{
		await UniTask.Yield();
		RequestCheck();
	}

	private FacePushConfigCheckResult GetConfigCheckResult(PopUp config)
	{
		if (config == null || config.enabled == 0)
		{
			_model.SetConfigCheckReason((config == null) ? "配置为空" : $"配置 {config.id} 未启用");
			return FacePushConfigCheckResult.CannotShow;
		}
		if (_handledInCurrentRun.Contains(config.id))
		{
			_model.SetConfigCheckReason($"配置 {config.id} 本轮已经处理过");
			return FacePushConfigCheckResult.CannotShow;
		}
		return _model.GetConfigFacePushCheckResult(config);
	}

	private void RecordCurrentConfigShownIfNeeded()
	{
		if (_currentSourceType == FacePushSourceType.ConfigPopUp && _currentConfig != null && !_currentConfigShowRecorded)
		{
			_model.RecordConfigFacePushShown(_currentConfig);
			_currentConfigShowRecorded = true;
		}
	}

	private void MarkCurrentHandled()
	{
		if (_currentConfig != null)
		{
			_handledInCurrentRun.Add(_currentConfig.id);
		}
		ResetConfigPendingDataState(cancelScheduledRetry: true);
	}

	private void ClearCurrent()
	{
		CancelStateTimeout();
		_currentConfig = null;
		_currentConfigShowRecorded = false;
		_currentSourceType = FacePushSourceType.None;
		CurrentSession = null;
		_currentSessionId = 0;
		_state = FacePushSchedulerState.Idle;
	}

	private bool IsConversationPlaying()
	{
		NewUIManager instance = Singleton<NewUIManager>.instance;
		if (instance == null)
		{
			return false;
		}
		if (!IsUIOpening(instance, UI_TYPE.UI_CONVERSATION))
		{
			return IsUIOpening(instance, UI_TYPE.UI_CONVERSATION_WITHOUTHEAD);
		}
		return true;
	}

	private static bool IsUIOpening(NewUIManager uiManager, UI_TYPE uiType)
	{
		if (!uiManager.TryGetFirstUIController(uiType, out var ui))
		{
			return false;
		}
		if (ui.ExpectedState == UIExpectedState.Open)
		{
			return ui.State != UIState.Closed;
		}
		return false;
	}

	private void AbortCurrentFacePushForConversation()
	{
		if (_state == FacePushSchedulerState.ShowingFacePush)
		{
			FacePushFlowLog.FailAlways("拍脸展示", $"来源 {_currentSourceType}，配置 {_currentConfig?.id} 被对话或AVG打断");
			if (_currentSourceType == FacePushSourceType.ConfigPopUp && _currentConfigShowRecorded)
			{
				MarkCurrentHandled();
			}
			ClearCurrent();
			_hasPendingCheck = true;
			EndHudQueueBlock();
		}
	}

	private void BeginHudQueueBlock()
	{
		if (IsChaseBattleInProgress())
		{
			IsHudQueueBlocked = false;
		}
		else if (IsSubWorldActive())
		{
			IsHudQueueBlocked = false;
		}
		else if (IsBossBattleInProgress())
		{
			IsHudQueueBlocked = false;
		}
		else
		{
			IsHudQueueBlocked = true;
		}
	}

	private static bool IsSubWorldActive()
	{
		if (MonoECS.instance != null)
		{
			return MonoECS.instance.sceneStatus != SceneStatus.Main;
		}
		return false;
	}

	private static bool IsChaseBattleInProgress()
	{
		if (Singleton<ChaseBattleManager>.HasInstance())
		{
			return Singleton<ChaseBattleManager>.instance.IsInChaseBattle;
		}
		return false;
	}

	private bool IsTeamDeathOrRespawn()
	{
		if (_isHandlingTeamDeath)
		{
			return true;
		}
		if (MonoECS.instance != null && MonoECS.instance.playState == PlayState.Death)
		{
			return true;
		}
		if (Singleton<GameState>.instance != null)
		{
			return Singleton<GameState>.instance.PlayerAlive != PlayerLiveState.Normal;
		}
		return false;
	}

	private void OnTeamRespawnComplete(BaseEventContent content)
	{
		RequestCheck();
	}

	private void CloseFacePushForTeamDeath()
	{
		if (_isHandlingTeamDeath || _state != FacePushSchedulerState.ShowingFacePush)
		{
			return;
		}
		_isHandlingTeamDeath = true;
		try
		{
			UI_TYPE uiType = UI_TYPE.UI_NONE;
			if (_currentSourceType == FacePushSourceType.ConfigPopUp)
			{
				if (_currentConfig != null)
				{
					_model.TryGetFacePushUIType(_currentConfig, out uiType);
				}
				if (_currentConfigShowRecorded)
				{
					MarkCurrentHandled();
				}
			}
			else if (_currentSourceType == FacePushSourceType.MonthCardReward)
			{
				uiType = UI_TYPE.UI_MONTHCARDREWARD;
			}
			string[] array = new string[5]
			{
				"来源 ",
				_currentSourceType.ToString(),
				"，配置 ",
				null,
				null
			};
			string text;
			if (_currentConfig == null)
			{
				text = "无";
			}
			else
			{
				int id = _currentConfig.id;
				text = id.ToString();
			}
			array[3] = text;
			array[4] = " 被全队死亡打断，关闭拍脸以打开复活界面";
			FacePushFlowLog.FailAlways("拍脸展示", string.Concat(array));
			ClearCurrent();
			_hasPendingCheck = true;
			EndHudQueueBlock();
			if (uiType != UI_TYPE.UI_NONE && Singleton<NewUIManager>.instance != null)
			{
				Singleton<NewUIManager>.instance.CloseUI(uiType);
			}
		}
		finally
		{
			_isHandlingTeamDeath = false;
		}
	}

	private static bool IsBossBattleInProgress()
	{
		if (Singleton<GameState>.instance != null)
		{
			return Singleton<GameState>.instance.BattleState == BattleState.Boss;
		}
		return false;
	}

	private void EndHudQueueBlock()
	{
		ResetConfigPendingDataState(cancelScheduledRetry: true);
		CancelFacePushUIReadyRetry();
		_isWaitingNextFacePush = false;
		IsHudQueueBlocked = false;
	}

	private bool WaitConfigPendingDataAndRetry(PopUp config)
	{
		if (_configPendingDataStartRealtime < 0f)
		{
			_configPendingDataStartRealtime = Time.realtimeSinceStartup;
		}
		if (Time.realtimeSinceStartup - _configPendingDataStartRealtime < 10f)
		{
			_state = FacePushSchedulerState.Idle;
			ScheduleConfigPendingDataRetry();
			return true;
		}
		if (config != null)
		{
			FacePushFlowLog.FailAlways("等待配置数据", $"配置 {config.id} 超过 {10f} 秒仍未就绪，本轮跳过");
		}
		CancelConfigPendingDataRetry();
		return false;
	}

	private void ScheduleConfigPendingDataRetry()
	{
		if (!_configPendingDataRetryScheduled)
		{
			_configPendingDataRetryScheduled = true;
			RetryConfigPendingDataAsync(++_configPendingDataRetryVersion).Forget();
		}
	}

	private async UniTaskVoid RetryConfigPendingDataAsync(int retryVersion)
	{
		await UniTask.Delay(200);
		if (retryVersion == _configPendingDataRetryVersion)
		{
			_configPendingDataRetryScheduled = false;
			RequestCheck();
		}
	}

	private void ResetConfigPendingDataState(bool cancelScheduledRetry)
	{
		_configPendingDataStartRealtime = -1f;
		if (cancelScheduledRetry)
		{
			CancelConfigPendingDataRetry();
		}
	}

	private bool IsFacePushStartDelayed()
	{
		return _facePushBlockedUntilRealtime > Time.realtimeSinceStartup;
	}

	private void BeginFacePushStartDelay(int delayMilliseconds)
	{
		_hasPendingCheck = true;
		BeginHudQueueBlock();
		float num = Time.realtimeSinceStartup + (float)delayMilliseconds * 0.001f;
		if (!(num <= _facePushBlockedUntilRealtime))
		{
			_facePushBlockedUntilRealtime = num;
			ScheduleFacePushStartDelayRetry();
		}
	}

	private void CancelFacePushStartDelay()
	{
		_facePushBlockedUntilRealtime = -1f;
		_facePushDelayVersion++;
	}

	private void ScheduleFacePushStartDelayRetry()
	{
		RetryFacePushStartDelayAsync(++_facePushDelayVersion).Forget();
	}

	private async UniTaskVoid RetryFacePushStartDelayAsync(int delayVersion)
	{
		float num = _facePushBlockedUntilRealtime - Time.realtimeSinceStartup;
		if (num > 0f)
		{
			await UniTask.Delay(Math.Max(1, (int)Math.Ceiling(num * 1000f)));
		}
		if (delayVersion == _facePushDelayVersion && !IsFacePushStartDelayed())
		{
			_facePushBlockedUntilRealtime = -1f;
			if (_hasPendingCheck)
			{
				RequestCheck();
			}
		}
	}

	private void CancelConfigPendingDataRetry()
	{
		_configPendingDataRetryScheduled = false;
		_configPendingDataRetryVersion++;
	}

	private void StartStateTimeout(FacePushSchedulerState state, int timeoutMilliseconds)
	{
		CancelStateTimeout();
		_timeoutCts = new CancellationTokenSource();
		WaitStateTimeoutAsync(state, timeoutMilliseconds, _timeoutCts.Token).Forget();
	}

	private async UniTask WaitStateTimeoutAsync(FacePushSchedulerState expectedState, int timeoutMilliseconds, CancellationToken token)
	{
		try
		{
			await UniTask.Delay(timeoutMilliseconds, ignoreTimeScale: false, PlayerLoopTiming.Update, token);
		}
		catch (OperationCanceledException)
		{
			return;
		}
		if (!token.IsCancellationRequested && _state == expectedState)
		{
			HandleStateTimeout(expectedState);
		}
	}

	private void CancelStateTimeout()
	{
		if (_timeoutCts != null)
		{
			CancellationTokenSource timeoutCts = _timeoutCts;
			_timeoutCts = null;
			timeoutCts.Cancel();
			timeoutCts.Dispose();
		}
	}

	private void HandleStateTimeout(FacePushSchedulerState timeoutState)
	{
		FacePushFlowLog.FailAlways("等待状态超时", (timeoutState == FacePushSchedulerState.ShowingFacePush) ? $"来源 {_currentSourceType}，配置 {_currentConfig?.id} 长时间没有关闭、跳转或失败回调" : "跳转目标长时间没有回到可弹时机");
		CancelStateTimeout();
		switch (timeoutState)
		{
		case FacePushSchedulerState.ShowingFacePush:
			NotifyCurrentFacePushOpenFailed();
			break;
		case FacePushSchedulerState.WaitingJumpTargetClose:
			_waitingTargetUI = UI_TYPE.UI_NONE;
			_waitingWorldReload = false;
			_state = FacePushSchedulerState.Idle;
			RequestCheck();
			break;
		}
	}

	private void HandleUnexpectedException(Exception exception)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.LogException(exception);
		}
		_hasPendingCheck = false;
		_isChecking = false;
		_waitingTargetUI = UI_TYPE.UI_NONE;
		_waitingWorldReload = false;
		ClearCurrent();
		EndHudQueueBlock();
	}

	private void CloseActiveHudQueueDisplays()
	{
		OnHudForceClose evt = Singleton<EventManager>.instance.GetEvt<OnHudForceClose>();
		evt.position = UIPosition.UpperMiddle;
		evt.type = HudComponentType.RegionNameTip;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HUDUIForceClose, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private FacePushSession CreateCurrentSession(FacePushSourceType sourceType, PopUp config)
	{
		_nextSessionId++;
		if (_nextSessionId <= 0)
		{
			_nextSessionId = 1;
		}
		_currentSessionId = _nextSessionId;
		return new FacePushSession(this, _currentSessionId, sourceType, config);
	}

	private bool IsCurrentSession(FacePushSession session)
	{
		if (session != null && _state == FacePushSchedulerState.ShowingFacePush && session.SessionId == _currentSessionId)
		{
			return session.SourceType == _currentSourceType;
		}
		return false;
	}

	private bool TryJumpAndWait(PopUp config)
	{
		if (!TryBuildJumpData(config, out var jumpData))
		{
			return false;
		}
		if (!CanJump(jumpData))
		{
			return false;
		}
		_waitingTargetUI = ResolveTargetUI(jumpData);
		_waitingWorldReload = jumpData.JumpType == 1;
		_state = FacePushSchedulerState.WaitingJumpTargetClose;
		StartStateTimeout(FacePushSchedulerState.WaitingJumpTargetClose, 180000);
		try
		{
			Model<JumpModel>.Interface.JumpTo(jumpData);
		}
		catch (Exception ex)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(ex);
			}
			CancelStateTimeout();
			_waitingTargetUI = UI_TYPE.UI_NONE;
			_waitingWorldReload = false;
			_state = FacePushSchedulerState.Idle;
			_jumpFailReason = "跳转异常：" + ex.Message;
			return false;
		}
		TryFinishWaitingJump();
		if (_state == FacePushSchedulerState.WaitingJumpTargetClose)
		{
			FacePushFlowLog.SuccessAlways("拍脸跳转", $"配置 {config?.id} 已跳转，等待目标关闭");
			return true;
		}
		if (_state == FacePushSchedulerState.Idle)
		{
			return true;
		}
		_jumpFailReason = "跳转没有停留在等待状态";
		return false;
	}

	private bool TryBuildJumpData(PopUp config, out RuntimeJumpData jumpData)
	{
		jumpData = default;
		if (config?.jumpParam == null || config.jumpParam.Length == 0 || config.jumpParam[0] == 0)
		{
			_jumpFailReason = $"配置 {config?.id} 没有跳转参数";
			return false;
		}
		jumpData = ItemJumpHelper.GetRunTimeJumpData(config.jumpParam[0]);
		if (jumpData.Params == null)
		{
			_jumpFailReason = $"跳转配置 {config.jumpParam[0]} 不存在";
			return false;
		}
		return true;
	}

	private bool CanJump(RuntimeJumpData jumpData)
	{
		if (!Model<JumpModel>.HasInstance())
		{
			_jumpFailReason = "跳转模块未初始化";
			return false;
		}
		JumpResult jumpResult = Model<JumpModel>.Interface.CanJump(jumpData);
		bool flag = jumpResult.ShowType == JumpResult.JumpShowType.CanJump;
		if (!flag)
		{
			_jumpFailReason = $"跳转条件不满足：{jumpResult.ShowType}";
		}
		jumpResult.Release();
		return flag;
	}

	private UI_TYPE ResolveTargetUI(RuntimeJumpData jumpData)
	{
		if (jumpData.JumpType != 2 || jumpData.Params == null || jumpData.Params.Count == 0)
		{
			return UI_TYPE.UI_NONE;
		}
		if (!JumpModel.UIJumpIdToUITypeMap.TryGetValue(jumpData.Params[0], out var value))
		{
			return UI_TYPE.UI_NONE;
		}
		return (UI_TYPE)value.Item1;
	}

	private void TryFinishWaitingJump()
	{
		if (_state == FacePushSchedulerState.WaitingJumpTargetClose)
		{
			if (_waitingWorldReload)
			{
				FacePushFlowLog.Fail("结束跳转等待", "世界仍在加载");
				return;
			}
			if (!IsWaitingTargetClosed())
			{
				FacePushFlowLog.Fail("结束跳转等待", $"目标界面 {_waitingTargetUI} 仍未关闭");
				return;
			}
			if (!CanOpenFacePushNow())
			{
				FacePushFlowLog.Fail("结束跳转等待", _openBlockReason);
				return;
			}
			_waitingTargetUI = UI_TYPE.UI_NONE;
			_state = FacePushSchedulerState.Idle;
			CancelStateTimeout();
			FacePushFlowLog.SuccessAlways("结束跳转等待", "已回到可弹时机");
			RequestCheck();
		}
	}

	private bool IsWaitingTargetClosed()
	{
		if (_waitingTargetUI == UI_TYPE.UI_NONE)
		{
			return true;
		}
		NewUIManager instance = Singleton<NewUIManager>.instance;
		if (instance.GetFirstUIExpectedState(_waitingTargetUI) != UIExpectedState.Open)
		{
			return !NewUIManager.IsUIStateBusy(instance.GetFirstUIState(_waitingTargetUI));
		}
		return false;
	}
}
