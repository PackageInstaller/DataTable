using System;
using UnityEngine;

namespace CriMana.Detail;

public class RendererResourceSofdecPrimeYuvRawData : RendererResource
{
	private int width;

	private int height;

	private int chromaWidth;

	private int chromaHeight;

	private int alphaWidth;

	private int alphaHeight;

	private bool useUserShader;

	private CodecType codecType;

	private Vector4 movieTextureST = Vector4.zero;

	private Vector4 movieChromaTextureST = Vector4.zero;

	private Vector4 movieAlphaTextureST = Vector4.zero;

	private Texture2D[][] textures = new Texture2D[NumTextureSets][];

	private int currentTextureSet;

	private int drawTextureSet;

	private IntPtr[] nativePixels;

	private int playerID;

	private bool hasTextureUpdated;

	private bool hasRenderedNewFrame;

	private bool isStoppingForSeek;

	private static int NumTextureSets => 1;

	public RendererResourceSofdecPrimeYuvRawData(int playerId, MovieInfo movieInfo, bool additive, Shader userShader)
	{
		CalculateTextureSize(ref width, ref height, (int)movieInfo.width, (int)movieInfo.height, movieInfo.codecType, isChroma: false);
		CalculateTextureSize(ref chromaWidth, ref chromaHeight, (int)movieInfo.width, (int)movieInfo.height, movieInfo.codecType, isChroma: true);
		CalculateTextureSize(ref alphaWidth, ref alphaHeight, (int)movieInfo.width, (int)movieInfo.height, CodecType.SofdecPrime, isChroma: false);
		base.additive = additive;
		hasAlpha = movieInfo.hasAlpha;
		useUserShader = userShader != null;
		codecType = movieInfo.codecType;
		if (useUserShader)
		{
			shader = userShader;
		}
		else
		{
			string name = "CriMana/SofdecPrimeYuv";
			shader = Shader.Find(name);
		}
		UpdateMovieTextureST(movieInfo.dispWidth, movieInfo.dispHeight);
		for (int i = 0; i < NumTextureSets; i++)
		{
			textures[i] = new Texture2D[hasAlpha ? 4 : 3];
			textures[i][0] = new Texture2D(width, height, TextureFormat.Alpha8, mipChain: false);
			textures[i][0].wrapMode = TextureWrapMode.Clamp;
			textures[i][1] = new Texture2D(chromaWidth, chromaHeight, TextureFormat.Alpha8, mipChain: false);
			textures[i][1].wrapMode = TextureWrapMode.Clamp;
			textures[i][2] = new Texture2D(chromaWidth, chromaHeight, TextureFormat.Alpha8, mipChain: false);
			textures[i][2].wrapMode = TextureWrapMode.Clamp;
			if (hasAlpha)
			{
				textures[i][3] = new Texture2D(alphaWidth, alphaHeight, TextureFormat.Alpha8, mipChain: false);
				textures[i][3].wrapMode = TextureWrapMode.Clamp;
			}
		}
		nativePixels = new IntPtr[hasAlpha ? 4 : 3];
		playerID = playerId;
	}

	protected override void OnDisposeManaged()
	{
	}

	protected override void OnDisposeUnmanaged()
	{
		RendererResource.CRIWAREB34EE65D(playerID, 0, null);
		for (int i = 0; i < NumTextureSets; i++)
		{
			Texture[] array = textures[i];
			RendererResource.DisposeTextures(array);
		}
		textures = null;
	}

	public override bool IsPrepared()
	{
		return hasTextureUpdated;
	}

	public override bool ContinuePreparing()
	{
		return true;
	}

	public override bool IsSuitable(int playerId, MovieInfo movieInfo, bool additive, Shader userShader)
	{
		int w = 0;
		int h = 0;
		CalculateTextureSize(ref w, ref h, (int)movieInfo.width, (int)movieInfo.height, movieInfo.codecType, isChroma: false);
		bool num = movieInfo.codecType == codecType;
		bool flag = width == w && height >= h;
		bool flag2 = hasAlpha == movieInfo.hasAlpha;
		bool flag3 = base.additive == additive;
		bool flag4 = !useUserShader || userShader == shader;
		return num & flag & flag2 & flag3 & flag4;
	}

	public override bool OnPlayerStopForSeek()
	{
		isStoppingForSeek = hasTextureUpdated;
		hasTextureUpdated = false;
		hasRenderedNewFrame = false;
		return true;
	}

	public override bool HasRenderedNewFrame()
	{
		return hasRenderedNewFrame;
	}

	public override void AttachToPlayer(int playerId)
	{
		RendererResource.CRIWARE3A25993F(playerID, 0, new IntPtr[1]);
		hasTextureUpdated = false;
		hasRenderedNewFrame = false;
	}

	public override bool UpdateFrame(int playerId, FrameInfo frameInfo, ref bool frameDrop)
	{
		bool num = RendererResource.CRIWARE09829167(playerId, 0, null, frameInfo, ref frameDrop);
		if (num && !frameDrop)
		{
			UpdateMovieTextureST(frameInfo.dispWidth, frameInfo.dispHeight);
			drawTextureSet = currentTextureSet;
			currentTextureSet = (currentTextureSet + 1) % NumTextureSets;
		}
		return num;
	}

