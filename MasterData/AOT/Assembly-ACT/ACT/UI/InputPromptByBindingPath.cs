using System;
using ACT.Battle;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.Serialization;

namespace ACT.UI;

public class InputPromptByBindingPath : UIBehaviour
{
	[SerializeField]
	[FormerlySerializedAs("InputActionPath")]
	private string _inputActionPath;

	[SerializeField]
	[FormerlySerializedAs("InputBindingIndex")]
	private int inputBindingIndex;

	[SerializeField]
	[FormerlySerializedAs("InputIcon")]
	private BImage _inputIcon;

	public Action onBindingPathChanged;

	public int InputBindingIndex
	{
		get
		{
			return inputBindingIndex;
		}
		set
		{
			inputBindingIndex = value;
		}
	}

	public string InputActionPath
	{
		get
		{
			return _inputActionPath;
		}
		set
		{
			if (!(_inputActionPath == value))
			{
				_inputActionPath = value;
				onBindingPathChanged?.Invoke();
			}
		}
	}

	protected override void Start()
	{
		base.Start();
		MonoECS.instance.onInputModeChange.AddListener(OnInputDeviceChange);
		Refresh();
	}

	protected override void OnDestroy()
	{
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputDeviceChange);
	}

	private void OnInputDeviceChange(DeviceInputMode arg0)
	{
		Refresh();
	}

	public bool TryGetAction(out InputAction inputAction)
	{
		inputAction = MonoECS.instance.inputActionAsset.FindAction(_inputActionPath);
		if (inputAction == null)
		{
			return false;
		}
		return true;
	}

	public bool TryGetBinding(out InputBinding binding)
	{
		binding = default;
		InputAction inputAction = MonoECS.instance.inputActionAsset.FindAction(_inputActionPath);
		if (inputAction == null)
		{
			return false;
		}
		if (inputBindingIndex >= 0 && inputAction.bindings.Count > 0 && inputAction.bindings.Count > inputBindingIndex)
		{
			binding = inputAction.bindings[inputBindingIndex];
			return true;
		}
		return false;
	}

	public void Refresh()
	{
		if (!TryGetBinding(out var binding))
		{
			OnGetInputIcon(success: false, null, MonoECS.instance.GetPromptIconDevice());
			return;
		}
		MonoECS.CorrectBindingPath(binding.effectivePath, out var _, out var path);
		MonoECS.instance.GetInputBindingIcon(path, OnGetInputIcon);
	}

	private void OnGetInputIcon(bool success, Sprite sprite, InputDevice device)
	{
		_inputIcon.icon.sprite = sprite;
		_inputIcon.icon.gameObject.SetActive(success);
		if (sprite != null)
		{
			_inputIcon.icon.SetNativeSize();
		}
	}
}
