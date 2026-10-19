using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Event;
using ACT.Sound;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using FMODUnity;
using Fundamental;
using UI.ViewComponent.BattlemainView.ActComponent;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.U2D;
using UnityEngine.UI;

namespace ACT.UI;

public class BaseUIView : BaseUIView<BaseUIViewInputController>
{
}
public abstract class BaseUIView<T> : BaseUIComponent<T>, IBaseUIView, IBaseUIComponent where T : class, IInputController, new()
{
	protected UI_TYPE _uiType;

	protected object uiViewData;

	[SerializeField]
	private List<SpriteAtlas> m_Atlas;

	[SerializeField]
	private List<YooAssetReference<SpriteAtlas>> m_AtlasReferencesAssetID = new List<YooAssetReference<SpriteAtlas>>();

	private List<Canvas> _cachedCanvases;

	private List<GraphicRaycaster> _cachedRaycasters;

	[SerializeField]
	[FormerlySerializedAs("UILayer")]
	private UI_LAYER _uiLayer;

	[Tooltip("需要inputController")]
	public bool NeedController = true;

	[FormerlySerializedAs("isEmpty")]
	[Tooltip("是否任何交互都不需要")]
	private bool _isEmpty;

	[SerializeField]
	[FormerlySerializedAs("ContentCanvas")]
	private Canvas _contentCanvas;

	public RectTransform ControlTransform;

	[SerializeField]
	[FormerlySerializedAs("SafeArea")]
	private List<SafeArea> _safeArea;

	[FormerlySerializedAs("uiComponents")]
	private List<ActComponent> _uiComponents = new List<ActComponent>();

	public UpdateSortingLayer updateSortingLayer;

	public List<RedDotItem> redDotItems;

	private uint _bgmInstance;

	private ImageAssetStation _station;

	public bool useAnimation;

	public Animator uiEffectAnimator;

	public BetterAnimation betterAnimation;

	public YooAssetReference BankAssetID;

	public EventReference openSound;

	public AudioEventReference audioOpenSound;

	public EventReference closeSound;

	public AudioEventReference audioCloseSound;

	public EventReference bgm;

	public AudioEventReference audioBgm;

	public bool clearOnParentHide = true;

	public UIRelativeCanvas[] uiRelativeCanvases;

	public UIRelativeEffect[] uiRelativeEffects;

	[SerializeField]
	private List<GuideTargetNode> _guideTargets = new List<GuideTargetNode>();

	private Dictionary<string, Transform> _guideTargetMap;

	private IUIFrameElement[] _cachedUIElements;

	private HashSet<IUIFrameElement> _externalUIElements;

	private bool _inited;

	private bool _inShowAnimation;

	private bool _inCloseAnimation;

	private IBaseUIController _uiController;

	private readonly List<ISubUIView> _activateSubUIViews = new List<ISubUIView>();

	private CanvasGroup _canvasGroup;

	private List<UI_TYPE> _activeCanvasGroups = new List<UI_TYPE>
	{
		UI_TYPE.UI_BATTLEMAIN,
		UI_TYPE.UI_TEAM
	};

	protected const string PushStackAnimationName = "Push";

	protected const string PopStackAnimationName = "Pop";

	public UI_TYPE UIType
	{
		get
		{
			return _uiType;
		}
		set
		{
			_uiType = value;
		}
	}

	public IReadOnlyList<YooAssetReference<SpriteAtlas>> AtlasReferences => m_AtlasReferencesAssetID;

	public bool ActiveInShowRoot
	{
		get
		{
			UIState state = UIController.State;
			return state == UIState.Opening || state == UIState.Opened || state == UIState.Closing || state == UIState.PushingStack || state == UIState.PoppingStack;
		}
	}

	public UI_LAYER UILayer => _uiLayer;

	public bool isEmpty
	{
		get
		{
			return _isEmpty;
		}
		set
		{
			_isEmpty = value;
		}
	}

	public Canvas ContentCanvas => _contentCanvas;

