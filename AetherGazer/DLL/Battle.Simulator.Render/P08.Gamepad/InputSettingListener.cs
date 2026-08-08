using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.UI;

namespace P08.Gamepad;

public class InputSettingListener : MonoBehaviour
{
	private struct HashedString(string str)
	{
		public readonly string str = str;

		public readonly int hash = str.GetHashCode();
	}

	private struct SameKeyGroup(KeyCode first, KeyCode second)
	{
		public readonly KeyCode first = first;

		public readonly KeyCode second = second;

		public bool IsInGroup(KeyCode key)
		{
			if (key != first)
			{
				return key == second;
			}
			return true;
		}
	}

	private struct InputAxis
	{
		public readonly string inputAxis;

		public readonly HashedString pos;

		public readonly HashedString neg;

		public InputAxis(string inputAxis)
		{
			this.inputAxis = inputAxis;
			string text = inputAxis.Replace(' ', '_');
			pos = new HashedString(text + "P");
			neg = new HashedString(text + "N");
		}
	}

	private struct KeyGroupUpdateBuffer(KeyCode key)
	{
		public KeyCode keyCode = key;

		public InputValue input = GetKeyCodeInput(key);
	}

	public Text m_text;

	public Text m_deltaText;

	private static string[] m_halfAixsNames;

	private static HashedString[] s_xboxAxisNames;

	private static HashedString[] s_psAxisNames;

	private static InputAxis[] s_mouseAxis;

	private static KeyCode[] _keyCodesCache;

	private static string[] _keyCodeNames;

	private InputResult _initInputResult = new InputResult();

	private bool _init;

	private InputResult _inputResult = new InputResult();

	private static InputValue[] _keyCodeInputValue;

	private static Dictionary<int, InputValue> _axisInputValue;

	private static SameKeyGroup[] _sameKeyGroups;

	private static bool[] _keyCodeMapped;

	private KeyGroupUpdateBuffer[] _keyGroupBuffer = new KeyGroupUpdateBuffer[2];

	private static HashedString[] _axisNames
	{
		get
		{
			if (GamepadManager.Instance.GetPlayerSelectJoystick() != En_GamepadType.Xbox)
			{
				return s_psAxisNames;
			}
			return s_xboxAxisNames;
		}
	}

	static InputSettingListener()
	{
		m_halfAixsNames = new string[56]
		{
			"Axis1P", "Axis1N", "Axis2P", "Axis2N", "Axis3P", "Axis3N", "Axis4P", "Axis4N", "Axis5P", "Axis5N",
			"Axis6P", "Axis6N", "Axis7P", "Axis7N", "Axis8P", "Axis8N", "Axis9P", "Axis9N", "Axis10P", "Axis10N",
			"Axis11P", "Axis11N", "Axis12P", "Axis12N", "Axis13P", "Axis13N", "Axis14P", "Axis14N", "Axis15P", "Axis15N",
			"Axis16P", "Axis16N", "Axis17P", "Axis17N", "Axis18P", "Axis18N", "Axis19P", "Axis19N", "Axis20P", "Axis20N",
			"Axis21P", "Axis21N", "Axis22P", "Axis22N", "Axis23P", "Axis23N", "Axis24P", "Axis24N", "Axis25P", "Axis25N",
			"Axis26P", "Axis26N", "Axis27P", "Axis27N", "Axis28P", "Axis28N"
		};
		s_mouseAxis = new string[3] { "Mouse X", "Mouse Y", "Mouse ScrollWheel" }.Select((string str) => new InputAxis(str)).ToArray();
		_keyCodesCache = Enum.GetValues(typeof(KeyCode)) as KeyCode[];
		_axisInputValue = new Dictionary<int, InputValue>();
		_sameKeyGroups = new SameKeyGroup[11]
		{
			new SameKeyGroup(KeyCode.Return, KeyCode.KeypadEnter),
			new SameKeyGroup(KeyCode.Alpha0, KeyCode.Keypad0),
			new SameKeyGroup(KeyCode.Alpha1, KeyCode.Keypad1),
			new SameKeyGroup(KeyCode.Alpha2, KeyCode.Keypad2),
			new SameKeyGroup(KeyCode.Alpha3, KeyCode.Keypad3),
			new SameKeyGroup(KeyCode.Alpha4, KeyCode.Keypad4),
			new SameKeyGroup(KeyCode.Alpha5, KeyCode.Keypad5),
			new SameKeyGroup(KeyCode.Alpha6, KeyCode.Keypad6),
			new SameKeyGroup(KeyCode.Alpha7, KeyCode.Keypad7),
			new SameKeyGroup(KeyCode.Alpha8, KeyCode.Keypad8),
			new SameKeyGroup(KeyCode.Alpha9, KeyCode.Keypad9)
		};
		s_xboxAxisNames = (from str in m_halfAixsNames
			where str != "Axis3N" && str != "Axis3P"
			select new HashedString(str)).ToArray();
		s_psAxisNames = (from str in m_halfAixsNames
			where str != "Axis4N" && str != "Axis5N"
			select new HashedString(str)).ToArray();
		_keyCodeNames = new string[_keyCodesCache.Max((KeyCode key) => (int)key) + 1];
		KeyCode[] keyCodesCache = _keyCodesCache;
		for (int num = 0; num < keyCodesCache.Length; num++)
		{
			KeyCode keyCode = keyCodesCache[num];
			_keyCodeNames[(int)keyCode] = keyCode.ToString();
		}
		_keyCodeMapped = new bool[_keyCodeNames.Length];
		SameKeyGroup[] sameKeyGroups = _sameKeyGroups;
		for (int num = 0; num < sameKeyGroups.Length; num++)
		{
			SameKeyGroup sameKeyGroup = sameKeyGroups[num];
			_keyCodeMapped[(int)sameKeyGroup.second] = true;
		}
		_keyCodeInputValue = new InputValue[_keyCodeNames.Length];
	}

