using UnityEngine;
using UnityEngine.UI;

namespace T0World;

public class T0WorldUI : T0WorldUIBase
{
	public Button sliderAddBtn_;

	public Button sliderSubBtn_;

	public Slider fovSlider_;

	public float sliChangeValue;

	public Button btnEnterCapture_;

	public Button btnMainHideUI_;

	public Button btnMainShowUI_;

	public Button btnHideUI_;

	public Button btnExitHideUI_;

	public Button resetCameraBtn_;

	public Button lookCameraBtn_;

	public Button btnEnterFilter_;

	public Transform foreverShowContentNode_;

	public Transform normalShowContentNode_;

	public void ChangeGrahiceRaycastTarget(bool isTarget)
	{
		if (graphic != null)
		{
			graphic.raycastTarget = isTarget;
		}
	}

	protected override void AddListener()
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
		btnEnterCapture_?.onClick.AddListener(delegate
		{
			T0WorldLuaBridge.EnterChapterMode();
		});
		btnMainHideUI_?.onClick.AddListener(delegate
		{
			ChangePhotoViewMode(T0CaptureModeStateEnum.mainUIHide);
			T0SDKSystem.SendSDKData(T0WorldConst.SDKInterationTypeEnum.HIDE_UI);
		});
		btnMainShowUI_?.onClick.AddListener(delegate
		{
			ChangePhotoViewMode(T0CaptureModeStateEnum.normal);
			T0SDKSystem.SendSDKData(T0WorldConst.SDKInterationTypeEnum.SHOW_UI);
		});
		btnHideUI_?.onClick.AddListener(delegate
		{
			ChangePhotoViewMode(T0CaptureModeStateEnum.empty);
		});
		btnExitHideUI_?.onClick.AddListener(delegate
		{
			ChangePhotoViewMode(T0CaptureModeStateEnum.photo);
		});
		resetCameraBtn_?.onClick.AddListener(delegate
		{
			T0WorldScene.Scene.captureManager.ResetCapture();
		});
		lookCameraBtn_?.onClick.AddListener(delegate
		{
			T0WorldScene.Scene.captureManager.ChangeCharaterLook();
		});
		btnEnterFilter_?.onClick.AddListener(delegate
		{
			OnClickFilterBtn();
		});
	}

	protected override void RemoveListener()
	{
		sliderAddBtn_?.onClick.RemoveAllListeners();
		sliderSubBtn_?.onClick.RemoveAllListeners();
		fovSlider_?.onValueChanged.RemoveAllListeners();
		btnEnterCapture_?.onClick.RemoveAllListeners();
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
		T0WorldScene.Scene.captureManager.SetLookAtPointBySilderValue(value);
	}

	public void OnClickFilterBtn()
	{
		T0WorldScene.Scene.captureManager.OpenCaptureFilter(isOpen: true);
	}

	public override void SetSliderValue(float value)
	{
		if (fovSlider_ != null)
		{
			fovSlider_.value = value;
		}
	}

	public Transform GetForeverShowContentNode()
	{
		return foreverShowContentNode_;
	}
}