	public List<SafeArea> SafeArea => _safeArea;

	public List<ActComponent> uiComponents => _uiComponents;

	public sealed override ImageAssetStation Station
	{
		get
		{
			GetImageStation();
			return _station;
		}
		set
		{
			base.Station = value;
		}
	}

	public IBaseUIController UIController => _uiController;

	public int SortingLayer => _uiController.SortingLayer;

	IInputController IBaseUIView.InputController
	{
		get
		{
			if (NeedController && GetInputBindingController() == null)
			{
				CreateController();
			}
			return GetInputBindingController();
		}
	}

	protected override IBaseUIController GetUIController()
	{
		return _uiController;
	}

	IBaseUIController IBaseUIComponent.GetUIController()
	{
		return GetUIController();
	}

	public Transform FindGuideTarget(string id)
	{
		if (string.IsNullOrEmpty(id))
		{
			return null;
		}
		EnsureGuideTargetMap();
		if (!_guideTargetMap.TryGetValue(id, out var value) || !(value != null))
		{
			return null;
		}
		return value;
	}

	public void RegisterGuideTarget(GuideTargetNode node)
	{
		if (!(node == null) && !string.IsNullOrEmpty(node.Id))
		{
			EnsureGuideTargetMap();
			if (_guideTargetMap.TryGetValue(node.Id, out var value) && value != null && value != node.transform)
			{
				Debug.LogWarning("[BaseUIView] 引导目标 Id 重复(" + name + "):'" + node.Id + "',后注册的将覆盖先前的。", node);
			}
			_guideTargetMap[node.Id] = node.transform;
		}
	}

	public void UnregisterGuideTarget(GuideTargetNode node)
	{
		if (!(node == null) && !string.IsNullOrEmpty(node.Id) && _guideTargetMap != null && _guideTargetMap.TryGetValue(node.Id, out var value) && value == node.transform)
		{
			_guideTargetMap.Remove(node.Id);
		}
	}

	private void EnsureGuideTargetMap()
	{
		if (_guideTargetMap != null)
		{
			return;
		}
		_guideTargetMap = new Dictionary<string, Transform>(_guideTargets?.Count ?? 0);
		if (_guideTargets == null)
		{
			return;
		}
		foreach (GuideTargetNode guideTarget in _guideTargets)
		{
			if (!(guideTarget == null) && !string.IsNullOrEmpty(guideTarget.Id))
			{
				_guideTargetMap[guideTarget.Id] = guideTarget.transform;
			}
		}
	}

	private void BaseInit()
	{
		DoOnInit();
		SetRenderSetting();
		if (_station == null)
		{
			_station = ImageManager.instance.GetAssetStation();
		}
		Init();
		_inited = true;
	}

	private void SetRenderSetting()
	{
		if (UILayer == UI_LAYER.NORMAL)
		{
			if (UIType == UI_TYPE.UI_CHARACTER)
			{
				RenderUtility.SetURPGraphicSettings(isColor: false, isDepth: true, isSkybox: true, isDistortion: false);
			}
			else if (UIType == UI_TYPE.UI_TEAM)
			{
				RenderUtility.SetURPGraphicSettings(isColor: false, isDepth: true, isSkybox: true, isDistortion: false);
			}
			else if (UIType != UI_TYPE.UI_CONVERSATION)
			{
				RenderUtility.ResetRenderFeature();
			}
		}
	}

	private void DoOnInit()
	{
		UpdateChildrenLayer();
		UpdateRedDot();
		InitSound();
		AddRelativeUIEffect();
	}

	private void UpdateChildrenLayer()
	{
		if (updateSortingLayer != null)
		{
			updateSortingLayer.UpdateLayer();
		}
	}

	private void UpdateRedDot()
	{
		for (int i = 0; i < redDotItems.Count; i++)
		{
			RedDotItem redDotItem = redDotItems[i];
			if ((bool)redDotItem)
			{
				redDotItem.BindTrieNode();
				redDotItem.UpdateDisplay();
			}
		}
	}

