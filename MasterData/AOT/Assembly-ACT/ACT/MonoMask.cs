using System;
using ACT.UI;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace ACT;

[Obsolete]
public class MonoMask : BaseUIView
{
	public Button btn;

	private BaseUIView controlUIView;

	public void SetMask()
	{
		ContentCanvas.gameObject.SetActive(value: true);
	}

	public void CloseMask()
	{
		btn.onClick.RemoveAllListeners();
		ContentCanvas.gameObject.SetActive(value: false);
	}

	public void close(BaseUIView baseUIView)
	{
		Close();
	}

	public void ShowMask(BaseUIView controlUIView, int targetPopupDepth)
	{
		if (controlUIView.UILayer != UI_LAYER.POPUP)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"遮罩只能控制一个 popup view，{controlUIView} 不是一个 popup view");
			}
			return;
		}
		this.controlUIView = controlUIView;
		ContentCanvas.gameObject.SetActive(value: true);
		ContentCanvas.overrideSorting = true;
		ContentCanvas.sortingLayerName = NewUIManager.SortingLayers[targetPopupDepth].name;
		ContentCanvas.sortingOrder = 0;
		AddBtnListener(CloseControlUIView);
	}

	public void HideMask()
	{
		controlUIView = null;
		RemoveAllBtnListeners();
		ContentCanvas.gameObject.SetActive(value: false);
	}

	public void ResetMask(BaseUIView controlUIView, int targetPopupDepth)
	{
		HideMask();
		ShowMask(controlUIView, targetPopupDepth);
	}

	public async void CloseControlUIView()
	{
	}

	private void AddBtnListener(UnityAction action = null)
	{
		btn.onClick.RemoveAllListeners();
		if (action != null)
		{
			btn.onClick.AddListener(action);
		}
	}

	private void RemoveAllBtnListeners()
	{
		btn.onClick.RemoveAllListeners();
	}
}
