using System.Collections.Generic;
using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering;

internal class Texture2DAtlasDynamic
{
	private RTHandle m_AtlasTexture;

	private bool isAtlasTextureOwner;

	private int m_Width;

	private int m_Height;

	private GraphicsFormat m_Format;

	private AtlasAllocatorDynamic m_AtlasAllocator;

	private Dictionary<int, Vector4> m_AllocationCache;

	public RTHandle AtlasTexture => m_AtlasTexture;

	public Texture2DAtlasDynamic(int width, int height, int capacity, GraphicsFormat format)
	{
		m_Width = width;
		m_Height = height;
		m_Format = format;
		m_AtlasTexture = RTHandles.Alloc(m_Width, m_Height, 1, DepthBits.None, m_Format, FilterMode.Point, TextureWrapMode.Clamp, TextureDimension.Tex2D, enableRandomWrite: false, useMipMap: true, autoGenerateMips: false);
		isAtlasTextureOwner = true;
		m_AtlasAllocator = new AtlasAllocatorDynamic(width, height, capacity);
		m_AllocationCache = new Dictionary<int, Vector4>(capacity);
	}

	public Texture2DAtlasDynamic(int width, int height, int capacity, RTHandle atlasTexture)
	{
		m_Width = width;
		m_Height = height;
		m_Format = atlasTexture.rt.graphicsFormat;
		m_AtlasTexture = atlasTexture;
		isAtlasTextureOwner = false;
		m_AtlasAllocator = new AtlasAllocatorDynamic(width, height, capacity);
		m_AllocationCache = new Dictionary<int, Vector4>(capacity);
	}

	public void Release()
	{
		ResetAllocator();
		if (isAtlasTextureOwner)
		{
			RTHandles.Release(m_AtlasTexture);
		}
	}

	public void ResetAllocator()
	{
		m_AtlasAllocator.Release();
		m_AllocationCache.Clear();
	}

	public bool AddTexture(CommandBuffer cmd, out Vector4 scaleOffset, Texture texture)
	{
		int instanceID = texture.GetInstanceID();
		if (!m_AllocationCache.TryGetValue(instanceID, out scaleOffset))
		{
			int width = texture.width;
			int height = texture.height;
			if (m_AtlasAllocator.Allocate(out scaleOffset, instanceID, width, height))
			{
				scaleOffset.Scale(new Vector4(1f / (float)m_Width, 1f / (float)m_Height, 1f / (float)m_Width, 1f / (float)m_Height));
				for (int i = 0; i < (texture as Texture2D).mipmapCount; i++)
				{
					cmd.SetRenderTarget(m_AtlasTexture, i);
					Blitter.BlitQuad(cmd, texture, new Vector4(1f, 1f, 0f, 0f), scaleOffset, i, bilinear: false);
				}
				m_AllocationCache.Add(instanceID, scaleOffset);
				return true;
			}
			return false;
		}
		return true;
	}

	public bool IsCached(out Vector4 scaleOffset, int key)
	{
		return m_AllocationCache.TryGetValue(key, out scaleOffset);
	}

	public bool EnsureTextureSlot(out bool isUploadNeeded, out Vector4 scaleOffset, int key, int width, int height)
	{
		isUploadNeeded = false;
		if (m_AllocationCache.TryGetValue(key, out scaleOffset))
		{
			return true;
		}
		if (!m_AtlasAllocator.Allocate(out scaleOffset, key, width, height))
		{
			return false;
		}
		isUploadNeeded = true;
		scaleOffset.Scale(new Vector4(1f / (float)m_Width, 1f / (float)m_Height, 1f / (float)m_Width, 1f / (float)m_Height));
		m_AllocationCache.Add(key, scaleOffset);
		return true;
	}

	public void ReleaseTextureSlot(int key)
	{
		m_AtlasAllocator.Release(key);
		m_AllocationCache.Remove(key);
	}
}