	private void UpdateInputResult()
	{
		bool flag = IsAnyInput();
		_inputResult.m_inputValueList.Clear();
		if (Input.anyKey | flag)
		{
			GetKeyCodeInput(_inputResult.m_inputValueList);
			UpdateKeyGroups();
		}
		if (GamepadManager.Instance.IsJoystickConnected())
		{
			GetHalfAxisInput(_inputResult.m_inputValueList);
		}
		if (GamepadManager.Instance.GetGamepadType() == En_GamepadType.KeyMouse || GamepadManager.Instance.GetGamepadType() == En_GamepadType.Keyboard)
		{
			GetMouseAxisInput(_inputResult.m_inputValueList);
		}
	}

	public void Tick()
	{
		if (!_init)
		{
			UpdateInputResult();
			_initInputResult.m_inputValueList.Clear();
			foreach (InputValue inputValue in _inputResult.m_inputValueList)
			{
				_initInputResult.m_inputValueList.Add(inputValue);
			}
			_init = true;
		}
		else
		{
			UpdateInputResult();
		}
	}

	public void LostFocus()
	{
		InputValue[] keyCodeInputValue = _keyCodeInputValue;
		int i;
		for (i = 0; i < keyCodeInputValue.Length; i++)
		{
			keyCodeInputValue[i]?.LostFocus();
		}
		foreach (KeyValuePair<int, InputValue> item in _axisInputValue)
		{
			item.Deconstruct(out i, out var value);
			value?.LostFocus();
		}
	}

	public static string KeyCodeToString(KeyCode keyCode)
	{
		return _keyCodeNames[(int)keyCode] ?? "";
	}

	public static InputValue GetKeyCodeInput(KeyCode keyCode)
	{
		return _keyCodeInputValue[(int)keyCode];
	}

	public static InputValue GetAxisInput(int axisNameHash)
	{
		_axisInputValue.TryGetValue(axisNameHash, out var value);
		return value;
	}

