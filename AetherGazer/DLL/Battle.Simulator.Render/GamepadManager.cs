using System;
using System.Collections.Generic;
using P08.Gamepad;
using ParadoxNotion.Services;
using UnityEngine;

public class GamepadManager : MonoBehaviour
{
	[Obsolete("GamepadManager: deprecated const GAMEPAD_TYPE_KEY!")]
	public const string GAMEPAD_TYPE_KEY = "GamepadType";

	public const string JOYSTICK_TYPE_KEY = "JoystickType";

	public const string KEYBOARD_TYPE_KEY = "KeyboardType";

	private static GameObject go;

	private static GamepadManager _instance;

	private bool _runtime;

	private GamepadDeviceWatcher _gamepadDeviceWatcher;

	private Dictionary<En_GamepadType, Gamepad> _gamepads;

	private En_GamepadType _curInputGamepadType;

	private int _joystickNum;

	private InputSettingListener _inputListener;

	private bool _isSelectedJoystickDirty = true;

	private En_GamepadType _selectedJoystick = En_GamepadType.Xbox;

	private bool _isSelectedKeyboardDirty = true;

	private En_GamepadType _selectedKeyboard = En_GamepadType.Keyboard;

	private En_GamepadType _forceSelectedKeyboard;

	private const string GAMEPAD_DEVICE_ENABLE_LIST = "GamepadDeviceEnableList";

	private bool _isDeviceEnableDirty = true;

	private int _deviceEnableList = -1;

	public static GamepadManager Instance
	{
		get
		{
			if (_instance == null)
			{
				if (MonoManager.isQuiting)
				{
					return _instance;
				}
				Create();
			}
			return _instance;
		}
	}

	public event Action<En_GamepadType> OnChangeInputDevice;

	public static void Create()
	{
		if (_instance == null)
		{
			if (go == null)
			{
				go = new GameObject("GamepadManager", typeof(GamepadManager));
				UnityEngine.Object.DontDestroyOnLoad(go);
			}
			_instance = U3DUtil.Get<GamepadManager>(go);
			_instance.UpdateLayouts();
		}
	}

	private void Awake()
	{
		_inputListener = U3DUtil.Get<InputSettingListener>(base.gameObject);
		_gamepadDeviceWatcher = new GamepadDeviceWatcher();
		_gamepadDeviceWatcher.OnDeviceAdded += OnDeviceAdded;
		_gamepadDeviceWatcher.OnDeviceRemoved += OnDeviceRemoved;
		_gamepads = new Dictionary<En_GamepadType, Gamepad>();
		_curInputGamepadType = GetPlayerSelectKeyboard();
	}

	private void OnDestroy()
	{
		_gamepadDeviceWatcher.OnDeviceAdded -= OnDeviceAdded;
		_gamepadDeviceWatcher.OnDeviceRemoved -= OnDeviceRemoved;
	}

	[Obsolete("GamepadManager: deprecated method SetGamepadType!")]
	public void SetGamepadType(int pGamepadType)
	{
		Debug.LogError("GamepadManager: deprecated method SetGamepadType!");
	}

	public En_GamepadType GetGamepadType()
	{
		return GetCurInputGamepadType();
	}

	public void UseController()
	{
		CreateController(_curInputGamepadType, "UseController");
		_runtime = true;
		ResetSubStickController();
	}

	public void ReloadLayout()
	{
		if (!_runtime)
		{
			return;
		}
		foreach (KeyValuePair<En_GamepadType, Gamepad> gamepad in _gamepads)
		{
			gamepad.Deconstruct(out var _, out var value);
			value.ReloadLayoutFromConfig();
		}
	}

	[Obsolete("GamepadManager: deprecated method LoadLayoutFromJson!")]
	public void LoadLayoutFromJson(string pJson)
	{
		Debug.LogError("GamepadManager: deprecated method LoadLayoutFromJson!");
	}

