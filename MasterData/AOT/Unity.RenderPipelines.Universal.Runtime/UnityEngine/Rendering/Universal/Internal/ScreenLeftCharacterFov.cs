using System;

namespace UnityEngine.Rendering.Universal.Internal;

internal static class ScreenLeftCharacterFov
{
	internal struct OverrideState
	{
		internal bool applied;

		internal bool writesMotionVectors;

		internal bool hasHistory;

		internal Camera camera;

		internal Matrix4x4 view;

		internal Matrix4x4 projection;

		internal Matrix4x4 pipelineViewProjection;

		internal Matrix4x4 fovViewProjection;
	}

	internal const int Layer = 25;

	internal const float FieldOfView = 15f;

	internal const int LayerMask = 33554432;

	private static readonly int s_CameraFov = Shader.PropertyToID("_CameraFOV");

	private static readonly int s_ViewProjMatrixNoJitter = Shader.PropertyToID("_ViewProjMatrixNoJitter");

	private static readonly int s_PrevViewProjMatrix = Shader.PropertyToID("_PrevViewProjMatrix");

	private static Matrix4x4 s_PreviousPipelineViewProjection;

	private static Matrix4x4 s_PreviousFovViewProjection;

	private static Camera s_HistoryCamera;

	private static int s_HistoryFrame = -1;

	internal static Matrix4x4 BuildFovProjection(Matrix4x4 source, float currentFov, float targetFov)
	{
		float num = Mathf.Tan(0.5f * currentFov * (MathF.PI / 180f)) / Mathf.Tan(0.5f * targetFov * (MathF.PI / 180f));
		Matrix4x4 result = source;
		result.m00 *= num;
		result.m11 *= num;
		return result;
	}

	private static Matrix4x4 BuildGpuViewProjection(Camera camera, Matrix4x4 projectionMatrix)
	{
		return GL.GetGPUProjectionMatrix(projectionMatrix, renderIntoTexture: true) * camera.worldToCameraMatrix;
	}

	private static bool HasFrameHistory(Camera camera)
	{
		if (s_HistoryCamera == camera)
		{
			return s_HistoryFrame != Time.frameCount;
		}
		return false;
	}

	internal static OverrideState Apply(ref RenderingData renderingData, CommandBuffer cmd)
	{
		OverrideState result = default;
		ref CameraData cameraData = ref renderingData.cameraData;
		if (!cameraData.isGameCamera)
		{
			return result;
		}
		Camera camera = cameraData.camera;
		Matrix4x4 viewMatrix = cameraData.GetViewMatrix();
		Matrix4x4 projectionMatrix = cameraData.GetProjectionMatrix();
		Matrix4x4 proj = BuildFovProjection(projectionMatrix, camera.fieldOfView, 15f);
		cmd.SetViewProjectionMatrices(viewMatrix, proj);
		cmd.SetGlobalFloat(s_CameraFov, MathF.PI / 12f);
		result.applied = true;
		result.camera = camera;
		result.view = viewMatrix;
		result.projection = projectionMatrix;
		if (!renderingData.postProcessingData.requiresMotionVectorOutput)
		{
			return result;
		}
		UniversalRenderer renderer = cameraData.renderer;
		Matrix4x4 matrix4x = ((renderer != null && renderer.CurrentFrameNeedTemporalJitter) ? cameraData.NoJitterPMatrix : projectionMatrix);
		Matrix4x4 projectionMatrix2 = BuildFovProjection(matrix4x, camera.fieldOfView, 15f);
		result.writesMotionVectors = true;
		result.pipelineViewProjection = BuildGpuViewProjection(camera, matrix4x);
		result.fovViewProjection = BuildGpuViewProjection(camera, projectionMatrix2);
		result.hasHistory = HasFrameHistory(camera);
		cmd.SetGlobalMatrix(s_ViewProjMatrixNoJitter, result.fovViewProjection);
		cmd.SetGlobalMatrix(s_PrevViewProjMatrix, result.hasHistory ? s_PreviousFovViewProjection : result.fovViewProjection);
		return result;
	}

	internal static void Restore(CommandBuffer cmd, OverrideState state, bool recordFrame)
	{
		if (state.applied)
		{
			cmd.SetViewProjectionMatrices(state.view, state.projection);
			cmd.SetGlobalFloat(s_CameraFov, state.camera.fieldOfView * (MathF.PI / 180f));
			if (state.writesMotionVectors)
			{
				cmd.SetGlobalMatrix(s_ViewProjMatrixNoJitter, state.pipelineViewProjection);
				cmd.SetGlobalMatrix(s_PrevViewProjMatrix, state.hasHistory ? s_PreviousPipelineViewProjection : state.pipelineViewProjection);
			}
			if (recordFrame)
			{
				s_PreviousPipelineViewProjection = state.pipelineViewProjection;
				s_PreviousFovViewProjection = state.fovViewProjection;
				s_HistoryCamera = state.camera;
				s_HistoryFrame = Time.frameCount;
			}
		}
	}
}