	private void UpdateKeyCodeInput(KeyCode keyCode, out InputValue inputValue)
	{
		bool key = Input.GetKey(keyCode);
		bool keyUp = Input.GetKeyUp(keyCode);
		bool keyDown = Input.GetKeyDown(keyCode);
		bool num = key | keyUp | keyDown;
		inputValue = _keyCodeInputValue[(int)keyCode];
		if (inputValue != null)
		{
			inputValue.m_isKeyHeld = key;
			inputValue.m_isKeyDown = keyDown;
			inputValue.m_isKeyUp = keyUp;
		}
		if (num && inputValue == null)
		{
			InputValue[] keyCodeInputValue = _keyCodeInputValue;
			InputValue obj = new InputValue
			{
				m_listenType = En_ListenType.KeyCode,
				m_keyCode = keyCode
			};
			int num2 = (int)keyCode;
			obj.m_axisName = num2.ToString();
			obj.m_axisValue = 0f;
			obj.m_isKeyHeld = key;
			obj.m_isKeyDown = keyDown;
			obj.m_isKeyUp = keyUp;
			InputValue inputValue2 = obj;
			inputValue = obj;
			keyCodeInputValue[(int)keyCode] = inputValue2;
		}
	}

	private void UpdateAxisInput(string inputAxis, HashedString axisName, out InputValue inputValue)
	{
		string str = axisName.str;
		float num = Input.GetAxis(inputAxis);
		bool flag;
		if (str.StartsWith("Mouse_ScrollWheel"))
		{
			flag = num != 0f;
			num *= 10f;
		}
		else
		{
			flag = (str.EndsWith('N') ? ((double)num < -0.275) : ((double)num > 0.275));
		}
		int hash = axisName.hash;
		if (_axisInputValue.TryGetValue(hash, out inputValue))
		{
			inputValue.m_axisValue = num;
			inputValue.m_isKeyHeld = flag;
		}
		if (flag && inputValue == null)
		{
			Dictionary<int, InputValue> axisInputValue = _axisInputValue;
			InputValue obj = new InputValue
			{
				m_listenType = En_ListenType.Axis,
				m_keyCode = KeyCode.None,
				m_axisName = str,
				m_axisNameHash = axisName.hash,
				m_axisValue = num,
				m_isKeyHeld = flag,
				m_isKeyDown = false,
				m_isKeyUp = false
			};
			InputValue value = obj;
			inputValue = obj;
			axisInputValue[hash] = value;
		}
	}

	private void UpdateKeyGroup(SameKeyGroup group)
	{
		_keyGroupBuffer[0] = new KeyGroupUpdateBuffer(group.first);
		_keyGroupBuffer[1] = new KeyGroupUpdateBuffer(group.second);
		InputValue inputValue = null;
		KeyGroupUpdateBuffer[] keyGroupBuffer = _keyGroupBuffer;
		for (int i = 0; i < keyGroupBuffer.Length; i++)
		{
			InputValue input = keyGroupBuffer[i].input;
			if (input != null && input.isValid)
			{
				inputValue = input;
				break;
			}
		}
		if (inputValue == null)
		{
			return;
		}
		keyGroupBuffer = _keyGroupBuffer;
		for (int i = 0; i < keyGroupBuffer.Length; i++)
		{
			KeyGroupUpdateBuffer keyGroupUpdateBuffer = keyGroupBuffer[i];
			InputValue inputValue2 = keyGroupUpdateBuffer.input;
			if (inputValue2 == null)
			{
				KeyCode keyCode = keyGroupUpdateBuffer.keyCode;
				InputValue[] keyCodeInputValue = _keyCodeInputValue;
				InputValue obj = new InputValue
				{
					m_listenType = En_ListenType.KeyCode,
					m_keyCode = keyCode
				};
				int num = (int)keyCode;
				obj.m_axisName = num.ToString();
				obj.m_axisValue = 0f;
				obj.m_isKeyHeld = false;
				obj.m_isKeyDown = false;
				obj.m_isKeyUp = false;
				inputValue2 = obj;
				keyCodeInputValue[(int)keyCode] = obj;
			}
			if (!inputValue2.isValid)
			{
				inputValue2.m_isKeyHeld |= inputValue.m_isKeyHeld;
				inputValue2.m_isKeyDown |= inputValue.m_isKeyDown;
				inputValue2.m_isKeyUp |= inputValue.m_isKeyUp;
			}
		}
	}

	private void UpdateKeyGroups()
	{
		SameKeyGroup[] sameKeyGroups = _sameKeyGroups;
		foreach (SameKeyGroup sameKeyGroup in sameKeyGroups)
		{
			UpdateKeyGroup(sameKeyGroup);
		}
	}

