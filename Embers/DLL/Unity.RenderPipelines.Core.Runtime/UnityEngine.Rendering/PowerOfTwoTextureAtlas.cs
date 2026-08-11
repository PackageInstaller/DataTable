using System.Collections.Generic;
using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering;

public class PowerOfTwoTextureAtlas : Texture2DAtlas
{
	private enum BlitType
	{
		Padding,
		PaddingMultiply,
		OctahedralPadding,
		OctahedralPaddingMultiply
	}

	private readonly int m_MipPadding;

	private const float k_MipmapFactorApprox = 1.33f;

	private Dictionary<int, Vector2Int> m_RequestedTextures = new Dictionary<int, Vector2Int>();

	public int mipPadding => m_MipPadding;

	public PowerOfTwoTextureAtlas(int size, int mipPadding, GraphicsFormat format, FilterMode filterMode = FilterMode.Point, string name = "", bool useMipMap = true)
		: base(size, size, format, filterMode, powerOfTwoPadding: true, name, useMipMap)
	{
		m_MipPadding = mipPadding;
		_ = size & (size - 1);
	}

	private int GetTexturePadding()
	{
		return (int)Mathf.Pow(2f, m_MipPadding) * 2;
	}

	public Vector4 GetPayloadScaleOffset(Texture texture, in Vector4 scaleOffset)
	{
		int texturePadding = GetTexturePadding();
		Vector2 paddingSize = Vector2.one * texturePadding;
		return GetPayloadScaleOffset(GetPowerOfTwoTextureSize(texture), in paddingSize, in scaleOffset);
	}

	public static Vector4 GetPayloadScaleOffset(in Vector2 textureSize, in Vector2 paddingSize, in Vector4 scaleOffset)
	{
		Vector2 vector = new Vector2(scaleOffset.x, scaleOffset.y);
		Vector2 vector2 = new Vector2(scaleOffset.z, scaleOffset.w);
		Vector2 vector3 = (textureSize + paddingSize) / textureSize;
		Vector2 vector4 = paddingSize / 2f / (textureSize + paddingSize);
		Vector2 vector5 = vector / vector3;
		Vector2 vector6 = vector2 + vector * vector4;
		return new Vector4(vector5.x, vector5.y, vector6.x, vector6.y);
	}

	private void Blit2DTexture(CommandBuffer cmd, Vector4 scaleOffset, Texture texture, Vector4 sourceScaleOffset, bool blitMips, BlitType blitType)
	{
		int num = GetTextureMipmapCount(texture.width, texture.height);
		int texturePadding = GetTexturePadding();
		Vector2 powerOfTwoTextureSize = GetPowerOfTwoTextureSize(texture);
		bool bilinear = texture.filterMode != FilterMode.Point;
		if (!blitMips)
		{
			num = 1;
		}
		using (new ProfilingScope(cmd, ProfilingSampler.Get(CoreProfileId.BlitTextureInPotAtlas)))
		{
			for (int i = 0; i < num; i++)
			{
				cmd.SetRenderTarget(m_AtlasTexture, i);
				switch (blitType)
				{
				case BlitType.Padding:
					Blitter.BlitQuadWithPadding(cmd, texture, powerOfTwoTextureSize, sourceScaleOffset, scaleOffset, i, bilinear, texturePadding);
					break;
				case BlitType.PaddingMultiply:
					Blitter.BlitQuadWithPaddingMultiply(cmd, texture, powerOfTwoTextureSize, sourceScaleOffset, scaleOffset, i, bilinear, texturePadding);
					break;
				case BlitType.OctahedralPadding:
					Blitter.BlitOctahedralWithPadding(cmd, texture, powerOfTwoTextureSize, sourceScaleOffset, scaleOffset, i, bilinear, texturePadding);
					break;
				case BlitType.OctahedralPaddingMultiply:
					Blitter.BlitOctahedralWithPaddingMultiply(cmd, texture, powerOfTwoTextureSize, sourceScaleOffset, scaleOffset, i, bilinear, texturePadding);
					break;
				}
			}
		}
	}

	public override void BlitTexture(CommandBuffer cmd, Vector4 scaleOffset, Texture texture, Vector4 sourceScaleOffset, bool blitMips = true, int overrideInstanceID = -1)
	{
		if (Is2D(texture))
		{
			Blit2DTexture(cmd, scaleOffset, texture, sourceScaleOffset, blitMips, BlitType.Padding);
			MarkGPUTextureValid((overrideInstanceID != -1) ? overrideInstanceID : texture.GetInstanceID(), blitMips);
		}
	}

	public void BlitTextureMultiply(CommandBuffer cmd, Vector4 scaleOffset, Texture texture, Vector4 sourceScaleOffset, bool blitMips = true, int overrideInstanceID = -1)
	{
		if (Is2D(texture))
		{
			Blit2DTexture(cmd, scaleOffset, texture, sourceScaleOffset, blitMips, BlitType.PaddingMultiply);
			MarkGPUTextureValid((overrideInstanceID != -1) ? overrideInstanceID : texture.GetInstanceID(), blitMips);
		}
	}