	private void CreateController(En_GamepadType gamepadType, string createReason)
	{
		if (gamepadType != En_GamepadType.None && (!_gamepads.TryGetValue(gamepadType, out var value) || value == null) && IsDeviceEnable(gamepadType))
		{
			switch (gamepadType)
			{
			case En_GamepadType.Keyboard:
				value = new KeyboardController(useMouse: false);
				RemoveController(En_GamepadType.KeyMouse, "use keyboard");
				break;
			case En_GamepadType.KeyMouse:
				value = new KeyboardController(useMouse: true);
				RemoveController(En_GamepadType.Keyboard, "use keyboard and mouse");
				break;
			case En_GamepadType.Xbox:
				value = new XboxController();
				RemoveController(En_GamepadType.PS4, "use Xbox joystick");
				break;
			case En_GamepadType.PS4:
				value = new PS4Controller();
				RemoveController(En_GamepadType.Xbox, "use PS4 joystick");
				break;
			case En_GamepadType.Other:
				value = new Gamepad();
				break;
			}
			if (value != null)
			{
				_gamepads[gamepadType] = value;
				value.CreateController();
				Debug.Log($"GamepadManager: create new input device for {gamepadType}, reason = {createReason}");
			}
		}
	}

	private void RemoveController(En_GamepadType gamepadType, string removeReason)
	{
		if (_gamepads.TryGetValue(gamepadType, out var _))
		{
			_gamepads.Remove(gamepadType);
			Debug.Log($"GamepadManager: remove input device of {gamepadType}, reason = {removeReason}");
		}
	}

	public void ResetSubStickController()
	{
		foreach (KeyValuePair<En_GamepadType, Gamepad> gamepad in _gamepads)
		{
			gamepad.Deconstruct(out var _, out var value);
			value.ResetSubStickController();
		}
	}

	private void Update()
	{
		_gamepadDeviceWatcher.Tick();
		_inputListener.Tick();
		UpdateCurInputGamepadType();
		if (!_runtime)
		{
			return;
		}
		foreach (KeyValuePair<En_GamepadType, Gamepad> gamepad in _gamepads)
		{
			gamepad.Deconstruct(out var _, out var value);
			value.Update();
		}
	}

	public void Shutdown()
	{
		_runtime = false;
		foreach (KeyValuePair<En_GamepadType, Gamepad> gamepad in _gamepads)
		{
			gamepad.Deconstruct(out var _, out var value);
			value.Shutdown();
		}
	}

	public void SetIsRuntime(bool flag)
	{
		_runtime = flag;
		if (!_runtime)
		{
			LostFocus();
		}
	}

	public bool IsRuntime()
	{
		return _runtime;
	}

	public bool GetKeyDown(En_ButtonType pEn_ButtonType)
	{
		bool flag = false;
		if (_gamepads.Count == 0)
		{
			return flag;
		}
		Gamepad curInputGamepad = GetCurInputGamepad();
		if (curInputGamepad != null)
		{
			flag = curInputGamepad.GetKeyDownInternal(pEn_ButtonType);
			if (flag)
			{
				return flag;
			}
		}
		foreach (var (_, gamepad2) in _gamepads)
		{
			if (gamepad2 != curInputGamepad)
			{
				flag = gamepad2.GetKeyDownInternal(pEn_ButtonType);
				if (flag)
				{
					return flag;
				}
			}
		}
		return flag;
	}

	public bool GetKeyUp(En_ButtonType pEn_ButtonType)
	{
		bool flag = false;
		if (_gamepads.Count == 0)
		{
			return flag;
		}
		Gamepad curInputGamepad = GetCurInputGamepad();
		if (curInputGamepad != null)
		{
			flag = curInputGamepad.GetKeyUpInternal(pEn_ButtonType);
			if (flag)
			{
				return flag;
			}
		}
		foreach (var (_, gamepad2) in _gamepads)
		{
			if (gamepad2 != curInputGamepad)
			{
				flag = gamepad2.GetKeyUpInternal(pEn_ButtonType);
				if (flag)
				{
					return flag;
				}
			}
		}
		return flag;
	}

	public bool GetKey(En_ButtonType pEn_ButtonType)
	{
		bool flag = false;
		if (_gamepads.Count == 0)
		{
			return flag;
		}
		Gamepad curInputGamepad = GetCurInputGamepad();
		if (curInputGamepad != null)
		{
			flag = curInputGamepad.GetKeyInternal(pEn_ButtonType);
			if (flag)
			{
				return flag;
			}
		}
		foreach (var (_, gamepad2) in _gamepads)
		{
			if (gamepad2 != curInputGamepad)
			{
				flag = gamepad2.GetKeyInternal(pEn_ButtonType);
				if (flag)
				{
					return flag;
				}
			}
		}
		return flag;
	}

