using System;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace T0World;

public class T0CookSelectItem : MonoBehaviour
{
	public HorusCookSelectEnum selectType = HorusCookSelectEnum.NONE;

	public Button selectBtn_;

	public bool isSelect;

	public bool isLock;

	private Action<HorusCookSelectEnum> clickCallback;

	private ControllerExCollection controllerEx;

	private ControllerEx selectController;

	private ControllerEx lockController;

	private void Awake()
	{
		controllerEx = GetComponent<ControllerExCollection>();
		if (controllerEx != null)
		{
			selectController = controllerEx.GetController("select");
			lockController = controllerEx.GetController("lock");
		}
		AddListener();
		InitData();
		RefreshUI();
	}

	private void Dispose()
	{
	}

	private void InitData()
	{
		isSelect = false;
		isLock = false;
	}

	public void RefreshUI()
	{
		if (selectController != null)
		{
			if (isSelect)
			{
				selectController.SetSelectedState("select");
			}
			else
			{
				selectController.SetSelectedState("unselect");
			}
		}
		if (lockController != null)
		{
			if (isLock)
			{
				lockController.SetSelectedState("lock");
			}
			else
			{
				lockController.SetSelectedState("unlock");
			}
		}
	}

	private void AddListener()
	{
		selectBtn_?.onClick.AddListener(OnSelectBtnClick);
	}

	private void OnSelectBtnClick()
	{
		if (!isLock)
		{
			clickCallback?.Invoke(selectType);
		}
	}

	public void SetClickCallback(Action<HorusCookSelectEnum> callback_)
	{
		clickCallback = callback_;
	}

	public HorusCookSelectEnum GetSelectType()
	{
		return selectType;
	}

	public bool GetSelectState()
	{
		return isSelect;
	}

	public void SetSelectState(bool select_)
	{
		isSelect = select_;
	}
}
