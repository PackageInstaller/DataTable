using System;
using ControllerExSpace;
using UnityEngine;

namespace T0World;

public class T0BathSelectItem : MonoBehaviour
{
	public HorusBathCharacterEnum characterType = HorusBathCharacterEnum.RANDOM;

	private ControllerExCollection controllerEx;

	private ControllerEx selectController;

	public bool isSelect;

	private Action<HorusBathCharacterEnum> clickCallback;

	private void Awake()
	{
		controllerEx = GetComponent<ControllerExCollection>();
		if (controllerEx != null)
		{
			selectController = controllerEx.GetController("select");
		}
		base.gameObject.layer = LayerMask.NameToLayer("Effect");
		UpdateSelectUI();
	}

	public void SetClickCallback(Action<HorusBathCharacterEnum> callback)
	{
		clickCallback = callback;
	}

	public void TriggerClick()
	{
		clickCallback?.Invoke(characterType);
	}

	public void SetSelectState(bool select)
	{
		isSelect = select;
	}

	public bool GetSelectState()
	{
		return isSelect;
	}

	public void UpdateSelectUI()
	{
		if (selectController != null)
		{
			if (isSelect)
			{
				selectController.SetSelectedState("select");
			}
			else
			{
				selectController.SetSelectedState("normal");
			}
		}
	}
}