	public float GetKeyValue(En_ButtonType pEn_ButtonType)
	{
		float num = 0f;
		if (_gamepads.Count == 0)
		{
			return num;
		}
		Gamepad curInputGamepad = GetCurInputGamepad();
		if (curInputGamepad != null)
		{
			num = curInputGamepad.GetKeyValueInternal(pEn_ButtonType);
			if (!Mathf.Approximately(num, 0f))
			{
				return num;
			}
		}
		foreach (var (_, gamepad2) in _gamepads)
		{
			if (gamepad2 != curInputGamepad)
			{
				num = gamepad2.GetKeyValueInternal(pEn_ButtonType);
				if (!Mathf.Approximately(num, 0f))
				{
					return num;
				}
			}
		}
		return num;
	}

	public string GetMappedKey(En_ButtonType pEn_ButtonType)
	{
		if (_gamepads.TryGetValue(_curInputGamepadType, out var value))
		{
			return value.GetMappedKey(pEn_ButtonType);
		}
		return "";
	}

	public int GetCameraSensitivity()
	{
		if (_gamepads.TryGetValue(_curInputGamepadType, out var value))
		{
			return value.GetCameraSensitivity();
		}
		return 50;
	}

	public int GetCursorSensitivity()
	{
		if (_gamepads.TryGetValue(_curInputGamepadType, out var value))
		{
			return value.GetCursorSensitivity();
		}
		return 50;
	}

	private void OnApplicationFocus(bool hasFocus)
	{
		if (!hasFocus)
		{
			LostFocus();
		}
	}

	private void LostFocus()
	{
		_inputListener?.LostFocus();
		foreach (KeyValuePair<En_GamepadType, Gamepad> gamepad in _gamepads)
		{
			gamepad.Deconstruct(out var _, out var value);
			value.OnLostFocus();
		}
	}

	private InputValue GetLastInputValueRaw()
	{
		if (!_inputListener.enabled)
		{
			_inputListener.enabled = true;
		}
		return _inputListener.GetLastInputValue();
	}

	private InputValue GetFirstInputValueRaw()
	{
		if (!_inputListener.enabled)
		{
			_inputListener.enabled = true;
		}
		return _inputListener.GetFirstInputValue();
	}

	public string GetFirstInputValue()
	{
		if (!_inputListener.enabled)
		{
			_inputListener.enabled = true;
		}
		return _inputListener.GetFirstInputValueJson();
	}

	public string GetLastInputValue()
	{
		if (!_inputListener.enabled)
		{
			_inputListener.enabled = true;
		}
		return _inputListener.GetLastInputValueJson();
	}

	public string GetFirstDeltaInputValue()
	{
		if (!_inputListener.enabled)
		{
			_inputListener.enabled = true;
		}
		return _inputListener.GetFirstDeltaInputValueJson();
	}

	public void DisableListenerEnable()
	{
		if (_inputListener != null)
		{
			_inputListener.enabled = false;
		}
	}

	public void ClearAllInputResult()
	{
		if (_inputListener != null)
		{
			_inputListener.ClearAllInputResult();
		}
	}

	public string GetInputListString()
	{
		if (_inputListener != null)
		{
			return _inputListener.GetAllInputResult()?.GetInfo();
		}
		return "";
	}

	public string GetAllInputResultJson()
	{
		if (_inputListener != null)
		{
			return _inputListener.GetAllInputResultJson();
		}
		return "";
	}

	private void UpdateLayouts()
	{
		UpdateLayout("KeyboardLayout");
		UpdateLayout("KeyMouseLayout");
		UpdateLayout("XboxLayout");
		UpdateLayout("PS4Layout");
	}

