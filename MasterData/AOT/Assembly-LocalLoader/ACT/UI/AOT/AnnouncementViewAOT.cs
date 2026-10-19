using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ACT.LocalLoader;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.InputSystem;

namespace ACT.UI.AOT;

public class AnnouncementViewAOT : MonoBehaviour
{
	public AnnouncementView View;

	public UnityEvent OnClose;

	[Header("Input Actions")]
	[SerializeField]
	private InputActionReference navigateActionRef;

	[SerializeField]
	private InputActionReference scrollActionRef;

	[SerializeField]
	private List<GameStartPressButtonPrompt> buttonPrompts;

	private const float NavDeadZone = 0.5f;

	private const float NavHoldThreshold = 0.5f;

	private const float NavRepeatInterval = 0.15f;

	private const string PressAnyKeyActionPath = "UI/PressAnyKey";

	private const string PointActionPath = "UI/Point";

	private Vector2 _navInput;

	private MoveDirection _lastNavDir = MoveDirection.None;

	private float _navHoldStartTime;

	private float _navLastRepeatTime;

	private const float ScrollSpeed = 5f;

	private Vector2 _scrollInput;

	private InputDevice _activeDevice;

	private InputAction _pressAnyKeyAction;

	private InputAction _pointAction;

	private Task _refreshTask;

	private int _lifecycleVersion;

	private bool _inputActionsBound;

	private AnnouncementContentView announcementContentView;

	private LocalAudioManager localAudioManager;

	private void Awake()
	{
		View.Init();
		View.OnCloseButtonClicked = Close;
		if (View.AnnouncementPanel is AnnouncementContentView announcementContentView)
		{
			this.announcementContentView = announcementContentView;
			this.announcementContentView.OnAnnouncementClicked += PlayAnnouncementClickSound;
		}
		_activeDevice = InputSystem.devices.FirstOrDefault((InputDevice d) => d.enabled && d.added);
		UpdatePromptIcons(_activeDevice);
	}

	private void UpdatePromptIcons(InputDevice device)
	{
		List<GameStartPressButtonPrompt> list = buttonPrompts;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		foreach (GameStartPressButtonPrompt buttonPrompt in buttonPrompts)
		{
			buttonPrompt.UpdateDevice(device);
		}
	}

	private void OnEnable()
	{
		BindInputActions();
	}

	private void PlayAnnouncementClickSound()
	{
		if (!localAudioManager)
		{
			localAudioManager = UnityEngine.Object.FindObjectOfType<LocalAudioManager>(includeInactive: true);
		}
		if ((bool)localAudioManager)
		{
			localAudioManager.PlayBoardSound();
		}
	}

	private void OnDestroy()
	{
		if ((bool)announcementContentView)
		{
			announcementContentView.OnAnnouncementClicked -= PlayAnnouncementClickSound;
		}
	}

	public async UniTask UpdateData()
	{
		int lifecycleVersion = ++_lifecycleVersion;
		Task refreshTask = _refreshTask ?? (_refreshTask = RefreshView());
		try
		{
			await refreshTask;
		}
		finally
		{
			if (_refreshTask == refreshTask)
			{
				_refreshTask = null;
			}
		}
		if (lifecycleVersion == _lifecycleVersion && isActiveAndEnabled)
		{
			BindInputActions();
		}
	}

	private async Task RefreshView()
	{
		if (View.AnnouncementPanel is AnnouncementContentView announcementContentView)
		{
			announcementContentView.Category = 3;
		}
		View.SwitchToAnnouncementPanel();
		await View.Clear();
		await View.Refresh();
	}

	private void OnDisable()
	{
		_lifecycleVersion++;
		UnbindInputActions();
		_navInput = Vector2.zero;
		_scrollInput = Vector2.zero;
		_lastNavDir = MoveDirection.None;
	}

	private void BindInputActions()
	{
		if (!_inputActionsBound)
		{
			BindAction(navigateActionRef, OnNavigatePerformed, OnNavigateCanceled);
			BindAction(scrollActionRef, OnScrollPerformed, OnScrollCanceled);
			BindPressAnyKeyAction();
			_inputActionsBound = true;
		}
	}

	private void UnbindInputActions()
	{
		if (_inputActionsBound)
		{
			UnbindAction(navigateActionRef, OnNavigatePerformed, OnNavigateCanceled);
			UnbindAction(scrollActionRef, OnScrollPerformed, OnScrollCanceled);
			UnbindPressAnyKeyAction();
			_inputActionsBound = false;
		}
	}

	private void Update()
	{
		HandleNavRepeat();
		HandleScroll();
	}

	private void OnActionPerformed(InputAction.CallbackContext context)
	{
		InputDevice device = context.control.device;
		if (_activeDevice != device)
		{
			_activeDevice = device;
			UpdatePromptIcons(device);
		}
	}

	private void OnNavigatePerformed(InputAction.CallbackContext ctx)
	{
		_navInput = ctx.ReadValue<Vector2>();
		MoveDirection moveDirection = CalcMoveDir(_navInput);
		if (moveDirection != MoveDirection.None)
		{
			if (moveDirection != _lastNavDir)
			{
				_lastNavDir = moveDirection;
				_navHoldStartTime = Time.unscaledTime;
				_navLastRepeatTime = Time.unscaledTime;
				ExecuteNavigate(moveDirection);
			}
			OnActionPerformed(ctx);
		}
	}

