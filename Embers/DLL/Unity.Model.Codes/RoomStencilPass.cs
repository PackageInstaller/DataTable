#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class RoomStencilPass : ScriptableRenderPass
{
	private static readonly string RenderTag = "RoomStencil";

	private int[] downSampleRT;

	private int[] upSampleRT;

	private RoomStencilVolume _roomStencilVolume;

	private Material _postProcessMat;

	private RenderTargetIdentifier _currentTarget;

	private bool _cameraStackMode;

	public RoomStencilPass(RenderPassEvent evt, Shader postProcessShader, bool mode)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		((ScriptableRenderPass)this)._002Ector();
		((ScriptableRenderPass)this).renderPassEvent = evt;
		if (postProcessShader == null)
		{
			Log.Error("没有指定Shader");
			return;
		}
		_postProcessMat = CoreUtils.CreateEngineMaterial(postProcessShader);
		_cameraStackMode = mode;
	}

	public void Setup(in RenderTargetIdentifier currentTarget)
	{
		_currentTarget = currentTarget;
	}

	public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
	{
		if (renderingData.cameraData.cameraType != CameraType.SceneView && !renderingData.cameraData.camera.CompareTag("MainCamera"))
		{
			return;
		}
		if (_postProcessMat == null)
		{
			Log.Error("材质初始化失败");
		}
		else if (renderingData.cameraData.postProcessEnabled)
		{
			VolumeStack stack = VolumeManager.instance.stack;
			_roomStencilVolume = stack.GetComponent<RoomStencilVolume>();
			if (_roomStencilVolume == null)
			{
				Log.Error("Volume组件获取失败");
			}
			else if (_roomStencilVolume.IsActive())
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
		ref CameraData cameraData = ref renderingData.cameraData;
		Camera camera = cameraData.camera;
		_postProcessMat.SetInt("_RefValue", _roomStencilVolume.stencilRefValue.value);
		_postProcessMat.SetFloat("_BlurRange", _roomStencilVolume.blurSpread.value);
		RenderTargetIdentifier currentTarget = _currentTarget;
		int num = Shader.PropertyToID("tmpSceneColor_roomStencil");
		RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
		cmd.GetTemporaryRT(num, cameraTargetDescriptor);
		cmd.Blit(currentTarget, num);
		cmd.SetRenderTarget(cameraData.renderer.cameraColorTarget, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, cameraData.renderer.cameraDepthTarget, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store);
		cmd.ClearRenderTarget(clearDepth: false, clearColor: true, Color.clear);
		if (cameraData.cameraType == CameraType.Game && _cameraStackMode)
		{
			cmd.SetViewProjectionMatrices(Matrix4x4.identity, Matrix4x4.identity);
			cmd.DrawMesh(RenderingUtils.fullscreenMesh, Matrix4x4.identity, _postProcessMat, 0, 0);
			cmd.SetViewProjectionMatrices(camera.worldToCameraMatrix, camera.projectionMatrix);
		}
		else
		{
			cmd.Blit(null, currentTarget, _postProcessMat, 0);
		}
		RenderTargetIdentifier source = currentTarget;
		int scaledPixelWidth = camera.scaledPixelWidth;
		int scaledPixelHeight = camera.scaledPixelHeight;
		int value = _roomStencilVolume.blurIterations.value;
		int value2 = _roomStencilVolume.preDownSample.value;
		downSampleRT = new int[value];
		upSampleRT = new int[value];
		for (int i = 0; i < value; i++)
		{
			downSampleRT[i] = Shader.PropertyToID("DownSample" + i);
			upSampleRT[i] = Shader.PropertyToID("UpSample" + i);
		}
		scaledPixelWidth >>= value2;
		scaledPixelHeight >>= value2;
		for (int j = 0; j < value; j++)
		{
			scaledPixelWidth = Mathf.Max(scaledPixelWidth >> 1, 1);
			scaledPixelHeight = Mathf.Max(scaledPixelHeight >> 1, 1);
			cmd.GetTemporaryRT(downSampleRT[j], scaledPixelWidth, scaledPixelHeight, 0, FilterMode.Bilinear, RenderTextureFormat.Default);
			cmd.GetTemporaryRT(upSampleRT[j], scaledPixelWidth, scaledPixelHeight, 0, FilterMode.Bilinear, RenderTextureFormat.Default);
			cmd.Blit(source, downSampleRT[j], _postProcessMat, 1);
			source = downSampleRT[j];
		}
		for (int num2 = value - 2; num2 >= 0; num2--)
		{
			cmd.Blit(source, upSampleRT[num2], _postProcessMat, 2);
			source = upSampleRT[num2];
		}
		cmd.SetGlobalTexture("_SourceTex", num);
		cmd.Blit(source, currentTarget, _postProcessMat, 3);
		for (int k = 0; k < value; k++)
		{
			cmd.ReleaseTemporaryRT(downSampleRT[k]);
			cmd.ReleaseTemporaryRT(upSampleRT[k]);
		}
		cmd.ReleaseTemporaryRT(num);
	}
}