	private void UpdateLayout(string layoutKey)
	{
		string defaultLayoutFileName = GamepadLayout.GetDefaultLayoutFileName(layoutKey);
		string layoutJsonFormConfig = GamepadLayout.GetLayoutJsonFormConfig(layoutKey, defaultLayoutFileName);
		string layoutJsonFromFile = GamepadLayout.GetLayoutJsonFromFile(defaultLayoutFileName);
		GamepadLayout layout = GamepadLayout.GetLayout(layoutJsonFormConfig);
		GamepadLayout layout2 = GamepadLayout.GetLayout(layoutJsonFromFile);
		bool flag = false;
		foreach (ButtonParameter buttonDef in layout2.m_buttonMapLayouts)
		{
			ButtonParameter buttonUser = layout.m_buttonMapLayouts.Find((ButtonParameter buttonParameter4) => buttonParameter4.m_buttonType == buttonDef.m_buttonType);
			if (buttonUser == null)
			{
				flag = true;
				ButtonParameter buttonParameter = new ButtonParameter
				{
					m_buttonType = buttonDef.m_buttonType,
					m_value = buttonDef.m_value,
					m_isAxis = buttonDef.m_isAxis
				};
				layout.m_buttonMapLayouts.Add(buttonParameter);
				Debug.Log($"GamepadManager: {layoutKey} insert new key {buttonParameter.m_buttonType} = {buttonParameter.m_value}");
			}
			else if (buttonDef.m_value != buttonUser.m_value && (buttonUser.m_value == "0" || !InputManager.controlGroups.Exists((ControlGroup g) => g.keys.Exists((En_ButtonType k) => k == buttonUser.m_buttonType))))
			{
				flag = true;
				buttonUser.m_value = buttonDef.m_value;
				buttonUser.m_isAxis = buttonDef.m_isAxis;
				Debug.Log($"GamepadManager: {layoutKey} update gamepad key {buttonUser.m_buttonType} = None -> {buttonDef.m_value}");
			}
			else if (buttonUser.m_isAxis != buttonDef.m_isAxis)
			{
				flag = true;
				buttonUser.m_isAxis = buttonDef.m_isAxis;
			}
		}
		ButtonParameter buttonParameter2 = layout.m_buttonMapLayouts.Find((ButtonParameter buttonParameter4) => buttonParameter4.m_buttonType == En_ButtonType.Special_CampSkill);
		ButtonParameter buttonParameter3 = layout.m_buttonMapLayouts.Find((ButtonParameter buttonParameter4) => buttonParameter4.m_buttonType == En_ButtonType.MasterSkill);
		if (buttonParameter3.m_value != buttonParameter2.m_value)
		{
			flag = true;
			Debug.Log($"GamepadManager: {layoutKey} update gamepad key {buttonParameter3.m_buttonType} = {buttonParameter3.m_value} -> {buttonParameter2.m_value}");
			buttonParameter3.m_value = buttonParameter2.m_value;
			buttonParameter3.m_isAxis = buttonParameter2.m_isAxis;
		}
		foreach (ButtonParameter buttonMapLayout in layout.m_buttonMapLayouts)
		{
			if (!Enum.TryParse<KeyCode>(buttonMapLayout.m_value, out var result))
			{
				continue;
			}
			if (result >= KeyCode.Joystick1Button0 && result <= KeyCode.Joystick8Button19)
			{
				KeyCode joystickKeySpecificToAny = GetJoystickKeySpecificToAny(result);
				if (result != joystickKeySpecificToAny)
				{
					flag = true;
					int num = (int)joystickKeySpecificToAny;
					buttonMapLayout.m_value = num.ToString();
					Debug.Log($"GamepadManager: {layoutKey} update gamepad key {buttonMapLayout.m_buttonType} = {result} -> {joystickKeySpecificToAny}");
				}
			}
			else if (result >= KeyCode.Keypad0 && result <= KeyCode.KeypadEquals)
			{
				KeyCode keypadKeyToAlpha = GetKeypadKeyToAlpha(result);
				if (result != keypadKeyToAlpha)
				{
					flag = true;
					int num = (int)keypadKeyToAlpha;
					buttonMapLayout.m_value = num.ToString();
					Debug.Log($"GamepadManager: {layoutKey} update gamepad key {buttonMapLayout.m_buttonType} = {result} -> {keypadKeyToAlpha}");
				}
			}
		}
		if (flag)
		{
			string pJson = JsonUtility.ToJson(layout);
			GamepadLayout.SaveLayoutJson(layoutKey, pJson);
		}
	}

	private KeyCode GetJoystickKeySpecificToAny(KeyCode keyCode)
	{
		if (keyCode < KeyCode.JoystickButton0 || keyCode > KeyCode.Joystick8Button19)
		{
			return keyCode;
		}
		int num = 330;
		return (KeyCode)(num + (int)(keyCode - num) % 20);
	}

