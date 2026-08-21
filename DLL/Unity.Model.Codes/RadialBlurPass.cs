#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class RadialBlurPass : ScriptableRenderPass
{
	private static readonly string RenderTag = " RadialBlur Effects";

	private RadialBlurVolume radialBlur;

	private Material Radialmaterial;

	private RenderTargetIdentifier BlurTex;

	private RenderTargetIdentifier Temp1;

	public RadialBlurPass(RenderPassEvent evt, Shader blurshader)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		((ScriptableRenderPass)this)._002Ector();
		((ScriptableRenderPass)this).renderPassEvent = evt;
		if (blurshader == null)
		{
			Log.Error("没有指定Shader");
		}
		else
		{
			Radialmaterial = CoreUtils.CreateEngineMaterial(blurshader);
		}
	}

	public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
	{
		if (Radialmaterial == null)
		{
			Log.Error("材质初始化失败");
		}
		else if (renderingData.cameraData.postProcessEnabled)
		{
			VolumeStack stack = VolumeManager.instance.stack;
			radialBlur = stack.GetComponent<RadialBlurVolume>();
			if (radialBlur == null)
			{
				Log.Error("获取后处理组件失败");
			}
			else if (radialBlur.BlurTimes.overrideState)
			{
				CommandBuffer commandBuffer = CommandBufferPool.Get(RenderTag);
				Render(commandBuffer, ref renderingData);
				context.ExecuteCommandBuffer(commandBuffer);
				CommandBufferPool.Release(commandBuffer);
			}
		}
	}

	private void Render(CommandBuffer cmd, ref RenderingData renderingData)
	{
		RenderTargetIdentifier cameraColorTarget = renderingData.cameraData.renderer.cameraColorTarget;
		RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
		cameraTargetDescriptor.depthBufferBits = 0;
		int width = cameraTargetDescriptor.width / radialBlur.RTDownSampling.value;
		int height = cameraTargetDescriptor.height / radialBlur.RTDownSampling.value;
		Radialmaterial.SetFloat("_Loop", radialBlur.BlurTimes.value);
		Radialmaterial.SetFloat("_X", radialBlur.X.value);
		Radialmaterial.SetFloat("_Y", radialBlur.Y.value);
		Radialmaterial.SetFloat("_Blur", radialBlur.BlurRange.value);
		Radialmaterial.SetFloat("_BufferRadius", radialBlur.BufferRadius.value);
		int nameID = Shader.PropertyToID("Temp1");
		int nameID2 = Shader.PropertyToID("_BlurTex");
		cmd.GetTemporaryRT(nameID, width, height, 0, FilterMode.Bilinear, RenderTextureFormat.DefaultHDR);
		cmd.GetTemporaryRT(nameID2, cameraTargetDescriptor);
		BlurTex = new RenderTargetIdentifier(nameID2);
		Temp1 = new RenderTargetIdentifier(nameID);
		cmd.Blit(cameraColorTarget, Temp1);
		cmd.Blit(Temp1, BlurTex, Radialmaterial, 0);
		cmd.Blit(BlurTex, cameraColorTarget);
	}
}
