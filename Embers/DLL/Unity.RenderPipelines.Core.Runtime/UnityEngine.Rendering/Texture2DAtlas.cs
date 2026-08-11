using System;
using System.Collections.Generic;
using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering;

public class Texture2DAtlas
{
	private enum BlitType
	{
		Default,
		CubeTo2DOctahedral,
		SingleChannel,
		CubeTo2DOctahedralSingleChannel
	}

	private protected const int kGPUTexInvalid = 0;

	private protected const int kGPUTexValidMip0 = 1;

	private protected const int kGPUTexValidMipAll = 2;

	private protected RTHandle m_AtlasTexture;

	private protected int m_Width;

	private protected int m_Height;

	private protected GraphicsFormat m_Format;

	private protected bool m_UseMipMaps;

	private bool m_IsAtlasTextureOwner;

	private AtlasAllocator m_AtlasAllocator;

	private Dictionary<int, (Vector4 scaleOffset, Vector2Int size)> m_AllocationCache = new Dictionary<int, (Vector4, Vector2Int)>();

	private Dictionary<int, int> m_IsGPUTextureUpToDate = new Dictionary<int, int>();

	private Dictionary<int, int> m_TextureHashes = new Dictionary<int, int>();

	private static readonly Vector4 fullScaleOffset = new Vector4(1f, 1f, 0f, 0f);

	private static readonly int s_MaxMipLevelPadding = 10;

	public static int maxMipLevelPadding => s_MaxMipLevelPadding;

	public RTHandle AtlasTexture => m_AtlasTexture;

	public Texture2DAtlas(int width, int height, GraphicsFormat format, FilterMode filterMode = FilterMode.Point, bool powerOfTwoPadding = false, string name = "", bool useMipMap = true)
	{
		m_Width = width;
		m_Height = height;
		m_Format = format;
		m_UseMipMaps = useMipMap;
		m_AtlasTexture = RTHandles.Alloc(m_Width, m_Height, 1, DepthBits.None, m_Format, filterMode, TextureWrapMode.Clamp, TextureDimension.Tex2D, enableRandomWrite: false, useMipMap, autoGenerateMips: false, isShadowMap: false, 1, 0f, MSAASamples.None, bindTextureMS: false, useDynamicScale: false, RenderTextureMemoryless.None, name);
		m_IsAtlasTextureOwner = true;
		int num = ((!useMipMap) ? 1 : GetTextureMipmapCount(m_Width, m_Height));
		for (int i = 0; i < num; i++)
		{
			Graphics.SetRenderTarget(m_AtlasTexture, i);
			GL.Clear(clearDepth: false, clearColor: true, Color.clear);
		}
		m_AtlasAllocator = new AtlasAllocator(width, height, powerOfTwoPadding);
	}

	public void Release()
	{
		ResetAllocator();
		if (m_IsAtlasTextureOwner)
		{
			RTHandles.Release(m_AtlasTexture);
		}
	}

	public void ResetAllocator()
	{
		m_AtlasAllocator.Reset();
		m_AllocationCache.Clear();
		m_IsGPUTextureUpToDate.Clear();
	}

	public void ClearTarget(CommandBuffer cmd)
	{
		int num = ((!m_UseMipMaps) ? 1 : GetTextureMipmapCount(m_Width, m_Height));
		for (int i = 0; i < num; i++)
		{
			cmd.SetRenderTarget(m_AtlasTexture, i);
			Blitter.BlitQuad(cmd, Texture2D.blackTexture, fullScaleOffset, fullScaleOffset, i, bilinear: true);
		}
		m_IsGPUTextureUpToDate.Clear();
	}

	private protected int GetTextureMipmapCount(int width, int height)
	{
		if (!m_UseMipMaps)
		{
			return 1;
		}
		return Mathf.FloorToInt(Mathf.Log(Mathf.Max(width, height), 2f)) + 1;
	}

	private protected bool Is2D(Texture texture)
	{
		RenderTexture renderTexture = texture as RenderTexture;
		if (!(texture is Texture2D))
		{
			if ((object)renderTexture == null)
			{
				return false;
			}
			return renderTexture.dimension == TextureDimension.Tex2D;
		}
		return true;
	}