	private KeyCode GetKeypadKeyToAlpha(KeyCode keyCode)
	{
		switch (keyCode)
		{
		case KeyCode.KeypadEnter:
			return KeyCode.Return;
		case KeyCode.Keypad0:
		case KeyCode.Keypad1:
		case KeyCode.Keypad2:
		case KeyCode.Keypad3:
		case KeyCode.Keypad4:
		case KeyCode.Keypad5:
		case KeyCode.Keypad6:
		case KeyCode.Keypad7:
		case KeyCode.Keypad8:
		case KeyCode.Keypad9:
			return 48 + (keyCode - 256);
		default:
			return keyCode;
		}
	}

	private En_GamepadType GetCurInputGamepadType()
	{
		return _curInputGamepadType;
	}

	private Gamepad GetCurInputGamepad()
	{
		if (_gamepads.TryGetValue(_curInputGamepadType, out var value))
		{
			return value;
		}
		return null;
	}

	private En_GamepadType GetDeviceGamepadType(string deviceName)
	{
		if (PlayerPrefs.HasKey("JoystickType"))
		{
			return GetPlayerSelectJoystick();
		}
		return GamepadDeviceWatcher.GetGamepadTypeForName(deviceName);
	}

	private void OnDeviceAdded(string deviceName)
	{
		_joystickNum++;
		En_GamepadType deviceGamepadType = GetDeviceGamepadType(deviceName);
		LuaHelper.CallFunction("OnGamepadDeviceAdded", deviceGamepadType, deviceName);
	}

	private void OnDeviceRemoved(string deviceName)
	{
		_joystickNum--;
		En_GamepadType deviceGamepadType = GetDeviceGamepadType(deviceName);
		LuaHelper.CallFunction("OnGamepadDeviceRemoved", deviceGamepadType, deviceName);
		if (_joystickNum <= 0)
		{
			RemoveController(En_GamepadType.Xbox, "device removed");
			RemoveController(En_GamepadType.PS4, "device removed");
			_curInputGamepadType = GetPlayerSelectKeyboard();
		}
	}

	private void UpdateCurInputGamepadType()
	{
		InputValue firstInputValueRaw = GetFirstInputValueRaw();
		if (firstInputValueRaw == null)
		{
			return;
		}
		string axisName = firstInputValueRaw.m_axisName;
		bool flag = false;
		En_GamepadType en_GamepadType = En_GamepadType.None;
		if (firstInputValueRaw.m_listenType == En_ListenType.KeyCode)
		{
			KeyCode keyCode = firstInputValueRaw.m_keyCode;
			if (keyCode >= KeyCode.JoystickButton0 && keyCode <= KeyCode.Joystick8Button19)
			{
				en_GamepadType = GetPlayerSelectJoystick();
				flag = true;
			}
			else
			{
				en_GamepadType = GetPlayerSelectKeyboard();
			}
		}
		else if (InputSettingListener.IsMouseAxisInput(firstInputValueRaw.m_axisNameHash))
		{
			en_GamepadType = GetPlayerSelectKeyboard();
		}
		else
		{
			en_GamepadType = GetPlayerSelectJoystick();
			flag = true;
		}
		if (flag && !IsJoystickConnected())
		{
			Debug.Log("GamepadManager: no joystick connect but joystick input detected: " + axisName);
		}
		else if (IsDeviceEnable(en_GamepadType))
		{
			CreateController(en_GamepadType, axisName);
			if (_curInputGamepadType != en_GamepadType)
			{
				_curInputGamepadType = en_GamepadType;
				OnChangeInputDevice?.Invoke(en_GamepadType);
			}
		}
	}

	public En_GamepadType GetPlayerSelectJoystick()
	{
		if (_isSelectedJoystickDirty)
		{
			_selectedJoystick = (En_GamepadType)PlayerPrefs.GetInt("JoystickType", 2);
			_isSelectedJoystickDirty = false;
		}
		return _selectedJoystick;
	}

	public void SetPlayerSelectJoystick(En_GamepadType gamepadType)
	{
		PlayerPrefs.SetInt("JoystickType", (int)gamepadType);
		_isSelectedJoystickDirty = true;
		if (gamepadType == En_GamepadType.None)
		{
			RemoveController(En_GamepadType.Xbox, "select none joystick");
			RemoveController(En_GamepadType.PS4, "select none joystick");
		}
		else
		{
			CreateController(gamepadType, "change joystick");
		}
	}

	public En_GamepadType GetPlayerSelectKeyboard()
	{
		if (_forceSelectedKeyboard != En_GamepadType.None)
		{
			return _forceSelectedKeyboard;
		}
		if (_isSelectedKeyboardDirty)
		{
			_selectedKeyboard = (En_GamepadType)PlayerPrefs.GetInt("KeyboardType", 1);
			_isSelectedKeyboardDirty = false;
		}
		return _selectedKeyboard;
	}

