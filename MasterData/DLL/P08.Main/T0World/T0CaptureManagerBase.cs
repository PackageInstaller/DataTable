using System.Linq;
using UnityEngine;

namespace T0World;

public class T0CaptureManagerBase
{
	protected T0CaptureCameraLogic cameraLogic;

	protected T0CaptureCharacterLogic characterLogic;

	public T0WorldCaptureContext captureContext;

	public T0SceneDitherSystem sceneDitherSystem;

	public virtual void Init()
	{
		captureContext = new T0WorldCaptureContext();
		cameraLogic = new T0CaptureCameraLogic();
		characterLogic = new T0CaptureCharacterLogic();
		sceneDitherSystem = new T0SceneDitherSystem();
		sceneDitherSystem.Init();
		if (!captureContext.isInit)
		{
			captureContext.Init();
			characterLogic?.InitBind(captureContext.captureEntityMono);
		}
	}

	public virtual void Dispose()
	{
		cameraLogic?.Dispose();
		characterLogic?.Dispose();
		captureContext.Dispose();
		captureContext = null;
		sceneDitherSystem?.Dispose();
	}

	public void LateTick()
	{
		if (IsEnterCaptureMode())
		{
			sceneDitherSystem.LateTick();
		}
	}

	public T0CaptureDitherData GetDitherData()
	{
		return characterLogic.ditherColliderData;
	}

	public virtual bool IsEnterCaptureMode()
	{
		return true;
	}

	public virtual void EnterCaptureMode()
	{
	}

	public virtual void ExitCaptureMode()
	{
	}

	public void ChangeCharaterLook()
	{
		SetCharaterLookState(!captureContext.islookCamera);
	}

	public void SetCharaterLookState(bool isLook = true)
	{
		T0WorldScene.Scene.mWorldUI.ChangeLookState(isLook);
		if (!(captureContext.ikBehavior == null))
		{
			captureContext.ikBehavior.ChangeIkState(isLook ? T0CharacterIkControlerStateEnum.open : T0CharacterIkControlerStateEnum.close);
			captureContext.islookCamera = isLook;
			LuaHelper.CallFunction("T0WorldSetCaptureLookAt", isLook);
		}
	}

	public void ChangeCapturePose(int filterType, string poseName)
	{
		switch ((T0CaptureFilterTypeEnum)filterType)
		{
		case T0CaptureFilterTypeEnum.Anim:
			characterLogic?.PlayAction(poseName);
			SetPosePosData(poseName);
			break;
		case T0CaptureFilterTypeEnum.Face:
			characterLogic?.PlayFaceTimeline(poseName);
			break;
		case T0CaptureFilterTypeEnum.CameraFilter:
			captureContext?.SetCameraFillter(poseName);
			break;
		}
	}

	public void SetPosePosData(string poseName)
	{
		T0WorldCaptureAniData t0WorldCaptureAniData = captureContext.captureData.captureAniDataList.FirstOrDefault((T0WorldCaptureAniData data) => data.aniName == poseName);
		captureContext.currentAniData = t0WorldCaptureAniData;
		if (t0WorldCaptureAniData != null && !t0WorldCaptureAniData.isUseSceneData)
		{
			captureContext.modelObj.transform.position = t0WorldCaptureAniData.charaterPos;
			captureContext.modelObj.transform.rotation = Quaternion.Euler(t0WorldCaptureAniData.charaterRot);
		}
		else
		{
			captureContext.modelObj.transform.position = captureContext.currentLocationData.spawnCharaterPos;
			captureContext.modelObj.transform.rotation = Quaternion.Euler(captureContext.currentLocationData.spawnCharaterRot);
		}
		if (t0WorldCaptureAniData != null && t0WorldCaptureAniData.isIndependentRig && t0WorldCaptureAniData.rigParams != null)
		{
			cameraLogic.SetCaptureRig(t0WorldCaptureAniData.rigParams);
		}
		else
		{
			cameraLogic.SetCaptureRig(captureContext.currentLocationData.rigParams);
		}
		ResetCapture();
		captureContext.freeLookCamera.PreviousStateIsValid = false;
	}

	public void ChangeCaptureScene(int locationID)
	{
		if (captureContext.currentLocationData != null && captureContext.currentLocationData.locationID == locationID)
		{
			return;
		}
		foreach (T0WorldCaptureLocationData captureLocationData in captureContext.captureData.captureLocationDataList)
		{
			if (captureLocationData.locationID == locationID)
			{
				captureContext.currentLocationData = captureLocationData;
				break;
			}
		}
		captureContext.modelObj.transform.position = captureContext.currentLocationData.spawnCharaterPos;
		captureContext.modelObj.transform.rotation = Quaternion.Euler(captureContext.currentLocationData.spawnCharaterRot);
		ResetCapture();
		LuaHelper.CallFunction("T0WorldChangeLocation", locationID);
	}

	public void ResetCapture()
	{
		ResetCaptureFov();
		ResetCapturePos();
		ResetLookAtPoint();
	}

	public void ResetLookAtPoint()
	{
		SetLookAtPointBySilderValue(0.5f);
		T0WorldScene.Scene.mWorldUI.SetSliderValue(0.5f);
	}

	public void ResetCaptureFov()
	{
		ChangeFov(0.5f);
	}

	public void ResetCapturePos()
	{
		T0WorldCaptureAniData t0WorldCaptureAniData = captureContext.captureData.captureAniDataList.FirstOrDefault((T0WorldCaptureAniData data) => data.aniName == characterLogic.runAniName);
		if (t0WorldCaptureAniData != null)
		{
			cameraLogic.SetXValue(t0WorldCaptureAniData.beginCameraX);
			cameraLogic.SetYValue(t0WorldCaptureAniData.beginCameraY);
		}
		else
		{
			cameraLogic.SetXValue(captureContext.currentLocationData.beginCameraX);
			cameraLogic.SetYValue(captureContext.currentLocationData.beginCameraY);
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
}
