using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using ACT.Battle;
using ACT.Event;
using ACT.LocalLoader;
using ACT.Utility;
using Bamboo.Pool;
using Coffee.UIExtensions;
using Cysharp.Threading.Tasks;
using Cysharp.Threading.Tasks.Linq;
using Fundamental;
using UnityEngine;
using UnityEngine.InputSystem.UI;
using UnityEngine.Pool;
using UnityEngine.Rendering.Universal.Internal;
using UnityEngine.UI;

namespace ACT.UI;

public class NewUIManager : Singleton<NewUIManager>
{
	private enum BlackScreenFadeState
	{
		FadeIn,
		FadeOut
	}

	private enum BlackScreenFadeTrigger
	{
		None,
		FadeIn,
		FadeOut
	}

	public struct UIOpenData
	{
		public uint Uid;

		public UI_TYPE UIType;

		public object OpenData;
	}

	private enum PanelTransitionOperation
	{
		Open,
		CloseAndPop
	}

	private enum PanelTransitionPhase
	{
		WaitingForBlack,
		LoadingTarget,
		WaitingForSource,
		WaitingForVisuals,
		WaitingForBlackHidden
	}

	private sealed class PanelTransitionContext
	{
		public PanelTransitionOperation Operation;

		public PanelTransitionPhase Phase;

		public UIOpenData Request;

		public IBaseUIController From;

		public IBaseUIController To;

		public IBaseUIController Restore;

		public bool UseBlackScreen;

		public bool UseCrossFade;

		public bool SourceActionStarted;

		public bool TargetActionStarted;

		public bool RestoreActionStarted;

		public bool RestorePrepared;

		public bool BlackFadeOutRequested;

		public void Reset()
		{
			Operation = PanelTransitionOperation.Open;
			Phase = PanelTransitionPhase.WaitingForBlack;
			Request = default;
			From = null;
			To = null;
			Restore = null;
			UseBlackScreen = false;
			UseCrossFade = false;
			SourceActionStarted = false;
			TargetActionStarted = false;
			RestoreActionStarted = false;
			RestorePrepared = false;
			BlackFadeOutRequested = false;
		}
	}

	private Image _blackScreenImage;

	private float _alpha;

	private float _fullyVisibleStartTime = -1f;

	private BlackScreenFadeState _blackScreenFadeState = BlackScreenFadeState.FadeOut;

	private BlackScreenFadeTrigger _blackScreenFadeTrigger;

	private bool _hasLoggedFadeOutPending;

	private bool _hasLoggedFullyVisible;

	private bool _hasLoggedHidden = true;

	private const float BLACK_SCREEN_FADE_SPEED = 2f;

	private const float BLACK_SCREEN_MIN_VISIBLE_DURATION = 0.2f;

	private IDisposable _update;

	private bool _isImmediateUIUpdateRunning;

	private bool _immediateUIUpdateRequested;

	private UI_TYPE _hudUIType = UI_TYPE.UI_BATTLEMAIN;

	private static bool _enableInactiveUIActiveOptimization = true;

	private InputControllerContainer _inputControllerContainer;

	private bool _activeInput = true;

	private bool _internalActiveInput = true;

	private bool _externalActiveInput = true;

	private Dictionary<uint, IBaseUIController> _allUI = new Dictionary<uint, IBaseUIController>();

	private Dictionary<UI_TYPE, List<IBaseUIController>> _uiPool = new Dictionary<UI_TYPE, List<IBaseUIController>>();

	private Dictionary<UI_TYPE, List<IBaseUIController>> _allLifeUI = new Dictionary<UI_TYPE, List<IBaseUIController>>();

	private readonly List<IBaseUIController> _nonPanelLifeUI = new List<IBaseUIController>();

	private readonly Dictionary<uint, IBaseUIController> _openRequestAliases = new Dictionary<uint, IBaseUIController>();

	private float _nextPoolCleanupTime = float.PositiveInfinity;

	private uint _incrementingId;

	private CancellationTokenSource _cancellationTokenSource;

	private HashSet<UI_TYPE> _cachedUIs = new HashSet<UI_TYPE>();

	private NewUIManagerMonoProxy _monoProxy;

	public bool NeedPop = true;

	public readonly int HideLayer = LayerMask.NameToLayer("Hidden");

	public readonly int UILayer = LayerMask.NameToLayer("UI");

	private readonly List<UIOpenData> _openQueue = new List<UIOpenData>();

	private readonly PanelTransitionContext _reusablePanelTransition = new PanelTransitionContext();

	private PanelTransitionContext _panelTransition;

	public ConfigSafeArea ConfigSafeArea;

	public const int UncoveredBorderBias = 105;

	public const int CoveredBorderBias = 40;

	public const int SetBorderBias = 85;

	private List<IBaseUIController> _pauseGameUI = new List<IBaseUIController>();

	private readonly Dictionary<object, List<UIEffectRendering>> _uiRenderingEffects = new Dictionary<object, List<UIEffectRendering>>();

	private readonly HashSet<IBaseUIController> _catchCameraUIs = new HashSet<IBaseUIController>();

	private readonly Dictionary<IBaseUIController, UIEffectRendering> _catchCameraEffects = new Dictionary<IBaseUIController, UIEffectRendering>();

	private readonly int _basePanelSortingLayer = 10;

	private readonly List<IBaseUIController> _uiStack = new List<IBaseUIController>();

	private readonly List<IBaseUIController> _activePanelQueue = new List<IBaseUIController>();

	private bool _panelCloseCleanupRequested;

	private readonly Dictionary<UI_TYPE, UIParticleUpdateMark> _uiParticleUpdateMarks = new Dictionary<UI_TYPE, UIParticleUpdateMark>();

	public bool EnableInactiveUIActiveOptimization
	{
		get
		{
			return _enableInactiveUIActiveOptimization;
		}
		set
		{
			if (_enableInactiveUIActiveOptimization != value)
			{
				_enableInactiveUIActiveOptimization = value;
				RefreshInactiveUIActiveState();
			}
		}
	}

	public List<UI_TYPE> KeepActiveWhenHiddenUITypes { get; } = new List<UI_TYPE> { UI_TYPE.UI_BATTLEMAIN };

	public UI_TYPE HudUITYPE
	{
		get
		{
			return _hudUIType;
		}
		set
		{
			_hudUIType = value;
		}
	}

	public override ContextType ContextType => ContextType.GLOBAL;

	public static SortingLayer[] SortingLayers { get; } = SortingLayer.layers;

	public bool ActiveInput
	{
		get
		{
			return _activeInput;
		}
		set
		{
			if (_activeInput != value)
			{
				_activeInput = value;
				OnInputActiveChanged(value);
			}
		}
	}

	public bool InternalActiveInput
	{
		get
		{
			return _internalActiveInput;
		}
		private set
		{
			if (_internalActiveInput != value)
			{
				_internalActiveInput = value;
				ActiveInput = InternalActiveInput && ExternalActiveInput;
			}
		}
	}

	public bool ExternalActiveInput
	{
		get
		{
			return _externalActiveInput;
		}
		set
		{
			if (_externalActiveInput != value)
			{
				_externalActiveInput = value;
				ActiveInput = InternalActiveInput && ExternalActiveInput;
			}
		}
	}

	private static Dictionary<UI_TYPE, UIData> UIData => CommonUIData.DICT_UI_DATA;

	public InputSystemUIInputModule InputModule => _monoProxy.inputModule;

	public Transform PanelRoot => _monoProxy.panelRoot;

	public Transform PopRoot => _monoProxy.popRoot;

	public Transform ToastRoot => _monoProxy.toastRoot;

	public Transform TipRoot => _monoProxy.tipRoot;

	public RectTransform UIEffectRoot => _monoProxy.uiEffectRoot;

	public BlurUIEffect UIBlurEffect => _monoProxy?.uiBlurEffect;

	public Image NewUIManagerBlackScreen => _monoProxy.newUIManagerBlackScreen;

	public FrameworkBlackScreen BlackScreen => _monoProxy.blackScreen;

	public FrameworkBlackLoad BlackLoad => _monoProxy.blackLoad;

	public FrameworkBlackFade BlackFade => _monoProxy.blackFade;

	public MonoMessageBox MessageBox => _monoProxy.messageBox;

	public bool MessageBoxIsShow => _monoProxy.messageBox?.isActiveAndEnabled ?? false;

	public MonoUIDtxt UidTxt => _monoProxy.uidTxt;

	public MonoLoaderView LoadingPanel => _monoProxy.loadingPanel;

	public GuideComp GuideComp => _monoProxy.guideComp;

	public CharacterFullScreenAni CharacterFullScreenAni => _monoProxy.characterFullScreenAni;

	public GameObject RayCastBlocker => _monoProxy.rayCastBlocker;

	public DisconnectionPanel DisconnectionPanel => _monoProxy.disconnectionPanel;

	public MonoNetworkFluctuationView NetworkFluctuationView => _monoProxy.monoNetworkFluctuation;

	public Camera UICamera => GameUtility.uiCamera;

	public Canvas RootCanvas => GameUtility.uiCanvas;

	private void EnsureBlackScreenInitialized()
	{
		if (_blackScreenImage == null)
		{
			_blackScreenImage = NewUIManagerBlackScreen;
			_blackScreenImage.enabled = true;
		}
	}

	private void SetAlpha(float value)
	{
		_alpha = Mathf.Clamp01(value);
		if (_blackScreenImage != null)
		{
			Color color = _blackScreenImage.color;
			color.a = _alpha;
			_blackScreenImage.color = color;
			if (_alpha == 0f)
			{
				_blackScreenImage.gameObject.SetActive(value: false);
			}
			else
			{
				_blackScreenImage.gameObject.SetActive(value: true);
			}
		}
	}

	private void UpdateBlackScreen()
	{
		if (!(_blackScreenImage == null))
		{
			ApplyBlackScreenFadeTrigger();
			switch (_blackScreenFadeState)
			{
			case BlackScreenFadeState.FadeIn:
				UpdateBlackScreenFadeIn();
				break;
			case BlackScreenFadeState.FadeOut:
				UpdateBlackScreenFadeOut();
				break;
			}
		}
	}

	private void ApplyBlackScreenFadeTrigger()
	{
		if (_blackScreenFadeTrigger != BlackScreenFadeTrigger.None)
		{
			if (_blackScreenFadeTrigger == BlackScreenFadeTrigger.FadeIn)
			{
				_blackScreenFadeState = BlackScreenFadeState.FadeIn;
				_blackScreenFadeTrigger = BlackScreenFadeTrigger.None;
				_hasLoggedFadeOutPending = false;
				_hasLoggedHidden = false;
				LogBlackScreenState("Consume FadeIn trigger");
			}
			else if (CanStartBlackScreenFadeOut())
			{
				_blackScreenFadeState = BlackScreenFadeState.FadeOut;
				_blackScreenFadeTrigger = BlackScreenFadeTrigger.None;
				_hasLoggedFadeOutPending = false;
				LogBlackScreenState("Consume FadeOut trigger");
			}
			else
			{
				LogBlackScreenFadeOutPending();
			}
		}
	}

	private void UpdateBlackScreenFadeIn()
	{
		if (_alpha >= 1f)
		{
			SetAlpha(1f);
			if (_fullyVisibleStartTime < 0f)
			{
				_fullyVisibleStartTime = Time.time;
				LogBlackScreenFullyVisible();
			}
		}
		else
		{
			SetAlpha(Mathf.Min(1f, _alpha + 2f * Time.deltaTime));
			if (_alpha >= 1f && _fullyVisibleStartTime < 0f)
			{
				_fullyVisibleStartTime = Time.time;
				LogBlackScreenFullyVisible();
			}
		}
	}