	public void SetPlayerSelectKeyboard(En_GamepadType gamepadType)
	{
		PlayerPrefs.SetInt("KeyboardType", (int)gamepadType);
		_isSelectedKeyboardDirty = true;
		if (gamepadType == En_GamepadType.None)
		{
			RemoveController(En_GamepadType.Keyboard, "select none keyboard");
			RemoveController(En_GamepadType.KeyMouse, "select none keyboard");
		}
		else
		{
			CreateController(gamepadType, "change keyboard");
		}
	}

	public void ForceSelectKeyboard(En_GamepadType gamepadType)
	{
		if (gamepadType == En_GamepadType.None || gamepadType == En_GamepadType.Keyboard || gamepadType == En_GamepadType.KeyMouse)
		{
			_forceSelectedKeyboard = gamepadType;
			if (IsUsingKeyboard())
			{
				En_GamepadType playerSelectKeyboard = GetPlayerSelectKeyboard();
				CreateController(playerSelectKeyboard, "force select keyboard by code");
				_curInputGamepadType = playerSelectKeyboard;
			}
		}
		else
		{
			Debug.LogError($"无法强制选择键盘模式为: {gamepadType}");
		}
	}

	public bool IsDeviceEnable(En_GamepadType gamepadType)
	{
		int num;
		if (_isDeviceEnableDirty)
		{
			num = (_deviceEnableList = PlayerPrefs.GetInt("GamepadDeviceEnableList", -1));
			_isDeviceEnableDirty = false;
		}
		else
		{
			num = _deviceEnableList;
		}
		int num2 = 1 << (int)gamepadType;
		return (num & num2) != 0;
	}

	public void SetDeviceEnable(En_GamepadType gamepadType, bool val)
	{
		int num = PlayerPrefs.GetInt("GamepadDeviceEnableList", -1);
		int num2 = 1 << (int)gamepadType;
		num = (val ? (num | num2) : (num & ~num2));
		PlayerPrefs.SetInt("GamepadDeviceEnableList", num);
		_isDeviceEnableDirty = true;
		if (!val)
		{
			RemoveController(gamepadType, "disable joystick");
		}
	}

	public bool IsJoystickConnected()
	{
		return _joystickNum > 0;
	}

	public bool IsUsingJoystick()
	{
		if (!IsJoystickConnected())
		{
			return false;
		}
		if (_curInputGamepadType != En_GamepadType.Xbox)
		{
			return _curInputGamepadType == En_GamepadType.PS4;
		}
		return true;
	}

	public bool IsUsingKeyboard()
	{
		if (_curInputGamepadType != En_GamepadType.Keyboard)
		{
			return _curInputGamepadType == En_GamepadType.KeyMouse;
		}
		return true;
	}

	public bool IsInputGamepadType(En_GamepadType gamepadType)
	{
		return _curInputGamepadType == gamepadType;
	}

	public void GetJoystickClick(out bool buttonDown, out bool buttonHold, out bool buttonUp)
	{
		if (!IsUsingJoystick())
		{
			buttonDown = false;
			buttonHold = false;
			buttonUp = false;
		}
		else
		{
			KeyCode key = ((GetPlayerSelectJoystick() == En_GamepadType.Xbox) ? KeyCode.JoystickButton0 : KeyCode.JoystickButton1);
			buttonDown = Input.GetKeyDown(key);
			buttonHold = Input.GetKey(key);
			buttonUp = Input.GetKeyUp(key);
		}
	}

	public static bool GetKeyCodeDown(KeyCode key)
	{
		return InputSettingListener.GetKeyCodeInput(key)?.m_isKeyDown ?? false;
	}

	public static bool GetKeyCodeHeld(KeyCode key)
	{
		return InputSettingListener.GetKeyCodeInput(key)?.m_isKeyHeld ?? false;
	}

	public static bool GetKeyCodeUp(KeyCode key)
	{
		return InputSettingListener.GetKeyCodeInput(key)?.m_isKeyUp ?? false;
	}

	public static float GetAxisValue(int axisNameHash)
	{
		return InputSettingListener.GetAxisInput(axisNameHash)?.m_axisValue ?? 0f;
	}
}