	public override bool UpdateMaterial(Material material)
	{
		if (!hasTextureUpdated && NumTextureSets > 1)
		{
			return false;
		}
		if (currentMaterial != material)
		{
			currentMaterial = material;
			SetupStaticMaterialProperties();
		}
		if (material == null)
		{
			return false;
		}
		material.SetTexture("_TextureY", textures[drawTextureSet][0]);
		material.SetTexture("_TextureU", textures[drawTextureSet][1]);
		material.SetTexture("_TextureV", textures[drawTextureSet][2]);
		material.SetVector("_MovieTexture_ST", movieTextureST);
		material.SetVector("_MovieChromaTexture_ST", movieChromaTextureST);
		if (hasAlpha)
		{
			material.SetTexture("_TextureA", textures[drawTextureSet][3]);
			material.SetVector("_MovieAlphaTexture_ST", movieAlphaTextureST);
		}
		hasRenderedNewFrame = hasTextureUpdated;
		if (!hasTextureUpdated)
		{
			return isStoppingForSeek;
		}
		return true;
	}

	private void UpdateMovieTextureST(uint dispWidth, uint dispHeight)
	{
		float x = ((dispWidth != width) ? ((float)(dispWidth - 1) / (float)width) : 1f);
		float num = ((dispHeight != height) ? ((float)(dispHeight - 1) / (float)height) : 1f);
		movieTextureST.x = x;
		movieTextureST.y = 0f - num;
		movieTextureST.z = 0f;
		movieTextureST.w = num;
		x = ((dispWidth != chromaWidth * 2) ? ((float)(dispWidth / 2 - 1) / (float)(chromaWidth * 2) * 2f) : 1f);
		num = ((dispHeight != chromaHeight * 2) ? ((float)(dispHeight / 2 - 1) / (float)(chromaHeight * 2) * 2f) : 1f);
		movieChromaTextureST.x = x;
		movieChromaTextureST.y = 0f - num;
		movieChromaTextureST.z = 0f;
		movieChromaTextureST.w = num;
		if (hasAlpha)
		{
			x = ((dispWidth != alphaWidth) ? ((float)(dispWidth - 1) / (float)alphaWidth) : 1f);
			num = ((dispHeight != alphaHeight) ? ((float)(dispHeight - 1) / (float)alphaHeight) : 1f);
			movieAlphaTextureST.x = x;
			movieAlphaTextureST.y = 0f - num;
			movieAlphaTextureST.z = 0f;
			movieAlphaTextureST.w = num;
		}
	}

	public override void UpdateTextures()
	{
		int num_textures = (hasAlpha ? 4 : 3);
		nativePixels[0] = IntPtr.Zero;
		hasTextureUpdated |= RendererResource.CRIWARE913A0F8B(playerID, num_textures, nativePixels);
		if (hasTextureUpdated && nativePixels[0] != IntPtr.Zero)
		{
			textures[currentTextureSet][0].LoadRawTextureData(nativePixels[0], width * height);
			textures[currentTextureSet][1].LoadRawTextureData(nativePixels[1], chromaWidth * chromaHeight);
			textures[currentTextureSet][2].LoadRawTextureData(nativePixels[2], chromaWidth * chromaHeight);
			textures[currentTextureSet][0].Apply();
			textures[currentTextureSet][1].Apply();
			textures[currentTextureSet][2].Apply();
			if (hasAlpha)
			{
				textures[currentTextureSet][3].LoadRawTextureData(nativePixels[3], alphaWidth * alphaHeight);
				textures[currentTextureSet][3].Apply();
			}
			isStoppingForSeek = false;
		}
	}

	private static void CalculateTextureSize(ref int w, ref int h, int videoWidth, int videoHeight, CodecType type, bool isChroma)
	{
		switch (type)
		{
		case CodecType.SofdecPrime:
		{
			uint primeBufferAlignmentSize = CriManaPlugin.GetPrimeBufferAlignmentSize();
			if (!isChroma)
			{
				w = RendererResource.CeilingWith(RendererResource.Ceiling16(videoWidth), (int)primeBufferAlignmentSize);
				h = RendererResource.CeilingWith(videoHeight, 8);
			}
			else
			{
				w = RendererResource.CeilingWith(RendererResource.Ceiling16(videoWidth) / 2, (int)primeBufferAlignmentSize);
				h = RendererResource.CeilingWith(videoHeight, 8) / 2;
			}
			break;
		}
		case CodecType.VP9:
			if (!isChroma)
			{
				w = RendererResource.CeilingWith(RendererResource.CeilingWith(videoWidth, 2), 8);
				h = RendererResource.CeilingWith(videoHeight, 2);
			}
			else
			{
				w = RendererResource.CeilingWith(RendererResource.CeilingWith(videoWidth, 2) / 2, 8);
				h = RendererResource.CeilingWith(videoHeight, 2) / 2;
			}
			break;
		case CodecType.AV1:
			if (!isChroma)
			{
				w = RendererResource.CeilingWith(videoWidth, 128);
				if (w % 1024 == 0)
				{
					w += 64;
				}
				h = RendererResource.CeilingWith(videoHeight, 2);
			}
			else
			{
				w = RendererResource.CeilingWith(videoWidth, 128) / 2;
				if (w % 1024 == 0)
				{
					w += 64;
				}
				h = RendererResource.CeilingWith(videoHeight, 2) / 2;
			}
			break;
		case CodecType.H264:
			if (!isChroma)
			{
				w = videoWidth;
				h = videoHeight;
			}
			else
			{
				w = RendererResource.CeilingWith(videoWidth / 2, 8);
				h = RendererResource.CeilingWith(videoHeight, 2) / 2;
			}
			break;
		}
	}
}
