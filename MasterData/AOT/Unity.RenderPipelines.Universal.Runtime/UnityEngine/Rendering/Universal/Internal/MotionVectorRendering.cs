using System.Collections.Generic;

namespace UnityEngine.Rendering.Universal.Internal;

internal sealed class MotionVectorRendering
{
	private static MotionVectorRendering s_Instance;

	private Dictionary<Camera, FrameData> m_CameraFrameData;

	public static MotionVectorRendering instance
	{
		get
		{
			if (s_Instance == null)
			{
				s_Instance = new MotionVectorRendering();
			}
			return s_Instance;
		}
	}

	private MotionVectorRendering()
	{
		m_CameraFrameData = new Dictionary<Camera, FrameData>();
	}

	public FrameData GetMotionDataForCamera(Camera camera, Matrix4x4 cameraP)
	{
		if (!m_CameraFrameData.TryGetValue(camera, out var value))
		{
			value = new FrameData();
			m_CameraFrameData.Add(camera, value);
		}
		UpdateMotionData(camera, cameraP, value);
		return value;
	}

	private void UpdateMotionData(Camera camera, Matrix4x4 cameraP, FrameData motionData)
	{
		Matrix4x4 gPUProjectionMatrix = GL.GetGPUProjectionMatrix(cameraP, renderIntoTexture: true);
		Matrix4x4 worldToCameraMatrix = camera.worldToCameraMatrix;
		Matrix4x4 matrix4x = gPUProjectionMatrix * worldToCameraMatrix;
		int frameIndex = GetFrameIndex();
		if (motionData.lastFrameActive != frameIndex)
		{
			motionData.previousViewProjectionMatrix = (motionData.isFirstFrame ? matrix4x : motionData.viewProjectionMatrix);
			motionData.previousViewMatrix = (motionData.isFirstFrame ? worldToCameraMatrix : motionData.viewMatrix);
			motionData.previousProjectionMatrix = (motionData.isFirstFrame ? gPUProjectionMatrix : motionData.projectionMatrix);
			motionData.isFirstFrame = false;
		}
		motionData.viewProjectionMatrix = matrix4x;
		motionData.viewMatrix = worldToCameraMatrix;
		motionData.projectionMatrix = gPUProjectionMatrix;
		motionData.lastFrameActive = frameIndex;
	}

	private int GetFrameIndex()
	{
		return Time.frameCount;
	}
}
