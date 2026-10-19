using ACT.Battle;
using ACT.UI.InputController;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace ACT.ViewControl;

public sealed class SelectedUGUI : UIBehaviour, ISelectHandler, IEventSystemHandler, IDeselectHandler
{
	public GameObject Selected;

	public GameObject gamePadArrow;

	public UnityEvent OnSelected;

	public UnityEvent OnDeselected;

	protected override void Awake()
	{
		if ((bool)MonoECS.instance)
		{
			MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		}
	}

	protected override void OnDestroy()
	{
		if ((bool)MonoECS.instance)
		{
			MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		}
	}

	private void OnInputModeChanged(DeviceInputMode arg0)
	{
		RefreshVisible((bool)EventSystemHelper.Shared && EventSystemHelper.CurrentSelected == gameObject);
	}

	protected override void OnEnable()
	{
		RefreshVisible((bool)EventSystemHelper.Shared && EventSystemHelper.CurrentSelected == gameObject);
	}

	protected override void OnDisable()
	{
		RefreshVisible((bool)EventSystemHelper.Shared && EventSystemHelper.CurrentSelected == gameObject);
	}

	void ISelectHandler.OnSelect(BaseEventData eventData)
	{
		if (!(eventData is PointerEventData))
		{
			OnSelected?.Invoke();
			RefreshVisible(visible: true);
		}
	}

	void IDeselectHandler.OnDeselect(BaseEventData eventData)
	{
		if (!(eventData is PointerEventData))
		{
			OnDeselected?.Invoke();
			RefreshVisible(visible: false);
		}
	}

	private void RefreshVisible(bool visible)
	{
		if ((bool)Selected)
		{
			Selected.SetActive(visible && MonoECS.instance.InputMode != DeviceInputMode.TouchScreen && MonoECS.instance.InputMode != DeviceInputMode.Unknown);
		}
		if ((bool)gamePadArrow)
		{
			gamePadArrow.SetActive(visible && MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		}
	}
}
