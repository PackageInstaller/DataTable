using System;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

public struct KeyboardState : IInputStateTypeInfo
{
	private const int kSizeInBits = 110;

	internal const int kSizeInBytes = 14;

	[InputControl(name = "d", displayName = "D", layout = "Key", bit = 18u)]
	[InputControl(name = "rightArrow", displayName = "Right Arrow", layout = "Key", bit = 62u)]
	[InputControl(name = "a", displayName = "A", layout = "Key", bit = 15u)]
	[InputControl(name = "b", displayName = "B", layout = "Key", bit = 16u)]
	[InputControl(name = "c", displayName = "C", layout = "Key", bit = 17u)]
	[InputControl(name = "leftArrow", displayName = "Left Arrow", layout = "Key", bit = 61u)]
	[InputControl(name = "e", displayName = "E", layout = "Key", bit = 19u)]
	[InputControl(name = "n", displayName = "N", layout = "Key", bit = 28u)]
	[InputControl(name = "g", displayName = "G", layout = "Key", bit = 21u)]
	[InputControl(name = "h", displayName = "H", layout = "Key", bit = 22u)]
	[InputControl(name = "i", displayName = "I", layout = "Key", bit = 23u)]
	[InputControl(name = "j", displayName = "J", layout = "Key", bit = 24u)]
	[InputControl(name = "k", displayName = "K", layout = "Key", bit = 25u)]
	[InputControl(name = "l", displayName = "L", layout = "Key", bit = 26u)]
	[InputControl(name = "m", displayName = "M", layout = "Key", bit = 27u)]
	[InputControl(name = "t", displayName = "T", layout = "Key", bit = 34u)]
	[InputControl(name = "s", displayName = "S", layout = "Key", bit = 33u)]
	[InputControl(name = "r", displayName = "R", layout = "Key", bit = 32u)]
	[InputControl(name = "q", displayName = "Q", layout = "Key", bit = 31u)]
	[InputControl(name = "p", displayName = "P", layout = "Key", bit = 30u)]
	[InputControl(name = "f", displayName = "F", layout = "Key", bit = 20u)]
	[InputControl(name = "o", displayName = "O", layout = "Key", bit = 29u)]
	[InputControl(name = "contextMenu", displayName = "Context Menu", layout = "Key", usage = "Modifier", bit = 59u)]
	[InputControl(name = "IMESelected", layout = "Button", bit = 111u, synthetic = true)]
	[InputControl(name = "numpadMultiply", displayName = "Numpad *", layout = "Key", bit = 79u)]
	[InputControl(name = "numpadPlus", displayName = "Numpad +", layout = "Key", bit = 80u)]
	[InputControl(name = "numpadMinus", displayName = "Numpad -", layout = "Key", bit = 81u)]
	[InputControl(name = "leftAlt", displayName = "Left Alt", layout = "Key", usage = "Modifier", bit = 53u)]
	[InputControl(name = "shift", displayName = "Shift", layout = "DiscreteButton", usage = "Modifier", bit = 51u, sizeInBits = 2u, synthetic = true, parameters = "minValue=1,maxValue=3,writeMode=1")]
	[InputControl(name = "rightShift", displayName = "Right Shift", layout = "Key", usage = "Modifier", bit = 52u)]
	[InputControl(name = "leftShift", displayName = "Left Shift", layout = "Key", usage = "Modifier", bit = 51u)]
	[InputControl(name = "0", displayName = "0", layout = "Key", bit = 50u)]
	[InputControl(name = "9", displayName = "9", layout = "Key", bit = 49u)]
	[InputControl(name = "8", displayName = "8", layout = "Key", bit = 48u)]
	[InputControl(name = "7", displayName = "7", layout = "Key", bit = 47u)]
	[InputControl(name = "6", displayName = "6", layout = "Key", bit = 46u)]
	[InputControl(name = "5", displayName = "5", layout = "Key", bit = 45u)]
	[InputControl(name = "4", displayName = "4", layout = "Key", bit = 44u)]
	[InputControl(name = "3", displayName = "3", layout = "Key", bit = 43u)]
	[InputControl(name = "rightAlt", displayName = "Right Alt", layout = "Key", usage = "Modifier", bit = 54u, alias = "AltGr")]
	[InputControl(name = "2", displayName = "2", layout = "Key", bit = 42u)]
	[InputControl(name = "alt", displayName = "Alt", layout = "DiscreteButton", usage = "Modifier", bit = 53u, sizeInBits = 2u, synthetic = true, parameters = "minValue=1,maxValue=3,writeMode=1")]
	[InputControl(name = "numpadEnter", displayName = "Numpad Enter", layout = "Key", bit = 77u)]
	[InputControl(name = "pageDown", displayName = "Page Down", layout = "Key", bit = 66u)]
	[InputControl(name = "pageUp", displayName = "Page Up", layout = "Key", bit = 67u)]
	[InputControl(name = "home", displayName = "Home", layout = "Key", bit = 68u)]
	[InputControl(name = "end", displayName = "End", layout = "Key", bit = 69u)]
	[InputControl(name = "insert", displayName = "Insert", layout = "Key", bit = 70u)]
	[InputControl(name = "delete", displayName = "Delete", layout = "Key", bit = 71u)]
	[InputControl(name = "capsLock", displayName = "Caps Lock", layout = "Key", bit = 72u)]
	[InputControl(name = "numLock", displayName = "Num Lock", layout = "Key", bit = 73u)]
	[InputControl(name = "printScreen", displayName = "Print Screen", layout = "Key", bit = 74u)]
	[InputControl(name = "scrollLock", displayName = "Scroll Lock", layout = "Key", bit = 75u)]
	[InputControl(name = "pause", displayName = "Pause/Break", layout = "Key", bit = 76u)]
	[InputControl(name = "leftMeta", displayName = "Left System", layout = "Key", usage = "Modifier", bit = 57u, aliases = new string[] { "LeftWindows", "LeftApple", "LeftCommand" })]
	[InputControl(name = "ctrl", displayName = "Control", layout = "DiscreteButton", usage = "Modifier", bit = 55u, sizeInBits = 2u, synthetic = true, parameters = "minValue=1,maxValue=3,writeMode=1")]
	[InputControl(name = "rightCtrl", displayName = "Right Control", layout = "Key", usage = "Modifier", bit = 56u)]
	[InputControl(name = "leftCtrl", displayName = "Left Control", layout = "Key", usage = "Modifier", bit = 55u)]
	[InputControl(name = "numpadDivide", displayName = "Numpad /", layout = "Key", bit = 78u)]
	[InputControl(name = "rightMeta", displayName = "Right System", layout = "Key", usage = "Modifier", bit = 58u, aliases = new string[] { "RightWindows", "RightApple", "RightCommand" })]
	[InputControl(name = "1", displayName = "1", layout = "Key", bit = 41u)]
	[InputControl(name = "y", displayName = "Y", layout = "Key", bit = 39u)]
	[InputControl(name = "f4", displayName = "F4", layout = "Key", bit = 97u)]
	[InputControl(name = "f5", displayName = "F5", layout = "Key", bit = 98u)]
	[InputControl(name = "f6", displayName = "F6", layout = "Key", bit = 99u)]
	[InputControl(name = "f7", displayName = "F7", layout = "Key", bit = 100u)]
	[InputControl(name = "f8", displayName = "F8", layout = "Key", bit = 101u)]
	[InputControl(name = "f9", displayName = "F9", layout = "Key", bit = 102u)]
	[InputControl(name = "f10", displayName = "F10", layout = "Key", bit = 103u)]
	[InputControl(name = "f11", displayName = "F11", layout = "Key", bit = 104u)]
	[InputControl(name = "f12", displayName = "F12", layout = "Key", bit = 105u)]
	[InputControl(name = "OEM1", layout = "Key", bit = 106u)]
	[InputControl(name = "OEM2", layout = "Key", bit = 107u)]
	[InputControl(name = "OEM3", layout = "Key", bit = 108u)]
	[InputControl(name = "OEM4", layout = "Key", bit = 109u)]
	[InputControl(name = "downArrow", displayName = "Down Arrow", layout = "Key", bit = 64u)]
	[InputControl(name = "OEM5", layout = "Key", bit = 110u)]
	[InputControl(name = "f3", displayName = "F3", layout = "Key", bit = 96u)]
	[InputControl(name = "z", displayName = "Z", layout = "Key", bit = 40u)]
	[InputControl(name = "f2", displayName = "F2", layout = "Key", bit = 95u)]
	[InputControl(name = "numpad0", displayName = "Numpad 0", layout = "Key", bit = 84u)]
	[InputControl(name = "x", displayName = "X", layout = "Key", bit = 38u)]
	[InputControl(name = "w", displayName = "W", layout = "Key", bit = 37u)]
	[InputControl(name = "v", displayName = "V", layout = "Key", bit = 36u)]
	[InputControl(name = "u", displayName = "U", layout = "Key", bit = 35u)]
	[InputControl(name = "numpadPeriod", displayName = "Numpad .", layout = "Key", bit = 82u)]
	[InputControl(name = "numpadEquals", displayName = "Numpad =", layout = "Key", bit = 83u)]
	[InputControl(name = "numpad1", displayName = "Numpad 1", layout = "Key", bit = 85u)]
	[InputControl(name = "numpad2", displayName = "Numpad 2", layout = "Key", bit = 86u)]
	[InputControl(name = "numpad3", displayName = "Numpad 3", layout = "Key", bit = 87u)]
	[InputControl(name = "numpad4", displayName = "Numpad 4", layout = "Key", bit = 88u)]
	[InputControl(name = "numpad5", displayName = "Numpad 5", layout = "Key", bit = 89u)]
	[InputControl(name = "numpad6", displayName = "Numpad 6", layout = "Key", bit = 90u)]
	[InputControl(name = "numpad7", displayName = "Numpad 7", layout = "Key", bit = 91u)]
	[InputControl(name = "numpad8", displayName = "Numpad 8", layout = "Key", bit = 92u)]
	[InputControl(name = "numpad9", displayName = "Numpad 9", layout = "Key", bit = 93u)]
	[InputControl(name = "f1", displayName = "F1", layout = "Key", bit = 94u)]
	[InputControl(name = "upArrow", displayName = "Up Arrow", layout = "Key", bit = 63u)]
	[InputControl(name = "backspace", displayName = "Backspace", layout = "Key", bit = 65u)]
	[InputControl(name = "minus", displayName = "-", layout = "Key", bit = 13u)]
	[InputControl(name = "anyKey", displayName = "Any Key", layout = "AnyKey", sizeInBits = 109u, synthetic = true)]
	[InputControl(name = "escape", displayName = "Escape", layout = "Key", usages = new string[] { "Back", "Cancel" }, bit = 60u)]
	[InputControl(name = "space", displayName = "Space", layout = "Key", bit = 1u)]
	[InputControl(name = "enter", displayName = "Enter", layout = "Key", usage = "Submit", bit = 2u)]
	[InputControl(name = "tab", displayName = "Tab", layout = "Key", bit = 3u)]
	[InputControl(name = "backquote", displayName = "`", layout = "Key", bit = 4u)]
	[InputControl(name = "quote", displayName = "'", layout = "Key", bit = 5u)]
	[InputControl(name = "comma", displayName = ",", layout = "Key", bit = 7u)]
	[InputControl(name = "period", displayName = ".", layout = "Key", bit = 8u)]
	[InputControl(name = "slash", displayName = "/", layout = "Key", bit = 9u)]
	[InputControl(name = "backslash", displayName = "\\", layout = "Key", bit = 10u)]
	[InputControl(name = "leftBracket", displayName = "[", layout = "Key", bit = 11u)]
	[InputControl(name = "rightBracket", displayName = "]", layout = "Key", bit = 12u)]
	[InputControl(name = "semicolon", displayName = ";", layout = "Key", bit = 6u)]
	[InputControl(name = "equals", displayName = "=", layout = "Key", bit = 14u)]
	public unsafe fixed byte keys[14];

	public static FourCC Format => new FourCC('K', 'E', 'Y', 'S');

	public FourCC format => Format;

	public unsafe KeyboardState(params Key[] pressedKeys)
	{
		if (pressedKeys == null)
		{
			throw new ArgumentNullException("pressedKeys");
		}
		fixed (byte* ptr = keys)
		{
			UnsafeUtility.MemClear(ptr, 14L);
			for (int i = 0; i < pressedKeys.Length; i++)
			{
				MemoryHelpers.WriteSingleBit(ptr, (uint)pressedKeys[i], value: true);
			}
		}
	}

	public unsafe void Set(Key key, bool state)
	{
		fixed (byte* ptr = keys)
		{
			MemoryHelpers.WriteSingleBit(ptr, (uint)key, state);
		}
	}

	public void Press(Key key)
	{
		Set(key, state: true);
	}

	public void Release(Key key)
	{
		Set(key, state: false);
	}
}