	public override void BlitOctahedralTexture(CommandBuffer cmd, Vector4 scaleOffset, Texture texture, Vector4 sourceScaleOffset, bool blitMips = true, int overrideInstanceID = -1)
	{
		if (Is2D(texture))
		{
			Blit2DTexture(cmd, scaleOffset, texture, sourceScaleOffset, blitMips, BlitType.OctahedralPadding);
			MarkGPUTextureValid((overrideInstanceID != -1) ? overrideInstanceID : texture.GetInstanceID(), blitMips);
		}
	}

	public void BlitOctahedralTextureMultiply(CommandBuffer cmd, Vector4 scaleOffset, Texture texture, Vector4 sourceScaleOffset, bool blitMips = true, int overrideInstanceID = -1)
	{
		if (Is2D(texture))
		{
			Blit2DTexture(cmd, scaleOffset, texture, sourceScaleOffset, blitMips, BlitType.OctahedralPaddingMultiply);
			MarkGPUTextureValid((overrideInstanceID != -1) ? overrideInstanceID : texture.GetInstanceID(), blitMips);
		}
	}

	private void TextureSizeToPowerOfTwo(Texture texture, ref int width, ref int height)
	{
		width = Mathf.NextPowerOfTwo(width);
		height = Mathf.NextPowerOfTwo(height);
	}

	private Vector2 GetPowerOfTwoTextureSize(Texture texture)
	{
		int width = texture.width;
		int height = texture.height;
		TextureSizeToPowerOfTwo(texture, ref width, ref height);
		return new Vector2(width, height);
	}

	public override bool AllocateTexture(CommandBuffer cmd, ref Vector4 scaleOffset, Texture texture, int width, int height, int overrideInstanceID = -1)
	{
		if (height != width)
		{
			Debug.LogError("Can't place " + texture?.ToString() + " in the atlas " + m_AtlasTexture.name + ": Only squared texture are allowed in this atlas.");
			return false;
		}
		TextureSizeToPowerOfTwo(texture, ref height, ref width);
		return base.AllocateTexture(cmd, ref scaleOffset, texture, width, height);
	}

	public void ResetRequestedTexture()
	{
		m_RequestedTextures.Clear();
	}

	public bool ReserveSpace(Texture texture)
	{
		return ReserveSpace(texture, texture.width, texture.height);
	}

	public bool ReserveSpace(Texture texture, int width, int height)
	{
		return ReserveSpace(GetTextureID(texture), width, height);
	}

	public bool ReserveSpace(Texture textureA, Texture textureB, int width, int height)
	{
		return ReserveSpace(GetTextureID(textureA, textureB), width, height);
	}

	private bool ReserveSpace(int id, int width, int height)
	{
		m_RequestedTextures[id] = new Vector2Int(width, height);
		Vector2Int cachedTextureSize = GetCachedTextureSize(id);
		if (!IsCached(out var _, id) || cachedTextureSize.x != width || cachedTextureSize.y != height)
		{
			Vector4 scaleOffset2 = Vector4.zero;
			if (!AllocateTextureWithoutBlit(id, width, height, ref scaleOffset2))
			{
				return false;
			}
		}
		return true;
	}

	public bool RelayoutEntries()
	{
		List<(int, Vector2Int)> list = new List<(int, Vector2Int)>();
		foreach (KeyValuePair<int, Vector2Int> requestedTexture in m_RequestedTextures)
		{
			list.Add((requestedTexture.Key, requestedTexture.Value));
		}
		ResetAllocator();
		list.Sort(((int instanceId, Vector2Int size) c1, (int instanceId, Vector2Int size) c2) => c2.size.magnitude.CompareTo(c1.size.magnitude));
		bool flag = true;
		Vector4 scaleOffset = Vector4.zero;
		foreach (var item3 in list)
		{
			bool num = flag;
			int item = item3.Item1;
			Vector2Int item2 = item3.Item2;
			int x = item2.x;
			item2 = item3.Item2;
			flag = num & AllocateTextureWithoutBlit(item, x, item2.y, ref scaleOffset);
		}
		return flag;
	}

	public static long GetApproxCacheSizeInByte(int nbElement, int resolution, bool hasMipmap, GraphicsFormat format)
	{
		return (long)((double)(nbElement * resolution * resolution) * (double)((hasMipmap ? 1.33f : 1f) * (float)GraphicsFormatUtility.GetBlockSize(format)));
	}

	public static int GetMaxCacheSizeForWeightInByte(int weight, bool hasMipmap, GraphicsFormat format)
	{
		float num = (float)GraphicsFormatUtility.GetBlockSize(format) * (hasMipmap ? 1.33f : 1f);
		return CoreUtils.PreviousPowerOfTwo((int)Mathf.Sqrt((float)weight / num));
	}
}
