using System;
using System.Collections.Generic;
using System.Threading;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public abstract class BaseUIController : IBaseUIController
{
	protected UI_TYPE _uiType;

	protected AssetLoadHandle _uiLoadHandle;

	protected UIState _state;

	protected IBaseUIView _uiView;

	protected IInputController _inputController;

	protected GameObject _viewObject;

	protected List<uint> _children = new List<uint>();

	protected object _data;

	protected CancellationTokenSource _openCts;

	private float _closeTime;

	private int _sortingLayer;

	private bool _hasClosedLifecycleCompleted;

	private bool _isBlurEnabled;

	private bool _isHidden = true;

	private readonly List<UIEffectRendering> _uiBlurEffects = new List<UIEffectRendering>();

	public IReadOnlyCollection<ISubUIView> ActivateSubViews => GetUIView()?.GetActivateSubUIViews();

	public uint Uid { get; private set; }

	public UIState State => _state;

	public bool IsLoadOver
	{
		get
		{
			if (_uiView != null && _state != UIState.None)
			{
				return _state != UIState.Loading;
			}
			return false;
		}
	}

	public UIExpectedState ExpectedState { get; set; }

	public UI_TYPE UIType => _uiType;

	public uint Parent { get; private set; }

	public IReadOnlyList<uint> Children => _children;

	public abstract UIPanelType PanelType { get; }

	public virtual int SortingLayerCount => 1;

	public int SortingLayer => _sortingLayer;

	public virtual int? ForceSortingLayer => null;

	public abstract bool IsConnectSystem { get; }

	public abstract int SystemId { get; }

	public virtual bool DisableInputOnTransition => PanelType != UIPanelType.Toast;

	public virtual bool RequireBlackScreenTransition => false;

	public virtual bool RequirePauseGame => PanelType != UIPanelType.Toast;

	public virtual bool RequireCatchScreen => PanelType == UIPanelType.Panel;

	public virtual bool RequireBlurBackGround => false;

	public virtual UITransitionStrategy TransitionStrategy => UITransitionStrategy.CrossFade;

	public virtual UILifetimePolicy LifetimePolicy => UILifetimePolicy.Timed;

	public virtual UIInstanceStrategy InstanceStrategy => UIInstanceStrategy.SingleInstance;

	public virtual float LifetimeDelay => 30f;

	public float CloseTime => _closeTime;

	public bool IsInHideRoot
	{
		get
		{
			if (!(_viewObject == null))
			{
				return _isHidden;
			}
			return true;
		}
	}

	public bool IsBlurEnabled => _isBlurEnabled;

	private bool ShouldKeepViewObjectActiveWhenHidden()
	{
		if (Singleton<NewUIManager>.instance != null)
		{
			return Singleton<NewUIManager>.instance.ShouldKeepActiveWhenHidden(_uiType);
		}
		return false;
	}

	private void ActivateViewObjectBeforeOpen()
	{
		if (_viewObject != null && !_viewObject.activeSelf)
		{
			_viewObject.SetActive(value: true);
		}
	}

	private void DeactivateViewObjectAfterHidden()
	{
		if (!(_viewObject == null) && _viewObject.activeSelf && Singleton<NewUIManager>.instance != null && Singleton<NewUIManager>.instance.EnableInactiveUIActiveOptimization && !ShouldKeepViewObjectActiveWhenHidden())
		{
			_viewObject.SetActive(value: false);
		}
	}

	internal void RefreshViewObjectActiveState()
	{
		if (_viewObject == null)
		{
			return;
		}
		if (!Singleton<NewUIManager>.instance.EnableInactiveUIActiveOptimization || !_isHidden || ShouldKeepViewObjectActiveWhenHidden())
		{
			if (!_viewObject.activeSelf)
			{
				_viewObject.SetActive(value: true);
			}
		}
		else if (_viewObject.activeSelf)
		{
			_viewObject.SetActive(value: false);
		}
	}

	void IBaseUIController.Init(UI_TYPE type, uint uid)
	{
		Uid = uid;
		_uiType = type;
		_state = UIState.None;
		ExpectedState = UIExpectedState.None;
		_hasClosedLifecycleCompleted = false;
		_isHidden = true;
		InitializeUIBlurEffects();
		try
		{
			OnInit();
		}
		catch (OperationCanceledException message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log(message);
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"On OnInit UI {_uiType} Failed : {arg}");
			}
		}
		Load();
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"UI {_uiType} Init");
		}
	}

	private void InitializeUIBlurEffects()
	{
		_uiBlurEffects.Clear();
		BlurUIEffect blurUIEffect = Singleton<NewUIManager>.instance?.UIBlurEffect;
		if (blurUIEffect != null)
		{
			_uiBlurEffects.Add(new UIEffectRendering
			{
				Intensity = 1f,
				RenderDirectly = true,
				rendererList = new List<AbstractUIEffectRenderer>
				{
					new BlurUIEffectRenderer
					{
						setting = new BlurUIEffect
						{
							BlurRadius = blurUIEffect.BlurRadius
						}
					}
				}
			});
		}
	}

	void IBaseUIController.SetUid(uint uid)
	{
		Uid = uid;
		Parent = 0u;
		_children.Clear();
	}

	internal void DisableBlurImmediately()
	{
		if (_isBlurEnabled)
		{
			Singleton<NewUIManager>.instance.PopUIEffectRenderingList(this, _uiBlurEffects);
			_isBlurEnabled = false;
		}
	}

	void IBaseUIController.UnInit()
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"UI {_uiType} UnInit");
		}
		Singleton<NewUIManager>.instance.UnbindUIParticleUpdateMark(this, _viewObject);
		_uiView?.InvokeElementsOnUIDestroy();
		_uiView?.ClearElements();
		Release();
		try
		{
			OnUnInit();
		}
		catch (OperationCanceledException message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log(message);
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"On OnUnInit UI {_uiType} Failed : {arg}");
			}
		}
		_viewObject = null;
		_uiLoadHandle = default;
		_isHidden = true;
	}

	private void Load()
	{
		string uIAssetPathByUIType = NewUIManager.GetUIAssetPathByUIType(_uiType);
		if (!_uiLoadHandle.IsValid)
		{
			_state = UIState.Loading;
			if (RequireBlackScreenTransition)
			{
				Application.backgroundLoadingPriority = UnityEngine.ThreadPriority.High;
			}
			_uiLoadHandle = AssetStationManager.Root.InstantiateAsync(uIAssetPathByUIType, Singleton<NewUIManager>.instance.GetUIRoot(PanelType));
			_uiLoadHandle.Completed += OnLoadOver;
		}
		else
		{
			OnLoadOver(_uiLoadHandle);
		}
	}

	private void Release()
	{
		if (_uiLoadHandle.IsValid)
		{
			AssetStationManager.Root.ReleaseInstance(_uiLoadHandle);
		}
	}

	async void IBaseUIController.Open(object data)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"UI {_uiType} Open");
		}
		_data = data;
		_hasClosedLifecycleCompleted = false;
		CancellationTokenSource openCts = _openCts;
		if (openCts != null && !openCts.IsCancellationRequested)
		{
			_openCts.Cancel();
			_openCts.Dispose();
		}
		_openCts = new CancellationTokenSource();
		if (RequirePauseGame)
		{
			Singleton<NewUIManager>.instance.UIPushPauseGame(this);
		}
		try
		{
			OnOpen();
		}
		catch (OperationCanceledException message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log(message);
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"On OnOpen UI {_uiType} Failed : {arg}");
			}
		}
	}

	async void IBaseUIController.Close()
	{
		_data = null;
		if (RequireCatchScreen)
		{
			Singleton<NewUIManager>.instance.DisableCatchCamera(this);
		}
		try
		{
			OnClose();
		}
		catch (OperationCanceledException message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log(message);
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"On OnClose UI {_uiType} Failed : {arg}");
			}
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"UI {_uiType} Close");
		}
	}

	void IBaseUIController.CloseImmediately()
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"UI {_uiType} Close Immediately");
		}
		CancellationTokenSource openCts = _openCts;
		if (openCts != null && !openCts.IsCancellationRequested)
		{
			_openCts.Cancel();
		}
		Singleton<NewUIManager>.instance.RemoveInputController(_inputController);
		if (RequireCatchScreen)
		{
			Singleton<NewUIManager>.instance.DisableCatchCamera(this);
		}
		if (_uiView != null && _state != UIState.Loaded && _state != UIState.None)
		{
			MoveToHideRoot();
		}
		DeactivateViewObjectAfterHidden();
		OnClosedInternal();
	}

	void IBaseUIController.OpenView()
	{
		OpenViewAsync(_openCts.Token);
		OnOpenView();
	}

	private async void OpenViewAsync(CancellationToken token)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"UI {_uiType} OpenView");
		}
		_state = UIState.Opening;
		try
		{
			ActivateViewObjectBeforeOpen();
			_uiView.Init(_data);
			_uiView.InvokeElementsInit();
			_uiView.InvokeElementsAddListener();
			try
			{
				await _uiView.PreShow(token);
			}
			catch (OperationCanceledException message)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.Log(message);
				}
			}
			catch (Exception arg)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError($"PreShow UI {_uiType} Failed : {arg}");
				}
			}
			if (token.IsCancellationRequested)
			{
				return;
			}
			MoveToShowRoot();
			try
			{
				await _uiView.Show(token);
			}
			catch (OperationCanceledException message2)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.Log(message2);
				}
			}
			catch (Exception arg2)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError($"Show UI {_uiType} Failed : {arg2}");
				}
			}
			if (token.IsCancellationRequested)
			{
				return;
			}
			if (RequireCatchScreen)
			{
				Singleton<NewUIManager>.instance.EnableUICatchCamera(this, (_uiBlurEffects.Count > 0) ? _uiBlurEffects[0] : null);
			}
			Singleton<NewUIManager>.instance.AddInputController(_inputController);
		}
		catch (OperationCanceledException message3)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log(message3);
			}
		}
		catch (Exception arg3)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"Open UI {_uiType} Failed : {arg3}");
			}
		}
		if (!token.IsCancellationRequested)
		{
			_state = UIState.Opened;
			if (PanelType == UIPanelType.PopUp)
			{
				Singleton<NewUIManager>.instance.RefreshActivePanelCatchCamera();
			}
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"UI {_uiType} Opened");
			}
		}
	}

	async void IBaseUIController.CloseView(UI_TYPE otherUIType)
	{
		CloseViewAsync(otherUIType, _openCts.Token);
	}

	private async void CloseViewAsync(UI_TYPE otherUIType, CancellationToken token)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"UI {_uiType} CloseView");
		}
		_state = UIState.Closing;
		try
		{
			Singleton<NewUIManager>.instance.RemoveInputController(_inputController);
			await _uiView.Hide(token);
			if (token.IsCancellationRequested)
			{
				return;
			}
			await WaitForBlackScreenBeforeMoveToHide(token);
			if (token.IsCancellationRequested)
			{
				return;
			}
			MoveToHideRoot();
			DeactivateViewObjectAfterHidden();
			if (token.IsCancellationRequested)
			{
				return;
			}
		}
		catch (OperationCanceledException message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log(message);
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"Close UI {_uiType} Failed : {arg}");
			}
		}
		if (!token.IsCancellationRequested)
		{
			OnClosedInternal();
		}
	}

	async void IBaseUIController.PushStack(UI_TYPE otherUIType)
	{
		PushStackAsync(otherUIType, _openCts.Token);
	}

	private async void PushStackAsync(UI_TYPE otherUIType, CancellationToken token)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"UI {_uiType} PushStack");
		}
		if (RequireCatchScreen)
		{
			Singleton<NewUIManager>.instance.DisableCatchCamera(this);
		}
		Singleton<NewUIManager>.instance.RemoveInputController(_inputController);
		_state = UIState.PushingStack;
		try
		{
			OnPushStack();
			await _uiView.PushToStack(token);
			if (token.IsCancellationRequested)
			{
				return;
			}
			await WaitForBlackScreenBeforeMoveToHide(token);
			if (token.IsCancellationRequested)
			{
				return;
			}
		}
		catch (OperationCanceledException message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log(message);
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"PushToStack UI {_uiType} Failed : {arg}");
			}
		}
		if (!token.IsCancellationRequested)
		{
			_uiView?.InvokeElementsPushInStack();
			MoveToHideRoot();
			_state = UIState.InStack;
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"UI {_uiType} InStack");
			}
		}
	}

	private async UniTask WaitForBlackScreenBeforeMoveToHide(CancellationToken token)
	{
		NewUIManager uiManager = Singleton<NewUIManager>.instance;
		if (uiManager != null && !uiManager.CanTransitionSourceMoveToHide(this))
		{
			await UniTask.WaitUntil(() => uiManager.CanTransitionSourceMoveToHide(this), PlayerLoopTiming.Update, token);
		}
	}

	async void IBaseUIController.PopStack(UI_TYPE otherUIType)
	{
		PopStackAsync(otherUIType, _openCts.Token);
	}

	private async void PopStackAsync(UI_TYPE otherUIType, CancellationToken token)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"UI {_uiType} PopStack");
		}
		_state = UIState.PoppingStack;
		try
		{
			OnPopStack();
			MoveToShowRoot();
			_uiView?.InvokeElementsPopUpStack();
			await _uiView.PopFromStack(token);
			await UniTask.Yield(token);
		}
		catch (OperationCanceledException message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log(message);
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"PopFromStack UI {_uiType} Failed : {arg}");
			}
		}
		if (!token.IsCancellationRequested)
		{
			if (RequireCatchScreen)
			{
				Singleton<NewUIManager>.instance.EnableUICatchCamera(this, (_uiBlurEffects.Count > 0) ? _uiBlurEffects[0] : null);
			}
			Singleton<NewUIManager>.instance.AddInputController(_inputController);
			Singleton<NewUIManager>.instance.RestoreTopPopupInputController(this);
			_state = UIState.Opened;
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"UI {_uiType} Popped");
			}
		}
	}

	private void OnLoadOver(AssetLoadHandle handle)
	{
		if (RequireBlackScreenTransition)
		{
			Application.backgroundLoadingPriority = UnityEngine.ThreadPriority.Normal;
		}
		_viewObject = handle.AsGameObject();
		_uiView = _viewObject.GetComponent<IBaseUIView>();
		_uiView.BindUIController(this);
		Singleton<NewUIManager>.instance.BindUIParticleUpdateMark(this, _viewObject);
		_inputController = _uiView.InputController;
		_isHidden = true;
		_uiView.InitializeHiddenState();
		if (ExpectedState == UIExpectedState.Open)
		{
			DeactivateViewObjectAfterHidden();
			_state = UIState.Loaded;
		}
		else if (ExpectedState == UIExpectedState.Close)
		{
			MoveToHideRoot();
			if (_hasClosedLifecycleCompleted)
			{
				_state = UIState.Closed;
			}
			else
			{
				OnClosedInternal();
			}
		}
		else
		{
			MoveToHideRoot();
			DeactivateViewObjectAfterHidden();
			_state = UIState.Closed;
			_closeTime = Time.time;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"UI {_uiType} Load Over");
		}
	}

	void IBaseUIController.SetParentUI(uint parent)
	{
		Parent = parent;
	}

	void IBaseUIController.AddChildUI(uint child)
	{
		_children.Add(child);
	}

	void IBaseUIController.RemoveChildUI(uint child)
	{
		_children.Remove(child);
	}

	public void MoveToShowRoot()
	{
		if (Singleton<NewUIManager>.instance.TryGetUIController(Parent, out var ui) && ui.IsInHideRoot)
		{
			return;
		}
		_uiView.SetSortingLayer(_sortingLayer);
		_isHidden = false;
		Singleton<NewUIManager>.instance.SetUIParticleUpdate(this, enabled: true);
		_uiView.OnMoveToShow();
		if (RequireBlurBackGround && !_isBlurEnabled)
		{
			Singleton<NewUIManager>.instance.PushUIEffectRenderingList(this, _uiBlurEffects);
			_isBlurEnabled = true;
		}
		if (PanelType != UIPanelType.Panel)
		{
			return;
		}
		for (int num = _children.Count - 1; num >= 0; num--)
		{
			uint uid = _children[num];
			if (Singleton<NewUIManager>.instance.TryGetUIController(uid, out var ui2) && ui2.ExpectedState == UIExpectedState.Open)
			{
				ui2.MoveToShowRoot();
			}
		}
	}

	public void MoveToHideRoot()
	{
		if (_isBlurEnabled)
		{
			Singleton<NewUIManager>.instance.PopUIEffectRenderingList(this, _uiBlurEffects);
			_isBlurEnabled = false;
		}
		if (!(_viewObject != null))
		{
			return;
		}
		if (!_isHidden)
		{
			_isHidden = true;
			Singleton<NewUIManager>.instance.SetUIParticleUpdate(this, enabled: false);
			_uiView.OnMoveToHide();
		}
		for (int num = _children.Count - 1; num >= 0; num--)
		{
			uint uid = _children[num];
			if (Singleton<NewUIManager>.instance.TryGetUIController(uid, out var ui) && ui != this)
			{
				ui.MoveToHideRoot();
			}
		}
	}

	void IBaseUIController.SetSortingLayer(int layer)
	{
		_sortingLayer = layer;
		_uiView?.SetSortingLayer(layer);
		foreach (UIEffectRendering uiBlurEffect in _uiBlurEffects)
		{
			uiBlurEffect.layer = _sortingLayer;
		}
	}

	public IBaseUIView GetUIView()
	{
		return _uiView;
	}

	public void ReOpen(object newData)
	{
		for (int num = _children.Count - 1; num >= 0; num--)
		{
			Singleton<NewUIManager>.instance.CloseUI(_children[num]);
		}
		_uiView.ReShow(newData);
	}

	private void OnClosedInternal()
	{
		if (_hasClosedLifecycleCompleted)
		{
			_state = UIState.Closed;
			return;
		}
		_hasClosedLifecycleCompleted = true;
		try
		{
			_uiView?.InvokeElementsRemoveListener();
			_uiView?.UnInit();
			_uiView?.InvokeElementsUnInit();
		}
		catch (OperationCanceledException message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log(message);
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"UnInit UI {_uiType} Failed : {arg}");
			}
		}
		try
		{
			OnClosed();
		}
		catch (OperationCanceledException message2)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log(message2);
			}
		}
		catch (Exception arg2)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"On OnClosed UI {_uiType} Failed : {arg2}");
			}
		}
		if (RequirePauseGame)
		{
			Singleton<NewUIManager>.instance.UIPopPauseGame(this);
		}
		Singleton<NewUIManager>.instance.PopUIEffectRenderingList(this, _uiBlurEffects);
		_isBlurEnabled = false;
		if (RequireCatchScreen)
		{
			Singleton<NewUIManager>.instance.DisableCatchCamera(this);
		}
		_state = UIState.Closed;
		_closeTime = Time.time;
		CancellationTokenSource openCts = _openCts;
		if (openCts != null && !openCts.IsCancellationRequested)
		{
			_openCts.Cancel();
		}
		_openCts?.Dispose();
		Singleton<NewUIManager>.instance.ReturnToPool(this);
		if (PanelType == UIPanelType.PopUp)
		{
			Singleton<NewUIManager>.instance.RefreshActivePanelCatchCamera();
		}
	}

	protected virtual void OnInit()
	{
	}

	protected virtual void OnUnInit()
	{
	}

	protected virtual void OnOpen()
	{
	}

	protected virtual void OnOpenView()
	{
	}

	protected virtual void OnClose()
	{
	}

	protected virtual void OnClosed()
	{
	}

	protected virtual void OnPushStack()
	{
	}

	protected virtual void OnPopStack()
	{
	}
}
