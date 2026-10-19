using System;
using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

[InputControlLayout(stateType = typeof(KeyboardState), isGenericTypeOfDevice = true)]
public class Keyboard : InputDevice, ITextInputReceiver, IEventPreProcessor
{
	public const int KeyCount = 110;

	internal const int ExtendedKeyCount = 126;

	private InlinedArray<Action<char>> m_TextInputListeners;

	private string m_KeyboardLayoutName;

	private KeyControl[] m_Keys;

	private InlinedArray<Action<IMECompositionString>> m_ImeCompositionListeners;

	public string keyboardLayout
	{
		get
		{
			RefreshConfigurationIfNeeded();
			return m_KeyboardLayoutName;
		}
		protected set
		{
			m_KeyboardLayoutName = value;
		}
	}

	public AnyKeyControl anyKey { get; protected set; }

	public KeyControl spaceKey => this[Key.Space];

	public KeyControl enterKey => this[Key.Enter];

	public KeyControl tabKey => this[Key.Tab];

	public KeyControl backquoteKey => this[Key.Backquote];

	public KeyControl quoteKey => this[Key.Quote];

	public KeyControl semicolonKey => this[Key.Semicolon];

	public KeyControl commaKey => this[Key.Comma];

	public KeyControl periodKey => this[Key.Period];

	public KeyControl slashKey => this[Key.Slash];

	public KeyControl backslashKey => this[Key.Backslash];

	public KeyControl leftBracketKey => this[Key.LeftBracket];

	public KeyControl rightBracketKey => this[Key.RightBracket];

	public KeyControl minusKey => this[Key.Minus];

	public KeyControl equalsKey => this[Key.Equals];

	public KeyControl aKey => this[Key.A];

	public KeyControl bKey => this[Key.B];

	public KeyControl cKey => this[Key.C];

	public KeyControl dKey => this[Key.D];

	public KeyControl eKey => this[Key.E];

	public KeyControl fKey => this[Key.F];

	public KeyControl gKey => this[Key.G];

	public KeyControl hKey => this[Key.H];

	public KeyControl iKey => this[Key.I];

	public KeyControl jKey => this[Key.J];

	public KeyControl kKey => this[Key.K];

	public KeyControl lKey => this[Key.L];

	public KeyControl mKey => this[Key.M];

	public KeyControl nKey => this[Key.N];

	public KeyControl oKey => this[Key.O];

	public KeyControl pKey => this[Key.P];

	public KeyControl qKey => this[Key.Q];

	public KeyControl rKey => this[Key.R];

	public KeyControl sKey => this[Key.S];

	public KeyControl tKey => this[Key.T];

	public KeyControl uKey => this[Key.U];

	public KeyControl vKey => this[Key.V];

	public KeyControl wKey => this[Key.W];

	public KeyControl xKey => this[Key.X];

	public KeyControl yKey => this[Key.Y];

	public KeyControl zKey => this[Key.Z];

	public KeyControl digit1Key => this[Key.Digit1];

	public KeyControl digit2Key => this[Key.Digit2];

	public KeyControl digit3Key => this[Key.Digit3];

	public KeyControl digit4Key => this[Key.Digit4];

	public KeyControl digit5Key => this[Key.Digit5];

	public KeyControl digit6Key => this[Key.Digit6];

	public KeyControl digit7Key => this[Key.Digit7];

	public KeyControl digit8Key => this[Key.Digit8];

	public KeyControl digit9Key => this[Key.Digit9];

	public KeyControl digit0Key => this[Key.Digit0];

	public KeyControl leftShiftKey => this[Key.LeftShift];

	public KeyControl rightShiftKey => this[Key.RightShift];

	public KeyControl leftAltKey => this[Key.LeftAlt];

	public KeyControl rightAltKey => this[Key.RightAlt];

	public KeyControl leftCtrlKey => this[Key.LeftCtrl];

	public KeyControl rightCtrlKey => this[Key.RightCtrl];

	public KeyControl leftMetaKey => this[Key.LeftMeta];

	public KeyControl rightMetaKey => this[Key.RightMeta];

	public KeyControl leftWindowsKey => this[Key.LeftMeta];

	public KeyControl rightWindowsKey => this[Key.RightMeta];

	public KeyControl leftAppleKey => this[Key.LeftMeta];

	public KeyControl rightAppleKey => this[Key.RightMeta];

	public KeyControl leftCommandKey => this[Key.LeftMeta];

	public KeyControl rightCommandKey => this[Key.RightMeta];

	public KeyControl contextMenuKey => this[Key.ContextMenu];

	public KeyControl escapeKey => this[Key.Escape];

	public KeyControl leftArrowKey => this[Key.LeftArrow];

	public KeyControl rightArrowKey => this[Key.RightArrow];

	public KeyControl upArrowKey => this[Key.UpArrow];