	private void GetKeyCodeInput(List<InputValue> list)
	{
		int num = _keyCodesCache.Length;
		for (int i = 0; i < num; i++)
		{
			KeyCode keyCode = _keyCodesCache[i];
			UpdateKeyCodeInput(keyCode, out var inputValue);
			if (inputValue != null && inputValue.isValid)
			{
				list.Add(inputValue);
			}
		}
	}

	private void GetHalfAxisInput(List<InputValue> list)
	{
		int num = _axisNames.Length;
		for (int i = 0; i < num; i++)
		{
			HashedString axisName = _axisNames[i];
			UpdateAxisInput(axisName.str, axisName, out var inputValue);
			if (inputValue != null && inputValue.isValid)
			{
				list.Add(inputValue);
			}
		}
	}

	private void GetMouseAxisInput(List<InputValue> list)
	{
		int num = s_mouseAxis.Length;
		for (int i = 0; i < num; i++)
		{
			InputAxis inputAxis = s_mouseAxis[i];
			UpdateAxisInput(inputAxis.inputAxis, inputAxis.neg, out var inputValue);
			if (inputValue != null && inputValue.isValid)
			{
				list.Add(inputValue);
			}
			UpdateAxisInput(inputAxis.inputAxis, inputAxis.pos, out inputValue);
			if (inputValue != null && inputValue.isValid)
			{
				list.Add(inputValue);
			}
		}
	}

	public InputResult GetAllInputResult()
	{
		return _inputResult;
	}

	public string GetAllInputResultJson()
	{
		return _inputResult.ToString();
	}

	public InputValue GetFirstDeltaInputValue()
	{
		if (_inputResult.m_inputValueList.Count > 0)
		{
			foreach (InputValue inputValue in _inputResult.m_inputValueList)
			{
				if (!_initInputResult.m_inputValueList.Contains(inputValue))
				{
					return inputValue;
				}
			}
		}
		return null;
	}

	public InputValue GetFirstInputValue()
	{
		if (_inputResult.m_inputValueList.Count > 0)
		{
			return _inputResult.m_inputValueList[0];
		}
		return null;
	}

	public InputValue GetLastInputValue()
	{
		if (_inputResult.m_inputValueList.Count > 0)
		{
			return _inputResult.m_inputValueList[_inputResult.m_inputValueList.Count - 1];
		}
		return null;
	}

	public string GetFirstInputValueJson()
	{
		InputValue firstInputValue = GetFirstInputValue();
		if (firstInputValue != null)
		{
			return JsonUtility.ToJson(firstInputValue);
		}
		return string.Empty;
	}

	public string GetLastInputValueJson()
	{
		InputValue lastInputValue = GetLastInputValue();
		if (lastInputValue != null)
		{
			return JsonUtility.ToJson(lastInputValue);
		}
		return string.Empty;
	}

	public string GetFirstDeltaInputValueJson()
	{
		InputValue firstDeltaInputValue = GetFirstDeltaInputValue();
		if (firstDeltaInputValue != null)
		{
			return JsonUtility.ToJson(firstDeltaInputValue);
		}
		return string.Empty;
	}

	public List<InputValue> GetDeltaInputValue()
	{
		List<InputValue> list = new List<InputValue>();
		foreach (InputValue inputValue in _inputResult.m_inputValueList)
		{
			if (!_initInputResult.m_inputValueList.Contains(inputValue))
			{
				list.Add(inputValue);
			}
		}
		return list;
	}

	public void ClearAllInputResult()
	{
		_init = false;
		_initInputResult.m_inputValueList.Clear();
		_inputResult.m_inputValueList.Clear();
	}

	public static bool IsMouseAxisInput(int axisNameHash)
	{
		int num = s_mouseAxis.Length;
		for (int i = 0; i < num; i++)
		{
			InputAxis inputAxis = s_mouseAxis[i];
			if (inputAxis.neg.hash == axisNameHash || inputAxis.pos.hash == axisNameHash)
			{
				return true;
			}
		}
		return false;
	}

	public bool IsAnyInput()
	{
		return _inputResult.m_inputValueList.Count > 0;
	}
}
