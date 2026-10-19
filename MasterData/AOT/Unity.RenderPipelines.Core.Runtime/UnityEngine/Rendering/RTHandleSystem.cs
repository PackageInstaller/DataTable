using System;
using System.Collections.Generic;
using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering;

public class RTHandleSystem : IDisposable
{
	private HashSet<RTHandle> m_AutoSizedRTs;

	private RTHandle[] m_AutoSizedRTsArray;

	private HashSet<RTHandle> m_ResizeOnDemandRTs;

	private RTHandleProperties m_RTHandleProperties;

	private int m_MaxWidths;

	private int m_MaxHeights;

	public RTHandleProperties rtHandleProperties => m_RTHandleProperties;

	public RTHandleSystem()
	{
		m_AutoSizedRTs = new HashSet<RTHandle>();
		m_ResizeOnDemandRTs = new HashSet<RTHandle>();
		m_MaxWidths = 1;
		m_MaxHeights = 1;
	}

	public void Dispose()
	{
		Dispose(disposing: true);
	}

	public void Release(RTHandle rth)
	{
		rth?.Release();
	}

	internal void Remove(RTHandle rth)
	{
		m_AutoSizedRTs.Remove(rth);
	}

	private void Dispose(bool disposing)
	{
		if (disposing)
		{
			Array.Resize(ref m_AutoSizedRTsArray, m_AutoSizedRTs.Count);
			m_AutoSizedRTs.CopyTo(m_AutoSizedRTsArray);
			int i = 0;
			for (int num = m_AutoSizedRTsArray.Length; i < num; i++)
			{
				RTHandle rth = m_AutoSizedRTsArray[i];
				Release(rth);
			}
			m_AutoSizedRTs.Clear();
			Array.Resize(ref m_AutoSizedRTsArray, m_ResizeOnDemandRTs.Count);
			m_ResizeOnDemandRTs.CopyTo(m_AutoSizedRTsArray);
			int j = 0;
			for (int num2 = m_AutoSizedRTsArray.Length; j < num2; j++)
			{
				RTHandle rth2 = m_AutoSizedRTsArray[j];
				Release(rth2);
			}
			m_ResizeOnDemandRTs.Clear();
			m_AutoSizedRTsArray = null;
		}
	}

	public RTHandle Alloc(int width, int height, int slices = 1, DepthBits depthBufferBits = DepthBits.None, GraphicsFormat colorFormat = GraphicsFormat.R8G8B8A8_SRGB, FilterMode filterMode = FilterMode.Point, TextureWrapMode wrapMode = TextureWrapMode.Repeat, TextureDimension dimension = TextureDimension.Tex2D, bool enableRandomWrite = false, bool useMipMap = false, bool autoGenerateMips = true, bool isShadowMap = false, int anisoLevel = 1, float mipMapBias = 0f, MSAASamples msaaSamples = MSAASamples.None, bool bindTextureMS = false, bool useDynamicScale = false, RenderTextureMemoryless memoryless = RenderTextureMemoryless.None, VRTextureUsage vrUsage = VRTextureUsage.None, string name = "")
	{
		return Alloc(width, height, wrapMode, wrapMode, wrapMode, slices, depthBufferBits, colorFormat, filterMode, dimension, enableRandomWrite, useMipMap, autoGenerateMips, isShadowMap, anisoLevel, mipMapBias, msaaSamples, bindTextureMS, useDynamicScale, memoryless, vrUsage, name);
	}