	private protected bool IsSingleChannelBlit(Texture source, Texture destination)
	{
		uint componentCount = GraphicsFormatUtility.GetComponentCount(source.graphicsFormat);
		uint componentCount2 = GraphicsFormatUtility.GetComponentCount(destination.graphicsFormat);
		if (componentCount == 1 || componentCount2 == 1)
		{
			if (componentCount != componentCount2)
			{
				return true;
			}
			int num = (1 << (int)(GraphicsFormatUtility.GetSwizzleA(source.graphicsFormat) & (FormatSwizzle)7) << 24) | (1 << (int)(GraphicsFormatUtility.GetSwizzleB(source.graphicsFormat) & (FormatSwizzle)7) << 16) | (1 << (int)(GraphicsFormatUtility.GetSwizzleG(source.graphicsFormat) & (FormatSwizzle)7) << 8) | (1 << (int)(GraphicsFormatUtility.GetSwizzleR(source.graphicsFormat) & (FormatSwizzle)7));
			int num2 = (1 << (int)(GraphicsFormatUtility.GetSwizzleA(destination.graphicsFormat) & (FormatSwizzle)7) << 24) | (1 << (int)(GraphicsFormatUtility.GetSwizzleB(destination.graphicsFormat) & (FormatSwizzle)7) << 16) | (1 << (int)(GraphicsFormatUtility.GetSwizzleG(destination.graphicsFormat) & (FormatSwizzle)7) << 8) | (1 << (int)(GraphicsFormatUtility.GetSwizzleR(destination.graphicsFormat) & (FormatSwizzle)7));
			if (num != num2)
			{
				return true;
			}
		}
		return false;
	}

	private void Blit2DTexture(CommandBuffer cmd, Vector4 scaleOffset, Texture texture, Vector4 sourceScaleOffset, bool blitMips, BlitType blitType)
	{
		int num = GetTextureMipmapCount(texture.width, texture.height);
		if (!blitMips)
		{
			num = 1;
		}
		for (int i = 0; i < num; i++)
		{
			cmd.SetRenderTarget(m_AtlasTexture, i);
			switch (blitType)
			{
			case BlitType.Default:
				Blitter.BlitQuad(cmd, texture, sourceScaleOffset, scaleOffset, i, bilinear: true);
				break;
			case BlitType.CubeTo2DOctahedral:
				Blitter.BlitCubeToOctahedral2DQuad(cmd, texture, scaleOffset, i);
				break;
			case BlitType.SingleChannel:
				Blitter.BlitQuadSingleChannel(cmd, texture, sourceScaleOffset, scaleOffset, i);
				break;
			case BlitType.CubeTo2DOctahedralSingleChannel:
				Blitter.BlitCubeToOctahedral2DQuadSingleChannel(cmd, texture, scaleOffset, i);
				break;
			}
		}
	}

	private protected void MarkGPUTextureValid(int instanceId, bool mipAreValid = false)
	{
		m_IsGPUTextureUpToDate[instanceId] = ((!mipAreValid) ? 1 : 2);
	}

	private protected void MarkGPUTextureInvalid(int instanceId)
	{
		m_IsGPUTextureUpToDate[instanceId] = 0;
	}

	public virtual void BlitTexture(CommandBuffer cmd, Vector4 scaleOffset, Texture texture, Vector4 sourceScaleOffset, bool blitMips = true, int overrideInstanceID = -1)
	{
		if (Is2D(texture))
		{
			BlitType blitType = BlitType.Default;
			if (IsSingleChannelBlit(texture, m_AtlasTexture.m_RT))
			{
				blitType = BlitType.SingleChannel;
			}
			Blit2DTexture(cmd, scaleOffset, texture, sourceScaleOffset, blitMips, blitType);
			int num = ((overrideInstanceID != -1) ? overrideInstanceID : GetTextureID(texture));
			MarkGPUTextureValid(num, blitMips);
			m_TextureHashes[num] = CoreUtils.GetTextureHash(texture);
		}
	}

	public virtual void BlitOctahedralTexture(CommandBuffer cmd, Vector4 scaleOffset, Texture texture, Vector4 sourceScaleOffset, bool blitMips = true, int overrideInstanceID = -1)
	{
		BlitTexture(cmd, scaleOffset, texture, sourceScaleOffset, blitMips, overrideInstanceID);
	}

