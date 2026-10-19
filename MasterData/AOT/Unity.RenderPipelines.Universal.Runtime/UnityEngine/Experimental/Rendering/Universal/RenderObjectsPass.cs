using System.Collections.Generic;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace UnityEngine.Experimental.Rendering.Universal;

public class RenderObjectsPass : ScriptableRenderPass
{
	private RenderQueueType renderQueueType;

	private FilteringSettings m_FilteringSettings;

	private RenderObjects.CustomCameraSettings m_CameraSettings;

	private ProfilingSampler m_ProfilingSampler;

	private List<ShaderTagId> m_ShaderTagIdList = new List<ShaderTagId>();

	internal override bool supportsNativePostDeferredPass => true;

	public RenderObjectsPass(string profilerTag, RenderPassEvent renderPassEvent, string[] shaderTags, RenderQueueType renderQueueType, int layerMask, RenderObjects.CustomCameraSettings cameraSettings, uint renderingLayerMask)
	{
		profilingSampler = new ProfilingSampler("RenderObjectsPass");
		m_ProfilingSampler = new ProfilingSampler(profilerTag);
		base.renderPassEvent = renderPassEvent;
		this.renderQueueType = renderQueueType;
		m_FilteringSettings = new FilteringSettings((renderQueueType == RenderQueueType.Transparent) ? RenderQueueRange.transparent : RenderQueueRange.opaque, layerMask, renderingLayerMask);
		if (shaderTags != null && shaderTags.Length != 0)
		{
			foreach (string name in shaderTags)
			{
				m_ShaderTagIdList.Add(new ShaderTagId(name));
			}
		}
		else
		{
			m_ShaderTagIdList.Add(ShaderPassTags.SRPDefaultUnlit);
			m_ShaderTagIdList.Add(ShaderPassTags.UniversalForward);
			m_ShaderTagIdList.Add(ShaderPassTags.UniversalForwardOnly);
		}
		m_CameraSettings = cameraSettings;
	}

	internal RenderObjectsPass(URPProfileId profileId, RenderPassEvent renderPassEvent, string[] shaderTags, RenderQueueType renderQueueType, int layerMask, RenderObjects.CustomCameraSettings cameraSettings, uint renderingLayerMask)
		: this(profileId.GetType().Name, renderPassEvent, shaderTags, renderQueueType, layerMask, cameraSettings, renderingLayerMask)
	{
		m_ProfilingSampler = ProfilingSampler.Get(profileId);
	}

	public override void BeginSubPass(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		NativeRenderPassManager nativeRenderPassManager = renderingData.nativeRenderPassManager;
		nativeRenderPassManager.ConfigureTarget(nativeRenderPassManager.CurrentCameraColorAttachment);
		nativeRenderPassManager.BeginSubPass(ref context);
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		SortingCriteria sortingCriteria = ((renderQueueType == RenderQueueType.Transparent) ? SortingCriteria.CommonTransparent : renderingData.cameraData.defaultOpaqueSortFlags);
		DrawingSettings drawingSettings = CreateDrawingSettings(m_ShaderTagIdList, ref renderingData, sortingCriteria);
		ref CameraData cameraData = ref renderingData.cameraData;
		Camera camera = cameraData.camera;
		Rect pixelRect = renderingData.cameraData.pixelRect;
		float aspect = pixelRect.width / pixelRect.height;
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(cmd, m_ProfilingSampler))
		{
			if (m_CameraSettings.overrideCamera)
			{
				Matrix4x4 proj = Matrix4x4.Perspective(m_CameraSettings.cameraFieldOfView, aspect, camera.nearClipPlane, camera.farClipPlane);
				proj = GL.GetGPUProjectionMatrix(proj, cameraData.isCameraProjectionMatrixFlipped);
				Matrix4x4 viewMatrix = cameraData.GetViewMatrix();
				Vector4 column = viewMatrix.GetColumn(3);
				viewMatrix.SetColumn(3, column + m_CameraSettings.offset);
				RenderingUtils.SetViewAndProjectionMatrices(cmd, viewMatrix, proj, setInverseMatrices: false);
			}
			context.ExecuteCommandBuffer(cmd);
			cmd.Clear();
			context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref m_FilteringSettings);
			if (m_CameraSettings.overrideCamera && m_CameraSettings.restoreCamera)
			{
				RenderingUtils.SetViewAndProjectionMatrices(cmd, cameraData.GetViewMatrix(), cameraData.GetGPUProjectionMatrix(), setInverseMatrices: false);
			}
		}
	}
}
