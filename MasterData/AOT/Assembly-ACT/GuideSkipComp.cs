using System;
using ACT.Battle;
using ACT.UI;
using ACT.Utility;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.Utilities;
using UnityEngine.UI;

public class GuideSkipComp : MonoBehaviour
{
	private const string SkipGuideInputAction = "Guide/ClickSkipGuide";

	public GameObject BtnSkipRoot;

	public ActButton BtnSkip;

	public Image SkipFilled;

	public GameObject BtnHandShankSkipRoot;

	public ActButton BtnHandShankSkip;

	public BImage ImageHandShankSkip;

	public Image HandShankSkipFilled;

	[SerializeField]
	[Min(0.01f)]
	private float skipLongPressDuration = 1f;

	private bool _isSkipLongPressing;

	private float _skipLongPressStartTime;

	private Action _onLongPressEnd;

	private bool _isInitialized;

	public bool CanSkip
	{
		get
		{
			if (_isInitialized)
			{
				return gameObject.activeInHierarchy;
			}
			return false;
		}
	}

	public void Init(Action onLongPressEnd, bool isShow)
	{
		UnInit();
		_onLongPressEnd = onLongPressEnd;
		gameObject.SetActive(isShow);
		if (isShow)
		{
			BindButton(BtnSkip);
			BindButton(BtnHandShankSkip);
			RefreshInputMode(MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
			MonoECS.instance?.onInputModeChange.AddListener(OnInputDeviceChange);
			MonoECS.instance?.OnActiveDeviceChange.AddListener(OnActiveDeviceChange);
			ResetSkipLongPressState();
			_isInitialized = true;
		}
	}

	public void UnInit()
	{
		if (_isInitialized)
		{
			MonoECS.instance?.onInputModeChange.RemoveListener(OnInputDeviceChange);
			MonoECS.instance?.OnActiveDeviceChange.RemoveListener(OnActiveDeviceChange);
		}
		UnbindButton(BtnSkip);
		UnbindButton(BtnHandShankSkip);
		ResetSkipLongPressState();
		ClearHandShankSkipIcon();
		_onLongPressEnd = null;
		_isInitialized = false;
	}

	private void Update()
	{
		if (_isSkipLongPressing)
		{
			float num = Mathf.Clamp01((Time.unscaledTime - _skipLongPressStartTime) / skipLongPressDuration);
			Image currentFillImage = GetCurrentFillImage();
			if (currentFillImage != null)
			{
				currentFillImage.fillAmount = num;
			}
			if (num >= 1f)
			{
				_isSkipLongPressing = false;
				OnLongPressEnd();
			}
		}
	}

	private void BindButton(ActButton button)
	{
		if (!(button == null))
		{
			button.SetBtnClick(null);
			button.OnLongPress.RemoveListener(OnLongPress);
			button.OnLongPress.AddListener(OnLongPress);
			button.OnUp.RemoveListener(OnUp);
			button.OnUp.AddListener(OnUp);
		}
	}

	private void UnbindButton(ActButton button)
	{
		if (!(button == null))
		{
			button.OnLongPress.RemoveListener(OnLongPress);
			button.OnUp.RemoveListener(OnUp);
		}
	}

	private void OnLongPress()
	{
		_isSkipLongPressing = true;
		_skipLongPressStartTime = Time.unscaledTime;
		Image currentFillImage = GetCurrentFillImage();
		if (!(currentFillImage == null))
		{
			currentFillImage.gameObject.SetActive(value: true);
			currentFillImage.fillAmount = 0f;
		}
	}

	public void BeginLongPress()
	{
		if (CanSkip)
		{
			OnLongPress();
		}
	}

	private void OnLongPressEnd()
	{
		Image currentFillImage = GetCurrentFillImage();
		if (currentFillImage != null)
		{
			currentFillImage.fillAmount = 1f;
		}
		_onLongPressEnd?.Invoke();
		ResetSkipLongPressState();
	}

	private void OnUp()
	{
		ResetSkipLongPressState();
	}

	public void EndLongPress()
	{
		ResetSkipLongPressState();
	}

	private void OnInputDeviceChange(DeviceInputMode inputMode)
	{
		RefreshInputMode(inputMode == DeviceInputMode.Gamepad);
	}

	private void OnActiveDeviceChange(ReadOnlyArray<InputDevice> _)
	{
		RefreshHandShankSkipIcon();
	}

	private void RefreshInputMode(bool isGamepad)
	{
		if (BtnSkip != null)
		{
			BtnSkipRoot.gameObject.SetActive(!isGamepad);
		}
		if (BtnHandShankSkip != null)
		{
			BtnHandShankSkipRoot.gameObject.SetActive(isGamepad);
		}
		RefreshHandShankSkipIcon();
		ResetSkipLongPressState();
	}

	private Image GetCurrentFillImage()
	{
		if (!(MonoECS.instance != null) || MonoECS.instance.InputMode != DeviceInputMode.Gamepad)
		{
			return SkipFilled;
		}
		return HandShankSkipFilled;
	}

	private void ResetSkipLongPressState()
	{
		_isSkipLongPressing = false;
		_skipLongPressStartTime = 0f;
		if (SkipFilled != null)
		{
			SkipFilled.gameObject.SetActive(value: false);
			SkipFilled.fillAmount = 0f;
		}
		if (HandShankSkipFilled != null)
		{
			HandShankSkipFilled.gameObject.SetActive(value: false);
			HandShankSkipFilled.fillAmount = 0f;
		}
	}

	private void RefreshHandShankSkipIcon()
	{
		if (!(ImageHandShankSkip?.icon == null))
		{
			if (MonoECS.instance == null || MonoECS.instance.InputMode != DeviceInputMode.Gamepad)
			{
				ClearHandShankSkipIcon();
				return;
			}
			ImageHandShankSkip.icon.sprite = null;
			ImageHandShankSkip.icon.gameObject.SetActive(value: false);
			MonoECS.instance.GetInputDeviceButtonIconAsync("Guide/ClickSkipGuide", OnGetHandShankSkipIcon);
		}
	}

	private void OnGetHandShankSkipIcon(bool success, Sprite icon, InputDevice device)
	{
		if (!(ImageHandShankSkip?.icon == null))
		{
			ImageHandShankSkip.icon.sprite = (success ? icon : null);
			ImageHandShankSkip.icon.gameObject.SetActive(success && icon != null);
			if (success && icon != null)
			{
				ImageHandShankSkip.icon.SetNativeSize();
			}
		}
	}

	private void ClearHandShankSkipIcon()
	{
		if (!(ImageHandShankSkip?.icon == null))
		{
			ImageHandShankSkip.icon.sprite = null;
			ImageHandShankSkip.icon.gameObject.SetActive(value: false);
		}
	}
}