	public virtual void BlitCubeTexture2D(CommandBuffer cmd, Vector4 scaleOffset, Texture texture, bool blitMips = true, int overrideInstanceID = -1)
	{
		if (texture.dimension == TextureDimension.Cube)
		{
			BlitType blitType = BlitType.CubeTo2DOctahedral;
			if (IsSingleChannelBlit(texture, m_AtlasTexture.m_RT))
			{
				blitType = BlitType.CubeTo2DOctahedralSingleChannel;
			}
			Blit2DTexture(cmd, scaleOffset, texture, new Vector4(1f, 1f, 0f, 0f), blitMips, blitType);
			int num = ((overrideInstanceID != -1) ? overrideInstanceID : GetTextureID(texture));
			MarkGPUTextureValid(num, blitMips);
			m_TextureHashes[num] = CoreUtils.GetTextureHash(texture);
		}
	}

	public virtual bool AllocateTexture(CommandBuffer cmd, ref Vector4 scaleOffset, Texture texture, int width, int height, int overrideInstanceID = -1)
	{
		int num = ((overrideInstanceID != -1) ? overrideInstanceID : GetTextureID(texture));
		bool num2 = AllocateTextureWithoutBlit(num, width, height, ref scaleOffset);
		if (num2)
		{
			if (Is2D(texture))
			{
				BlitTexture(cmd, scaleOffset, texture, fullScaleOffset);
			}
			else
			{
				BlitCubeTexture2D(cmd, scaleOffset, texture);
			}
			MarkGPUTextureValid(num, mipAreValid: true);
			m_TextureHashes[num] = CoreUtils.GetTextureHash(texture);
		}
		return num2;
	}

	public bool AllocateTextureWithoutBlit(Texture texture, int width, int height, ref Vector4 scaleOffset)
	{
		return AllocateTextureWithoutBlit(texture.GetInstanceID(), width, height, ref scaleOffset);
	}

	public virtual bool AllocateTextureWithoutBlit(int instanceId, int width, int height, ref Vector4 scaleOffset)
	{
		scaleOffset = Vector4.zero;
		if (m_AtlasAllocator.Allocate(ref scaleOffset, width, height))
		{
			scaleOffset.Scale(new Vector4(1f / (float)m_Width, 1f / (float)m_Height, 1f / (float)m_Width, 1f / (float)m_Height));
			m_AllocationCache[instanceId] = (scaleOffset, new Vector2Int(width, height));
			MarkGPUTextureInvalid(instanceId);
			m_TextureHashes[instanceId] = -1;
			return true;
		}
		return false;
	}

	private protected int GetTextureHash(Texture textureA, Texture textureB)
	{
		return CoreUtils.GetTextureHash(textureA) + 23 * CoreUtils.GetTextureHash(textureB);
	}

	public int GetTextureID(Texture texture)
	{
		return texture.GetInstanceID();
	}

	public int GetTextureID(Texture textureA, Texture textureB)
	{
		return GetTextureID(textureA) + 23 * GetTextureID(textureB);
	}

	public bool IsCached(out Vector4 scaleOffset, Texture textureA, Texture textureB)
	{
		return IsCached(out scaleOffset, GetTextureID(textureA, textureB));
	}

	public bool IsCached(out Vector4 scaleOffset, Texture texture)
	{
		return IsCached(out scaleOffset, GetTextureID(texture));
	}

	public bool IsCached(out Vector4 scaleOffset, int id)
	{
		bool result = m_AllocationCache.TryGetValue(id, out (Vector4, Vector2Int) value);
		(scaleOffset, _) = value;
		return result;
	}

	internal Vector2Int GetCachedTextureSize(int id)
	{
		m_AllocationCache.TryGetValue(id, out (Vector4, Vector2Int) value);
		return value.Item2;
	}

	public virtual bool NeedsUpdate(Texture texture, bool needMips = false)
	{
		RenderTexture renderTexture = texture as RenderTexture;
		int textureID = GetTextureID(texture);
		int textureHash = CoreUtils.GetTextureHash(texture);
		if (renderTexture != null)
		{
			if (m_IsGPUTextureUpToDate.TryGetValue(textureID, out var value))
			{
				if (renderTexture.updateCount != value)
				{
					m_IsGPUTextureUpToDate[textureID] = (int)renderTexture.updateCount;
					return true;
				}
			}
			else
			{
				m_IsGPUTextureUpToDate[textureID] = (int)renderTexture.updateCount;
			}
		}
		else
		{
			if (m_TextureHashes.TryGetValue(textureID, out var value2) && value2 != textureHash)
			{
				m_TextureHashes[textureID] = textureHash;
				return true;
			}
			if (m_IsGPUTextureUpToDate.TryGetValue(textureID, out var value3))
			{
				if (value3 != 0)
				{
					if (needMips)
					{
						return value3 == 1;
					}
					return false;
				}
				return true;
			}
		}
		return false;
	}

