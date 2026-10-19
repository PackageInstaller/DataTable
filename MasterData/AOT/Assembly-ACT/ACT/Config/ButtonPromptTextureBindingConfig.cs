using System;
using System.Collections.Generic;
using ACT.Battle;
using Bamboo.AssetField;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.DualShock;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace ACT.Config;

[Serializable]
[CreateAssetMenu(fileName = "ButtonPromptTextureBindingConfig", menuName = "ButtonPromptTextureBindingConfig")]
internal class ButtonPromptTextureBindingConfig : LuminSerializedScriptableObject
{
	internal interface IButtonPromptTexture
	{
		string GetDefine();

		YooAssetReference GetDefaultIconRef();

		YooAssetReference GetIconRef(InputDevice device);

		AssetLoadHandle GetIconLoadHandle(YooAssetReference assetReference);
	}

	[Serializable]
	internal class GamepadButtonTexture : IButtonPromptTexture
	{
		private const string TypeTemplate = "Gamepad/{0}";

		[SerializeField]
		public int codeDef;

		[SerializeField]
		public YooAssetReference xboxIconRef;

		[SerializeField]
		public YooAssetReference psIconRef;

		private AssetLoadHandle _xboxLoadHandle;

		private AssetLoadHandle _psLoadHandle;

		public string GetDefine()
		{
			return $"Gamepad/{(GamepadInputCode)codeDef}";
		}

		YooAssetReference IButtonPromptTexture.GetDefaultIconRef()
		{
			return xboxIconRef;
		}

		YooAssetReference IButtonPromptTexture.GetIconRef(InputDevice device)
		{
			if (device is DualShockGamepad)
			{
				return psIconRef;
			}
			return xboxIconRef;
		}

		public AssetLoadHandle GetIconLoadHandle(YooAssetReference assetReference)
		{
			if (assetReference.RuntimeKeyIsValid())
			{
				AssetLoadHandle psLoadHandle;
				if (assetReference.Equals(psIconRef))
				{
					psLoadHandle = _psLoadHandle;
					if (!psLoadHandle.IsValid)
					{
						_psLoadHandle = AssetStationManager.BattleStation.LoadAsync<Sprite>(assetReference);
					}
					return _psLoadHandle;
				}
				psLoadHandle = _xboxLoadHandle;
				if (!psLoadHandle.IsValid)
				{
					_xboxLoadHandle = AssetStationManager.BattleStation.LoadAsync<Sprite>(assetReference);
				}
				return _xboxLoadHandle;
			}
			return default;
		}
	}

	[Serializable]
	internal class KeyboardButtonTexture : IButtonPromptTexture
	{
		private const string TypeTemplate = "Keyboard/{0}";

		[SerializeField]
		public int codeDef;

		[SerializeField]
		public YooAssetReference iconRef;

		private AsyncOperationHandle<Sprite> _asyncLoadOperation;

		private OnButtonPromptTextureLoaded _loadedCallbacks;

		private AssetLoadHandle _assetLoadHandle;

		public string GetDefine()
		{
			return $"Keyboard/{(KeyboardInputCode)codeDef}";
		}

		public YooAssetReference GetDefaultIconRef()
		{
			return iconRef;
		}

		public YooAssetReference GetIconRef(InputDevice device)
		{
			return iconRef;
		}

		public AssetLoadHandle GetIconLoadHandle(YooAssetReference assetReference)
		{
			if (assetReference.RuntimeKeyIsValid())
			{
				AssetLoadHandle assetLoadHandle = _assetLoadHandle;
				if (!assetLoadHandle.IsValid)
				{
					_assetLoadHandle = AssetStationManager.BattleStation.LoadAsync<Sprite>(assetReference);
				}
			}
			return _assetLoadHandle;
		}

		private void OnIconLoaded(AsyncOperationHandle<Sprite> handle)
		{
			handle.Release();
			NotifyResult(_loadedCallbacks);
		}

		private void NotifyResult(OnButtonPromptTextureLoaded callback)
		{
			Sprite sprite = ((_assetLoadHandle.IsValid && _assetLoadHandle.IsDone) ? _assetLoadHandle.As<Sprite>() : null);
			callback?.Invoke(sprite != null, sprite, MonoECS.instance.GetPromptIconDevice());
		}
	}

	[Serializable]
	internal class MouseButtonTexture : IButtonPromptTexture
	{
		private const string TypeTemplate = "Mouse/{0}";

