using System;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace T0World;

public class T0CrocodileGameItem : MonoBehaviour
{
	public int itemIndex;

	public bool isPress;

	public Button itemButton;

	public Text indexText;

	private ControllerExCollection controllerEx;

	private ControllerEx selectController;

	private ControllerEx closeController;

	public Action<int> clickCallbak;

	public void Init()
	{
		controllerEx = GetComponent<ControllerExCollection>();
		selectController = controllerEx.GetController("select");
		closeController = controllerEx.GetController("Close");
		itemButton.onClick.AddListener(OnClickItem);
	}

	public void OnClickItem()
	{
		if (!isPress)
		{
			clickCallbak?.Invoke(itemIndex);
		}
	}

	public void InitData(int index)
	{
		itemIndex = index;
		indexText.text = itemIndex.ToString();
		isPress = false;
		RefreshUI();
	}

	public void RefreshUI()
	{
		if (isPress)
		{
			closeController.SetSelectedState("on");
		}
		else
		{
			closeController.SetSelectedState("off");
		}
	}
}