	private void InitSound()
	{
		if (!audioBgm.IsNull())
		{
			Singleton<BGMManager>.instance.SetBGM(BGMType.UI, audioBgm.GetEventPath());
		}
	}

	private void BaseUnInit()
	{
		if (_inited)
		{
			_inited = false;
			DoOnUnInit();
			UnInit();
		}
	}

	private void DoOnUnInit()
	{
		UnInitSound();
		RemoveRelativeUIEffect();
		((IOperatePromptIconCollectionProvider)this).UnInitCollection();
	}

	public void SetMainCameraSkipBaseEnable(bool enable)
	{
		Singleton<CameraManager>.instance.SetMainCameraSkipBaseEnable(enable);
	}

	private void UnInitSound()
	{
		if (!audioBgm.IsNull())
		{
			Singleton<BGMManager>.instance.ClearBGM(BGMType.UI);
		}
	}

	private void GetImageStation()
	{
		if (_station == null)
		{
			_station = ImageManager.instance.GetAssetStation();
		}
	}

	private void ReleaseImageStation()
	{
		if (_station != null)
		{
			ImageManager.instance.UnloadAssetStation(_station);
			_station = null;
		}
	}

	public virtual void BackToBattleMain()
	{
		Singleton<NewUIManager>.instance.BackToBattleMain();
	}