	public RTHandle Alloc(int width, int height, TextureWrapMode wrapModeU, TextureWrapMode wrapModeV, TextureWrapMode wrapModeW = TextureWrapMode.Repeat, int slices = 1, DepthBits depthBufferBits = DepthBits.None, GraphicsFormat colorFormat = GraphicsFormat.R8G8B8A8_SRGB, FilterMode filterMode = FilterMode.Point, TextureDimension dimension = TextureDimension.Tex2D, bool enableRandomWrite = false, bool useMipMap = false, bool autoGenerateMips = true, bool isShadowMap = false, int anisoLevel = 1, float mipMapBias = 0f, MSAASamples msaaSamples = MSAASamples.None, bool bindTextureMS = false, bool useDynamicScale = false, RenderTextureMemoryless memoryless = RenderTextureMemoryless.None, VRTextureUsage vrUsage = VRTextureUsage.None, string name = "")
	{
		bool flag = msaaSamples != MSAASamples.None;
		if (!flag && bindTextureMS)
		{
			Debug.LogWarning("RTHandle allocated without MSAA but with bindMS set to true, forcing bindMS to false.");
			bindTextureMS = false;
		}
		RenderTexture renderTexture;
		if (isShadowMap || depthBufferBits != DepthBits.None)
		{
			RenderTextureFormat format = ((!isShadowMap) ? RenderTextureFormat.Depth : RenderTextureFormat.Shadowmap);
			GraphicsFormat stencilFormat = ((!isShadowMap && SystemInfo.IsFormatSupported(GraphicsFormat.R8_UInt, FormatUsage.StencilSampling)) ? GraphicsFormat.R8_UInt : GraphicsFormat.None);
			renderTexture = new RenderTexture(width, height, (int)depthBufferBits, format, RenderTextureReadWrite.Linear)
			{
				hideFlags = HideFlags.HideAndDontSave,
				volumeDepth = slices,
				filterMode = filterMode,
				wrapModeU = wrapModeU,
				wrapModeV = wrapModeV,
				wrapModeW = wrapModeW,
				dimension = dimension,
				enableRandomWrite = enableRandomWrite,
				useMipMap = useMipMap,
				autoGenerateMips = autoGenerateMips,
				anisoLevel = anisoLevel,
				mipMapBias = mipMapBias,
				stencilFormat = stencilFormat,
				antiAliasing = (int)msaaSamples,
				bindTextureMS = bindTextureMS,
				useDynamicScale = false,
				memorylessMode = memoryless,
				vrUsage = vrUsage,
				name = CoreUtils.GetRenderTargetAutoName(width, height, slices, format, name, useMipMap, flag, msaaSamples)
			};
		}
		else
		{
			renderTexture = new RenderTexture(width, height, (int)depthBufferBits, colorFormat)
			{
				hideFlags = HideFlags.HideAndDontSave,
				volumeDepth = slices,
				filterMode = filterMode,
				wrapModeU = wrapModeU,
				wrapModeV = wrapModeV,
				wrapModeW = wrapModeW,
				dimension = dimension,
				enableRandomWrite = enableRandomWrite,
				useMipMap = useMipMap,
				autoGenerateMips = autoGenerateMips,
				anisoLevel = anisoLevel,
				mipMapBias = mipMapBias,
				antiAliasing = (int)msaaSamples,
				bindTextureMS = bindTextureMS,
				useDynamicScale = false,
				memorylessMode = memoryless,
				vrUsage = vrUsage,
				name = CoreUtils.GetRenderTargetAutoName(width, height, slices, colorFormat, dimension, name, useMipMap, flag, msaaSamples)
			};
		}
		renderTexture.Create();
		RTHandle rTHandle = new RTHandle(this);
		rTHandle.SetRenderTexture(renderTexture);
		rTHandle.useScaling = false;
		rTHandle.m_EnableRandomWrite = enableRandomWrite;
		rTHandle.m_EnableMSAA = flag;
		rTHandle.m_Name = name;
		rTHandle.referenceSize = new Vector2Int(width, height);
		return rTHandle;
	}

	public RTHandle Alloc(RenderTexture texture)
	{
		RTHandle rTHandle = new RTHandle(this);
		rTHandle.SetRenderTexture(texture);
		rTHandle.m_EnableMSAA = false;
		rTHandle.m_EnableRandomWrite = false;
		rTHandle.useScaling = false;
		rTHandle.m_Name = texture.name;
		return rTHandle;
	}
}
