using UnityEngine;

namespace Capture.Runtime;

public class CameraLogic : CaptureLogicBase
{
	private CaptureCameraController cameraController;

	public override void Dispose()
	{
		LuaHelper.CallFunction("CaptureGameBridge.StopCameraMgr");
		if (cameraController != null)
		{
			Object.Destroy(cameraController.gameObject);
		}
	}

	public override void Execute()
	{
		cameraController?.Execute();
	}

	public override void Init()
	{
		GameObject gameObject = Asset.InstantiateWithoutCache(CaptureHelper.CameraController, GameObject.Find("UICamera/Canvas/UIMain").transform);
		cameraController = gameObject.GetComponent<CaptureCameraController>();
		cameraController.Init(this);
		LuaHelper.CallFunction("CaptureGameBridge.StartCameraMgr", cameraController);
	}

	public void UpdateSingleCamera(float dragDelta, float deltaHeight)
	{
		AddSingleXVlaue(dragDelta);
		AddSingleYVlaue(deltaHeight);
	}

	public void AddSingleXVlaue(float value)
	{
		StageData stageData = base.context.m_stageData;
		if (stageData.cameraParams.singleLimitX)
		{
			float min = Mathf.Min(stageData.cameraParams.singleLimitXVlaue.x, stageData.cameraParams.singleLimitXVlaue.y);
			float max = Mathf.Max(stageData.cameraParams.singleLimitXVlaue.x, stageData.cameraParams.singleLimitXVlaue.y);
			float value2 = Mathf.Clamp(base.context.singleCaptureCamera.m_XAxis.Value + value * 0.36f, min, max);
			base.context.singleCaptureCamera.m_XAxis.Value = value2;
		}
		else
		{
			float num = base.context.singleCaptureCamera.m_XAxis.Value + value * 0.36f;
			base.context.singleCaptureCamera.m_XAxis.Value = num % 360f;
		}
	}

	public void AddSingleYVlaue(float value)
	{
		StageData stageData = base.context.m_stageData;
		if (stageData.cameraParams.singleLimitY)
		{
			float min = Mathf.Min(stageData.cameraParams.singleLimitYVlaue.x, stageData.cameraParams.singleLimitYVlaue.y);
			float max = Mathf.Max(stageData.cameraParams.singleLimitYVlaue.x, stageData.cameraParams.singleLimitYVlaue.y);
			float value2 = Mathf.Clamp(base.context.singleCaptureCamera.m_YAxis.Value - value / 500f, min, max);
			base.context.singleCaptureCamera.m_YAxis.Value = value2;
		}
		else
		{
			float value3 = base.context.singleCaptureCamera.m_YAxis.Value - value / 500f;
			base.context.singleCaptureCamera.m_YAxis.Value = Mathf.Clamp(value3, 0f, 1f);
		}
	}

	public void UpdateSingleCameraFov(float deltaFov)
	{
		float fieldOfView = base.context.singleCaptureCamera.m_Lens.FieldOfView;
		fieldOfView = Mathf.Clamp(fieldOfView + deltaFov, cameraController.singleCameraMinFov, cameraController.singleCameraMaxFov);
		base.context.singleCaptureCamera.m_Lens.FieldOfView = fieldOfView;
	}

	public void ChangeSingleCameraFov(float fov)
	{
		float fieldOfView = Mathf.Clamp(fov, cameraController.singleCameraMinFov, cameraController.singleCameraMaxFov);
		base.context.singleCaptureCamera.m_Lens.FieldOfView = fieldOfView;
	}

	public void UpdateMultiCamera(float dragDelta, float deltaHeight)
	{
		Vector3 pos = base.context.m_stageData.cameraParams.pos;
		Vector3 position = base.context.multiCaptureCamera.transform.position;
		position += base.context.multiCaptureCamera.transform.right * dragDelta;
		position += base.context.multiCaptureCamera.transform.up * deltaHeight;
		base.context.multiCaptureCamera.transform.Translate(position, Space.World);
		float value = Vector3.Dot(position - pos, base.context.multiCaptureCamera.transform.right);
		float value2 = Vector3.Dot(position - pos, base.context.multiCaptureCamera.transform.up);
		value = Mathf.Clamp(value, 0f - cameraController.multiCameraMoveLimitX, cameraController.multiCameraMoveLimitX);
		value2 = Mathf.Clamp(value2, 0f - cameraController.multiCameraMoveLimitY, cameraController.multiCameraMoveLimitY);
		Vector3 position2 = pos;
		position2 += base.context.multiCaptureCamera.transform.right * value;
		position2 += base.context.multiCaptureCamera.transform.up * value2;
		float num = base.context.m_stageData.cameraParams.minCameraY;
		if (num == 0f)
		{
			num = ((!(pos.y < 0f)) ? 0.5f : pos.y);
		}
		float max = position2.y + 1f;
		if (base.context.m_stageData.cameraParams.limitMaxY)
		{
			max = base.context.m_stageData.cameraParams.maxCameraY;
		}
		position2.y = Mathf.Clamp(position2.y, num, max);
		float min = position2.x - 1f;
		float max2 = position2.x + 1f;
		if (base.context.m_stageData.cameraParams.limitMinX)
		{
			min = base.context.m_stageData.cameraParams.minCameraX;
		}
		if (base.context.m_stageData.cameraParams.limitMaxX)
		{
			max2 = base.context.m_stageData.cameraParams.maxCameraX;
		}
		position2.x = Mathf.Clamp(position2.x, min, max2);
		base.context.multiCaptureCamera.transform.position = position2;
	}

	public void UpdateMultiCameraFov(float deltaFov)
	{
		float fieldOfView = base.context.multiCaptureCamera.m_Lens.FieldOfView;
		fieldOfView = Mathf.Clamp(fieldOfView + deltaFov, cameraController.multiCameraMinFov, cameraController.multiCameraMaxFov);
		base.context.multiCaptureCamera.m_Lens.FieldOfView = fieldOfView;
	}

	public void ChangeMultiCameraFov(float fov)
	{
		float fieldOfView = Mathf.Clamp(fov, cameraController.multiCameraMinFov, cameraController.multiCameraMaxFov);
		base.context.multiCaptureCamera.m_Lens.FieldOfView = fieldOfView;
	}
}
