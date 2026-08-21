using System;
using System.Collections.Generic;
using System.Reflection;
using P08.Gamepad;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class PCCursor : MonoBehaviour
{
	private struct ClickInfo
	{
		public PointerEventData pointerEventData;

		public EventSystem eventSystem;

		public bool isValid;

		public bool isScroll;

		public bool isClick;

		public bool isMoved;

		public bool isButtonDown;

		public bool isButtonHold;

		public bool isButtonUp;

		public bool isPressed;

		public Vector2 moveDelta;

		public void Reset()
		{
			isValid = false;
			isPressed = false;
		}
	}

	private class Helpers
	{
		private static string _click = "Submit";

		public static void MoveMousePosition(Vector2 delta)
		{
			CursorControl.MoveLocalCursorPos(delta);
		}

		public static bool IsJoystick(En_GamepadType gamepadType)
		{
			if (gamepadType != En_GamepadType.Xbox)
			{
				return gamepadType == En_GamepadType.PS4;
			}
			return true;
		}

		public static void GetJoystickClick(En_GamepadType gamepadType, out bool buttonDown, out bool buttonHold, out bool buttonUp)
		{
			if (!IsJoystick(gamepadType))
			{
				buttonDown = false;
				buttonHold = false;
				buttonUp = false;
			}
			else
			{
				KeyCode key = ((GamepadManager.Instance.GetPlayerSelectJoystick() == En_GamepadType.Xbox) ? KeyCode.JoystickButton0 : KeyCode.JoystickButton1);
				buttonDown = Input.GetKeyDown(key);
				buttonHold = Input.GetKey(key);
				buttonUp = Input.GetKeyUp(key);
			}
		}

		public static bool GetLeftJoystickClick(En_GamepadType gamepadType)
		{
			return Input.GetKeyUp((GamepadManager.Instance.GetPlayerSelectJoystick() == En_GamepadType.Xbox) ? KeyCode.JoystickButton8 : KeyCode.JoystickButton10);
		}

		public static Vector2 GetJoystickRightInput(En_GamepadType gamepadType)
		{
			if (!IsJoystick(gamepadType))
			{
				return Vector2.zero;
			}
			bool num = GamepadManager.Instance.GetPlayerSelectJoystick() == En_GamepadType.Xbox;
			float axis = Input.GetAxis(num ? "Axis4th" : "Axis3rd");
			float axis2 = Input.GetAxis(num ? "Axis5th" : "Axis6th");
			return new Vector2(0f - axis, 0f - axis2);
		}

		public static bool IsOverDeadZone(Vector2 input)
		{
			if (!((double)Mathf.Abs(input.x) > 0.125))
			{
				return (double)Mathf.Abs(input.y) > 0.125;
			}
			return true;
		}
	}

	private class HackExecuteEvents
	{
		private static bool _hacked = false;

		public static float scrollSpeed = 1f;

		private static ExecuteEvents.EventFunction<IScrollHandler> s_ScrollHandler;

		public static void Hack()
		{
			if (!_hacked)
			{
				FieldInfo field = typeof(ExecuteEvents).GetField("s_ScrollHandler", BindingFlags.Static | BindingFlags.NonPublic);
				if (field != null)
				{
					s_ScrollHandler = ExecuteEvents.scrollHandler;
					field.SetValue(null, new ExecuteEvents.EventFunction<IScrollHandler>(HackExecute));
					Debug.Log("HackExecuteEvents: s_ScrollHandler hacked");
				}
			}
		}

		private static void HackExecute(IScrollHandler handler, BaseEventData eventData)
		{
			if (eventData is PointerEventData pointerEventData)
			{
				Vector2 scrollDelta = pointerEventData.scrollDelta * scrollSpeed;
				pointerEventData.scrollDelta = scrollDelta;
			}
			s_ScrollHandler(handler, eventData);
		}
	}

	public float minMoveSpeed = 5f;

	public float maxMoveSpeed = 25f;

	public float scrollSpeed = 30f;

	public float minScale = 0.75f;

	public float maxScale = 2f;

	private static PCCursor _instance;

	private static bool _stopMove;

	private static bool _regKeyDirty = true;

	private static bool _keyboardAutoHide;

	private static bool _BattleShowCursor;

	private const string AUTO_HIDE_KEY = "PCCURSOR_AUTOHIDE";

	private const string BATTLE_SHOW_CURSOR_KEY = "PCCURSOR_BATTLE_SHOW_CURSOR";

	private Vector2 _curPos;

	private Vector2 _lastPos;

	private bool _visible = true;

	[SerializeField]
	private Vector2 _hotspot = new Vector2(0.5f, 0.5f);

	[SerializeField]
	private Texture2D _cursorTex;

	private Texture2D _cursorTexScaled;

	private En_GamepadType _curGamepadType;

	private bool _isJoystick;

	private bool _isKeyMouse;

	private bool isBanCharMove;

	private bool isBanCameraMove;

	private bool _isBattle;

	private bool _isBattleGameOver;

	private bool _isBattlePause;

	private bool _isGamepadRuntime;

	private bool _isGuiding;

	private GameObject _battlePanel;

	private GameObject _battleGuideUi;

	private Transform _battleGuideButtonMaskT;

	private HIDInputPage _battleHidInputPage;

	private bool _battleHidActive;

	private static GameObject _fullscreenScrollObject;

	public float disappearTime = 4f;

	private float _disappearTimer;

	private ClickInfo _clickInfo;

	private static List<RaycastResult> _raycastResultTmp = new List<RaycastResult>();

	private bool _isKeyboard => _curGamepadType == En_GamepadType.Keyboard;

	internal event Action<Vector2> onClick;

	public static void SetCanMove(bool val)
	{
		_stopMove = !val;
	}

	public static void SwtichCursor(bool visible)
	{
		if (!(_instance == null))
		{
			_instance.SwitchCursor(visible);
		}
	}

	public static void SetFullscreenScrollObject(GameObject go)
	{
		_fullscreenScrollObject = go;
	}

	public static void SetKeyboardAutoHide(bool val)
	{
		PlayerPrefs.SetInt("PCCURSOR_AUTOHIDE", val ? 1 : 0);
		_keyboardAutoHide = val;
	}

	public static bool GetKeyboardAutoHide()
	{
		if (_regKeyDirty)
		{
			_keyboardAutoHide = PlayerPrefs.GetInt("PCCURSOR_AUTOHIDE", 0) != 0;
		}
		return _keyboardAutoHide;
	}

	public static void SetBattleShowCursor(bool val)
	{
		PlayerPrefs.SetInt("PCCURSOR_BATTLE_SHOW_CURSOR", val ? 1 : 0);
		_BattleShowCursor = val;
		_instance?.ResetInputNotice();
	}

	public static bool GetBattleShowCursor()
	{
		if (_regKeyDirty)
		{
			_BattleShowCursor = PlayerPrefs.GetInt("PCCURSOR_BATTLE_SHOW_CURSOR", 1) != 0;
		}
		return _BattleShowCursor;
	}

	public static bool ResizeCursor(float percent)
	{
		if (_instance == null)
		{
			return false;
		}
		float num = 1f;
		num = ((!((double)percent > 0.5)) ? Mathf.Lerp(_instance.minScale, 1f, 2f * percent) : Mathf.Lerp(1f, _instance.maxScale, 2f * percent - 1f));
		return _instance.ResizeCursorInternal(num);
	}

	private Vector2 GetMoveInput()
	{
		if (!_visible || _stopMove || !_isJoystick)
		{
			return Vector2.zero;
		}
		float t = (float)GamepadManager.Instance.GetCursorSensitivity() / 100f;
		float axis = Input.GetAxis("Horizontal");
		float axis2 = Input.GetAxis("Vertical");
		return new Vector2(axis, axis2) * Mathf.Lerp(minMoveSpeed, maxMoveSpeed, t);
	}

	private void UpdateMove(out Vector2 moveDelta, out bool isMoved)
	{
		Vector2 vector = GetMoveInput() * (Time.deltaTime * 60f);
		isMoved = Helpers.IsOverDeadZone(vector);
		_lastPos = _curPos;
		Vector2 vector2 = Input.mousePosition;
		if (Application.isFocused)
		{
			if (isMoved)
			{
				Cursor.lockState = CursorLockMode.Confined;
				Helpers.MoveMousePosition(vector);
				vector2 = Input.mousePosition;
			}
			else if (!_visible)
			{
				Cursor.lockState = CursorLockMode.Locked;
			}
			else
			{
				Cursor.lockState = CursorLockMode.None;
			}
		}
		else
		{
			Cursor.lockState = CursorLockMode.None;
		}
		moveDelta = vector2 - _curPos;
		if (!Mathf.Approximately(moveDelta.x, 0f) || !Mathf.Approximately(moveDelta.y, 0f))
		{
			_curPos = vector2;
			_curPos.x = Mathf.Clamp(_curPos.x, 0f, Screen.width);
			_curPos.y = Mathf.Clamp(_curPos.y, 0f, Screen.height);
			Cursor.visible = _visible || _curPos != vector2;
		}
	}

	private void CollectClickInfo()
	{
		Helpers.GetJoystickClick(_curGamepadType, out var buttonDown, out var buttonHold, out var buttonUp);
		Vector2 joystickRightInput = Helpers.GetJoystickRightInput(_curGamepadType);
		_clickInfo.isButtonDown = buttonDown;
		_clickInfo.isButtonHold = buttonHold;
		_clickInfo.isButtonUp = buttonUp;
		_clickInfo.isClick = buttonDown | buttonHold | buttonUp;
		_clickInfo.isScroll = Helpers.IsOverDeadZone(joystickRightInput);
		if (!_clickInfo.isClick && !_clickInfo.isScroll && !_clickInfo.isMoved)
		{
			_clickInfo.isValid = false;
			return;
		}
		_clickInfo.isValid = true;
		Vector2 curPos = _curPos;
		EventSystem current = EventSystem.current;
		PointerEventData pointerEventData = ((!(_clickInfo.eventSystem == current)) ? new PointerEventData(EventSystem.current)
		{
			pointerId = -1,
			button = PointerEventData.InputButton.Left,
			pressure = 1f
		} : _clickInfo.pointerEventData);
		pointerEventData.delta = (_clickInfo.isMoved ? _clickInfo.moveDelta : Vector2.zero);
		pointerEventData.scrollDelta = joystickRightInput;
		pointerEventData.position = curPos;
		if (buttonDown)
		{
			pointerEventData.pressPosition = curPos;
			pointerEventData.dragging = false;
			pointerEventData.eligibleForClick = true;
			_clickInfo.isPressed = true;
		}
		List<RaycastResult> raycastResultTmp = _raycastResultTmp;
		current.RaycastAll(pointerEventData, raycastResultTmp);
		RaycastResult raycastResult = raycastResultTmp.Find((RaycastResult result) => result.gameObject != null);
		GameObject gameObject = (raycastResult.gameObject = raycastResult.gameObject);
		pointerEventData.pointerCurrentRaycast = raycastResult;
		if (buttonDown)
		{
			pointerEventData.pointerPress = gameObject;
			pointerEventData.rawPointerPress = gameObject;
			pointerEventData.pointerDrag = ExecuteEvents.GetEventHandler<IDragHandler>(gameObject);
			pointerEventData.pointerEnter = gameObject;
			pointerEventData.pointerPressRaycast = raycastResult;
		}
		else if (buttonUp)
		{
			pointerEventData.pointerClick = gameObject;
		}
		_clickInfo.pointerEventData = pointerEventData;
		_clickInfo.eventSystem = current;
	}

	private void ProcessClickEvent()
	{
		if (!_clickInfo.isClick || !_clickInfo.isPressed)
		{
			return;
		}
		bool isButtonDown = _clickInfo.isButtonDown;
		bool isButtonHold = _clickInfo.isButtonHold;
		bool isButtonUp = _clickInfo.isButtonUp;
		PointerEventData pointerEventData = _clickInfo.pointerEventData;
		if (isButtonDown)
		{
			ExecuteEvents.Execute(ExecuteEvents.GetEventHandler<IPointerDownHandler>(pointerEventData.pointerPress), pointerEventData, ExecuteEvents.pointerDownHandler);
			if (pointerEventData.pointerDrag != null)
			{
				ExecuteEvents.Execute(pointerEventData.pointerDrag, pointerEventData, ExecuteEvents.initializePotentialDrag);
			}
		}
		if (isButtonHold && _clickInfo.isMoved && pointerEventData.pointerDrag != null)
		{
			if (!pointerEventData.dragging)
			{
				ExecuteEvents.Execute(pointerEventData.pointerDrag, pointerEventData, ExecuteEvents.beginDragHandler);
				pointerEventData.dragging = true;
			}
			if (pointerEventData.dragging)
			{
				if (pointerEventData.pointerPress != pointerEventData.pointerDrag)
				{
					ExecuteEvents.Execute(pointerEventData.pointerPress, pointerEventData, ExecuteEvents.pointerUpHandler);
					pointerEventData.eligibleForClick = false;
					pointerEventData.pointerPress = null;
					pointerEventData.rawPointerPress = null;
				}
				ExecuteEvents.Execute(pointerEventData.pointerDrag, pointerEventData, ExecuteEvents.dragHandler);
			}
		}
		if (isButtonUp)
		{
			if (pointerEventData.pointerClick == pointerEventData.pointerPress && pointerEventData.eligibleForClick)
			{
				ExecuteEvents.Execute(ExecuteEvents.GetEventHandler<IPointerClickHandler>(pointerEventData.pointerClick), pointerEventData, ExecuteEvents.pointerClickHandler);
			}
			ExecuteEvents.Execute(ExecuteEvents.GetEventHandler<IPointerUpHandler>(pointerEventData.pointerPress), pointerEventData, ExecuteEvents.pointerUpHandler);
			if (pointerEventData.pointerDrag != null && pointerEventData.dragging)
			{
				ExecuteEvents.ExecuteHierarchy(pointerEventData.pointerCurrentRaycast.gameObject, pointerEventData, ExecuteEvents.dropHandler);
				ExecuteEvents.Execute(pointerEventData.pointerDrag, pointerEventData, ExecuteEvents.endDragHandler);
			}
			_clickInfo.Reset();
		}
	}

	private void ProcessScrollEvent()
	{
		if (_clickInfo.isScroll)
		{
			PointerEventData pointerEventData = _clickInfo.pointerEventData;
			ExecuteEvents.ExecuteHierarchy(ExecuteEvents.GetEventHandler<IScrollHandler>((_fullscreenScrollObject == null) ? pointerEventData.pointerCurrentRaycast.gameObject : _fullscreenScrollObject), pointerEventData, ExecuteEvents.scrollHandler);
		}
	}

	private void UpdateDisapper()
	{
		if (_isKeyboard)
		{
			bool flag = Input.GetMouseButton(0) || Input.GetMouseButton(1) || Input.GetMouseButton(2) || !Mathf.Approximately(Input.GetAxis("Mouse X"), 0f) || !Mathf.Approximately(Input.GetAxis("Mouse Y"), 0f);
			if (_visible && _isBattle)
			{
				_disappearTimer = (flag ? 0f : (_disappearTimer + Time.deltaTime));
				if (_disappearTimer > disappearTime)
				{
					SwitchCursor(visible: false);
				}
			}
			else if (flag)
			{
				SwitchCursor(visible: true);
			}
		}
		if (_disappearTimer < 0f)
		{
			_disappearTimer += Time.deltaTime;
			if (_disappearTimer >= 0f)
			{
				_disappearTimer = 0f;
				SwitchCursor(visible: false);
			}
		}
	}

	private void ProcessInputEvent()
	{
		UpdateMove(out _clickInfo.moveDelta, out _clickInfo.isMoved);
		if (_isJoystick && _visible)
		{
			CollectClickInfo();
			ProcessClickEvent();
			ProcessScrollEvent();
		}
	}

	private void Show(bool flag)
	{
		if (_visible != flag)
		{
			_visible = flag;
			Cursor.visible = _visible;
		}
	}

	private void SwitchCursor(bool visible, bool force = false)
	{
		if (_isKeyboard && !_keyboardAutoHide)
		{
			visible = true;
		}
		if (_visible != visible || force)
		{
			Show(visible);
			if (_isBattle)
			{
				BanBattleCharMove(visible && _isJoystick && !_isGuiding);
				BanCameraMove(visible && _isKeyMouse);
			}
			_disappearTimer = 0f;
		}
	}

	private void DelayHideCursor(float time = 0.1f)
	{
		if (_visible)
		{
			_disappearTimer = 0f - time;
		}
	}

	private void OnBattleSceneEnter(bool isEnter)
	{
		SwitchCursor(!isEnter);
		if (isEnter)
		{
			_isBattleGameOver = false;
			_isBattlePause = false;
		}
	}

	private void OnBattlePanel(GameObject go)
	{
		if (go != null)
		{
			_battleHidInputPage = go.GetComponent<HIDInputPage>();
			_battleHidActive = _battleHidInputPage.isActiveAndEnabled;
			ResetInputNotice();
		}
		else
		{
			_battleHidInputPage = null;
		}
	}

	private void OnBattleGameOver(bool isGameOver)
	{
		if (isGameOver)
		{
			SwitchCursor(visible: true);
		}
	}

	private void OnBattlePause(bool isPause)
	{
		if (!isPause)
		{
			SwitchCursor(isPause);
		}
	}

	private void OnBattleGuide(bool isGuiding)
	{
		_isGuiding = isGuiding;
		if (isGuiding)
		{
			SwitchCursor(isGuiding, force: true);
		}
		else
		{
			DelayHideCursor();
		}
	}

	private void OnHidTypeChange(En_GamepadType newType, En_GamepadType oldType)
	{
		BanBattleCharMove(_visible && _isJoystick && !_isGuiding);
		BanCameraMove(_visible && _isKeyMouse);
		ResetInputNotice();
	}

	private void OnApplicationFocus(bool hasFocus)
	{
		if (base.enabled)
		{
		}
	}

	private void Awake()
	{
		if (_instance != null)
		{
			Debug.LogError("PCCursor: repeat assign!");
		}
		_instance = this;
		if (!ResizeCursor(PlayerPrefs.GetFloat("PCCursor_CursorScalePercent", 0.5f)))
		{
			Debug.LogError("PCCursor: not assign cursor texture");
		}
		_keyboardAutoHide = GetKeyboardAutoHide();
		_BattleShowCursor = GetBattleShowCursor();
		HackExecuteEvents.scrollSpeed = scrollSpeed;
		HackExecuteEvents.Hack();
	}

	private void OnEnable()
	{
		if (Application.isFocused)
		{
			OnApplicationFocus(hasFocus: true);
		}
	}

	private void OnDisable()
	{
		OnApplicationFocus(hasFocus: false);
	}

	private void OnDestroy()
	{
		if (_cursorTexScaled != null)
		{
			UnityEngine.Object.Destroy(_cursorTexScaled);
			_cursorTexScaled = null;
		}
		_instance = null;
	}

	private void Update()
	{
		bool flag = false;
		En_GamepadType gamepadType = GamepadManager.Instance.GetGamepadType();
		if (gamepadType != _curGamepadType)
		{
			_curGamepadType = gamepadType;
			_isJoystick = Helpers.IsJoystick(_curGamepadType);
			_isKeyMouse = _curGamepadType == En_GamepadType.KeyMouse;
			OnHidTypeChange(gamepadType, _curGamepadType);
			flag = true;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		bool flag2 = battleScene != null;
		if (flag2 != _isBattle)
		{
			_isBattle = flag2;
			OnBattleSceneEnter(flag2);
		}
		if (flag2)
		{
			GameObject battlePanelGameObject = battleScene.battlePanelGameObject;
			if (_battlePanel != battlePanelGameObject)
			{
				_battlePanel = battlePanelGameObject;
				OnBattlePanel(battlePanelGameObject);
			}
			if (_battleHidInputPage != null && _battleHidActive != _battleHidInputPage.isActiveAndEnabled)
			{
				_battleHidActive = _battleHidInputPage.isActiveAndEnabled;
				ResetInputNotice();
			}
			bool flag3 = battleScene.GetBattleSimulatorSystem() != null && battleScene.IsGameOver();
			if (flag3 != _isBattleGameOver)
			{
				_isBattleGameOver = flag3;
				OnBattleGameOver(flag3);
			}
			bool isPause = BattleScene.isPause;
			if (isPause != _isBattlePause)
			{
				_isBattlePause = isPause;
				OnBattlePause(isPause);
			}
			bool flag4 = false;
			if (_isBattlePause)
			{
				flag4 = true;
			}
			else if (CommonProcessor.mSimContext != null)
			{
				SimWorldState worldState = CommonProcessor.GetWorldState();
				if (worldState != null && worldState.commonWorldTimeScaleFactor.Count > 0)
				{
					foreach (KeyValuePair<int, short> item in worldState.commonWorldTimeScaleFactor)
					{
						item.Deconstruct(out var _, out var value);
						if (value == 0)
						{
							flag4 = true;
							break;
						}
					}
				}
			}
			if (flag4 && _battleGuideUi == null && _battlePanel != null)
			{
				Transform transform = _battlePanel.transform.Find("GuideUI");
				if (transform != null)
				{
					_battleGuideUi = transform.gameObject;
					_battleGuideButtonMaskT = _battleGuideUi.transform.Find("buttonMask");
				}
			}
			bool flag5 = GamepadManager.Instance.IsRuntime();
			if (flag5 != _isGamepadRuntime)
			{
				_isGamepadRuntime = flag5;
				Transform transform2 = ((battlePanelGameObject != null) ? battlePanelGameObject.transform.Find("GuideUI") : null);
				if (transform2 != null)
				{
					_battleGuideUi = transform2.gameObject;
				}
				if (transform2 == null || !transform2.gameObject.activeSelf)
				{
					OnBattleGuide(isGuiding: false);
				}
				else
				{
					GameObject gameObject = transform2.gameObject;
					bool flag6 = false;
					if (!flag6 && gameObject.transform.Find("mask (1)").gameObject.activeSelf)
					{
						GameObject gameObject2 = gameObject.transform.Find("maskUI").gameObject;
						if (gameObject2.activeSelf && gameObject2.GetComponent<PassEventUI>() != null)
						{
							flag6 = true;
						}
					}
					if (!flag6 && gameObject.transform.Find("mask").gameObject.activeSelf)
					{
						GameObject gameObject3 = gameObject.transform.Find("TextPanel").gameObject;
						if (gameObject3.activeSelf && gameObject3.GetComponent<Button>() != null)
						{
							flag6 = true;
						}
					}
					_battleGuideButtonMaskT = gameObject.transform.Find("buttonMask");
					if (!flag6 && _battleGuideButtonMaskT.gameObject.activeSelf)
					{
						flag6 = true;
					}
					OnBattleGuide(flag6);
				}
			}
			if (flag5)
			{
				bool flag7 = _battleGuideButtonMaskT != null && _battleGuideUi.activeSelf && _battleGuideButtonMaskT.gameObject.activeSelf;
				if (_isGuiding != flag7)
				{
					OnBattleGuide(flag7);
				}
			}
			if ((_isJoystick ? Helpers.GetLeftJoystickClick(_curGamepadType) : Input.GetKeyDown(KeyCode.LeftAlt)) && !_isKeyboard && _BattleShowCursor)
			{
				bool flag8 = false;
				if (flag3)
				{
					object[] array = LuaHelper.CallFunction("IsPolyhedronGameOver");
					if (array != null && array.Length != 0)
					{
						flag8 = (bool)array[0];
					}
				}
				SwitchCursor((!_visible | isPause) || (flag3 && !flag8));
				return;
			}
			if (flag && _visible && _isJoystick && !_BattleShowCursor)
			{
				bool flag9 = false;
				if (flag3)
				{
					object[] array2 = LuaHelper.CallFunction("IsPolyhedronGameOver");
					if (array2 != null && array2.Length != 0)
					{
						flag9 = (bool)array2[0];
					}
				}
				SwitchCursor(isPause || (flag3 && !flag9));
			}
		}
		else if ((QWorldScene.Scene != null || (T0WorldScene.Scene != null && T0WorldScene.Scene.CheckIsCanSwitchCursor())) && (_isJoystick ? Helpers.GetLeftJoystickClick(_curGamepadType) : Input.GetKeyDown(KeyCode.LeftAlt)) && !_isKeyboard)
		{
			SwitchCursor(!_visible);
			return;
		}
		UpdateDisapper();
		ProcessInputEvent();
	}

	private void BanBattleCharMove(bool val)
	{
		if (isBanCharMove == val)
		{
			return;
		}
		isBanCharMove = val;
		BattleUI battleUI = BattleUI.GetBattleUI();
		if (!(battleUI != null))
		{
			return;
		}
		if (battleUI.joystickController != null)
		{
			CanvasGroup component = battleUI.joystickController.GetComponent<CanvasGroup>();
			if (component != null)
			{
				component.alpha = ((!val) ? 1 : 0);
				component.blocksRaycasts = !val;
			}
			battleUI.joystickController.enabled = !val;
		}
		Transform transform = battleUI.transform.Find("ScreenAdjustContainer/BattleButtons");
		if (transform != null)
		{
			transform.gameObject.SetActive(!val);
		}
	}

	private void BanCameraMove(bool val)
	{
		if (isBanCameraMove != val)
		{
			isBanCameraMove = val;
			BattleUI battleUI = BattleUI.GetBattleUI();
			if (battleUI != null && battleUI.cameraCtrl != null)
			{
				battleUI.cameraCtrl.SetActive(!val);
			}
		}
	}

	private void ResetInputNotice()
	{
		bool flag = !_isKeyboard && _BattleShowCursor;
		try
		{
			if (!InputManager.system.TryGetPageInputActionMap("BattlePanel", out var map))
			{
				return;
			}
			InputAction inputAction = map.GetInputAction("SwitchCursor");
			if (inputAction.enabled != flag)
			{
				if (flag)
				{
					inputAction.Enable();
				}
				else
				{
					inputAction.Disable();
				}
				InputManager.system.IncPagesVersion();
			}
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}

	private bool ResizeCursorInternal(float scale)
	{
		if (_cursorTex == null)
		{
			return false;
		}
		if (Mathf.Approximately(scale, 1f))
		{
			Cursor.SetCursor(_cursorTex, new Vector2(_cursorTex.width, _cursorTex.height) * new Vector2(_hotspot.x, 1f - _hotspot.y), CursorMode.Auto);
			Debug.Log("ResizeCursor: scale = 1, set hardward cursor.");
		}
		else
		{
			if (_cursorTexScaled != null)
			{
				UnityEngine.Object.Destroy(_cursorTexScaled);
				_cursorTexScaled = null;
			}
			(int, int) tuple = GetUnityCursorSize();
			int item = tuple.Item1;
			int item2 = tuple.Item2;
			_cursorTexScaled = new Texture2D((int)((float)item * scale), (int)((float)item2 * scale), _cursorTex.format, mipChain: false);
			for (int i = 0; i < _cursorTexScaled.height; i++)
			{
				for (int j = 0; j < _cursorTexScaled.width; j++)
				{
					float u = (float)j / (float)_cursorTexScaled.width;
					float v = (float)i / (float)_cursorTexScaled.height;
					Color pixelBilinear = _cursorTex.GetPixelBilinear(u, v);
					_cursorTexScaled.SetPixel(j, i, new Color(Mathf.Pow(pixelBilinear.r, 0.45454544f), Mathf.Pow(pixelBilinear.g, 0.45454544f), Mathf.Pow(pixelBilinear.b, 0.45454544f), pixelBilinear.a));
				}
			}
			_cursorTexScaled.Apply();
			Debug.Log($"ResizeCursor: dpi = {Screen.dpi}, unitySize = {item}, scale = {scale}, scaledSize = {_cursorTexScaled.width}");
			Cursor.SetCursor(_cursorTexScaled, new Vector2(_cursorTexScaled.width, _cursorTexScaled.height) * new Vector2(_hotspot.x, 1f - _hotspot.y), CursorMode.ForceSoftware);
		}
		return true;
		static (int, int) GetUnityCursorSize()
		{
			float dpi = Screen.dpi;
			if (dpi < 144f)
			{
				return (32, 32);
			}
			if (dpi < 192f)
			{
				return (48, 48);
			}
			if (dpi < 288f)
			{
				return (64, 64);
			}
			if (dpi < 384f)
			{
				return (96, 96);
			}
			return (128, 128);
		}
	}
}