		[SerializeField]
		public int codeDef;

		[SerializeField]
		public YooAssetReference iconRef;

		private AsyncOperationHandle<Sprite> _asyncLoadOperation;

		private OnButtonPromptTextureLoaded _loadedCallbacks;

		private AssetLoadHandle _assetLoadHandle;

		public string GetDefine()
		{
			return $"Mouse/{(MouseInputCode)codeDef}";
		}

		public YooAssetReference GetDefaultIconRef()
		{
			return iconRef;
		}

		public YooAssetReference GetIconRef(InputDevice device)
		{
			return iconRef;
		}

		public AssetLoadHandle GetIconLoadHandle(YooAssetReference assetReference)
		{
			if (assetReference.RuntimeKeyIsValid())
			{
				AssetLoadHandle assetLoadHandle = _assetLoadHandle;
				if (!assetLoadHandle.IsValid)
				{
					_assetLoadHandle = AssetStationManager.BattleStation.LoadAsync<Sprite>(assetReference);
				}
			}
			return _assetLoadHandle;
		}

		private void OnIconLoaded(AsyncOperationHandle<Sprite> handle)
		{
			handle.Release();
			NotifyResult(_loadedCallbacks);
		}

		private void NotifyResult(OnButtonPromptTextureLoaded callback)
		{
			Sprite sprite = ((_assetLoadHandle.IsValid && _assetLoadHandle.IsDone) ? _assetLoadHandle.As<Sprite>() : null);
			callback?.Invoke(sprite != null, sprite, MonoECS.instance.GetPromptIconDevice());
		}
	}

	internal enum MouseInputCode
	{
		LeftButton = 0,
		RightButton = 1,
		MiddleButton = 2,
		ForwardButton = 3,
		BackButton = 4,
		ScrollY = 10,
		ScrollUp = 11,
		ScrollDown = 12
	}

	internal enum KeyboardInputCode
	{
		A = 15,
		B = 16,
		C = 17,
		D = 18,
		E = 19,
		F = 20,
		G = 21,
		H = 22,
		I = 23,
		J = 24,
		K = 25,
		L = 26,
		M = 27,
		N = 28,
		O = 29,
		P = 30,
		Q = 31,
		R = 32,
		S = 33,
		T = 34,
		U = 35,
		V = 36,
		W = 37,
		X = 38,
		Y = 39,
		Z = 40,
		Digit1 = 41,
		Digit2 = 42,
		Digit3 = 43,
		Digit4 = 44,
		Digit5 = 45,
		Digit6 = 46,
		Digit7 = 47,
		Digit8 = 48,
		Digit9 = 49,
		Digit0 = 50,
		F1 = 94,
		F2 = 95,
		F3 = 96,
		F4 = 97,
		F5 = 98,
		F6 = 99,
		F7 = 100,
		F8 = 101,
		F9 = 102,
		F10 = 103,
		F11 = 104,
		F12 = 105,
		DownArrow = 64,
		LeftArrow = 61,
		RightArrow = 62,
		UpArrow = 63,
		LeftCtrl = 55,
		RightCtrl = 56,
		LeftAlt = 53,
		RightAlt = 54,
		LeftShift = 51,
		RightShift = 52,
		Escape = 60,
		Space = 1,
		Tab = 3,
		CapsLock = 72,
		Del = 71,
		End = 69,
		Home = 68,
		Insert = 70,
		PageDown = 66,
		PageUp = 67,
		BackQuote = 4,
		RightBracket = 12,
		LeftBracket = 11,
		Comma = 7,
		Equals = 14,
		Minus = 13,
		Period = 8,
		Semicolon = 6,
		Quote = 5,
		Slash = 9,
		BackSlash = 10
	}

	internal enum GamepadInputCode
	{
		DpadUp = 0,
		DpadDown = 1,
		DpadLeft = 2,
		DpadRight = 3,
		North = 4,
		East = 5,
		South = 6,
		West = 7,
		LeftStick = 8,
		LeftStickPress = 108,
		LeftStickUp = 109,
		LeftStickDown = 110,
		LeftStickLeft = 111,
		LeftStickRight = 112,
		LeftStickY = 113,
		LeftStickX = 114,
		RightStick = 9,
		RightStickPress = 209,
		RightStickUp = 210,
		RightStickDown = 211,
		RightStickLeft = 212,
		RightStickRight = 213,
		RightStickY = 214,
		RightStickX = 215,
		LeftShoulder = 10,
		RightShoulder = 11,
		Start = 12,
		Select = 13,
		LeftTrigger = 32,
		RightTrigger = 33
	}