	private void UpdateBlackScreenFadeOut()
	{
		if (!CanStartBlackScreenFadeOut())
		{
			LogBlackScreenFadeOutPending();
			return;
		}
		if (_alpha <= 0f)
		{
			SetAlpha(0f);
			_fullyVisibleStartTime = -1f;
			LogBlackScreenHidden();
			return;
		}
		SetAlpha(Mathf.Max(0f, _alpha - 2f * Time.deltaTime));
		if (_alpha <= 0f)
		{
			_fullyVisibleStartTime = -1f;
			LogBlackScreenHidden();
		}
	}

	private bool CanStartBlackScreenFadeOut()
	{
		if (_alpha < 1f && _blackScreenFadeState == BlackScreenFadeState.FadeIn)
		{
			return false;
		}
		if (_fullyVisibleStartTime < 0f)
		{
			return true;
		}
		return Time.time - _fullyVisibleStartTime >= 0.2f;
	}

	private void LogBlackScreenState(string eventName)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"[UIManager][BlackScreen] {eventName}, alpha={_alpha:F3}, state={_blackScreenFadeState}, trigger={_blackScreenFadeTrigger}, visibleStart={_fullyVisibleStartTime:F3}, time={Time.time:F3}");
		}
	}

	private void LogBlackScreenFadeOutPending()
	{
		if (!_hasLoggedFadeOutPending && LuminApplication.LogEnabled)
		{
			_hasLoggedFadeOutPending = true;
			if (_alpha < 1f && _blackScreenFadeState == BlackScreenFadeState.FadeIn)
			{
				Debug.Log($"[UIManager][BlackScreen] FadeOut pending: waiting fade-in complete, alpha={_alpha:F3}, state={_blackScreenFadeState}, trigger={_blackScreenFadeTrigger}, time={Time.time:F3}");
			}
			else
			{
				float num = Mathf.Max(0f, 0.2f - (Time.time - _fullyVisibleStartTime));
				Debug.Log($"[UIManager][BlackScreen] FadeOut pending: waiting min visible duration, remaining={num:F3}, alpha={_alpha:F3}, state={_blackScreenFadeState}, trigger={_blackScreenFadeTrigger}, visibleStart={_fullyVisibleStartTime:F3}, time={Time.time:F3}");
			}
		}
	}

	private void LogBlackScreenFullyVisible()
	{
		if (!_hasLoggedFullyVisible)
		{
			_hasLoggedFullyVisible = true;
			_hasLoggedHidden = false;
			LogBlackScreenState("Fully visible");
		}
	}

	private void LogBlackScreenHidden()
	{
		if (!_hasLoggedHidden)
		{
			_hasLoggedHidden = true;
			_hasLoggedFullyVisible = false;
			_hasLoggedFadeOutPending = false;
			LogBlackScreenState("Fully hidden");
		}
	}

	internal void FadeInBlackScreen()
	{
		EnsureBlackScreenInitialized();
		_blackScreenFadeTrigger = BlackScreenFadeTrigger.FadeIn;
		_hasLoggedFullyVisible = false;
		LogBlackScreenState("Request FadeIn");
	}

	internal void FadeOutBlackScreen()
	{
		if (_blackScreenFadeState != BlackScreenFadeState.FadeOut && _blackScreenFadeTrigger != BlackScreenFadeTrigger.FadeOut)
		{
			_blackScreenFadeTrigger = BlackScreenFadeTrigger.FadeOut;
			LogBlackScreenState("Request FadeOut");
		}
	}

	internal void ShowBlackScreenImmediate()
	{
		EnsureBlackScreenInitialized();
		_blackScreenFadeState = BlackScreenFadeState.FadeIn;
		_blackScreenFadeTrigger = BlackScreenFadeTrigger.None;
		_fullyVisibleStartTime = Time.time;
		SetAlpha(1f);
		_hasLoggedFadeOutPending = false;
		_hasLoggedFullyVisible = true;
		_hasLoggedHidden = false;
		LogBlackScreenState("Show immediate");
	}

	internal void HideBlackScreenImmediate()
	{
		_blackScreenFadeState = BlackScreenFadeState.FadeOut;
		_blackScreenFadeTrigger = BlackScreenFadeTrigger.None;
		_fullyVisibleStartTime = -1f;
		SetAlpha(0f);
		_hasLoggedFadeOutPending = false;
		_hasLoggedFullyVisible = false;
		_hasLoggedHidden = true;
		LogBlackScreenState("Hide immediate");
	}

	internal bool IsBlackScreenFullyVisible()
	{
		return _alpha >= 1f;
	}

	internal bool IsBlackScreenFullyHidden()
	{
		return _alpha <= 0f;
	}

	private void CancelBlackScreenTransition()
	{
		if (_alpha <= 0f)
		{
			HideBlackScreenImmediate();
			return;
		}
		if (_alpha >= 1f)
		{
			FadeOutBlackScreen();
			return;
		}
		_fullyVisibleStartTime = -1f;
		_blackScreenFadeState = BlackScreenFadeState.FadeOut;
		_blackScreenFadeTrigger = BlackScreenFadeTrigger.None;
		_hasLoggedFadeOutPending = false;
	}

	public bool ShouldKeepActiveWhenHidden(UI_TYPE uiType)
	{
		return KeepActiveWhenHiddenUITypes.Contains(uiType);
	}

	private void RefreshInactiveUIActiveState()
	{
		List<IBaseUIController> list = CollectionPool<List<IBaseUIController>, IBaseUIController>.Get();
		list.AddRange(_allUI.Values);
		foreach (IBaseUIController item in list)
		{
			if (item is BaseUIController baseUIController)
			{
				baseUIController.RefreshViewObjectActiveState();
			}
		}
		CollectionPool<List<IBaseUIController>, IBaseUIController>.Release(list);
	}

	public override void Init()
	{
		base.Init();
		_cancellationTokenSource = new CancellationTokenSource();
		_inputControllerContainer = new InputControllerContainer();
		_update = UniTaskAsyncEnumerable.EveryUpdate(PlayerLoopTiming.LastUpdate).Subscribe((AsyncUnit _) =>
		{
			Tick();
		});
	}

	public override void UnInit()
	{
		_update.Dispose();
		_cancellationTokenSource?.Cancel();
		_cancellationTokenSource?.Dispose();
		Reset();
		base.UnInit();
	}

	public UIOpenResult OpenUI(UI_TYPE uiType, object uiData = null, bool isneedinqueue = true)
	{
		if (!isneedinqueue && (IsActivePanelBusy() || _openQueue.Count != 0))
		{
			return UIOpenResult.InValid;
		}
		if (!UIData.TryGetValue(uiType, out var value))
		{
			Debug.LogError($"找不到uiType : {uiType} 对应的config， 请检查！！！");
			return UIOpenResult.InValid;
		}
		if (!CheckOpenUIBySystem(uiType))
		{
			Debug.LogError($"{uiType} System {value.SystemId} 被禁用，请检查！！！");
			return UIOpenResult.InValid;
		}
		if (!CheckOpenUI(uiType))
		{
			return UIOpenResult.InValid;
		}
		LuminApplication.RuntimeInfo.SetUiType((int)uiType);
		uint uid = CreateUIId();
		UIOpenData uIOpenData = new UIOpenData
		{
			Uid = uid,
			UIType = uiType,
			OpenData = uiData
		};
		switch (value.PanelType)
		{
		case UIPanelType.Panel:
			EnqueuePanelOpen(uIOpenData);
			CheckStackContainsHudAndInsertToStackBottom();
			DisableInputController();
			break;
		case UIPanelType.PopUp:
		{
			IBaseUIController activeUI = GetActiveUI();
			if (activeUI == null)
			{
				Debug.LogError("当前Panel不存在, 不允许打开popup");
				return UIOpenResult.InValid;
			}
			if (activeUI.State != UIState.Opened || activeUI.IsInHideRoot)
			{
				Debug.LogError($"当前Panel状态为 {activeUI.State}, 不允许打开popup");
				return UIOpenResult.InValid;
			}
			IBaseUIController orCreateUI2 = GetOrCreateUI(uIOpenData);
			OpenInternal(orCreateUI2, uIOpenData.OpenData);
			UpdateActiveUIQueueSortingLayers();
			if (orCreateUI2.DisableInputOnTransition)
			{
				DisableInputController();
			}
			break;
		}
		case UIPanelType.Toast:
		{
			IBaseUIController orCreateUI = GetOrCreateUI(uIOpenData);
			OpenInternal(orCreateUI, uIOpenData.OpenData);
			break;
		}
		default:
			throw new ArgumentOutOfRangeException();
		}
		RequestImmediateUIUpdate();
		return new UIOpenResult
		{
			Uid = uid,
			IsValid = true
		};
	}

	public async UniTask<UIOpenResult> OpenUIAsync(UI_TYPE uiType, object uiData = null, bool isneedinqueue = true)
	{
		UIOpenResult openUIResult = OpenUI(uiType, uiData, isneedinqueue);
		if (openUIResult.IsValid)
		{
			await UniTask.WaitUntil(() =>
			{
				if (QueueContains(openUIResult.Uid))
				{
					return false;
				}
				switch (GetUIState(openUIResult.Uid))
				{
				case UIState.Closed:
					return GetUIExpectedState(openUIResult.Uid) != UIExpectedState.Open;
				default:
					return false;
				case UIState.None:
				case UIState.Opened:
					return true;
				}
			}, PlayerLoopTiming.Update, _cancellationTokenSource.Token);
		}
		return openUIResult;
	}

	public async UniTask WaitUIOpenAsync(UIOpenResult openUIResult)
	{
		if (!openUIResult.IsValid)
		{
			return;
		}
		await UniTask.WaitUntil(() =>
		{
			if (QueueContains(openUIResult.Uid))
			{
				return false;
			}
			switch (GetUIState(openUIResult.Uid))
			{
			case UIState.Closed:
				return GetUIExpectedState(openUIResult.Uid) != UIExpectedState.Open;
			default:
				return false;
			case UIState.None:
			case UIState.Opened:
				return true;
			}
		}, PlayerLoopTiming.Update, _cancellationTokenSource.Token);
	}

	public async UniTask WaitUICloseAsync(UIOpenResult openUIResult)
	{
		if (!openUIResult.IsValid)
		{
			return;
		}
		await UniTask.WaitUntil(() =>
		{
			if (QueueContains(openUIResult.Uid))
			{
				return false;
			}
			UIState uIState = GetUIState(openUIResult.Uid);
			return uIState == UIState.Closed || uIState == UIState.None;
		}, PlayerLoopTiming.Update, _cancellationTokenSource.Token);
	}

	public void CloseUI(uint uid)
	{
		QueueTryRemove(uid);
		if (TryGetUIController(uid, out var ui))
		{
			CloseUIInternal(ui);
		}
		RequestImmediateUIUpdate();
	}

	public async UniTask CloseUIAsync(uint uid)
	{
		CloseUI(uid);
		await UniTask.WaitUntil(() =>
		{
			UIState uIState = GetUIState(uid);
			return GetUIState(uid) == UIState.Closed || uIState == UIState.None;
		}, PlayerLoopTiming.Update, _cancellationTokenSource.Token);
	}

	public void CloseUI(UI_TYPE uiType)
	{
		QueueTryRemove(uiType);
		if (_allLifeUI.TryGetValue(uiType, out var value))
		{
			List<IBaseUIController> list = CollectionPool<List<IBaseUIController>, IBaseUIController>.Get();
			list.AddRange(value);
			foreach (IBaseUIController item in list)
			{
				CloseUIInternal(item);
			}
			CollectionPool<List<IBaseUIController>, IBaseUIController>.Release(list);
		}
		RequestImmediateUIUpdate();
	}

	public async UniTask CloseUIAsync(UI_TYPE uiType)
	{
		QueueTryRemove(uiType);
		List<uint> listUid = CollectionPool<List<uint>, uint>.Get();
		if (_allLifeUI.TryGetValue(uiType, out var value))
		{
			List<IBaseUIController> list = CollectionPool<List<IBaseUIController>, IBaseUIController>.Get();
			list.AddRange(value);
			foreach (IBaseUIController item in list)
			{
				if (item.ExpectedState == UIExpectedState.Open)
				{
					listUid.Add(item.Uid);
					CloseUIInternal(item);
				}
			}
			CollectionPool<List<IBaseUIController>, IBaseUIController>.Release(list);
		}
		RequestImmediateUIUpdate();
		await UniTask.WaitUntil(() =>
		{
			bool flag = true;
			foreach (uint item2 in listUid)
			{
				UIState uIState = GetUIState(item2);
				flag &= uIState == UIState.Closed || uIState == UIState.None;
			}
			return flag;
		}, PlayerLoopTiming.Update, _cancellationTokenSource.Token);
		CollectionPool<List<uint>, uint>.Release(listUid);
	}

	public UIOpenResult BackToBattleMain()
	{
		ClearPanelTransition(closeTargetImmediately: false, hideBlackImmediately: false);
		_openQueue.Clear();
		List<IBaseUIController> list = CollectionPool<List<IBaseUIController>, IBaseUIController>.Get();
		foreach (KeyValuePair<UI_TYPE, List<IBaseUIController>> item in _allLifeUI)
		{
			if (UIData[item.Key].PanelType == UIPanelType.Panel)
			{
				list.AddRange(item.Value);
			}
		}
		foreach (IBaseUIController item2 in list)
		{
			CloseUIInternal(item2, needTickActiveUI: false);
		}
		CollectionPool<List<IBaseUIController>, IBaseUIController>.Release(list);
		return OpenUI(UI_TYPE.UI_BATTLEMAIN);
	}

	public void ApplyMarkedLifetimePolicies()
	{
		int systemMemorySize = SystemInfo.systemMemorySize;
		foreach (KeyValuePair<UI_TYPE, UIData> uIDatum in UIData)
		{
			if (uIDatum.Key != UI_TYPE.UI_MAX)
			{
				Type uIController = uIDatum.Value.UIController;
				UILifecyclePolicyAttribute uILifecyclePolicyAttribute = ((uIController == null) ? null : (Attribute.GetCustomAttribute(uIController, typeof(UILifecyclePolicyAttribute)) as UILifecyclePolicyAttribute));
				if (uILifecyclePolicyAttribute != null && uILifecyclePolicyAttribute.CanExecute(systemMemorySize))
				{
					uIDatum.Value.RuntimeLifetimePolicy = uILifecyclePolicyAttribute.LifetimePolicy;
				}
			}
		}
	}

	public async UniTask PreLoadMarkedUIs()
	{
		if (!CanPreLoadMarkedUIs())
		{
			Debug.LogWarning("UI 正在加载或切换，跳过本次批量预加载。");
			return;
		}
		int deviceMemoryMb = SystemInfo.systemMemorySize;
		foreach (KeyValuePair<UI_TYPE, UIData> uIDatum in UIData)
		{
			if (uIDatum.Key == UI_TYPE.UI_MAX)
			{
				continue;
			}
			Type uIController = uIDatum.Value.UIController;
			UIPreloadAttribute uIPreloadAttribute = ((uIController == null) ? null : (Attribute.GetCustomAttribute(uIController, typeof(UIPreloadAttribute)) as UIPreloadAttribute));
			if (uIPreloadAttribute != null && uIPreloadAttribute.CanPreload(deviceMemoryMb) && uIDatum.Value.RuntimeLifetimePolicy != UILifetimePolicy.Immediate)
			{
				if (!CanPreLoadMarkedUIs())
				{
					Debug.LogWarning("批量预加载期间检测到 UI 加载或切换，终止剩余预加载。");
					return;
				}
				await PreLoadUI(uIDatum.Key);
			}
		}
	}

	private bool CanPreLoadMarkedUIs()
	{
		if (_openQueue.Count == 0 && _panelTransition == null)
		{
			return _allUI.Values.All((IBaseUIController ui) => ui.State != UIState.Loading);
		}
		return false;
	}

	public async UniTask PreLoadUI(UI_TYPE uiType)
	{
		if (!UIData.TryGetValue(uiType, out var _))
		{
			Debug.LogError($"找不到uiType : {uiType} 对应的config， 请检查！！！");
			return;
		}
		_cachedUIs.Add(uiType);
		if ((!_uiPool.TryGetValue(uiType, out var value2) || value2.Count <= 0) && (!_allLifeUI.TryGetValue(uiType, out var value3) || value3.Count <= 0))
		{
			uint uid = CreateUIId();
			UIOpenData uiOpenData = new UIOpenData
			{
				Uid = uid,
				UIType = uiType,
				OpenData = null
			};
			IBaseUIController ui = GetOrCreateUI(uiOpenData);
			AddToPool(ui);
			await UniTask.WaitUntil(() => ui.State != UIState.Loading, PlayerLoopTiming.Update, _cancellationTokenSource.Token);
		}
	}

	public UIState GetUIState(uint uid)
	{
		if (TryGetUIController(uid, out var ui))
		{
			return ui.State;
		}
		return UIState.None;
	}

	public UIState GetFirstUIState(UI_TYPE uiType)
	{
		foreach (KeyValuePair<uint, IBaseUIController> item in _allUI)
		{
			if (item.Value.UIType == uiType)
			{
				return item.Value.State;
			}
		}
		return UIState.None;
	}

	public bool HasUIInTransition(UI_TYPE uiType)
	{
		foreach (KeyValuePair<uint, IBaseUIController> item in _allUI)
		{
			if (item.Value.UIType == uiType)
			{
				UIState state = item.Value.State;
				if (state == UIState.Loading || (uint)(state - 3) <= 2u)
				{
					return true;
				}
			}
		}
		return false;
	}

	public UIExpectedState GetUIExpectedState(uint uid)
	{
		if (QueueContains(uid))
		{
			return UIExpectedState.Open;
		}
		if (TryGetUIController(uid, out var ui))
		{
			return ui.ExpectedState;
		}
		return UIExpectedState.None;
	}

	public UIExpectedState GetFirstUIExpectedState(UI_TYPE uiType)
	{
		if (QueueContains(uiType))
		{
			return UIExpectedState.Open;
		}
		foreach (KeyValuePair<uint, IBaseUIController> item in _allUI)
		{
			if (item.Value.UIType == uiType)
			{
				return item.Value.ExpectedState;
			}
		}
		return UIExpectedState.None;
	}

	public bool TryGetUIController(uint uid, out IBaseUIController ui)
	{
		if (!_allUI.TryGetValue(uid, out ui))
		{
			return _openRequestAliases.TryGetValue(uid, out ui);
		}
		return true;
	}

	public bool TryGetFirstUIController(UI_TYPE uiType, out IBaseUIController ui)
	{
		ui = null;
		foreach (KeyValuePair<uint, IBaseUIController> item in _allUI)
		{
			if (item.Value.UIType == uiType)
			{
				ui = item.Value;
				return true;
			}
		}
		return false;
	}

	public IBaseUIController GetTopActivePanel()
	{
		if (_activePanelQueue.Count != 0)
		{
			List<IBaseUIController> activePanelQueue = _activePanelQueue;
			return activePanelQueue[activePanelQueue.Count - 1];
		}
		return null;
	}

	public IBaseUIController GetTopActiveUI()
	{
		IBaseUIController topActivePanel = GetTopActivePanel();
		if (topActivePanel == null)
		{
			return null;
		}
		IBaseUIController topExpectedOpenChild = GetTopExpectedOpenChild(topActivePanel);
		return topExpectedOpenChild ?? topActivePanel;
	}

	public IBaseUIController GetTopPopupUI()
	{
		IBaseUIController topActivePanel = GetTopActivePanel();
		if (topActivePanel != null)
		{
			return GetTopExpectedOpenChild(topActivePanel);
		}
		return null;
	}

	private IBaseUIController GetTopExpectedOpenChild(IBaseUIController panel)
	{
		if (panel == null || panel.Children.Count == 0)
		{
			return null;
		}
		IReadOnlyList<uint> children = panel.Children;
		for (int num = children.Count - 1; num >= 0; num--)
		{
			uint uid = children[num];
			if (TryGetUIController(uid, out var ui) && ui.ExpectedState == UIExpectedState.Open)
			{
				return ui;
			}
		}
		return null;
	}

	public IBaseUIView FindUIViewByUIType(UI_TYPE uiType)
	{
		foreach (KeyValuePair<uint, IBaseUIController> item in _allUI)
		{
			if (item.Value.UIType == uiType)
			{
				return item.Value.GetUIView();
			}
		}
		return null;
	}

	private void Tick()
	{
		UpdateBlackScreen();
		TickActivePanelUI();
		TickNotCurrentUI();
		UpdateInputControllerState();
		CheckAndCleanupExpiredUIs();
	}

	private void RequestImmediateUIUpdate()
	{
		_immediateUIUpdateRequested = true;
		if (_isImmediateUIUpdateRunning)
		{
			return;
		}
		_isImmediateUIUpdateRunning = true;
		try
		{
			do
			{
				_immediateUIUpdateRequested = false;
				TickActivePanelUI();
				TickNotCurrentUI();
				UpdateInputControllerState();
			}
			while (_immediateUIUpdateRequested);
		}
		finally
		{
			_isImmediateUIUpdateRunning = false;
			_immediateUIUpdateRequested = false;
		}
	}

	private void TickActivePanelUI()
	{
		QueueExecute();
		StackExecute();
	}

	private void TickNotCurrentUI()
	{
		if (_nonPanelLifeUI.Count == 0)
		{
			return;
		}
		List<IBaseUIController> list = Bamboo.Pool.ListPool<IBaseUIController>.Default.Get();
		list.AddRange(_nonPanelLifeUI);
		foreach (IBaseUIController item in list)
		{
			TickUI(item);
		}
		Bamboo.Pool.ListPool<IBaseUIController>.Default.Recycle(list);
	}

	private void TickUI(IBaseUIController controller)
	{
		if (controller.ExpectedState == UIExpectedState.Open)
		{
			if ((controller.State == UIState.Loaded || controller.State == UIState.Closed) && !_uiStack.Contains(controller))
			{
				controller.OpenView();
			}
		}
		else
		{
			if (controller.ExpectedState != UIExpectedState.Close)
			{
				return;
			}
			if (controller.State == UIState.Opened || controller.State == UIState.InStack)
			{
				controller.CloseView(UI_TYPE.UI_NONE);
				return;
			}
			UIState state = controller.State;
			if (state == UIState.None || state == UIState.Loaded || state == UIState.Closed)
			{
				controller.CloseImmediately();
			}
		}
	}

	public static string GetUIAssetPathByUIType(UI_TYPE uiType)
	{
		if (CommonUIData.DICT_UI_DATA.TryGetValue(uiType, out var value))
		{
			return value.mobilePath;
		}
		throw new IndexOutOfRangeException(uiType.ToString());
	}

	public static bool IsPanel(UI_TYPE uiType)
	{
		return UIData[uiType].PanelType == UIPanelType.Panel;
	}

	public static bool IsRequireBlackScreenTransition(UI_TYPE uiType)
	{
		if (UIData.TryGetValue(uiType, out var value))
		{
			return value.RequireBlackScreenTransition;
		}
		return false;
	}

	public Vector3 ScreenPosToWorld(Vector2 uiPos)
	{
		return UICamera.ScreenToWorldPoint(new Vector3(uiPos.x, uiPos.y, RootCanvas.planeDistance));
	}

	public static bool IsUIStateBusy(UIState uiState)
	{
		if (uiState != UIState.None)
		{
			return uiState != UIState.Closed;
		}
		return false;
	}

	private void OnInputActiveChanged(bool isActive)
	{
		_inputControllerContainer.Active = isActive;
		RayCastBlocker.SetActive(!isActive);
	}

	internal void AddInputController(IInputController inputController)
	{
		_inputControllerContainer.AddInputController(inputController);
	}

	internal void RemoveInputController(IInputController inputController)
	{
		_inputControllerContainer.RemoveInputController(inputController);
	}

	internal void RestoreTopPopupInputController(IBaseUIController panel)
	{
		if (panel == null || panel.Children.Count == 0)
		{
			return;
		}
		IReadOnlyList<uint> children = panel.Children;
		for (int i = 0; i < children.Count; i++)
		{
			if (TryGetUIController(children[i], out var ui) && ui.ExpectedState == UIExpectedState.Open && ui.State == UIState.Opened && !ui.IsInHideRoot)
			{
				AddInputController(ui.GetUIView()?.InputController);
			}
		}
	}

	private void EnableInputController()
	{
		InternalActiveInput = true;
	}

	private void DisableInputController()
	{
		InternalActiveInput = false;
	}

	private bool IsAnyUITransitioning()
	{
		if (_panelTransition != null || _openQueue.Count > 0)
		{
			return true;
		}
		foreach (IBaseUIController item in _nonPanelLifeUI)
		{
			if (item.DisableInputOnTransition && item.ExpectedState == UIExpectedState.Open && IsInputBlockingState(item.State))
			{
				return true;
			}
		}
		return false;
	}

	private static bool IsInputBlockingState(UIState state)
	{
		if (state != UIState.Loading && state != UIState.Opening && state != UIState.Closing && state != UIState.PushingStack)
		{
			return state == UIState.PoppingStack;
		}
		return true;
	}

	private void UpdateInputControllerState()
	{
		if (IsAnyUITransitioning())
		{
			DisableInputController();
		}
		else
		{
			EnableInputController();
		}
	}

	private void OpenInternal(IBaseUIController ui, object uiData = null)
	{
		if (ui.ExpectedState == UIExpectedState.Open)
		{
			return;
		}
		if (ui.DisableInputOnTransition)
		{
			DisableInputController();
		}
		ui.ExpectedState = UIExpectedState.Open;
		if (ui.PanelType == UIPanelType.PopUp)
		{
			IBaseUIController activeUI = GetActiveUI();
			if (activeUI != null)
			{
				activeUI.AddChildUI(ui.Uid);
				ui.SetParentUI(activeUI.Uid);
			}
		}
		ui.Open(uiData);
		if (ui.PanelType == UIPanelType.Panel)
		{
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Open, null);
		}
	}

	private void CloseUIInternal(IBaseUIController ui, bool needTickActiveUI = true)
	{
		if (ui.ExpectedState != UIExpectedState.Close)
		{
			if (ui.DisableInputOnTransition)
			{
				DisableInputController();
			}
			ui.ExpectedState = UIExpectedState.Close;
			if (ui.PanelType == UIPanelType.Panel)
			{
				_panelCloseCleanupRequested = true;
				RequestPanelClose(ui);
			}
			else
			{
				CloseAllChildren(ui);
				ui.Close();
			}
		}
	}

	private void CloseAllChildren(IBaseUIController parent)
	{
		List<uint> list = Bamboo.Pool.ListPool<uint>.Default.Get();
		list.AddRange(parent.Children);
		foreach (uint item in list)
		{
			if (_allUI.TryGetValue(item, out var value))
			{
				CloseUIInternal(value);
			}
		}
		Bamboo.Pool.ListPool<uint>.Default.Recycle(list);
	}

	private void RemoveFromParentUI(IBaseUIController ui)
	{
		if (_allUI.TryGetValue(ui.Parent, out var value))
		{
			value.RemoveChildUI(ui.Uid);
		}
	}

	private void RequestPanelClose(IBaseUIController panel)
	{
	}

	private static void DispatchUICloseEvent(IBaseUIController ui)
	{
		UIEvent evt = Singleton<EventManager>.instance.GetEvt<UIEvent>();
		evt.UIType = ui?.UIType ?? UI_TYPE.UI_NONE;
		evt.Uid = ui?.Uid ?? 0;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Close, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void ExecutePanelCloseLifecycle(IBaseUIController panel)
	{
		CloseAllChildren(panel);
		RemoveFromParentUI(panel);
		panel.Close();
		DispatchUICloseEvent(panel);
	}

	private void ClosePanelImmediatelyInternal(IBaseUIController panel)
	{
		if (panel != null)
		{
			bool flag = panel.State != UIState.Closed;
			panel.ExpectedState = UIExpectedState.Close;
			CloseAllChildren(panel);
			RemoveFromParentUI(panel);
			panel.Close();
			panel.CloseImmediately();
			RemoveFromActiveUIQueue(panel);
			_uiStack.Remove(panel);
			if (_allLifeUI.TryGetValue(panel.UIType, out var value) && value.Contains(panel))
			{
				ReturnToPool(panel);
			}
			if (flag)
			{
				DispatchUICloseEvent(panel);
			}
		}
	}

	private uint CreateUIId()
	{
		_incrementingId++;
		while (_allUI.ContainsKey(_incrementingId))
		{
			_incrementingId++;
		}
		return _incrementingId;
	}

	private IBaseUIController GetOrCreateUI(UIOpenData uiOpenData)
	{
		UI_TYPE uIType = uiOpenData.UIType;
		uint uid = uiOpenData.Uid;
		switch (UIData[uIType].InstanceStrategy)
		{
		case UIInstanceStrategy.SingleInstance:
		{
			if (_allLifeUI.TryGetValue(uIType, out var value) && value.Count > 0)
			{
				List<IBaseUIController> list = Bamboo.Pool.ListPool<IBaseUIController>.Default.Get();
				list.AddRange(value);
				foreach (IBaseUIController item in list)
				{
					CloseUIImmediately(item);
				}
				Bamboo.Pool.ListPool<IBaseUIController>.Default.Recycle(list);
			}
			if (!_uiPool.TryGetValue(uIType, out var value2) || value2.Count <= 1)
			{
				break;
			}
			List<IBaseUIController> list2 = Bamboo.Pool.ListPool<IBaseUIController>.Default.Get();
			for (int i = 0; i < value2.Count - 1; i++)
			{
				list2.Add(value2[i]);
			}
			foreach (IBaseUIController item2 in list2)
			{
				DestroyUIInternal(item2);
			}
			Bamboo.Pool.ListPool<IBaseUIController>.Default.Recycle(list2);
			break;
		}
		}
		IBaseUIController baseUIController;
		if (_uiPool.TryGetValue(uIType, out var value3) && value3.Count > 0)
		{
			List<IBaseUIController> list3 = value3;
			baseUIController = list3[list3.Count - 1];
			value3.Remove(baseUIController);
			uint uid2 = uiOpenData.Uid;
			uint uid3 = baseUIController.Uid;
			RemoveAliasesForController(baseUIController);
			baseUIController.SetUid(uid2);
			AddToAllLifeUI(baseUIController);
			_allUI.Remove(uid3);
			_allUI.Add(uid2, baseUIController);
		}
		else
		{
			baseUIController = CreateUIController(uIType);
			baseUIController.Init(uIType, uid);
			AddToAllLifeUI(baseUIController);
			_allUI.Add(uid, baseUIController);
		}
		return baseUIController;
	}

	private void AddToAllLifeUI(IBaseUIController ui)
	{
		bool flag = false;
		if (_allLifeUI.TryGetValue(ui.UIType, out var value))
		{
			if (!value.Contains(ui))
			{
				value.Add(ui);
				flag = true;
			}
		}
		else
		{
			_allLifeUI[ui.UIType] = new List<IBaseUIController> { ui };
			flag = true;
		}
		if (flag && ui.PanelType != UIPanelType.Panel)
		{
			_nonPanelLifeUI.Add(ui);
		}
	}

	private void RemoveFromAllLifeUI(IBaseUIController ui)
	{
		if (_allLifeUI.TryGetValue(ui.UIType, out var value))
		{
			value.Remove(ui);
		}
		if (ui.PanelType != UIPanelType.Panel)
		{
			_nonPanelLifeUI.Remove(ui);
		}
	}

	private void RemoveAliasesForController(IBaseUIController controller)
	{
		List<uint> list = Bamboo.Pool.ListPool<uint>.Default.Get();
		foreach (KeyValuePair<uint, IBaseUIController> openRequestAlias in _openRequestAliases)
		{
			if (openRequestAlias.Value == controller)
			{
				list.Add(openRequestAlias.Key);
			}
		}
		foreach (uint item in list)
		{
			_openRequestAliases.Remove(item);
		}
		Bamboo.Pool.ListPool<uint>.Default.Recycle(list);
	}

	public bool IsActivePanelBusy()
	{
		if (Singleton<GameState>.instance.GameControlStateMachine.Current == GameControlState.Skill)
		{
			return true;
		}
		if (_panelTransition != null)
		{
			return true;
		}
		foreach (IBaseUIController item in _activePanelQueue)
		{
			if (item.State == UIState.Loading || item.State == UIState.Opening || item.State == UIState.Closing || item.State == UIState.PoppingStack || item.State == UIState.PushingStack)
			{
				return true;
			}
		}
		return false;
	}

	public bool IsUIManagerBusy()
	{
		if (IsActivePanelBusy() || _openQueue.Count != 0)
		{
			return true;
		}
		return false;
	}

	private bool CheckOpenUIBySystem(UI_TYPE uiType)
	{
		UIData uIData = UIData[uiType];
		bool isConnectSystem = uIData.IsConnectSystem;
		int systemId = uIData.SystemId;
		if (isConnectSystem)
		{
			return Singleton<SystemUnlockManager>.instance.IsSystemUnlock(systemId);
		}
		return true;
	}

	public bool CheckOpenUI(UI_TYPE uiType)
	{
		switch (UIData[uiType].PanelType)
		{
		case UIPanelType.Panel:
			return true;
		case UIPanelType.PopUp:
			if (HasActiveUI())
			{
				return !IsActivePanelBusy();
			}
			return false;
		case UIPanelType.Toast:
			return true;
		default:
			throw new ArgumentOutOfRangeException();
		}
	}

	private IBaseUIController CreateUIController(UI_TYPE uiType)
	{
		if (CommonUIData.DICT_UI_DATA.TryGetValue(uiType, out var value))
		{
			return Activator.CreateInstance(value.UIController) as IBaseUIController;
		}
		throw new NotImplementedException($"未找到{uiType}对应的UIData，请检查！！！");
	}

	private UILifetimePolicy GetLifetimePolicy(IBaseUIController ui)
	{
		if (UIData.TryGetValue(ui.UIType, out var value) && value.RuntimeLifetimePolicy.HasValue)
		{
			return value.RuntimeLifetimePolicy.Value;
		}
		return ui.LifetimePolicy;
	}

	private void AddToPool(IBaseUIController ui)
	{
		UILifetimePolicy lifetimePolicy = GetLifetimePolicy(ui);
		if (lifetimePolicy == UILifetimePolicy.Immediate)
		{
			DestroyUIInternal(ui);
			return;
		}
		UI_TYPE uIType = ui.UIType;
		RemoveFromAllLifeUI(ui);
		if (!_uiPool.ContainsKey(uIType))
		{
			_uiPool[uIType] = new List<IBaseUIController>();
		}
		if (_uiPool[uIType].Contains(ui))
		{
			return;
		}
		_uiPool[uIType].Add(ui);
		if (lifetimePolicy == UILifetimePolicy.Timed)
		{
			float num = ui.CloseTime + ui.LifetimeDelay;
			if (num < _nextPoolCleanupTime)
			{
				_nextPoolCleanupTime = num;
			}
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"pool add {uIType}");
		}
	}

	internal void ReturnToPool(IBaseUIController ui)
	{
		if (ui.ExpectedState == UIExpectedState.Close)
		{
			RemoveFromParentUI(ui);
			RemoveFromAllLifeUI(ui);
			RemoveFromActiveUIQueue(ui);
			_uiStack.Remove(ui);
			AddToPool(ui);
		}
	}

	private void DestroyUIInternal(IBaseUIController ui)
	{
		uint uid = ui.Uid;
		_allUI.Remove(uid);
		RemoveFromAllLifeUI(ui);
		RemoveAliasesForController(ui);
		RemoveFromPool(ui);
		if (_allUI.TryGetValue(ui.Parent, out var value))
		{
			value.RemoveChildUI(uid);
		}
		ui.UnInit();
	}

	private void CheckAndCleanupExpiredUIs()
	{
		float time = Time.time;
		if (time <= _nextPoolCleanupTime)
		{
			return;
		}
		_nextPoolCleanupTime = float.PositiveInfinity;
		foreach (KeyValuePair<UI_TYPE, List<IBaseUIController>> item in _uiPool)
		{
			if (_cachedUIs.Contains(item.Key))
			{
				continue;
			}
			List<IBaseUIController> value = item.Value;
			for (int num = value.Count - 1; num >= 0; num--)
			{
				IBaseUIController baseUIController = value[num];
				if (GetLifetimePolicy(baseUIController) == UILifetimePolicy.Timed)
				{
					float num2 = baseUIController.CloseTime + baseUIController.LifetimeDelay;
					if (time > num2)
					{
						DestroyUIInternal(baseUIController);
					}
					else if (num2 < _nextPoolCleanupTime)
					{
						_nextPoolCleanupTime = num2;
					}
				}
			}
		}
	}

	private void RemoveFromPool(IBaseUIController controller)
	{
		UI_TYPE uIType = controller.UIType;
		if (_uiPool.TryGetValue(uIType, out var value))
		{
			value.Remove(controller);
		}
	}

	private UIOpenResult InsertPanelToStackBottom(UI_TYPE uiType, object uiData)
	{
		if (!UIData.TryGetValue(uiType, out var value))
		{
			Debug.LogError($"找不到uiType : {uiType} 对应的config， 请检查！！！");
			return UIOpenResult.InValid;
		}
		if (value.PanelType != UIPanelType.Panel)
		{
			return UIOpenResult.InValid;
		}
		if (HasExpectedOpenUIInstance(uiType) || StackContainsExpectedOpen(uiType))
		{
			return UIOpenResult.InValid;
		}
		if (!CheckOpenUIBySystem(uiType))
		{
			Debug.LogError($"{uiType} System {value.SystemId} 被禁用，请检查！！！");
			return UIOpenResult.InValid;
		}
		uint uid = CreateUIId();
		UIOpenData uiOpenData = new UIOpenData
		{
			Uid = uid,
			UIType = uiType,
			OpenData = uiData
		};
		QueueTryRemove(uiType);
		IBaseUIController orCreateUI = GetOrCreateUI(uiOpenData);
		if (orCreateUI.ExpectedState != UIExpectedState.Open)
		{
			orCreateUI.ExpectedState = UIExpectedState.Open;
			orCreateUI.Open(uiData);
			_uiStack.Insert(0, orCreateUI);
		}
		return new UIOpenResult
		{
			Uid = uid,
			IsValid = true
		};
	}

	private void CheckStackContainsHudAndInsertToStackBottom()
	{
		if (_panelTransition == null && Singleton<GameState>.instance.RunningState != GameRunningState.Login && Singleton<GameState>.instance.RunningState != GameRunningState.UnLoading && !HasExpectedOpenUIInstance(HudUITYPE) && !StackContainsExpectedOpen(HudUITYPE) && !QueueContains(HudUITYPE))
		{
			InsertPanelToStackBottom(HudUITYPE, null);
		}
	}

	private bool HasExpectedOpenUIInstance(UI_TYPE uiType)
	{
		if (!_allLifeUI.TryGetValue(uiType, out var value))
		{
			return false;
		}
		foreach (IBaseUIController item in value)
		{
			if (item.ExpectedState == UIExpectedState.Open)
			{
				return true;
			}
		}
		return false;
	}

	private void CloseUIImmediately(IBaseUIController ui)
	{
		if (ui.PanelType == UIPanelType.Panel)
		{
			ClosePanelImmediatelyInternal(ui);
			return;
		}
		if (ui.ExpectedState != UIExpectedState.Close)
		{
			CloseUIInternal(ui, needTickActiveUI: false);
		}
		if (ui.State != UIState.Closed)
		{
			ui.CloseImmediately();
		}
	}

	public void CloseAllUIImmediately()
	{
		ClearPanelTransition(closeTargetImmediately: false, hideBlackImmediately: true);
		_openQueue.Clear();
		List<IBaseUIController> list = Bamboo.Pool.ListPool<IBaseUIController>.Default.Get();
		foreach (KeyValuePair<UI_TYPE, List<IBaseUIController>> item in _allLifeUI)
		{
			list.AddRange(item.Value);
		}
		foreach (IBaseUIController item2 in list)
		{
			CloseUIImmediately(item2);
		}
		Bamboo.Pool.ListPool<IBaseUIController>.Default.Recycle(list);
		ClearActiveUIQueue();
		_uiStack.Clear();
		_inputControllerContainer.Reset();
		InternalActiveInput = true;
		ClearImmediateUIRuntimeState();
		HideBlackScreenImmediate();
	}

	public void CloseAllUI()
	{
		ClearPanelTransition(closeTargetImmediately: false, hideBlackImmediately: false);
		_openQueue.Clear();
		List<IBaseUIController> list = Bamboo.Pool.ListPool<IBaseUIController>.Default.Get();
		foreach (KeyValuePair<UI_TYPE, List<IBaseUIController>> item in _allLifeUI)
		{
			list.AddRange(item.Value);
		}
		foreach (IBaseUIController item2 in list)
		{
			CloseUIInternal(item2, needTickActiveUI: false);
		}
		Bamboo.Pool.ListPool<IBaseUIController>.Default.Recycle(list);
	}

	public void CloseAllUIExcept(UI_TYPE preserveUIType)
	{
		PrepareTransitionForCloseAllExcept(preserveUIType);
		for (int num = _openQueue.Count - 1; num >= 0; num--)
		{
			if (_openQueue[num].UIType != preserveUIType)
			{
				_openQueue.RemoveAt(num);
			}
		}
		List<IBaseUIController> list = Bamboo.Pool.ListPool<IBaseUIController>.Default.Get();
		foreach (KeyValuePair<UI_TYPE, List<IBaseUIController>> item in _allLifeUI)
		{
			list.AddRange(item.Value);
		}
		foreach (IBaseUIController item2 in list)
		{
			if (item2.UIType != preserveUIType)
			{
				CloseUIInternal(item2, needTickActiveUI: false);
			}
		}
		Bamboo.Pool.ListPool<IBaseUIController>.Default.Recycle(list);
	}

	public void CloseAllUIPreservePendingOpenQueue()
	{
		List<UIOpenData> list = new List<UIOpenData>(_openQueue);
		PanelTransitionContext panelTransition = _panelTransition;
		if (panelTransition != null && panelTransition.Operation == PanelTransitionOperation.Open)
		{
			list.Insert(0, _panelTransition.Request);
		}
		List<UI_TYPE> snapshot = CapturePanelStackSnapshot();
		ClearPanelTransition(closeTargetImmediately: false, hideBlackImmediately: true);
		List<IBaseUIController> list2 = Bamboo.Pool.ListPool<IBaseUIController>.Default.Get();
		foreach (KeyValuePair<UI_TYPE, List<IBaseUIController>> item in _allLifeUI)
		{
			list2.AddRange(item.Value);
		}
		foreach (IBaseUIController item2 in list2)
		{
			if (item2.ExpectedState != UIExpectedState.Close && item2.State != UIState.Closed)
			{
				CloseUIImmediately(item2);
			}
		}
		Bamboo.Pool.ListPool<IBaseUIController>.Default.Recycle(list2);
		_openQueue.Clear();
		RestorePanelStackSnapshot(snapshot);
		_openQueue.AddRange(list);
	}

	private List<UI_TYPE> CapturePanelStackSnapshot()
	{
		List<UI_TYPE> list = new List<UI_TYPE>();
		foreach (IBaseUIController item in _uiStack)
		{
			if (item.ExpectedState != UIExpectedState.Close && item.State != UIState.Closed)
			{
				list.Add(item.UIType);
			}
		}
		foreach (IBaseUIController item2 in _activePanelQueue)
		{
			if (item2.ExpectedState != UIExpectedState.Close && item2.State != UIState.Closed)
			{
				list.Add(item2.UIType);
			}
		}
		return list;
	}

	private void RestorePanelStackSnapshot(List<UI_TYPE> snapshot)
	{
		if (snapshot.Count == 0)
		{
			CheckStackContainsHudAndInsertToStackBottom();
			return;
		}
		InsertPanelToStackBottom(snapshot[0], null);
		for (int i = 1; i < snapshot.Count; i++)
		{
			_openQueue.Add(new UIOpenData
			{
				Uid = CreateUIId(),
				UIType = snapshot[i],
				OpenData = null
			});
		}
	}

	public void Reset()
	{
		CloseAllUIImmediately();
		List<IBaseUIController> list = Bamboo.Pool.ListPool<IBaseUIController>.Default.Get();
		list.AddRange(_allUI.Values);
		foreach (IBaseUIController item in list)
		{
			DestroyUIInternal(item);
		}
		Bamboo.Pool.ListPool<IBaseUIController>.Default.Recycle(list);
		HideBlackScreenImmediate();
		ClearActiveUIQueue();
		_cachedUIs.Clear();
		_allUI.Clear();
		_nonPanelLifeUI.Clear();
		_openRequestAliases.Clear();
		_uiParticleUpdateMarks.Clear();
		_uiPool.Clear();
		_uiStack.Clear();
		_panelCloseCleanupRequested = false;
		_nextPoolCleanupTime = float.PositiveInfinity;
		_cachedUIs.Clear();
		ClearUIEffectRenderingLists();
		_hudUIType = UI_TYPE.UI_BATTLEMAIN;
		InternalActiveInput = true;
		ExternalActiveInput = true;
	}

	internal Transform GetUIRoot(UIPanelType panelType)
	{
		return panelType switch
		{
			UIPanelType.Panel => PanelRoot, 
			UIPanelType.PopUp => PopRoot, 
			UIPanelType.Toast => ToastRoot, 
			_ => throw new ArgumentOutOfRangeException("panelType", panelType, null), 
		};
	}

	public bool ShowMessage(MonoMessageBox.Message message)
	{
		if (_monoProxy == null)
		{
			return false;
		}
		_monoProxy.messageBox.SetShowHideCallback(OnShowMessage, OnHideMessage);
		_monoProxy.messageBox.Init(message);
		return true;
	}

	private void OnShowMessage()
	{
		Singleton<GameInputActionManager>.instance.PointerCursor.SetCursorVisibleOverride(visible: true);
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
	}

	private void OnHideMessage()
	{
		Singleton<GameInputActionManager>.instance.PointerCursor.ClearCursorVisibleOverride();
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		_monoProxy.messageBox.btnSelector.UpdateDevice(MonoECS.instance.activeInputDevice);
	}

	public void BindMonoProxy(NewUIManagerMonoProxy monoProxy)
	{
		_monoProxy = monoProxy;
		UICamera.depth = 10f;
	}

	public async UniTask SetBlackLoadState(bool activeState, bool immediate = false)
	{
		if (activeState)
		{
			if (immediate)
			{
				await BlackLoad.EnableImmediate();
			}
			else
			{
				await BlackLoad.Enable();
			}
		}
		else if (immediate)
		{
			await BlackLoad.DisableImmediate();
		}
		else
		{
			await BlackLoad.Disable();
		}
	}

	public async UniTask SetBlackFadeState(bool activeState, float duration = 1f, Action updateCallback = null)
	{
		bool complete = false;
		Singleton<NewUIManager>.instance.BlackFade.Fade(activeState ? 1f : 0f, duration, () =>
		{
			complete = true;
		});
		await UniTask.WaitUntil(() =>
		{
			Application.backgroundLoadingPriority = (activeState ? UnityEngine.ThreadPriority.High : UnityEngine.ThreadPriority.Normal);
			updateCallback?.Invoke();
			return complete;
		});
	}

	public int GetStackCount()
	{
		return _uiStack.Count;
	}

	public void SetHandleActionActive(in bool active, IInputController controller)
	{
		if (controller != null)
		{
			Singleton<GameInputActionManager>.instance.SetActionWhiteListModeEnable(controller, !active);
		}
	}

	public void SetHandeActionCallbackActive(string actionPath, bool active, IInputController controller)
	{
		if (controller != null)
		{
			Singleton<GameInputActionManager>.instance.SetActionWhiteList(controller, actionPath, active);
		}
	}

	private PanelTransitionContext PreparePanelTransitionContext()
	{
		_reusablePanelTransition.Reset();
		return _reusablePanelTransition;
	}

	private void ReleasePanelTransitionContext(PanelTransitionContext context)
	{
		if (_panelTransition == context)
		{
			_panelTransition = null;
			context.Reset();
		}
	}

	private void EnqueuePanelOpen(UIOpenData request)
	{
		for (int num = _openQueue.Count - 1; num >= 0; num--)
		{
			if (_openQueue[num].UIType == request.UIType)
			{
				_openQueue.RemoveAt(num);
			}
		}
		PanelTransitionContext panelTransition = _panelTransition;
		if (panelTransition != null && panelTransition.Operation == PanelTransitionOperation.Open && _panelTransition.Request.UIType == request.UIType)
		{
			if (_panelTransition.To == null)
			{
				_panelTransition.Request = request;
				return;
			}
			UIState state = _panelTransition.To.State;
			if (state == UIState.Opening || state == UIState.Opened)
			{
				_openQueue.Add(request);
				return;
			}
			_panelTransition.To.ExpectedState = UIExpectedState.Close;
			_openQueue.Add(request);
		}
		else
		{
			_openQueue.Add(request);
		}
	}

	private void QueueExecute()
	{
		TickPanelTransition();
		HandlePushedStackUI();
		CleanupActiveUIQueue();
		if (_panelTransition == null && _openQueue.Count != 0 && !IsActivePanelBusy())
		{
			IBaseUIController activeUI = GetActiveUI();
			while (_openQueue.Count > 0 && activeUI != null && activeUI.UIType == _openQueue[0].UIType && activeUI.ExpectedState == UIExpectedState.Open)
			{
				UIOpenData uIOpenData = _openQueue[0];
				_openQueue.RemoveAt(0);
				_openRequestAliases[uIOpenData.Uid] = activeUI;
				activeUI.ReOpen(uIOpenData.OpenData);
			}
			if (_openQueue.Count != 0)
			{
				CheckStackContainsHudAndInsertToStackBottom();
				UIOpenData request = _openQueue[0];
				_openQueue.RemoveAt(0);
				StartOpenTransition(request);
			}
		}
	}

	private void StartOpenTransition(UIOpenData request)
	{
		IBaseUIController activeUI = GetActiveUI();
		for (int num = _uiStack.Count - 1; num >= 0; num--)
		{
			if (_uiStack[num].UIType == request.UIType)
			{
				ClosePanelImmediatelyInternal(_uiStack[num]);
			}
		}
		bool flag = (activeUI != null && activeUI.RequireBlackScreenTransition) || IsRequireBlackScreenTransition(request.UIType);
		PanelTransitionContext panelTransitionContext = PreparePanelTransitionContext();
		panelTransitionContext.Operation = PanelTransitionOperation.Open;
		panelTransitionContext.Phase = ((!flag) ? PanelTransitionPhase.LoadingTarget : PanelTransitionPhase.WaitingForBlack);
		panelTransitionContext.Request = request;
		panelTransitionContext.From = activeUI;
		panelTransitionContext.UseBlackScreen = flag;
		_panelTransition = panelTransitionContext;
		if (flag)
		{
			FadeInBlackScreen();
		}
		else
		{
			CreateAndLoadTransitionTarget(panelTransitionContext);
		}
	}

	private void CreateAndLoadTransitionTarget(PanelTransitionContext context)
	{
		if (context.To == null)
		{
			context.To = GetOrCreateUI(context.Request);
			OpenInternal(context.To, context.Request.OpenData);
			AddToActiveUIQueue(context.To);
			context.UseCrossFade = context.From == null || (context.From.TransitionStrategy == UITransitionStrategy.CrossFade && context.To.TransitionStrategy == UITransitionStrategy.CrossFade);
			context.Phase = PanelTransitionPhase.LoadingTarget;
		}
	}

	private static bool IsTransitionSourceFinished(IBaseUIController source, bool allowInStack)
	{
		if (source == null)
		{
			return true;
		}
		if (allowInStack && source.State == UIState.InStack)
		{
			return true;
		}
		if (source.State != UIState.Closed)
		{
			if (source.State == UIState.None)
			{
				return source.ExpectedState == UIExpectedState.Close;
			}
			return false;
		}
		return true;
	}

	private void TickPanelTransition()
	{
		PanelTransitionContext panelTransition = _panelTransition;
		if (panelTransition != null)
		{
			if (panelTransition.Operation == PanelTransitionOperation.Open)
			{
				TickOpenTransition(panelTransition);
			}
			else
			{
				TickCloseTransition(panelTransition);
			}
		}
	}

	private void TickOpenTransition(PanelTransitionContext context)
	{
		if (context.To == null)
		{
			if (context.UseBlackScreen)
			{
				BeginSourcePushStack(context);
				bool flag = IsTransitionSourceFinished(context.From, allowInStack: true);
				if (IsBlackScreenFullyVisible() && flag)
				{
					CreateAndLoadTransitionTarget(context);
				}
			}
		}
		else if (context.To.ExpectedState == UIExpectedState.Close)
		{
			if (context.To.State != UIState.Opening)
			{
				if (context.To.State == UIState.Opened)
				{
					IBaseUIController to = context.To;
					ReleasePanelTransitionContext(context);
					StartCloseTransition(to);
				}
				else
				{
					CancelOpenTransition(context);
				}
			}
		}
		else if (context.Phase == PanelTransitionPhase.LoadingTarget)
		{
			if (context.To.IsLoadOver)
			{
				BeginSourcePushStack(context);
				if (context.UseCrossFade || !context.SourceActionStarted)
				{
					StartTransitionTargetOpen(context);
				}
				else
				{
					context.Phase = PanelTransitionPhase.WaitingForSource;
				}
			}
		}
		else if (context.Phase == PanelTransitionPhase.WaitingForSource)
		{
			if (IsTransitionSourceFinished(context.From, allowInStack: true))
			{
				StartTransitionTargetOpen(context);
			}
		}
		else if (context.Phase == PanelTransitionPhase.WaitingForVisuals)
		{
			if (context.UseBlackScreen && !context.BlackFadeOutRequested && context.TargetActionStarted && !context.To.IsInHideRoot)
			{
				FadeOutBlackScreen();
				context.BlackFadeOutRequested = true;
			}
			bool flag2 = !context.SourceActionStarted || IsTransitionSourceFinished(context.From, allowInStack: true);
			if (context.To.State == UIState.Opened && flag2)
			{
				if (context.UseBlackScreen && !IsBlackScreenFullyHidden())
				{
					context.Phase = PanelTransitionPhase.WaitingForBlackHidden;
				}
				else
				{
					CompletePanelTransition();
				}
			}
		}
		else if (context.Phase == PanelTransitionPhase.WaitingForBlackHidden && IsBlackScreenFullyHidden())
		{
			CompletePanelTransition();
		}
	}

	private static void StartTransitionTargetOpen(PanelTransitionContext context)
	{
		context.To.OpenView();
		context.TargetActionStarted = true;
		context.Phase = PanelTransitionPhase.WaitingForVisuals;
	}

	private static void BeginSourcePushStack(PanelTransitionContext context)
	{
		if (!context.SourceActionStarted && context.From != null && context.From.State == UIState.Opened)
		{
			context.From.PushStack(context.Request.UIType);
			context.SourceActionStarted = true;
		}
	}

	internal bool CanTransitionSourceMoveToHide(IBaseUIController source)
	{
		PanelTransitionContext panelTransition = _panelTransition;
		if (panelTransition != null && panelTransition.UseBlackScreen && panelTransition.From == source)
		{
			return IsBlackScreenFullyVisible();
		}
		return true;
	}

	private void CancelOpenTransition(PanelTransitionContext context)
	{
		IBaseUIController to = context.To;
		ReleasePanelTransitionContext(context);
		CancelBlackScreenTransition();
		if (to != null)
		{
			ClosePanelImmediatelyInternal(to);
		}
	}

	private void StartCloseTransition(IBaseUIController panel)
	{
		if (_panelTransition == null)
		{
			IBaseUIController topUsableStackPanel = GetTopUsableStackPanel();
			bool flag = panel.RequireBlackScreenTransition || (topUsableStackPanel?.RequireBlackScreenTransition ?? false);
			PanelTransitionContext panelTransitionContext = PreparePanelTransitionContext();
			panelTransitionContext.Operation = PanelTransitionOperation.CloseAndPop;
			panelTransitionContext.Phase = ((!flag) ? PanelTransitionPhase.WaitingForVisuals : PanelTransitionPhase.WaitingForBlack);
			panelTransitionContext.From = panel;
			panelTransitionContext.Restore = topUsableStackPanel;
			panelTransitionContext.UseBlackScreen = flag;
			panelTransitionContext.UseCrossFade = topUsableStackPanel == null || (panel.TransitionStrategy == UITransitionStrategy.CrossFade && topUsableStackPanel.TransitionStrategy == UITransitionStrategy.CrossFade);
			_panelTransition = panelTransitionContext;
			if (flag)
			{
				FadeInBlackScreen();
				BeginSourceClose(panelTransitionContext);
			}
			else
			{
				BeginCloseAndRestore(panelTransitionContext);
			}
		}
	}

	private void StartRestoreTransition()
	{
		if (_panelTransition != null)
		{
			return;
		}
		IBaseUIController topUsableStackPanel = GetTopUsableStackPanel();
		if (topUsableStackPanel != null)
		{
			bool requireBlackScreenTransition = topUsableStackPanel.RequireBlackScreenTransition;
			PanelTransitionContext panelTransitionContext = PreparePanelTransitionContext();
			panelTransitionContext.Operation = PanelTransitionOperation.CloseAndPop;
			panelTransitionContext.Phase = ((!requireBlackScreenTransition) ? PanelTransitionPhase.WaitingForVisuals : PanelTransitionPhase.WaitingForBlack);
			panelTransitionContext.Restore = topUsableStackPanel;
			panelTransitionContext.UseBlackScreen = requireBlackScreenTransition;
			panelTransitionContext.UseCrossFade = true;
			_panelTransition = panelTransitionContext;
			if (requireBlackScreenTransition)
			{
				FadeInBlackScreen();
			}
			else
			{
				BeginCloseAndRestore(panelTransitionContext);
			}
		}
	}

	private void TickCloseTransition(PanelTransitionContext context)
	{
		if (context.Phase == PanelTransitionPhase.WaitingForBlack)
		{
			StartCloseViewWhenReady(context);
			if (IsTransitionSourceFinished(context.From, allowInStack: false) && IsBlackScreenFullyVisible())
			{
				BeginRestore(context);
				context.Phase = PanelTransitionPhase.WaitingForVisuals;
			}
		}
		else if (context.Phase == PanelTransitionPhase.WaitingForVisuals)
		{
			StartCloseViewWhenReady(context);
			bool flag = IsTransitionSourceFinished(context.From, allowInStack: false);
			if (!context.RestorePrepared && context.Restore != null && (context.UseCrossFade | flag))
			{
				PrepareStackPanelBelowClosing(context.Restore, context.From);
				context.RestorePrepared = true;
			}
			StartRestoreViewWhenReady(context);
			bool flag2 = context.Restore == null || (context.RestorePrepared && context.Restore.State == UIState.Opened);
			if (context.UseBlackScreen && !context.BlackFadeOutRequested)
			{
				bool flag3 = context.Restore == null || !context.Restore.IsInHideRoot;
				if (flag & flag3)
				{
					FadeOutBlackScreen();
					context.BlackFadeOutRequested = true;
				}
			}
			if (flag && flag2)
			{
				if (context.UseBlackScreen && !IsBlackScreenFullyHidden())
				{
					context.Phase = PanelTransitionPhase.WaitingForBlackHidden;
				}
				else
				{
					CompletePanelTransition();
				}
			}
		}
		else if (context.Phase == PanelTransitionPhase.WaitingForBlackHidden && IsBlackScreenFullyHidden())
		{
			CompletePanelTransition();
		}
	}

	private void BeginCloseAndRestore(PanelTransitionContext context)
	{
		BeginSourceClose(context);
		BeginRestore(context);
		context.Phase = PanelTransitionPhase.WaitingForVisuals;
	}

	private void BeginSourceClose(PanelTransitionContext context)
	{
		if (!context.SourceActionStarted && context.From != null)
		{
			if (!context.UseBlackScreen && context.UseCrossFade && context.Restore != null && context.From is BaseUIController baseUIController)
			{
				baseUIController.DisableBlurImmediately();
			}
			ExecutePanelCloseLifecycle(context.From);
			context.SourceActionStarted = true;
			StartCloseViewWhenReady(context);
		}
	}

	private void BeginRestore(PanelTransitionContext context)
	{
		if (context.UseCrossFade && !context.RestorePrepared && context.Restore != null)
		{
			PrepareStackPanelBelowClosing(context.Restore, context.From);
			context.RestorePrepared = true;
		}
		StartRestoreViewWhenReady(context);
	}

	private void StartCloseViewWhenReady(PanelTransitionContext context)
	{
		IBaseUIController baseUIController = context.From;
		if (baseUIController != null && !context.TargetActionStarted)
		{
			if (baseUIController.State == UIState.Opened)
			{
				baseUIController.CloseView(context.Restore?.UIType ?? UI_TYPE.UI_NONE);
				context.TargetActionStarted = true;
			}
			else if (baseUIController.State == UIState.Loaded || baseUIController.State == UIState.InStack || baseUIController.State == UIState.Closed)
			{
				ClosePanelImmediatelyInternal(baseUIController);
				context.TargetActionStarted = true;
			}
		}
	}

	private void StartRestoreViewWhenReady(PanelTransitionContext context)
	{
		IBaseUIController restore = context.Restore;
		if (restore != null && context.RestorePrepared && !context.RestoreActionStarted)
		{
			if (restore.State == UIState.InStack)
			{
				restore.PopStack(context.From?.UIType ?? UI_TYPE.UI_NONE);
				context.RestoreActionStarted = true;
			}
			else if (restore.State == UIState.Loaded || restore.State == UIState.Closed)
			{
				restore.OpenView();
				context.RestoreActionStarted = true;
			}
		}
	}

	private void CompletePanelTransition()
	{
		PanelTransitionContext panelTransition = _panelTransition;
		ReleasePanelTransitionContext(panelTransition);
	}

	private void ClearPanelTransition(bool closeTargetImmediately, bool hideBlackImmediately)
	{
		PanelTransitionContext panelTransition = _panelTransition;
		IBaseUIController baseUIController = panelTransition?.To;
		if (panelTransition != null)
		{
			ReleasePanelTransitionContext(panelTransition);
		}
		if (hideBlackImmediately)
		{
			HideBlackScreenImmediate();
		}
		else
		{
			CancelBlackScreenTransition();
		}
		if (closeTargetImmediately && baseUIController != null)
		{
			ClosePanelImmediatelyInternal(baseUIController);
		}
	}

	private void PrepareTransitionForCloseAllExcept(UI_TYPE preserveUIType)
	{
		PanelTransitionContext panelTransition = _panelTransition;
		if (panelTransition == null)
		{
			return;
		}
		if (panelTransition.Operation == PanelTransitionOperation.Open)
		{
			if (panelTransition.Request.UIType != preserveUIType)
			{
				ClearPanelTransition(closeTargetImmediately: false, hideBlackImmediately: false);
			}
			return;
		}
		IBaseUIController baseUIController = panelTransition.From;
		if (baseUIController != null && baseUIController.UIType == preserveUIType)
		{
			if (!panelTransition.SourceActionStarted)
			{
				panelTransition.From.ExpectedState = UIExpectedState.Open;
				ClearPanelTransition(closeTargetImmediately: false, hideBlackImmediately: false);
				return;
			}
			EnqueuePanelOpen(new UIOpenData
			{
				Uid = CreateUIId(),
				UIType = preserveUIType,
				OpenData = null
			});
		}
	}

	private void HandlePushedStackUI()
	{
		for (int num = _activePanelQueue.Count - 1; num >= 0; num--)
		{
			IBaseUIController baseUIController = _activePanelQueue[num];
			if (baseUIController.State == UIState.InStack)
			{
				RemoveFromActiveUIQueueAt(num);
				for (int num2 = _uiStack.Count - 1; num2 >= 0; num2--)
				{
					IBaseUIController baseUIController2 = _uiStack[num2];
					if (baseUIController2 != baseUIController && baseUIController2.UIType == baseUIController.UIType)
					{
						ClosePanelImmediatelyInternal(baseUIController2);
					}
				}
				if (!_uiStack.Contains(baseUIController))
				{
					_uiStack.Add(baseUIController);
				}
			}
		}
	}

	private bool QueueTryRemove(uint uid)
	{
		PanelTransitionContext panelTransition = _panelTransition;
		if (panelTransition != null && panelTransition.Operation == PanelTransitionOperation.Open && _panelTransition.Request.Uid == uid)
		{
			if (_panelTransition.To != null)
			{
				_panelTransition.To.ExpectedState = UIExpectedState.Close;
			}
			else
			{
				ReleasePanelTransitionContext(_panelTransition);
				CancelBlackScreenTransition();
			}
			return true;
		}
		for (int num = _openQueue.Count - 1; num >= 0; num--)
		{
			if (_openQueue[num].Uid == uid)
			{
				_openQueue.RemoveAt(num);
				return true;
			}
		}
		return false;
	}

	private bool QueueTryRemove(UI_TYPE uiType)
	{
		bool result = false;
		PanelTransitionContext panelTransition = _panelTransition;
		if (panelTransition != null && panelTransition.Operation == PanelTransitionOperation.Open && _panelTransition.Request.UIType == uiType)
		{
			if (_panelTransition.To != null)
			{
				_panelTransition.To.ExpectedState = UIExpectedState.Close;
			}
			else
			{
				ReleasePanelTransitionContext(_panelTransition);
				CancelBlackScreenTransition();
			}
			result = true;
		}
		for (int num = _openQueue.Count - 1; num >= 0; num--)
		{
			if (_openQueue[num].UIType == uiType)
			{
				_openQueue.RemoveAt(num);
				result = true;
			}
		}
		return result;
	}

	public bool QueueContains(UI_TYPE uiType)
	{
		PanelTransitionContext panelTransition = _panelTransition;
		if (panelTransition != null && panelTransition.Operation == PanelTransitionOperation.Open && _panelTransition.Request.UIType == uiType)
		{
			return true;
		}
		foreach (UIOpenData item in _openQueue)
		{
			if (item.UIType == uiType)
			{
				return true;
			}
		}
		return false;
	}

	public bool QueueContains(uint uid)
	{
		PanelTransitionContext panelTransition = _panelTransition;
		if (panelTransition != null && panelTransition.Operation == PanelTransitionOperation.Open && _panelTransition.Request.Uid == uid)
		{
			return true;
		}
		foreach (UIOpenData item in _openQueue)
		{
			if (item.Uid == uid)
			{
				return true;
			}
		}
		return false;
	}

	public void UIPushPauseGame(IBaseUIController ui)
	{
		if (!_pauseGameUI.Contains(ui))
		{
			_pauseGameUI.Add(ui);
			if (_pauseGameUI.Count == 1)
			{
				GameManager.effectSystem.SetAllUIEffectsVisible(visible: false);
				MonoECS.instance.PushPause();
			}
		}
	}

	public void UIPopPauseGame(IBaseUIController ui)
	{
		if (_pauseGameUI.Remove(ui) && _pauseGameUI.Count == 0)
		{
			GameManager.effectSystem.SetAllUIEffectsVisible(visible: true);
			MonoECS.instance.PopPause();
		}
	}

	public void PushUIEffectRenderingList(object context, List<UIEffectRendering> effects)
	{
		if (context == null || effects == null || effects.Count == 0)
		{
			return;
		}
		if (!_uiRenderingEffects.TryGetValue(context, out var value))
		{
			value = Bamboo.Pool.ListPool<UIEffectRendering>.Default.Get();
			_uiRenderingEffects.TryAdd(context, value);
		}
		foreach (UIEffectRendering effect in effects)
		{
			if (!value.Contains(effect))
			{
				value.Add(effect);
				DrawUIPass.UIEffectRenderingList.Add(effect);
				DrawUIPass.UIEffectRenderingList.Sort((UIEffectRendering x, UIEffectRendering y) => x.layer - y.layer);
			}
		}
	}

	public void PopUIEffectRenderingList(object context, List<UIEffectRendering> effects = null)
	{
		if (context == null || !_uiRenderingEffects.TryGetValue(context, out var value))
		{
			return;
		}
		if (effects == null)
		{
			DrawUIPass.UIEffectRenderingList.RemoveRange(value);
			_uiRenderingEffects.Remove(context);
			CleanupUIEffectRenderingsIfUnused(value);
			Bamboo.Pool.ListPool<UIEffectRendering>.Default.Recycle(value);
			return;
		}
		for (int i = 0; i < effects.Count; i++)
		{
			UIEffectRendering uIEffectRendering = effects[i];
			if (value.Remove(uIEffectRendering))
			{
				DrawUIPass.UIEffectRenderingList.Remove(uIEffectRendering);
				CleanupUIEffectRenderingIfUnused(uIEffectRendering);
			}
		}
		if (value.Count == 0)
		{
			_uiRenderingEffects.Remove(context);
			Bamboo.Pool.ListPool<UIEffectRendering>.Default.Recycle(value);
		}
	}

	private void ClearUIEffectRenderingLists()
	{
		foreach (List<UIEffectRendering> value in _uiRenderingEffects.Values)
		{
			DrawUIPass.UIEffectRenderingList.RemoveRange(value);
			for (int i = 0; i < value.Count; i++)
			{
				value[i]?.Cleanup();
			}
			Bamboo.Pool.ListPool<UIEffectRendering>.Default.Recycle(value);
		}
		_uiRenderingEffects.Clear();
	}

	private void CleanupUIEffectRenderingsIfUnused(List<UIEffectRendering> renderings)
	{
		for (int i = 0; i < renderings.Count; i++)
		{
			CleanupUIEffectRenderingIfUnused(renderings[i]);
		}
	}

	private void CleanupUIEffectRenderingIfUnused(UIEffectRendering effect)
	{
		if (effect == null)
		{
			return;
		}
		foreach (List<UIEffectRendering> value in _uiRenderingEffects.Values)
		{
			if (value.Contains(effect))
			{
				return;
			}
		}
		effect.Cleanup();
	}

	public void EnableUICatchCamera(IBaseUIController ui, UIEffectRendering catchEffect = null)
	{
		if (_catchCameraUIs.Add(ui))
		{
			int catchPriority = GetCatchPriority(catchEffect, out var hasCatchEffect);
			if (!hasCatchEffect && DrawUIPass.UIEffectRenderingList.Count == 0)
			{
				_catchCameraUIs.Remove(ui);
				return;
			}
			if (hasCatchEffect && catchPriority < 0)
			{
				_catchCameraUIs.Remove(ui);
				return;
			}
			_catchCameraEffects[ui] = catchEffect;
			Singleton<CameraManager>.instance.SetMainCameraSkipBaseEnable(isEnabled: true, catchPriority);
		}
	}

	private void RefreshExistingCatchCameras()
	{
		if (_catchCameraUIs.Count == 0)
		{
			return;
		}
		List<UIEffectRendering> uIEffectRenderingList = DrawUIPass.UIEffectRenderingList;
		List<IBaseUIController> list = Bamboo.Pool.ListPool<IBaseUIController>.Default.Get();
		list.AddRange(_catchCameraUIs);
		if (list.Count > 1)
		{
			list.Sort((IBaseUIController a, IBaseUIController b) => a.SortingLayer.CompareTo(b.SortingLayer));
		}
		for (int num = 0; num < list.Count; num++)
		{
			_catchCameraEffects.TryGetValue(list[num], out var value);
			int catchPriority = GetCatchPriority(value, out var hasCatchEffect);
			if ((hasCatchEffect || uIEffectRenderingList.Count != 0) && (!hasCatchEffect || catchPriority >= 0))
			{
				Singleton<CameraManager>.instance.SetMainCameraSkipBaseEnable(isEnabled: true, catchPriority);
			}
		}
		Bamboo.Pool.ListPool<IBaseUIController>.Default.Recycle(list);
	}

	public void RefreshActivePanelCatchCamera()
	{
		IBaseUIController activeUI = GetActiveUI();
		if (activeUI != null && activeUI.PanelType == UIPanelType.Panel && activeUI.RequireCatchScreen && activeUI.State == UIState.Opened)
		{
			_catchCameraEffects.TryGetValue(activeUI, out var value);
			DisableCatchCamera(activeUI);
			EnableUICatchCamera(activeUI, value);
		}
	}

	private int GetCatchPriority(UIEffectRendering catchEffect, out bool hasCatchEffect)
	{
		hasCatchEffect = catchEffect != null;
		if (catchEffect != null)
		{
			int num = DrawUIPass.UIEffectRenderingList.IndexOf(catchEffect);
			if (num >= 0)
			{
				return num;
			}
		}
		return 0;
	}

	public void DisableCatchCamera(IBaseUIController ui)
	{
		_catchCameraEffects.Remove(ui);
		if (_catchCameraUIs.Remove(ui) && _catchCameraUIs.Count == 0)
		{
			Singleton<CameraManager>.instance.SetMainCameraSkipBaseEnable(isEnabled: false);
		}
	}

	private void ClearImmediateUIRuntimeState()
	{
		List<IBaseUIController> list = Bamboo.Pool.ListPool<IBaseUIController>.Default.Get();
		list.AddRange(_pauseGameUI);
		foreach (IBaseUIController item in list)
		{
			UIPopPauseGame(item);
		}
		Bamboo.Pool.ListPool<IBaseUIController>.Default.Recycle(list);
		List<IBaseUIController> list2 = Bamboo.Pool.ListPool<IBaseUIController>.Default.Get();
		list2.AddRange(_catchCameraUIs);
		foreach (IBaseUIController item2 in list2)
		{
			DisableCatchCamera(item2);
		}
		Bamboo.Pool.ListPool<IBaseUIController>.Default.Recycle(list2);
		ClearUIEffectRenderingLists();
	}

	private void UpdateActiveUIQueueSortingLayers()
	{
		if (_activePanelQueue.Count == 0)
		{
			return;
		}
		int currentLayer = _basePanelSortingLayer;
		foreach (IBaseUIController item in _activePanelQueue)
		{
			currentLayer = AssignSortingLayerAndAdvance(item, currentLayer);
			foreach (uint child in item.Children)
			{
				if (_allUI.TryGetValue(child, out var value) && (value.ExpectedState == UIExpectedState.Open || value.State != UIState.Closed))
				{
					currentLayer = AssignSortingLayerAndAdvance(value, currentLayer);
				}
			}
		}
		RefreshExistingCatchCameras();
	}

	private static int AssignSortingLayerAndAdvance(IBaseUIController ui, int currentLayer)
	{
		int num = ui.ForceSortingLayer ?? currentLayer;
		ui.SetSortingLayer(num);
		int num2 = num + ui.SortingLayerCount;
		if (num2 <= currentLayer)
		{
			return currentLayer;
		}
		return num2;
	}

	private void StackExecute()
	{
		for (int num = _uiStack.Count - 1; num >= 0; num--)
		{
			IBaseUIController baseUIController = _uiStack[num];
			if (baseUIController.ExpectedState == UIExpectedState.Close)
			{
				ClosePanelImmediatelyInternal(baseUIController);
			}
		}
		if (_panelCloseCleanupRequested)
		{
			_panelCloseCleanupRequested = false;
			List<IBaseUIController> list = Bamboo.Pool.ListPool<IBaseUIController>.Default.Get();
			foreach (List<IBaseUIController> value in _allLifeUI.Values)
			{
				foreach (IBaseUIController item in value)
				{
					if (item.PanelType == UIPanelType.Panel && item.ExpectedState == UIExpectedState.Close && !_activePanelQueue.Contains(item) && !_uiStack.Contains(item))
					{
						list.Add(item);
					}
				}
			}
			foreach (IBaseUIController item2 in list)
			{
				ClosePanelImmediatelyInternal(item2);
			}
			Bamboo.Pool.ListPool<IBaseUIController>.Default.Recycle(list);
		}
		if (_panelTransition == null && _openQueue.Count <= 0)
		{
			IBaseUIController activeUI = GetActiveUI();
			if (activeUI != null && activeUI.ExpectedState == UIExpectedState.Close)
			{
				StartCloseTransition(activeUI);
			}
			else if (activeUI == null && _uiStack.Count > 0)
			{
				StartRestoreTransition();
			}
		}
	}

	private IBaseUIController GetTopUsableStackPanel()
	{
		for (int num = _uiStack.Count - 1; num >= 0; num--)
		{
			IBaseUIController baseUIController = _uiStack[num];
			if (baseUIController.ExpectedState == UIExpectedState.Open)
			{
				return baseUIController;
			}
			ClosePanelImmediatelyInternal(baseUIController);
		}
		return null;
	}

	private void PrepareStackPanelBelowClosing(IBaseUIController ui, IBaseUIController closing)
	{
		if (ui.DisableInputOnTransition)
		{
			DisableInputController();
		}
		_uiStack.Remove(ui);
		ui.ExpectedState = UIExpectedState.Open;
		AddBelowClosingPanel(ui, closing);
	}

	private bool StackContainsExpectedOpen(UI_TYPE uiType)
	{
		foreach (IBaseUIController item in _uiStack)
		{
			if (item.UIType == uiType && item.ExpectedState == UIExpectedState.Open)
			{
				return true;
			}
		}
		return false;
	}

	private void RemoveFormStack(IBaseUIController ui)
	{
		_uiStack.Remove(ui);
		SyncRuntimeInfoUiType();
	}

	private void SyncRuntimeInfoUiType()
	{
		UI_TYPE uiType = UI_TYPE.UI_NONE;
		for (int num = _uiStack.Count - 1; num >= 0; num--)
		{
			IBaseUIController baseUIController = _uiStack[num];
			if (baseUIController.ExpectedState == UIExpectedState.Open)
			{
				uiType = baseUIController.UIType;
				break;
			}
		}
		LuminApplication.RuntimeInfo.SetUiType((int)uiType);
	}

	private void CleanupActiveUIQueue()
	{
		for (int num = _activePanelQueue.Count - 1; num >= 0; num--)
		{
			IBaseUIController baseUIController = _activePanelQueue[num];
			if (baseUIController.State == UIState.Closed && baseUIController.ExpectedState == UIExpectedState.Close)
			{
				RemoveFromActiveUIQueueAt(num);
			}
		}
	}

	private IBaseUIController GetActiveUI()
	{
		if (_activePanelQueue.Count <= 0)
		{
			return null;
		}
		List<IBaseUIController> activePanelQueue = _activePanelQueue;
		return activePanelQueue[activePanelQueue.Count - 1];
	}

	private bool HasActiveUI()
	{
		return _activePanelQueue.Count > 0;
	}

	private void AddToActiveUIQueue(IBaseUIController ui)
	{
		if (!_activePanelQueue.Contains(ui))
		{
			_activePanelQueue.Add(ui);
			UpdateActiveUIQueueSortingLayers();
		}
	}

	private void AddBelowClosingPanel(IBaseUIController ui, IBaseUIController closing)
	{
		if (!_activePanelQueue.Contains(ui))
		{
			int num = ((closing == null) ? _activePanelQueue.Count : _activePanelQueue.IndexOf(closing));
			if (num < 0)
			{
				num = _activePanelQueue.Count;
			}
			_activePanelQueue.Insert(num, ui);
			UpdateActiveUIQueueSortingLayers();
		}
	}

	private bool RemoveFromActiveUIQueue(IBaseUIController ui)
	{
		int num = _activePanelQueue.IndexOf(ui);
		if (num < 0)
		{
			return false;
		}
		RemoveFromActiveUIQueueAt(num);
		return true;
	}

	private void RemoveFromActiveUIQueueAt(int index)
	{
		_activePanelQueue.RemoveAt(index);
		UpdateActiveUIQueueSortingLayers();
	}

	private void ClearActiveUIQueue()
	{
		_activePanelQueue.Clear();
		UpdateActiveUIQueueSortingLayers();
	}

	internal void BindUIParticleUpdateMark(IBaseUIController controller, GameObject viewObject)
	{
		if (controller == null || !viewObject)
		{
			return;
		}
		UIParticleUpdateMark component = viewObject.GetComponent<UIParticleUpdateMark>();
		UIParticleUpdateMark value;
		if (!component)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"UI {controller.UIType} 缺少 UIParticleUpdateMark，请在 View Prefab 根节点添加该组件。");
			}
		}
		else if (!_uiParticleUpdateMarks.TryGetValue(controller.UIType, out value) || !(value == component))
		{
			_uiParticleUpdateMarks[controller.UIType] = component;
			component.SetUpdateEnabled(enabled: false);
		}
	}

	internal void UnbindUIParticleUpdateMark(IBaseUIController controller, GameObject viewObject)
	{
		if (controller != null && (bool)viewObject && _uiParticleUpdateMarks.TryGetValue(controller.UIType, out var value) && !(value.gameObject != viewObject))
		{
			value.SetUpdateEnabled(enabled: false);
			_uiParticleUpdateMarks.Remove(controller.UIType);
		}
	}

	internal void SetUIParticleUpdate(IBaseUIController controller, bool enabled)
	{
		if (controller != null && _uiParticleUpdateMarks.TryGetValue(controller.UIType, out var value) && (bool)value)
		{
			value.SetUpdateEnabled(enabled);
		}
	}
}
