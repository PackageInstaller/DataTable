using Cinemachine;
using UnityEngine;

namespace T0World;

public class T0CaptureCameraLogic
{
	public T0CaptureCameraController cameraController;

	public T0WorldCaptureContext context => T0WorldScene.Scene.captureManager.captureContext;

	public virtual CinemachineFreeLook freeLookCamera => context.freeLookCamera;

	public void Dispose()
	{
		if (cameraController != null)
		{
			Object.Destroy(cameraController.gameObject);
		}
	}

	public void Execute()
	{
		cameraController?.Execute();
	}

	public virtual void Init()
	{
		GameObject gameObject = Asset.InstantiateWithoutCache("T0World/Common/CameraController", T0WorldScene.Scene.mWorldUI.transform);
		cameraController = gameObject.GetComponent<T0CaptureCameraController>();
		cameraController.Init(this);
		gameObject.transform.SetAsFirstSibling();
	}

	public void UpdateSingleCamera(float dragDelta, float deltaHeight)
	{
		AddXVlaue(dragDelta);
		AddYVlaue(deltaHeight);
	}

	public void AddXVlaue(float value)
	{
		float value2 = freeLookCamera.m_XAxis.Value + value * 0.36f;
		freeLookCamera.m_XAxis.Value = value2;
	}

	public void AddYVlaue(float value)
	{
		float value2 = freeLookCamera.m_YAxis.Value - value * 0.002f;
		freeLookCamera.m_YAxis.Value = value2;
	}

	public void SetXValue(float value)
	{
		freeLookCamera.m_XAxis.Value = value;
	}

	public void SetYValue(float value)
	{
		freeLookCamera.m_YAxis.Value = value;
	}

	public void UpdateCameraFov(float deltaFov)
	{
		float value = freeLookCamera.m_Lens.FieldOfView + deltaFov;
		float num = Mathf.InverseLerp(cameraController.CameraMinFov, cameraController.CameraMaxFov, value);
		ChangeCameraFov(1f - num);
	}

	public void ChangeCameraFov(float sliderValue)
	{
		float fieldOfView = Mathf.Lerp(cameraController.CameraMaxFov, cameraController.CameraMinFov, sliderValue);
		freeLookCamera.m_Lens.FieldOfView = fieldOfView;
	}

	public void SetCaptureRig(T0WorldCaptureRigParams rigParams)
	{
		freeLookCamera.m_Orbits[0].m_Height = rigParams.topRig.height;
		freeLookCamera.m_Orbits[0].m_Radius = rigParams.topRig.radius;
		freeLookCamera.m_Orbits[1].m_Height = rigParams.middleRig.height;
		freeLookCamera.m_Orbits[1].m_Radius = rigParams.middleRig.radius;
		freeLookCamera.m_Orbits[2].m_Height = rigParams.bottomRig.height;
		freeLookCamera.m_Orbits[2].m_Radius = rigParams.bottomRig.radius;
	}

	public void ShowCameraController(bool isShow)
	{
		if (isShow && cameraController == null)
		{
			Init();
		}
		cameraController?.SetActive(isShow);
	}
}
