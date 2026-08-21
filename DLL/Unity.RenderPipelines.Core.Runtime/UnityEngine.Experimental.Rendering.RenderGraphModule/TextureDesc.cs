using UnityEngine.Rendering;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

public struct TextureDesc
{
	public TextureSizeMode sizeMode;

	public int width;

	public int height;

	public int slices;

	public Vector2 scale;

	public ScaleFunc func;

	public DepthBits depthBufferBits;

	public GraphicsFormat colorFormat;

	public FilterMode filterMode;

	public TextureWrapMode wrapMode;

	public TextureDimension dimension;

	public bool enableRandomWrite;

	public bool useMipMap;

	public bool autoGenerateMips;

	public bool isShadowMap;

	public int anisoLevel;

	public float mipMapBias;

	public MSAASamples msaaSamples;

	public bool bindTextureMS;

	public bool useDynamicScale;

	public RenderTextureMemoryless memoryless;

	public string name;

	public FastMemoryDesc fastMemoryDesc;

	public bool fallBackToBlackTexture;

	public bool clearBuffer;

	public Color clearColor;

	private void InitDefaultValues(bool dynamicResolution, bool xrReady)
	{
		useDynamicScale = dynamicResolution;
		if (xrReady)
		{
			slices = TextureXR.slices;
			dimension = TextureXR.dimension;
		}
		else
		{
			slices = 1;
			dimension = TextureDimension.Tex2D;
		}
	}

	public TextureDesc(int width, int height, bool dynamicResolution = false, bool xrReady = false)
	{
		this = default(TextureDesc);
		sizeMode = TextureSizeMode.Explicit;
		this.width = width;
		this.height = height;
		msaaSamples = MSAASamples.None;
		InitDefaultValues(dynamicResolution, xrReady);
	}

	public TextureDesc(Vector2 scale, bool dynamicResolution = false, bool xrReady = false)
	{
		this = default(TextureDesc);
		sizeMode = TextureSizeMode.Scale;
		this.scale = scale;
		msaaSamples = MSAASamples.None;
		dimension = TextureDimension.Tex2D;
		InitDefaultValues(dynamicResolution, xrReady);
	}

	public TextureDesc(ScaleFunc func, bool dynamicResolution = false, bool xrReady = false)
	{
		this = default(TextureDesc);
		sizeMode = TextureSizeMode.Functor;
		this.func = func;
		msaaSamples = MSAASamples.None;
		dimension = TextureDimension.Tex2D;
		InitDefaultValues(dynamicResolution, xrReady);
	}

	public TextureDesc(TextureDesc input)
	{
		this = input;
	}

	public override int GetHashCode()
	{
		int num = 17;
		switch (sizeMode)
		{
		case TextureSizeMode.Explicit:
			num = num * 23 + width;
			num = num * 23 + height;
			break;
		case TextureSizeMode.Functor:
			if (func != null)
			{
				num = num * 23 + func.GetHashCode();
			}
			break;
		case TextureSizeMode.Scale:
			num = num * 23 + scale.x.GetHashCode();
			num = num * 23 + scale.y.GetHashCode();
			break;
		}
		num = num * 23 + mipMapBias.GetHashCode();
		num = num * 23 + slices;
		num = (int)(num * 23 + depthBufferBits);
		num = (int)(num * 23 + colorFormat);
		num = (int)(num * 23 + filterMode);
		num = (int)(num * 23 + wrapMode);
		num = (int)(num * 23 + dimension);
		num = (int)(num * 23 + memoryless);
		num = num * 23 + anisoLevel;
		num = num * 23 + (enableRandomWrite ? 1 : 0);
		num = num * 23 + (useMipMap ? 1 : 0);
		num = num * 23 + (autoGenerateMips ? 1 : 0);
		num = num * 23 + (isShadowMap ? 1 : 0);
		num = num * 23 + (bindTextureMS ? 1 : 0);
		num = num * 23 + (useDynamicScale ? 1 : 0);
		num = (int)(num * 23 + msaaSamples);
		return num * 23 + (fastMemoryDesc.inFastMemory ? 1 : 0);
	}
}
