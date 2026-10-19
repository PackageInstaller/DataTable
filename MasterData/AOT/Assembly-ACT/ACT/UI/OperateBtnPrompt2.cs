using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Utility;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class OperateBtnPrompt2 : UIBehaviour
{
	[Flags]
	public enum InputDevice
	{
		None = 0,
		TouchScreen = 1,
		KeyboardAndMouse = 2,
		Gamepad = 4
	}

	[Serializable]
	public class PromptData
	{
		public BImage InputIcon;

		public string InputActionPath;
	}

	[Serializable]
	public class State
	{
		private int state;
	}

	public List<PromptData> PromptDatas = new List<PromptData>();

	public LocalizeStringEvent des;

	public InputDevice allowInputDevice = InputDevice.KeyboardAndMouse | InputDevice.Gamepad;

	private bool _forceVisible = true;

	protected override void Start()
	{
		base.Start();
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		RefreshState();
		RefreshIcon();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
	}

	private void OnInputModeChanged(DeviceInputMode arg0)
	{
		RefreshState();
		RefreshIcon();
	}

	private void RefreshState()
	{
		bool flag = false;
		foreach (PromptData promptData in PromptDatas)
		{
			if (promptData.InputIcon.icon.sprite != null)
			{
				flag = true;
				break;
			}
		}
		DeviceInputMode inputMode = MonoECS.instance.InputMode;
		InputDevice inputDevice = InputDevice.None;
		bool flag2 = ((inputMode switch
		{
			DeviceInputMode.Gamepad => InputDevice.Gamepad, 
			DeviceInputMode.TouchScreen => InputDevice.TouchScreen, 
			DeviceInputMode.KeyboardAndMouse => InputDevice.KeyboardAndMouse, 
			_ => InputDevice.None, 
		}) & allowInputDevice) != 0;
		ScreenSizeMode deviceScreenType = MonoECS.instance.DeviceScreenType;
		bool flag3 = false;
		flag3 = MonoECS.instance.ispc || ((deviceScreenType == ScreenSizeMode.LargeScreen) ? (inputMode != DeviceInputMode.TouchScreen) : (inputMode == DeviceInputMode.Gamepad));
		flag3 &= flag2;
		gameObject.SetActive(_forceVisible & flag3 & flag);
	}

	public void RefreshIcon()
	{
		foreach (PromptData promptData2 in PromptDatas)
		{
			promptData2.InputIcon.icon.sprite = null;
			promptData2.InputIcon.icon.gameObject.SetActive(value: false);
		}
		foreach (PromptData promptData in PromptDatas)
		{
			if (string.IsNullOrEmpty(promptData.InputActionPath))
			{
				promptData.InputIcon.icon.sprite = null;
				promptData.InputIcon.icon.gameObject.SetActive(value: false);
				continue;
			}
			if (MonoECS.instance.inputActionAsset.FindAction(promptData.InputActionPath) == null)
			{
				promptData.InputIcon.icon.sprite = null;
				promptData.InputIcon.icon.gameObject.SetActive(value: false);
				continue;
			}
			promptData.InputIcon.icon.sprite = null;
			promptData.InputIcon.icon.gameObject.SetActive(value: false);
			MonoECS.instance.GetInputDeviceButtonIconAsync(promptData.InputActionPath, (bool result, Sprite sprite, UnityEngine.InputSystem.InputDevice device) =>
			{
				promptData.InputIcon.icon.sprite = sprite;
				promptData.InputIcon.icon.gameObject.SetActive(result);
				promptData.InputIcon.icon.SetNativeSize();
				RefreshState();
			});
		}
	}

	public void SetPromptActive(bool active)
	{
		_forceVisible = active;
		RefreshState();
	}

	public void SetPromptDes(LocalizeTable tableType, int tableEntryReference)
	{
		des?.SetTable(tableType);
		if (des?.StringReference != null)
		{
			des.StringReference.TableEntryReference = tableEntryReference;
		}
	}
}