	private void OnNavigateCanceled(InputAction.CallbackContext ctx)
	{
		_navInput = Vector2.zero;
		_lastNavDir = MoveDirection.None;
	}

	private void OnScrollPerformed(InputAction.CallbackContext ctx)
	{
		_scrollInput = ctx.ReadValue<Vector2>();
		OnActionPerformed(ctx);
	}

	private void OnScrollCanceled(InputAction.CallbackContext ctx)
	{
		_scrollInput = Vector2.zero;
	}

	private void HandleNavRepeat()
	{
		if (_lastNavDir == MoveDirection.None)
		{
			return;
		}
		MoveDirection moveDirection = CalcMoveDir(_navInput);
		if (moveDirection != _lastNavDir)
		{
			_lastNavDir = MoveDirection.None;
			return;
		}
		float unscaledTime = Time.unscaledTime;
		if (unscaledTime - _navHoldStartTime >= 0.5f && unscaledTime - _navLastRepeatTime >= 0.15f)
		{
			_navLastRepeatTime = unscaledTime;
			ExecuteNavigate(moveDirection);
		}
	}

	private void HandleScroll()
	{
		if (!(_scrollInput.sqrMagnitude < 0.01f) && View?.AnnouncementPanel is AnnouncementContentView { ContentScrollRect: var contentScrollRect } && !(contentScrollRect == null))
		{
			float verticalNormalizedPosition = contentScrollRect.verticalNormalizedPosition;
			verticalNormalizedPosition += _scrollInput.y * 5f * Time.unscaledDeltaTime;
			contentScrollRect.verticalNormalizedPosition = Mathf.Clamp01(verticalNormalizedPosition);
		}
	}

	private void BindPressAnyKeyAction()
	{
		if (_pressAnyKeyAction == null)
		{
			_pressAnyKeyAction = FindActionInSameAsset(navigateActionRef, "UI/PressAnyKey") ?? FindActionInSameAsset(scrollActionRef, "UI/PressAnyKey");
		}
		if (_pressAnyKeyAction != null)
		{
			_pressAnyKeyAction.performed += OnPressAnyKeyPerformed;
			_pressAnyKeyAction.Enable();
		}
	}

	private void UnbindPressAnyKeyAction()
	{
		if (_pressAnyKeyAction != null)
		{
			_pressAnyKeyAction.performed -= OnPressAnyKeyPerformed;
		}
	}

	private void OnPressAnyKeyPerformed(InputAction.CallbackContext context)
	{
		if (context.ReadValueAsButton())
		{
			OnActionPerformed(context);
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		if ((dir == MoveDirection.Up || dir == MoveDirection.Down) && View?.AnnouncementPanel is AnnouncementContentView { AnnouncementComponents: { Count: not 0 } announcementComponents } announcementContentView)
		{
			AnnouncementData currentData = announcementContentView.CurrentAnnouncementData;
			int num = ((currentData != null) ? announcementComponents.FindIndex((AnnouncementItem c) => c.DataContext?.Id == currentData.Id) : (-1));
			int num2 = ((dir != MoveDirection.Down) ? ((num >= 0) ? Mathf.Max(num - 1, 0) : 0) : ((num >= 0) ? Mathf.Min(num + 1, announcementComponents.Count - 1) : 0));
			if (num2 != num || num < 0)
			{
				ExecuteEvents.Execute(announcementComponents[num2].gameObject, new PointerEventData(EventSystem.current), ExecuteEvents.pointerClickHandler);
			}
		}
	}

	private static MoveDirection CalcMoveDir(Vector2 input)
	{
		if (input.sqrMagnitude < 0.25f)
		{
			return MoveDirection.None;
		}
		if (!(Mathf.Abs(input.y) >= Mathf.Abs(input.x)))
		{
			if (!(input.x > 0f))
			{
				return MoveDirection.Left;
			}
			return MoveDirection.Right;
		}
		if (!(input.y > 0f))
		{
			return MoveDirection.Down;
		}
		return MoveDirection.Up;
	}

	private static void BindAction(InputActionReference actionRef, Action<InputAction.CallbackContext> onPerformed, Action<InputAction.CallbackContext> onCanceled)
	{
		if (!(actionRef == null))
		{
			actionRef.action.performed += onPerformed;
			actionRef.action.canceled += onCanceled;
			actionRef.action.Enable();
		}
	}

	private static void UnbindAction(InputActionReference actionRef, Action<InputAction.CallbackContext> onPerformed, Action<InputAction.CallbackContext> onCanceled)
	{
		if (!(actionRef == null))
		{
			actionRef.action.performed -= onPerformed;
			actionRef.action.canceled -= onCanceled;
		}
	}

	private static InputAction FindActionInSameAsset(InputActionReference actionRef, string actionPath)
	{
		return actionRef?.action?.actionMap?.asset?.FindAction(actionPath);
	}

	private void Close()
	{
		OnClose.Invoke();
		View.animator.Play("Hide");
	}

	public void OpenEffectFinishNew()
	{
	}

	public void CloseEffectFinishNew()
	{
	}
}
