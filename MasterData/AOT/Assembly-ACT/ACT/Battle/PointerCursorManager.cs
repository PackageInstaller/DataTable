using ACT.Event;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.EnhancedTouch;
using UnityEngine.UI;

namespace ACT.Battle;

internal class PointerCursorManager : IMouseCursorManager
{
	private bool _isInitialized;

	private bool _isPcMode;

	private bool _needHideCursor;

	private bool _gamePlaying;

	private MouseCursorEffectSetting _setting;

	private PlayerInput _playerInput;

	private GameInputActionManager _gameInputActionMgr;

	private bool _cursorCouldDisplay;

	private bool _hasCursorVisibleOverride;

	private bool _cursorVisibleOverride;

	private EffectPool<CursorEffect> _effectPool;

	private bool _gameWindowInMoving;

	private bool _pointerActive = true;

	private bool _pointerInputDirty;

	private Texture2D _emptyTexture;

	public bool NeedHideCursor
	{
		get
		{
			if (_isPcMode)
			{
				return _needHideCursor;
			}
			return false;
		}
	}

	public bool Visible => Cursor.visible;

	public void Init(bool pcMode, bool needHideCursor, MouseCursorEffectSetting setting, PlayerInput playerInput)
	{
		WindowsWindowMoveMonitor.OnWindowMoveStateChanged += OnWindowMoveStateChanged;
		_isInitialized = true;
		_playerInput = playerInput;
		_isPcMode = pcMode;
		_needHideCursor = needHideCursor;
		_setting = setting;
		_gamePlaying = false;
		_hasCursorVisibleOverride = false;
		_cursorVisibleOverride = false;
		_pointerActive = true;
		_pointerInputDirty = false;
		Cursor.lockState = CursorLockMode.None;
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Game_Start, OnGameStart);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Game_Over, OnGameStart);
	}

	private void OnWindowMoveStateChanged(bool moving)
	{
		_gameWindowInMoving = moving;
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		UpdateCursorVisibleState();
	}

	internal void Setup(GameInputActionManager mgr)
	{
		_gameInputActionMgr = mgr;
	}

	internal void Release()
	{
	}

	internal void Update()
	{
		if (_isInitialized)
		{
			ApplyPendingPointerInput();
			UpdateClickEffect();
			LockCursorInScreenRectIfNeeded();
		}
	}

	private void LockCursorInScreenRectIfNeeded()
	{
		if (!_gameWindowInMoving && _gamePlaying && _needHideCursor)
		{
			Mouse current = Mouse.current;
			if (current != null && Application.isFocused && !Visible)
			{
				Vector2 position = default;
				position.Set((float)Screen.width * 0.5f, (float)Screen.height * 0.5f);
				current.WarpCursorPosition(position);
			}
		}
	}

	public void UpdateCursorVisible()
	{
		if (!_gameInputActionMgr.CheckInputStateEqual(GameInputState.Battle))
		{
			bool flag = _gameInputActionMgr.CheckInputStateActive(GameInputState.Battle);
			bool flag2 = _gameInputActionMgr.CheckInputStateActive(GameInputState.Guide);
			bool flag3 = _gameInputActionMgr.CheckInputStateActive(GameInputState.Loading);
			bool flag4 = _gameInputActionMgr.CheckInputStateActive(GameInputState.Login);
			bool flag5 = _gameInputActionMgr.CheckInputStateActive(GameInputState.Pay);
			bool flag6 = (flag5 | flag4) || !(flag | flag3) || flag2;
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"Update Cursor Visible: {flag6}, {{ inPay:{flag5}, inBattle: {flag}, inGuide:{flag2}, inLoading:{flag3}, inLogin:{flag4}, inputMode:{MonoECS.instance.InputMode} }}");
			}
			SetCursorVisible(flag6);
		}
	}

	private bool CheckCouldTickHideCursor()
	{
		if (_hasCursorVisibleOverride)
		{
			return false;
		}
		if (_gameInputActionMgr.CheckInputStateEqual(GameInputState.Battle))
		{
			return true;
		}
		return false;
	}

	public void SetCursorVisible(bool vis)
	{
		_cursorCouldDisplay = vis;
		UpdateCursorVisibleState();
	}

	public void SetCursorVisibleOverride(bool visible)
	{
		_hasCursorVisibleOverride = true;
		_cursorVisibleOverride = visible;
		UpdateCursorVisibleState();
	}

	public void ClearCursorVisibleOverride()
	{
		if (_hasCursorVisibleOverride)
		{
			_hasCursorVisibleOverride = false;
			UpdateCursorVisibleState();
		}
	}

	private void UpdateCursorVisibleState()
	{
		if (_needHideCursor)
		{
			bool flag = (_hasCursorVisibleOverride ? _cursorVisibleOverride : _cursorCouldDisplay) && MonoECS.instance.InputMode == DeviceInputMode.KeyboardAndMouse;
			if (Cursor.visible != flag)
			{
				Cursor.visible = flag;
			}
			if (_pointerActive != flag)
			{
				_pointerActive = flag;
				_pointerInputDirty = true;
			}
		}
	}

	private void ApplyPendingPointerInput()
	{
		if (_pointerInputDirty)
		{
			_pointerInputDirty = false;
			bool flag = MonoECS.instance.SetUIMousePointerActive(_pointerActive);
			if (!(_pointerActive | flag))
			{
				DeHoverUINodes();
			}
		}
	}

	private void DeHoverUINodes()
	{
		foreach (GameObject hoverUINode in _gameInputActionMgr.GetHoverUINodeList())
		{
			if (hoverUINode.TryGetComponent<Selectable>(out var component))
			{
				component.OnPointerExit(null);
			}
		}
	}

	private void UpdateClickEffect()
	{
		if (_isPcMode)
		{
			UpdateMouseState();
		}
		else
		{
			UpdateTouchState();
		}
	}

	private void UpdateTouchState()
	{
		foreach (UnityEngine.InputSystem.EnhancedTouch.Touch activeTouch in UnityEngine.InputSystem.EnhancedTouch.Touch.activeTouches)
		{
			if (activeTouch.phase == UnityEngine.InputSystem.TouchPhase.Began)
			{
				PlayClickEffect(GetScreenPoint(activeTouch.startScreenPosition));
			}
		}
	}

	private void UpdateMouseState()
	{
		Mouse current = Mouse.current;
		if (current == null || !Application.isFocused)
		{
			return;
		}
		bool flag = Cursor.visible;
		if (_needHideCursor)
		{
			if (CheckCouldTickHideCursor())
			{
				bool flag2 = Keyboard.current?.altKey.isPressed ?? false;
				SetCursorVisible(flag2);
				flag = flag2;
			}
			SetClickEnable(flag);
			if (!flag)
			{
				if (_emptyTexture == null)
				{
					Color color = new Color(0f, 0f, 0f, 0f);
					_emptyTexture = new Texture2D(1, 1);
					_emptyTexture.SetPixel(0, 0, color);
					_emptyTexture.Apply(updateMipmaps: false);
				}
				Cursor.SetCursor(_emptyTexture, Vector2.zero, CursorMode.Auto);
				return;
			}
		}
		if (current.IsPressed())
		{
			if (current.press.wasPressedThisFrame)
			{
				PlayClickEffect(GetScreenPoint(current.position.value));
			}
			if (GameLoader.meta != null)
			{
				Cursor.SetCursor(GameLoader.meta.pressed, Vector2.zero, CursorMode.Auto);
			}
		}
		else if (GameLoader.meta != null)
		{
			Cursor.SetCursor(GameLoader.meta.normal, Vector2.zero, CursorMode.Auto);
		}
	}

	private Vector2 GetScreenPoint(Vector2 inputPosition)
	{
		if (GameUtility.uiCanvas != null)
		{
			Camera cam = ((GameUtility.uiCanvas.renderMode == RenderMode.ScreenSpaceOverlay) ? null : GameUtility.uiCamera);
			RectTransformUtility.ScreenPointToLocalPointInRectangle(GameUtility.uiCanvas.transform as RectTransform, inputPosition, cam, out var localPoint);
			return localPoint;
		}
		return Vector2.zero;
	}

	private void SetClickEnable(bool enable)
	{
		if (_playerInput == null)
		{
			return;
		}
		InputAction inputAction = _playerInput.actions.FindAction("UI/Click");
		if (inputAction != null)
		{
			if (enable)
			{
				inputAction.Enable();
			}
			else
			{
				inputAction.Disable();
			}
		}
	}

	private void PlayClickEffect(Vector2 position)
	{
		if (_setting != null && _setting.clickEffects != null && _setting.clickEffects.Length != 0 && !(_setting.clickEffectContainer == null))
		{
			GameObject[] clickEffects = _setting.clickEffects;
			if (_effectPool == null)
			{
				_effectPool = new EffectPool<CursorEffect>(_setting.clickEffectContainer);
			}
			_effectPool.Get(clickEffects[Random.Range(0, clickEffects.Length)]).PlayAnim(position, RecycleEffect);
		}
	}

	private void RecycleEffect(CursorEffect effect)
	{
	}

	private void OnGameStart(BaseEventContent evt)
	{
		_gamePlaying = true;
	}

	private void OnGameOver(BaseEventContent evt)
	{
		_gamePlaying = false;
	}
}