	public virtual bool NeedsUpdate(Texture textureA, Texture textureB, bool needMips = false)
	{
		RenderTexture renderTexture = textureA as RenderTexture;
		RenderTexture renderTexture2 = textureB as RenderTexture;
		int textureID = GetTextureID(textureA, textureB);
		int textureHash = GetTextureHash(textureA, textureB);
		if (renderTexture != null || renderTexture2 != null)
		{
			if (m_IsGPUTextureUpToDate.TryGetValue(textureID, out var value))
			{
				if (renderTexture != null && renderTexture2 != null && Math.Min(renderTexture.updateCount, renderTexture2.updateCount) != value)
				{
					m_IsGPUTextureUpToDate[textureID] = (int)Math.Min(renderTexture.updateCount, renderTexture2.updateCount);
					return true;
				}
				if (renderTexture != null && renderTexture.updateCount != value)
				{
					m_IsGPUTextureUpToDate[textureID] = (int)renderTexture.updateCount;
					return true;
				}
				if (renderTexture2 != null && renderTexture2.updateCount != value)
				{
					m_IsGPUTextureUpToDate[textureID] = (int)renderTexture2.updateCount;
					return true;
				}
			}
			else
			{
				m_IsGPUTextureUpToDate[textureID] = textureHash;
			}
		}
		else
		{
			if (m_TextureHashes.TryGetValue(textureID, out var value2) && value2 != textureHash)
			{
				m_TextureHashes[textureID] = textureID;
				return true;
			}
			if (m_IsGPUTextureUpToDate.TryGetValue(textureID, out var value3))
			{
				if (value3 != 0)
				{
					if (needMips)
					{
						return value3 == 1;
					}
					return false;
				}
				return true;
			}
		}
		return false;
	}

	public virtual bool AddTexture(CommandBuffer cmd, ref Vector4 scaleOffset, Texture texture)
	{
		if (IsCached(out scaleOffset, texture))
		{
			return true;
		}
		return AllocateTexture(cmd, ref scaleOffset, texture, texture.width, texture.height);
	}

	public virtual bool UpdateTexture(CommandBuffer cmd, Texture oldTexture, Texture newTexture, ref Vector4 scaleOffset, Vector4 sourceScaleOffset, bool updateIfNeeded = true, bool blitMips = true)
	{
		if (IsCached(out scaleOffset, oldTexture))
		{
			if (updateIfNeeded && NeedsUpdate(newTexture))
			{
				if (Is2D(newTexture))
				{
					BlitTexture(cmd, scaleOffset, newTexture, sourceScaleOffset, blitMips);
				}
				else
				{
					BlitCubeTexture2D(cmd, scaleOffset, newTexture, blitMips);
				}
				MarkGPUTextureValid(GetTextureID(newTexture), blitMips);
			}
			return true;
		}
		return AllocateTexture(cmd, ref scaleOffset, newTexture, newTexture.width, newTexture.height);
	}

	public virtual bool UpdateTexture(CommandBuffer cmd, Texture texture, ref Vector4 scaleOffset, bool updateIfNeeded = true, bool blitMips = true)
	{
		return UpdateTexture(cmd, texture, texture, ref scaleOffset, fullScaleOffset, updateIfNeeded, blitMips);
	}

	internal bool EnsureTextureSlot(out bool isUploadNeeded, ref Vector4 scaleBias, int key, int width, int height)
	{
		isUploadNeeded = false;
		if (m_AllocationCache.TryGetValue(key, out (Vector4, Vector2Int) value))
		{
			(scaleBias, _) = value;
			return true;
		}
		if (!m_AtlasAllocator.Allocate(ref scaleBias, width, height))
		{
			return false;
		}
		isUploadNeeded = true;
		scaleBias.Scale(new Vector4(1f / (float)m_Width, 1f / (float)m_Height, 1f / (float)m_Width, 1f / (float)m_Height));
		m_AllocationCache.Add(key, (scaleBias, new Vector2Int(width, height)));
		return true;
	}
}
