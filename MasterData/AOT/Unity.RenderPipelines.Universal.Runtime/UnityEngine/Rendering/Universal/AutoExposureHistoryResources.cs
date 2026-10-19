using System;
using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering.Universal;

internal sealed class AutoExposureHistoryResources : IDisposable
{
	private const string ExposureLUTNamePrefix = "AutoEVLUT_";

	private RenderTexture m_HistoryExposureLUT;

	private RenderTexture m_CurrentExposureLUT;

	internal RenderTexture historyExposureLUT => GetCreatedTexture(m_HistoryExposureLUT);

	internal RenderTexture currentExposureLUT => GetCreatedTexture(m_CurrentExposureLUT);

	internal bool isCreated
	{
		get
		{
			if (historyExposureLUT != null)
			{
				return currentExposureLUT != null;
			}
			return false;
		}
	}

	internal AutoExposureHistoryResources(string contextName)
	{
		m_HistoryExposureLUT = CreateExposureLUT("AutoEVLUT_" + contextName + "_History");
		m_CurrentExposureLUT = CreateExposureLUT("AutoEVLUT_" + contextName + "_Current");
	}

	internal void AdvanceFrame()
	{
		RenderTexture renderTexture = m_HistoryExposureLUT;
		m_HistoryExposureLUT = m_CurrentExposureLUT;
		m_CurrentExposureLUT = renderTexture;
	}

	private static RenderTexture GetCreatedTexture(RenderTexture texture)
	{
		if (!(texture != null) || !texture.IsCreated())
		{
			return null;
		}
		return texture;
	}

	private static RenderTexture CreateExposureLUT(string name)
	{
		RenderTexture renderTexture = new RenderTexture(1, 1, GraphicsFormat.R16_SFloat, GraphicsFormat.None);
		renderTexture.name = name;
		renderTexture.hideFlags = HideFlags.HideAndDontSave;
		renderTexture.dimension = TextureDimension.Tex2D;
		renderTexture.volumeDepth = 1;
		renderTexture.enableRandomWrite = true;
		renderTexture.filterMode = FilterMode.Point;
		renderTexture.wrapMode = TextureWrapMode.Clamp;
		renderTexture.Create();
		ResetExposureLUT(renderTexture);
		return renderTexture;
	}

	private static void ReleaseExposureLUT(ref RenderTexture exposureLUT)
	{
		if (!(exposureLUT == null))
		{
			if (exposureLUT.IsCreated())
			{
				exposureLUT.Release();
			}
			CoreUtils.Destroy(exposureLUT);
			exposureLUT = null;
		}
	}

	public void Dispose()
	{
		ReleaseExposureLUT(ref m_HistoryExposureLUT);
		ReleaseExposureLUT(ref m_CurrentExposureLUT);
	}

	internal void Reset()
	{
		ResetExposureLUT(m_HistoryExposureLUT);
		ResetExposureLUT(m_CurrentExposureLUT);
	}

	private static void ResetExposureLUT(RenderTexture exposureLUT)
	{
		if (!(exposureLUT == null) && exposureLUT.IsCreated())
		{
			RenderTexture active = RenderTexture.active;
			RenderTexture.active = exposureLUT;
			GL.Clear(clearDepth: false, clearColor: true, Color.white);
			RenderTexture.active = active;
		}
	}
}