	[SerializeField]
	[HideInInspector]
	private List<KeyboardButtonTexture> keyboardButtonIconBindings;

	[SerializeField]
	[HideInInspector]
	private List<MouseButtonTexture> mouseButtonIconBindings;

	[SerializeField]
	[HideInInspector]
	private List<GamepadButtonTexture> gamepadButtonIconBindings;

	private Dictionary<string, IButtonPromptTexture> _iconBindingMap;

	private const string GamepadNorthButton = "gamepad/north";

	private const string GamepadEastButton = "gamepad/east";

	private const string GamepadSouthButton = "gamepad/south";

	private const string GamepadWestButton = "gamepad/west";

	private static readonly Dictionary<string, string> SwitchProControllerBindingReverseMap = new Dictionary<string, string>
	{
		{ "gamepad/north", "gamepad/west" },
		{ "gamepad/west", "gamepad/north" },
		{ "gamepad/south", "gamepad/east" },
		{ "gamepad/east", "gamepad/south" }
	};

	private void InitBindingMap()
	{
		if (_iconBindingMap != null)
		{
			return;
		}
		_iconBindingMap = new Dictionary<string, IButtonPromptTexture>();
		foreach (KeyboardButtonTexture keyboardButtonIconBinding in keyboardButtonIconBindings)
		{
			_iconBindingMap[keyboardButtonIconBinding.GetDefine().ToLower() ?? ""] = keyboardButtonIconBinding;
		}
		foreach (MouseButtonTexture mouseButtonIconBinding in mouseButtonIconBindings)
		{
			_iconBindingMap[mouseButtonIconBinding.GetDefine().ToLower() ?? ""] = mouseButtonIconBinding;
		}
		foreach (GamepadButtonTexture gamepadButtonIconBinding in gamepadButtonIconBindings)
		{
			_iconBindingMap[gamepadButtonIconBinding.GetDefine().ToLower() ?? ""] = gamepadButtonIconBinding;
		}
	}

	public void GetInputBindingIconAsync(string bindingName, OnButtonPromptTextureLoaded onGetInputDeviceButtonIcon)
	{
		InitBindingMap();
		InputDevice promptIconDevice = MonoECS.instance.GetPromptIconDevice();
		if (_iconBindingMap.TryGetValue(bindingName, out var value))
		{
			AssetLoadHandle iconLoadHandle = value.GetIconLoadHandle(value.GetDefaultIconRef());
			if (!iconLoadHandle.IsValid)
			{
				onGetInputDeviceButtonIcon?.Invoke(success: false, null, promptIconDevice);
				return;
			}
			iconLoadHandle.Completed += (AssetLoadHandle operation) =>
			{
				Sprite sprite = operation.Result as Sprite;
				onGetInputDeviceButtonIcon?.Invoke(sprite != null, sprite, promptIconDevice);
			};
		}
		else
		{
			onGetInputDeviceButtonIcon?.Invoke(success: false, null, promptIconDevice);
		}
	}

	private static string CorrectBindingKeyNameByActiveDevice(string bindingName)
	{
		if (MonoECS.IsSwitchProDevice(MonoECS.instance.GetPromptIconDevice()) && SwitchProControllerBindingReverseMap.TryGetValue(bindingName, out var value))
		{
			bindingName = value;
		}
		return bindingName;
	}

	public void GetInputDeviceButtonIconAsync(string bindingName, InputDevice device, OnButtonPromptTextureLoaded onGetInputDeviceButtonIcon)
	{
		InitBindingMap();
		if (_iconBindingMap.TryGetValue(bindingName, out var value))
		{
			YooAssetReference iconRef = value.GetIconRef(device);
			if ((object)iconRef != null)
			{
				AssetLoadHandle iconLoadHandle = value.GetIconLoadHandle(iconRef);
				if (!iconLoadHandle.IsValid)
				{
					onGetInputDeviceButtonIcon?.Invoke(success: false, null, device);
					return;
				}
				iconLoadHandle.Completed += (AssetLoadHandle operation) =>
				{
					Sprite sprite = operation.Result as Sprite;
					onGetInputDeviceButtonIcon?.Invoke(sprite != null, sprite, device);
				};
				return;
			}
		}
		onGetInputDeviceButtonIcon(success: false, null, device);
	}
}
