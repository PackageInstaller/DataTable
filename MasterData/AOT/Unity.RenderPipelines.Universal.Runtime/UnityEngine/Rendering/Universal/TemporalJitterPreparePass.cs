using UnityEngine.Rendering.Universal.Internal;

namespace UnityEngine.Rendering.Universal;

public class TemporalJitterPreparePass : ScriptableRenderPass
{
	private static readonly int s_TemporalHistoryTexture = Shader.PropertyToID("_TemporalHistoryTexture");

	private static readonly int s_TemporalHistorySize = Shader.PropertyToID("_TemporalHistorySize");

	private static readonly int s_Jitter = Shader.PropertyToID("_Jitter");

	private static readonly int s_PrevViewProjMatrix = Shader.PropertyToID("_PrevViewProjMatrix");

	private static readonly int s_PrevOutlineViewMatrix = Shader.PropertyToID("_PrevOutlineViewMatrix");

	private static readonly int s_ViewProjMatrixNoJitter = Shader.PropertyToID("_ViewProjMatrixNoJitter");

	private static readonly int s_SkyMotionReprojectionMatrix = Shader.PropertyToID("_SkyMotionReprojectionMatrix");

	private static readonly GlobalKeyword s_TemporalHistoryKeyword = GlobalKeyword.Create("_TEMPORAL_HISTORY_AVAILABLE");

	private readonly FrameData m_FrameData = new FrameData();

	private int m_HaltonIndex;

	private int m_CameraInstanceId;

	private float m_JitterSize;

	private float m_HistoryResetDeltaTime;

	public TemporalJitterPreparePass()
	{
		profilingSampler = new ProfilingSampler("TemporalJitterPreparePass");
		renderPassEvent = RenderPassEvent.TemporalJitterPreparePass;
		targetCount = 0u;
	}

	internal void Setup(float jitterSize, float historyResetDeltaTime)
	{
		m_JitterSize = Mathf.Max(0f, jitterSize);
		m_HistoryResetDeltaTime = historyResetDeltaTime;
	}

	public override void OnCameraCleanup(CommandBuffer cmd)
	{
		cmd.SetKeyword(in s_TemporalHistoryKeyword, value: false);
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		ref CameraData cameraData = ref renderingData.cameraData;
		bool flag = renderingData.postProcessingData.TryGetPreviousTemporalColor(out var history);
		bool flag2 = cameraData.resetHistoryForCamera;
		if (!flag2 && m_HistoryResetDeltaTime > 0f && GetRenderDeltaTime() >= m_HistoryResetDeltaTime)
		{
			flag2 = true;
		}
		bool flag3 = flag && !flag2;
		bool flag4 = !flag3;
		if (flag4)
		{
			m_HaltonIndex = 0;
		}
		Matrix4x4 projectionMatrix = (cameraData.NoJitterPMatrix = cameraData.GetProjectionMatrix());
		int width = cameraData.cameraTargetDescriptor.width;
		int height = cameraData.cameraTargetDescriptor.height;
		float num = 1f / (float)width;
		float num2 = 1f / (float)height;
		float num3 = (HaltonSequence.Get(m_HaltonIndex + 1, 2) - 0.5f) * num;
		float num4 = (HaltonSequence.Get(m_HaltonIndex + 1, 3) - 0.5f) * num2;
		m_HaltonIndex = (m_HaltonIndex + 1) % 16;
		Vector4 vector = new Vector4(num3 * m_JitterSize, num4 * m_JitterSize, flag4 ? 1f : 0f, 0f);
		renderingData.postProcessingData.temporalJitter = vector;
		projectionMatrix.m02 -= vector.x * 2f;
		projectionMatrix.m12 -= vector.y * 2f;
		cameraData.SetProjectionMatrix(projectionMatrix);
		UpdateFrameData(cameraData.camera, cameraData.NoJitterPMatrix, flag4);
		CommandBuffer cmd = renderingData.cmd;
		cmd.SetKeyword(in s_TemporalHistoryKeyword, flag3);
		if (flag3)
		{
			cmd.SetGlobalTexture(s_TemporalHistoryTexture, history.texture);
			width = history.width;
			height = history.height;
		}
		else
		{
			cmd.SetGlobalTexture(s_TemporalHistoryTexture, Texture2D.blackTexture);
		}
		cmd.SetGlobalVector(s_TemporalHistorySize, new Vector4(width, height, 1f / (float)width, 1f / (float)height));
		cmd.SetGlobalVector(s_Jitter, vector);
		cmd.SetGlobalMatrix(s_PrevViewProjMatrix, m_FrameData.previousViewProjectionMatrix);
		cmd.SetGlobalMatrix(s_PrevOutlineViewMatrix, m_FrameData.previousViewMatrix);
		cmd.SetGlobalMatrix(s_ViewProjMatrixNoJitter, m_FrameData.viewProjectionMatrix);
		UniversalRenderer renderer = cameraData.renderer;
		if (renderer != null && renderer.actualRenderingMode == RenderingMode.Deferred && cameraData.isGameCamera && cameraData.isBase)
		{
			cmd.SetGlobalMatrix(s_SkyMotionReprojectionMatrix, m_FrameData.GetSkyMotionReprojectionMatrix());
		}
	}

	private void UpdateFrameData(Camera camera, Matrix4x4 projectionMatrix, bool resetHistory)
	{
		Matrix4x4 gPUProjectionMatrix = GL.GetGPUProjectionMatrix(projectionMatrix, renderIntoTexture: true);
		Matrix4x4 worldToCameraMatrix = camera.worldToCameraMatrix;
		Matrix4x4 matrix4x = gPUProjectionMatrix * worldToCameraMatrix;
		int instanceID = camera.GetInstanceID();
		bool flag = resetHistory || m_FrameData.isFirstFrame || m_CameraInstanceId != instanceID;
		m_FrameData.previousViewProjectionMatrix = (flag ? matrix4x : m_FrameData.viewProjectionMatrix);
		m_FrameData.previousViewMatrix = (flag ? worldToCameraMatrix : m_FrameData.viewMatrix);
		m_FrameData.previousProjectionMatrix = (flag ? gPUProjectionMatrix : m_FrameData.projectionMatrix);
		m_FrameData.viewProjectionMatrix = matrix4x;
		m_FrameData.viewMatrix = worldToCameraMatrix;
		m_FrameData.projectionMatrix = gPUProjectionMatrix;
		m_FrameData.isFirstFrame = false;
		m_CameraInstanceId = instanceID;
	}

	private static float GetRenderDeltaTime()
	{
		return Time.unscaledDeltaTime;
	}
}
