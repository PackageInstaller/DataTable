using ACT.Battle;
using ACT.Utility;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace ACT.UI;

public class TeamCharacterAddBtnV3 : MonoBehaviour, ISelectHandler, IEventSystemHandler, IDeselectHandler
{
	[SerializeField]
	private ActButton _addBtn;

	[SerializeField]
	private BetterAnimation _animation;

	[SerializeField]
	private CanvasGroup _canvasGroup;

	[SerializeField]
	private GameObject _gamePadHandle;

	[SerializeField]
	private GameObject _pcHandle;

	private const string Show = "show";

	private bool _playShow;

	private bool _isGamePadSelected;

	private void OnEnable()
	{
		MonoECS.instance?.onInputModeChange.AddListener(OnInputModeChanged);
		RefreshInputModeHandles();
	}

	private void OnDisable()
	{
		MonoECS.instance?.onInputModeChange.RemoveListener(OnInputModeChanged);
		SetGamePadSelected(selected: false);
	}

	public void DeActive()
	{
		_canvasGroup.alpha = 0f;
		SetBtnInteractable(interactable: false);
		_playShow = false;
		SetGamePadSelected(selected: false);
	}

	public void SetBtnInteractable(bool interactable)
	{
		_addBtn.Interactable(interactable);
	}

	public void SetCanvasGroup(bool show)
	{
		_canvasGroup.alpha = (show ? 1f : 0f);
		if (show && _animation != null && !_playShow)
		{
			_animation.GetSequence("show").Play();
		}
		_playShow = show;
		RefreshInputModeHandles();
	}

	public void AddEnterListener(UnityAction action)
	{
		_addBtn.OnEnter.AddListener(action);
	}

	public void RemoveEnterListener()
	{
		_addBtn.OnEnter.RemoveAllListeners();
	}

	public void AddExitListener(UnityAction action)
	{
		_addBtn.OnExit.AddListener(action);
	}

	public void RemoveExitListener()
	{
		_addBtn.OnExit.RemoveAllListeners();
	}

	public void AddClickListener(UnityAction action, string soundString)
	{
		_addBtn.SetBtnClick(action, soundString);
	}

	public void RemoveClickListener()
	{
		_addBtn.OnClick.RemoveAllListeners();
	}

	public void OnSubmit()
	{
		if (!(_addBtn == null) && _addBtn.gameObject.activeInHierarchy && _addBtn.interactable)
		{
			_addBtn.OnSubmit(null);
		}
	}

	public void OnSelect(BaseEventData eventData)
	{
		if (!(MonoECS.instance == null) && IsControllerInputMode())
		{
			SelectByGamePad();
		}
	}

	public void OnDeselect(BaseEventData eventData)
	{
		DeselectByGamePad();
	}

	public void SelectByGamePad()
	{
		if (!_isGamePadSelected)
		{
			SetGamePadSelected(selected: true);
			_addBtn.OnEnter?.Invoke();
		}
	}

	public void DeselectByGamePad()
	{
		if (_isGamePadSelected)
		{
			_addBtn.OnExit?.Invoke();
			SetGamePadSelected(selected: false);
		}
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		if (mode != DeviceInputMode.Gamepad && _isGamePadSelected)
		{
			DeselectByGamePad();
		}
		RefreshInputModeHandles();
	}

	private void SetGamePadSelected(bool selected)
	{
		_isGamePadSelected = selected;
		RefreshInputModeHandles();
	}

	private void RefreshInputModeHandles()
	{
		bool flag = _isGamePadSelected && IsEmptySeat();
		DeviceInputMode deviceInputMode = ((MonoECS.instance != null) ? MonoECS.instance.InputMode : DeviceInputMode.Unknown);
		if (_gamePadHandle != null)
		{
			_gamePadHandle.SetActive(flag && deviceInputMode == DeviceInputMode.Gamepad);
		}
		if (_pcHandle != null)
		{
			_pcHandle.SetActive(flag && deviceInputMode == DeviceInputMode.KeyboardAndMouse);
		}
	}

	private bool IsControllerInputMode()
	{
		if (MonoECS.instance.InputMode != DeviceInputMode.Gamepad)
		{
			return MonoECS.instance.InputMode == DeviceInputMode.KeyboardAndMouse;
		}
		return true;
	}

	private bool IsEmptySeat()
	{
		if (_canvasGroup != null)
		{
			return _canvasGroup.alpha > 0f;
		}
		return false;
	}
}
