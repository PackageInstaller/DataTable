using System.Linq;
using T0World;
using UnityEngine;

namespace Oath;

public class OathCaptureManager
{
	private OathCaptureCameraLogic cameraLogic;

	public OathCaptureContext captureContext;

	private T0CaptureCharacterLogic characterLogic;

	public OathSceneDitherSystem sceneDitherSystem;

	public void ChangeCapturePose(int filterType, string poseName)
	{
		switch ((OathCaptureFilterTypeEnum)filterType)
		{
		case OathCaptureFilterTypeEnum.Anim:
			characterLogic?.PlayAction(poseName);
			SetPosePosData(poseName);
			break;
		case OathCaptureFilterTypeEnum.Face:
			characterLogic?.PlayFaceTimeline(poseName);
			break;
		case OathCaptureFilterTypeEnum.CameraFilter:
			captureContext?.SetCameraFilter(poseName);
			break;
		}
	}

	public void SetPosePosData(string poseName)
	{
		T0WorldCaptureAniData t0WorldCaptureAniData = captureContext.captureData.captureAniDataList.FirstOrDefault((T0WorldCaptureAniData data) => data.aniName == poseName);
		if (t0WorldCaptureAniData != null)
		{
			captureContext.currentAniData = t0WorldCaptureAniData;
			captureContext.modelObj.transform.position = t0WorldCaptureAniData.charaterPos;
			captureContext.modelObj.transform.rotation = Quaternion.Euler(t0WorldCaptureAniData.charaterRot);
			cameraLogic.SetCaptureRig(t0WorldCaptureAniData.rigParams);
			ResetCapture();
			captureContext.freeLookCamera.PreviousStateIsValid = false;
		}
	}

	public void Init()
	{
		cameraLogic = new OathCaptureCameraLogic();
		captureContext = new OathCaptureContext();
		characterLogic = new OathCaptureCharacterLogic();
		sceneDitherSystem = new OathSceneDitherSystem();
		sceneDitherSystem.Init();
		if (!captureContext.isInit)
		{
			captureContext.Init();
			characterLogic?.InitBind(captureContext.captureEntityMono);
		}
	}

	public void Dispose()
	{
		cameraLogic?.Dispose();
		sceneDitherSystem?.Dispose();
		if (captureContext != null)
		{
			captureContext.Dispose();
			captureContext = null;
		}
	}

	public void LateTick()
	{
		sceneDitherSystem.LateTick();
	}

	public void EnterCaptureMode()
	{
		Init();
		cameraLogic.ShowCameraController(isShow: true);
		ResetCapture();
	}

	public void ChangeCharaterLook()
	{
		if (!captureContext.ikBehavior.bipedIk.enabled && !captureContext.islookCamera)
		{
			captureContext.ikBehavior.bipedIk.enabled = true;
		}
		SetCharaterLookState(!captureContext.islookCamera);
	}

	public void SetCharaterLookState(bool isLook = true)
	{
		OathSceneLoader.Scene.context.captureViewUI?.ChangeLookState(isLook);
		if (!(captureContext.ikBehavior == null))
		{
			captureContext.ikBehavior.ChangeIkState(isLook ? T0CharacterIkControlerStateEnum.open : T0CharacterIkControlerStateEnum.close);
			captureContext.islookCamera = isLook;
		}
	}

	public void ChangeCaptureFilter(string filterName)
	{
		captureContext.SetCameraFilter(filterName);
	}

	public void ResetCapture()
	{
		ResetFov();
		ResetLookAt();
		ResetCapturePos();
	}

	public void ResetFov()
	{
		ChangeFov(0.5f);
	}

	public void ResetLookAt()
	{
		SetLookAtPointBySilderValue(0.5f);
		OathSceneLoader.Scene.context.captureViewUI.SetSliderValue(0.5f);
	}

	public void ResetCapturePos()
	{
		if (captureContext != null && captureContext.currentAniData != null)
		{
			cameraLogic.SetXValue(captureContext.currentAniData.beginCameraX);
			cameraLogic.SetYValue(captureContext.currentAniData.beginCameraY);
		}
	}

	public Vector3 GetLookAtPointBySilderValue(float sliderValue)
	{
		if (captureContext.currentAniData == null)
		{
			return Vector3.zero;
		}
		return Vector3.Lerp(captureContext.currentAniData.lookPosMin, captureContext.currentAniData.lookPosMax, sliderValue);
	}

	public void SetLookAtPointBySilderValue(float sliderValue)
	{
		if (captureContext.currentAniData != null)
		{
			captureContext.captureEntityMono.lookAtPoint.localPosition = GetLookAtPointBySilderValue(sliderValue);
		}
	}

	public void ChangeFov(float value)
	{
		cameraLogic.ChangeCameraFov(value);
	}

	public void OpenCaptureFilter(bool isOpen)
	{
		LuaHelper.CallFunction("T0WorldOpenCaptureFilter", isOpen);
	}

	public T0CaptureDitherData GetDitherData()
	{
		return characterLogic.ditherColliderData;
	}
}
