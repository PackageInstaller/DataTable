using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace Oath;

public class OathCaptureViewUI : MonoBehaviour
{
	public ControllerExCollection controller;

	private ControllerEx captureModeController;

	private ControllerEx lookStateController;

	public Button sliderAddBtn_;

	public Button sliderSubBtn_;

	public Slider fovSlider_;

	public float sliChangeValue;

	public Button btnHideUI_;

	public Button btnExitHideUI_;

	public Button resetCameraBtn_;

	public Button lookCameraBtn_;

	public Button btnEnterFilter_;

	private void InitController()
	{
		captureModeController = controller.GetController("captureMode");
		lookStateController = controller.GetController("lookBtnState");
	}

	private void Awake()
	{
		OathSceneLoader.Scene.context.captureViewUI = this;
		InitController();
		AddListener();
	}

	public void Dispose()
	{
		OathSceneLoader.Scene.context.captureViewUI = null;
		RemoveListener();
	}

	public void ChangeViewMode(OathCaptureModeStateEnum state)
	{
		switch (state)
		{
		case OathCaptureModeStateEnum.photo:
			captureModeController.SetSelectedState("photoView");
			break;
		case OathCaptureModeStateEnum.empty:
			captureModeController.SetSelectedState("emptyView");
			break;
		case OathCaptureModeStateEnum.filter:
			captureModeController.SetSelectedState("filterView");
			break;
		}
		bool flag = state == OathCaptureModeStateEnum.empty;
		LuaHelper.CallFunction("OathToLuaBridge.OathEnterCaptureHideUIMode", flag);
	}

	public void ChangeLookState(bool isLook)
	{
		if (isLook)
		{
			lookStateController.SetSelectedState("on");
		}
		else
		{
			lookStateController.SetSelectedState("off");
		}
	}

	public void AddListener()
	{
		sliderAddBtn_?.onClick.AddListener(delegate
		{
			OnSliderChangeClick(sliChangeValue);
		});
		sliderSubBtn_?.onClick.AddListener(delegate
		{
			OnSliderChangeClick(0f - sliChangeValue);
		});
		fovSlider_?.onValueChanged.AddListener(OnFovSliderValueChange);
		btnHideUI_?.onClick.AddListener(delegate
		{
			ChangeViewMode(OathCaptureModeStateEnum.empty);
		});
		btnExitHideUI_?.onClick.AddListener(delegate
		{
			ChangeViewMode(OathCaptureModeStateEnum.photo);
		});
		resetCameraBtn_?.onClick.AddListener(delegate
		{
			OathSceneLoader.Scene.context.captureManager?.ResetCapture();
		});
		lookCameraBtn_?.onClick.AddListener(delegate
		{
			OathSceneLoader.Scene.context.captureManager?.ChangeCharaterLook();
		});
		btnEnterFilter_?.onClick.AddListener(delegate
		{
			OnClickFilterBtn();
		});
	}

	public void RemoveListener()
	{
		sliderAddBtn_?.onClick.RemoveAllListeners();
		sliderSubBtn_?.onClick.RemoveAllListeners();
		fovSlider_?.onValueChanged.RemoveAllListeners();
		btnHideUI_?.onClick.RemoveAllListeners();
		btnExitHideUI_?.onClick.RemoveAllListeners();
		resetCameraBtn_?.onClick.RemoveAllListeners();
		lookCameraBtn_?.onClick.RemoveAllListeners();
		btnEnterFilter_?.onClick.RemoveAllListeners();
	}

	private void OnSliderChangeClick(float value)
	{
		fovSlider_.value += value;
	}

	private void OnFovSliderValueChange(float value)
	{
		OathSceneLoader.Scene.context.captureManager?.SetLookAtPointBySilderValue(value);
	}

	public void OnClickFilterBtn()
	{
	}

	public void SetSliderValue(float value)
	{
		if (fovSlider_ != null)
		{
			fovSlider_.value = value;
		}
	}
}