	public KeyControl downArrowKey => this[Key.DownArrow];

	public KeyControl backspaceKey => this[Key.Backspace];

	public KeyControl pageDownKey => this[Key.PageDown];

	public KeyControl pageUpKey => this[Key.PageUp];

	public KeyControl homeKey => this[Key.Home];

	public KeyControl endKey => this[Key.End];

	public KeyControl insertKey => this[Key.Insert];

	public KeyControl deleteKey => this[Key.Delete];

	public KeyControl capsLockKey => this[Key.CapsLock];

	public KeyControl scrollLockKey => this[Key.ScrollLock];

	public KeyControl numLockKey => this[Key.NumLock];

	public KeyControl printScreenKey => this[Key.PrintScreen];

	public KeyControl pauseKey => this[Key.Pause];

	public KeyControl numpadEnterKey => this[Key.NumpadEnter];

	public KeyControl numpadDivideKey => this[Key.NumpadDivide];

	public KeyControl numpadMultiplyKey => this[Key.NumpadMultiply];

	public KeyControl numpadMinusKey => this[Key.NumpadMinus];

	public KeyControl numpadPlusKey => this[Key.NumpadPlus];

	public KeyControl numpadPeriodKey => this[Key.NumpadPeriod];

	public KeyControl numpadEqualsKey => this[Key.NumpadEquals];

	public KeyControl numpad0Key => this[Key.Numpad0];

	public KeyControl numpad1Key => this[Key.Numpad1];

	public KeyControl numpad2Key => this[Key.Numpad2];

	public KeyControl numpad3Key => this[Key.Numpad3];

	public KeyControl numpad4Key => this[Key.Numpad4];

	public KeyControl numpad5Key => this[Key.Numpad5];

	public KeyControl numpad6Key => this[Key.Numpad6];

	public KeyControl numpad7Key => this[Key.Numpad7];

	public KeyControl numpad8Key => this[Key.Numpad8];

	public KeyControl numpad9Key => this[Key.Numpad9];

	public KeyControl f1Key => this[Key.F1];

	public KeyControl f2Key => this[Key.F2];

	public KeyControl f3Key => this[Key.F3];

	public KeyControl f4Key => this[Key.F4];

	public KeyControl f5Key => this[Key.F5];

	public KeyControl f6Key => this[Key.F6];

	public KeyControl f7Key => this[Key.F7];

	public KeyControl f8Key => this[Key.F8];

	public KeyControl f9Key => this[Key.F9];

	public KeyControl f10Key => this[Key.F10];

	public KeyControl f11Key => this[Key.F11];

	public KeyControl f12Key => this[Key.F12];

	public KeyControl oem1Key => this[Key.OEM1];

	public KeyControl oem2Key => this[Key.OEM2];

	public KeyControl oem3Key => this[Key.OEM3];

	public KeyControl oem4Key => this[Key.OEM4];

	public KeyControl oem5Key => this[Key.OEM5];

	public KeyControl f13Key => this[Key.F13];

	public KeyControl f14Key => this[Key.F14];

	public KeyControl f15Key => this[Key.F15];

	public KeyControl f16Key => this[Key.F16];

	public KeyControl f17Key => this[Key.F17];

	public KeyControl f18Key => this[Key.F18];

	public KeyControl f19Key => this[Key.F19];

	public KeyControl f20Key => this[Key.F20];

	public KeyControl f21Key => this[Key.F21];

	public KeyControl f22Key => this[Key.F22];

	public KeyControl f23Key => this[Key.F23];

	public KeyControl f24Key => this[Key.F24];

	public KeyControl mediaPlayPause => this[Key.MediaPlayPause];

	public KeyControl mediaRewind => this[Key.MediaRewind];

	public KeyControl mediaForward => this[Key.MediaForward];

	public ButtonControl shiftKey { get; protected set; }

	public ButtonControl ctrlKey { get; protected set; }

	public ButtonControl altKey { get; protected set; }

	public ButtonControl imeSelected { get; protected set; }

	public KeyControl this[Key key]
	{
		get
		{
			int num = (int)(key - 1);
			if (num < 0 || num >= m_Keys.Length)
			{
				throw new ArgumentOutOfRangeException(string.Format("{0}: {1}", "key", key));
			}
			return m_Keys[num];
		}
	}

	public ReadOnlyArray<KeyControl> allKeys => new ReadOnlyArray<KeyControl>(m_Keys);

	public static Keyboard current { get; private set; }

	protected KeyControl[] keys
	{
		get
		{
			return m_Keys;
		}
		set
		{
			m_Keys = value;
		}
	}