	private void AddRelativeUIEffect()
	{
		UIRelativeEffect[] array = uiRelativeEffects;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].AddUIEffect(UIController);
		}
	}

	private void RemoveRelativeUIEffect()
	{
		UIRelativeEffect[] array = uiRelativeEffects;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].RemoveUIEffect(UIController);
		}
	}

	private void OnDestroy()
	{
		ReleaseImageStation();
	}

	private void CollectIuiElements()
	{
		_cachedUIElements = GetComponentsInChildren<IUIFrameElement>(includeInactive: true);
	}

	public void RefreshIuiElementsCollection()
	{
		CollectIuiElements();
	}

	internal void RegisterIuiElement(IUIFrameElement newElement)
	{
		if (_externalUIElements == null)
		{
			_externalUIElements = new HashSet<IUIFrameElement>();
		}
		_externalUIElements.Add(newElement);
	}

	private void ClearIuiElements()
	{
		_cachedUIElements = null;
		_externalUIElements = null;
	}

	private void InvokeElementLifecycle(string lifecycle, Action<IUIFrameElement> action)
	{
		if (_cachedUIElements != null)
		{
			IUIFrameElement[] cachedUIElements = _cachedUIElements;
			foreach (IUIFrameElement element in cachedUIElements)
			{
				InvokeElementLifecycle(lifecycle, element, action);
			}
		}
		if (_externalUIElements == null)
		{
			return;
		}
		foreach (IUIFrameElement externalUIElement in _externalUIElements)
		{
			InvokeElementLifecycle(lifecycle, externalUIElement, action);
		}
	}

	private void InvokeElementLifecycle(string lifecycle, IUIFrameElement element, Action<IUIFrameElement> action)
	{
		try
		{
			action(element);
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"[BaseUIView] UI 元素生命周期 {lifecycle} 执行失败({GetType().Name}): {arg}");
			}
		}
	}

	void IBaseUIView.InvokeElementsInit()
	{
		InvokeElementLifecycle("Initialize", (IUIFrameElement e) =>
		{
			e.Initialize();
		});
	}

	void IBaseUIView.InvokeElementsAddListener()
	{
		InvokeElementLifecycle("AddListener", (IUIFrameElement e) =>
		{
			e.AddListener();
		});
	}

	void IBaseUIView.InvokeElementsRemoveListener()
	{
		InvokeElementLifecycle("RemoveListener", (IUIFrameElement e) =>
		{
			e.RemoveListener();
		});
	}

	void IBaseUIView.InvokeElementsUnInit()
	{
		InvokeElementLifecycle("UnInitialize", (IUIFrameElement e) =>
		{
			e.UnInitialize();
		});
	}

	void IBaseUIView.InvokeElementsPushInStack()
	{
		InvokeElementLifecycle("PushInStack", (IUIFrameElement e) =>
		{
			e.PushInStack();
		});
	}

	void IBaseUIView.InvokeElementsPopUpStack()
	{
		InvokeElementLifecycle("PopUpStack", (IUIFrameElement e) =>
		{
			e.PopUpStack();
		});
	}

	void IBaseUIView.InvokeElementsOnUIDestroy()
	{
		InvokeElementLifecycle("OnUIDestroy", (IUIFrameElement e) =>
		{
			e.OnUIDestroy();
		});
	}

	void IBaseUIView.ClearElements()
	{
		ClearIuiElements();
	}

	public void BindUIController(IBaseUIController uiController)
	{
		if (_activateSubUIViews.Count > 0)
		{
			foreach (ISubUIView activateSubUIView in _activateSubUIViews)
			{
				if (activateSubUIView.InputController is ISubInputController subInputController)
				{
					subInputController.SetParentUIController(uiController);
				}
			}
		}
		_uiController = uiController;
		_uiType = uiController.UIType;
	}

	void IBaseUIView.ActivateSubView(ISubUIView subUIView)
	{
		if (!_activateSubUIViews.Contains(subUIView))
		{
			_activateSubUIViews.Add(subUIView);
			if (_uiController != null && subUIView.InputController is ISubInputController subInputController)
			{
				subInputController.SetParentUIController(_uiController);
			}
			if (_uiController.State == UIState.Opened)
			{
				subUIView.ActivateInputController();
			}
		}
	}

	void IBaseUIView.DeactivateSubViewInput(ISubUIView subUIView)
	{
		if (_activateSubUIViews.Contains(subUIView))
		{
			_activateSubUIViews.Remove(subUIView);
			if (subUIView.InputController is ISubInputController subInputController)
			{
				subInputController.SetParentUIController(null);
			}
			if (_uiController.State == UIState.Opened)
			{
				subUIView.DeactivateInputController();
			}
		}
	}

	IReadOnlyList<ISubUIView> IBaseUIView.GetActivateSubUIViews()
	{
		return _activateSubUIViews;
	}

	void IBaseUIView.Init(object data)
	{
		uiViewData = data;
		CollectIuiElements();
		AddEventListener();
		if (BankAssetID != null && BankAssetID.RuntimeKeyIsValid())
		{
			Singleton<GameManager>.instance.audioManager.LoadBank(BankAssetID);
		}
	}

	async UniTask IBaseUIView.PreShow(CancellationToken token)
	{
		await PreInit().AttachExternalCancellation(token);
	}

	async UniTask IBaseUIView.Show(CancellationToken token)
	{
		PlayOpenSound();
		BaseInit();
		await ShowOpenEffect(token);
		if (!token.IsCancellationRequested)
		{
			OpenEffectCallback();
			await WaitShowCompleteAsync(token);
			if (!token.IsCancellationRequested)
			{
				UIEvent evt = Singleton<EventManager>.instance.GetEvt<UIEvent>();
				evt.UIType = _uiType;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_AfterShowAni, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
		}
	}

	public void ReShow(object newData)
	{
		uiViewData = newData;
		ReInit();
	}

	async UniTask IBaseUIView.Hide(CancellationToken token)
	{
		RemoveEventListener();
		PlayCloseSound();
		BaseUnInit();
		await ShowCloseEffect(token);
		if (!token.IsCancellationRequested)
		{
			CloseEffectCallback();
			await WaitHideCompleteAsync(token);
		}
	}

	async UniTask IBaseUIView.PushToStack(CancellationToken token)
	{
		OnPushStack();
		await PlayPushStackAsync(token);
	}

	async UniTask IBaseUIView.PopFromStack(CancellationToken token)
	{
		OnPopStack();
		await PlayPopStackAsync(token);
		UIEvent evt = Singleton<EventManager>.instance.GetEvt<UIEvent>();
		evt.UIType = _uiType;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_AfterShowAni, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	void IBaseUIView.SetSortingLayer(int layer)
	{
		UIUtility.SetSortingLayer(ContentCanvas, layer);
		UpdateChildrenLayer();
		OnSetSortingLayer(layer);
		UIRelativeCanvas[] array = uiRelativeCanvases;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetSortingLayer(layer);
		}
		UIRelativeEffect[] array2 = uiRelativeEffects;
		for (int i = 0; i < array2.Length; i++)
		{
			array2[i].SetSortingLayer(layer);
		}
	}

	void IBaseUIView.InitializeHiddenState()
	{
		ChangeCanvasLayer(Singleton<NewUIManager>.instance.HideLayer);
		ChangeGraphicRaycasterState(enable: false);
	}

	void IBaseUIView.OnMoveToShow()
	{
		OnMoveToShow();
		ChangeCanvasLayer(Singleton<NewUIManager>.instance.UILayer);
		ChangeGraphicRaycasterState(enable: true);
	}

	void IBaseUIView.OnMoveToHide()
	{
		OnMoveToHide();
		UIEvent evt = Singleton<EventManager>.instance.GetEvt<UIEvent>();
		evt.UIType = _uiType;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_AfterHideAni, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		ChangeCanvasLayer(Singleton<NewUIManager>.instance.HideLayer);
		ChangeGraphicRaycasterState(enable: false);
	}

	void IBaseUIView.UnInit()
	{
		BaseUnInit();
		if (BankAssetID != null && BankAssetID.RuntimeKeyIsValid())
		{
			Singleton<GameManager>.instance.audioManager.UnloadBank(BankAssetID);
		}
		RemoveEventListener();
		CloseComplete();
	}

	private void PlayOpenSound()
	{
		if (!audioOpenSound.IsNull())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(audioOpenSound);
		}
	}

	private void PlayCloseSound()
	{
		if (!audioCloseSound.IsNull())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(audioCloseSound);
		}
	}

	public void SetUIViewData(object data)
	{
		uiViewData = data;
	}

	private async UniTask ShowOpenEffect(CancellationToken token)
	{
		_inShowAnimation = true;
		if (!useAnimation || (uiEffectAnimator == null && betterAnimation == null))
		{
			OpenEffectFinishNew();
			return;
		}
		PlayOpenAnimation();
		float num = 0f;
		if (betterAnimation != null)
		{
			num = betterAnimation.GetCurrentPlayingAnimationDuration();
		}
		if (num > 0f)
		{
			await UniTask.WhenAny(UniTask.WaitUntil(() => !_inShowAnimation, PlayerLoopTiming.Update, token), UniTask.Delay(TimeSpan.FromMilliseconds(num * 1000f + 200f), ignoreTimeScale: false, PlayerLoopTiming.Update, token));
		}
	}

	protected void OpenEffectFinishNew()
	{
		_inShowAnimation = false;
	}

	public virtual void Close()
	{
		Singleton<NewUIManager>.instance.CloseUI(UIController.Uid);
	}

	public async UniTask CloseAsync()
	{
		await Singleton<NewUIManager>.instance.CloseUIAsync(UIController.Uid);
	}

	protected virtual void CloseComplete()
	{
	}

	protected async UniTask ShowCloseEffect(CancellationToken token)
	{
		_inCloseAnimation = true;
		if (!useAnimation || (uiEffectAnimator == null && betterAnimation == null))
		{
			CloseEffectFinishNew();
			return;
		}
		PlayCloseAnimation();
		float num = 0f;
		if (betterAnimation != null)
		{
			num = betterAnimation.GetCurrentPlayingAnimationDuration();
		}
		if (num > 0f)
		{
			await UniTask.WhenAny(UniTask.WaitUntil(() => !_inCloseAnimation, PlayerLoopTiming.Update, token), UniTask.Delay(TimeSpan.FromMilliseconds(num * 1000f), ignoreTimeScale: false, PlayerLoopTiming.Update, token));
		}
	}

	protected void CloseEffectFinishNew()
	{
		_inCloseAnimation = false;
	}

	public void SetCanvasGroup(bool active)
	{
		if (!_activeCanvasGroups.Contains(_uiType))
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		if (_canvasGroup == null)
		{
			_canvasGroup = ContentCanvas.GetComponent<CanvasGroup>();
		}
		_canvasGroup.alpha = (active ? 1 : 0);
		_canvasGroup.interactable = active;
	}

	public bool GetCanvasGroupState()
	{
		if (!_activeCanvasGroups.Contains(_uiType))
		{
			_ = LuminApplication.LogEnabled;
			return false;
		}
		if (_canvasGroup == null)
		{
			_canvasGroup = ContentCanvas.GetComponent<CanvasGroup>();
		}
		return Mathf.Approximately(_canvasGroup.alpha, 1f);
	}

	protected virtual void OnCanvasLayerChanged(int layer)
	{
	}

	private void ChangeCanvasLayer(int layer)
	{
		if (!(transform == null))
		{
			if (_cachedCanvases == null)
			{
				_cachedCanvases = new List<Canvas>();
				transform.GetComponentsInChildren(includeInactive: true, _cachedCanvases);
			}
			for (int i = 0; i < _cachedCanvases.Count; i++)
			{
				_cachedCanvases[i].gameObject.layer = layer;
			}
			OnCanvasLayerChanged(layer);
		}
	}

	private void ChangeGraphicRaycasterState(bool enable)
	{
		if (_cachedRaycasters == null)
		{
			_cachedRaycasters = new List<GraphicRaycaster>();
			GetComponentsInChildren(includeInactive: true, _cachedRaycasters);
		}
		for (int i = 0; i < _cachedRaycasters.Count; i++)
		{
			_cachedRaycasters[i].enabled = enable;
		}
	}

	public virtual async UniTask PreInit()
	{
	}

	protected virtual void Init()
	{
	}

	protected virtual void ReInit()
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"当前界面{_uiType}已处于打开状态执行刷新方法ReInit");
		}
	}

	protected virtual void UnInit()
	{
	}

	protected virtual void AddEventListener()
	{
	}

	protected virtual void RemoveEventListener()
	{
	}

	protected virtual void PlayOpenAnimation()
	{
		if (betterAnimation != null)
		{
			betterAnimation.StopAnimation();
		}
	}

	protected virtual void PlayCloseAnimation()
	{
		if (betterAnimation != null)
		{
			betterAnimation.StopAnimation();
		}
	}

	protected virtual void OpenEffectCallback()
	{
	}

	protected virtual void CloseEffectCallback()
	{
	}

	protected void CreateController()
	{
		CreateInputBindingController();
	}

	public sealed override IInputController GetInputBindingController()
	{
		return GetController();
	}

	protected virtual async UniTask WaitShowCompleteAsync(CancellationToken token)
	{
	}

	protected virtual async UniTask WaitHideCompleteAsync(CancellationToken token)
	{
	}

	protected virtual void OnMoveToHide()
	{
	}

	protected virtual void OnMoveToShow()
	{
	}

	protected virtual UniTask PlayPushStackAsync(CancellationToken token)
	{
		return PlayStackAnimationAsync("Push", token);
	}

	protected virtual UniTask PlayPopStackAsync(CancellationToken token)
	{
		return PlayStackAnimationAsync("Pop", token);
	}

	private UniTask PlayStackAnimationAsync(string animationName, CancellationToken token)
	{
		if (betterAnimation == null)
		{
			return UniTask.CompletedTask;
		}
		AnimationBuilder sequence = betterAnimation.GetSequence(animationName);
		if (sequence == null)
		{
			return UniTask.CompletedTask;
		}
		sequence.Play();
		return UniTask.WaitUntil(sequence.IsComplete, PlayerLoopTiming.Update, token);
	}

	protected virtual void OnPushStack()
	{
	}

	protected virtual void OnPopStack()
	{
	}

	protected virtual void OnSetSortingLayer(int layer)
	{
	}
}
