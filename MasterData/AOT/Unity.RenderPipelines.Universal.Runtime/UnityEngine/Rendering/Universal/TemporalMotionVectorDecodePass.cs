using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering.Universal;

public class TemporalMotionVectorDecodePass : ScriptableRenderPass
{
	private static readonly int s_TemporalMotionVectorScale = Shader.PropertyToID("_TemporalMotionVectorScale");

	private ComputeShader m_DecodeCS;

	private int m_DecodeKernel = -1;

	private RTHandle m_OutputRT;

	private bool m_OutputValid;

	internal Texture outputTexture
	{
		get
		{
			if (!m_OutputValid || m_OutputRT == null)
			{
				return null;
			}
			return m_OutputRT.rt;
		}
	}

	public TemporalMotionVectorDecodePass()
	{
		profilingSampler = new ProfilingSampler("TemporalMotionVectorDecodePass");
		renderPassEvent = RenderPassEvent.TemporalMotionVectorDecodePass;
		targetCount = 0u;
	}

	internal void Setup(ComputeShader decodeCS)
	{
		m_OutputValid = false;
		if (!(m_DecodeCS == decodeCS))
		{
			m_DecodeCS = decodeCS;
			m_DecodeKernel = -1;
			if (m_DecodeCS != null)
			{
				m_DecodeKernel = m_DecodeCS.FindKernel("Decode");
			}
		}
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		Texture gBuffer2Texture = renderingData.cameraData.renderer?.gBuffer2TextureRT;
		Decode(renderingData.cmd, gBuffer2Texture);
	}

	internal bool Decode(CommandBuffer cmd, Texture gBuffer2Texture)
	{
		m_OutputValid = false;
		if (m_DecodeCS == null || m_DecodeKernel < 0 || cmd == null)
		{
			return false;
		}
		if (gBuffer2Texture == null)
		{
			return false;
		}
		int width = gBuffer2Texture.width;
		int height = gBuffer2Texture.height;
		if (!TryEnsureOutputRT(width, height, cmd))
		{
			return false;
		}
		cmd.SetComputeTextureParam(m_DecodeCS, m_DecodeKernel, ShaderPropertyId._GBuffer2, gBuffer2Texture);
		cmd.SetComputeTextureParam(m_DecodeCS, m_DecodeKernel, ShaderPropertyId._TemporalMotionVectorTexture, m_OutputRT.rt);
		cmd.SetComputeVectorParam(val: new Vector4(1f, 1f, 0f, 0f), computeShader: m_DecodeCS, nameID: s_TemporalMotionVectorScale);
		int threadGroupsX = (width + 7) / 8;
		int threadGroupsY = (height + 7) / 8;
		cmd.DispatchCompute(m_DecodeCS, m_DecodeKernel, threadGroupsX, threadGroupsY, 1);
		cmd.SetGlobalTexture(ShaderPropertyId._TemporalMotionVectorTexture, m_OutputRT.rt);
		m_OutputValid = true;
		return true;
	}

	private bool TryEnsureOutputRT(int width, int height, CommandBuffer cmd)
	{
		RenderTexture renderTexture = ((m_OutputRT != null) ? m_OutputRT.rt : null);
		if (renderTexture == null || renderTexture.width != width || renderTexture.height != height)
		{
			ReleaseOutputRT(destroyTexture: true);
			m_OutputRT = RTHandles.Alloc(width, height, 1, DepthBits.None, GraphicsFormat.R16G16_SFloat, FilterMode.Point, TextureWrapMode.Clamp, TextureDimension.Tex2D, enableRandomWrite: true, useMipMap: false, autoGenerateMips: false, isShadowMap: false, 1, 0f, MSAASamples.None, bindTextureMS: false, useDynamicScale: false, RenderTextureMemoryless.None, VRTextureUsage.None, "_TemporalMotionVectorDecode");
			renderTexture = m_OutputRT.rt;
		}
		if (!renderTexture.IsCreated())
		{
			renderTexture.Create();
		}
		return renderTexture.IsCreated();
	}

	private void ReleaseOutputRT(bool destroyTexture = false)
	{
		m_OutputValid = false;
		if (m_OutputRT == null)
		{
			return;
		}
		if (destroyTexture)
		{
			RTHandles.Release(m_OutputRT);
			m_OutputRT = null;
			return;
		}
		RenderTexture rt = m_OutputRT.rt;
		if (rt != null && rt.IsCreated())
		{
			rt.Release();
		}
	}

	public override void OnCameraCleanup(CommandBuffer cmd)
	{
	}

	internal void ReleaseResources(bool destroyTexture = false)
	{
		ReleaseOutputRT(destroyTexture);
	}
}