	public event Action<char> onTextInput
	{
		add
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			if (!m_TextInputListeners.Contains(value))
			{
				m_TextInputListeners.Append(value);
			}
		}
		remove
		{
			m_TextInputListeners.Remove(value);
		}
	}

	public event Action<IMECompositionString> onIMECompositionChange
	{
		add
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			if (!m_ImeCompositionListeners.Contains(value))
			{
				m_ImeCompositionListeners.Append(value);
			}
		}
		remove
		{
			m_ImeCompositionListeners.Remove(value);
		}
	}

	public void SetIMEEnabled(bool enabled)
	{
		EnableIMECompositionCommand command = EnableIMECompositionCommand.Create(enabled);
		ExecuteCommand(ref command);
	}

	public void SetIMECursorPosition(Vector2 position)
	{
		SetIMECursorPositionCommand command = SetIMECursorPositionCommand.Create(position);
		ExecuteCommand(ref command);
	}

	public override void MakeCurrent()
	{
		base.MakeCurrent();
		current = this;
	}

	protected override void OnRemoved()
	{
		base.OnRemoved();
		if (current == this)
		{
			current = null;
		}
	}

	protected override void FinishSetup()
	{
		string[] array = new string[126]
		{
			"space", "enter", "tab", "backquote", "quote", "semicolon", "comma", "period", "slash", "backslash",
			"leftbracket", "rightbracket", "minus", "equals", "a", "b", "c", "d", "e", "f",
			"g", "h", "i", "j", "k", "l", "m", "n", "o", "p",
			"q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
			"1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
			"leftshift", "rightshift", "leftalt", "rightalt", "leftctrl", "rightctrl", "leftmeta", "rightmeta", "contextmenu", "escape",
			"leftarrow", "rightarrow", "uparrow", "downarrow", "backspace", "pagedown", "pageup", "home", "end", "insert",
			"delete", "capslock", "numlock", "printscreen", "scrolllock", "pause", "numpadenter", "numpaddivide", "numpadmultiply", "numpadplus",
			"numpadminus", "numpadperiod", "numpadequals", "numpad0", "numpad1", "numpad2", "numpad3", "numpad4", "numpad5", "numpad6",
			"numpad7", "numpad8", "numpad9", "f1", "f2", "f3", "f4", "f5", "f6", "f7",
			"f8", "f9", "f10", "f11", "f12", "oem1", "oem2", "oem3", "oem4", "oem5",
			"IMESelectedObsoleteKey", "f13", "f14", "f15", "f16", "f17", "f18", "f19", "f20", "f21",
			"f22", "f23", "f24", "mediaPlayPause", "mediaRewind", "mediaForward"
		};
		m_Keys = new KeyControl[array.Length];
		for (int i = 0; i < array.Length; i++)
		{
			m_Keys[i] = GetChildControl<KeyControl>(array[i]);
			m_Keys[i].keyCode = (Key)(i + 1);
		}
		anyKey = GetChildControl<AnyKeyControl>("anyKey");
		shiftKey = GetChildControl<ButtonControl>("shift");
		ctrlKey = GetChildControl<ButtonControl>("ctrl");
		altKey = GetChildControl<ButtonControl>("alt");
		imeSelected = GetChildControl<ButtonControl>("IMESelected");
		base.FinishSetup();
	}

	protected override void RefreshConfiguration()
	{
		keyboardLayout = null;
		QueryKeyboardLayoutCommand command = QueryKeyboardLayoutCommand.Create();
		if (ExecuteCommand(ref command) >= 0)
		{
			keyboardLayout = command.ReadLayoutName();
		}
	}

	public void OnTextInput(char character)
	{
		for (int i = 0; i < m_TextInputListeners.length; i++)
		{
			m_TextInputListeners[i](character);
		}
	}

	public KeyControl FindKeyOnCurrentKeyboardLayout(string displayName)
	{
		ReadOnlyArray<KeyControl> readOnlyArray = allKeys;
		for (int i = 0; i < readOnlyArray.Count; i++)
		{
			if (string.Equals(readOnlyArray[i].displayName, displayName, StringComparison.CurrentCultureIgnoreCase))
			{
				return readOnlyArray[i];
			}
		}
		return null;
	}

	public void OnIMECompositionChanged(IMECompositionString compositionString)
	{
		if (m_ImeCompositionListeners.length > 0)
		{
			for (int i = 0; i < m_ImeCompositionListeners.length; i++)
			{
				m_ImeCompositionListeners[i](compositionString);
			}
		}
	}

	unsafe bool IEventPreProcessor.PreProcessEvent(InputEventPtr currentEventPtr)
	{
		if (currentEventPtr.type == 1398030676)
		{
			StateEvent* ptr = StateEvent.FromUnchecked(currentEventPtr);
			if (ptr->stateFormat == KeyboardState.Format)
			{
				KeyboardState* ptr2 = (KeyboardState*)ptr->stateData;
				if (ptr2->Get(Key.IMESelected))
				{
					ptr2->Set(Key.IMESelected, state: false);
					ptr2->Set((Key)127, state: true);
				}
			}
		}
		return true;
	}
}
