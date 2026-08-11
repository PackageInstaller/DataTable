using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering;

public static class Blitter
{
	private static class BlitShaderIDs
	{
		public static readonly int _BlitTexture = Shader.PropertyToID("_BlitTexture");

		public static readonly int _BlitCubeTexture = Shader.PropertyToID("_BlitCubeTexture");

		public static readonly int _BlitScaleBias = Shader.PropertyToID("_BlitScaleBias");

		public static readonly int _BlitScaleBiasRt = Shader.PropertyToID("_BlitScaleBiasRt");

		public static readonly int _BlitMipLevel = Shader.PropertyToID("_BlitMipLevel");

		public static readonly int _BlitTextureSize = Shader.PropertyToID("_BlitTextureSize");

		public static readonly int _BlitPaddingSize = Shader.PropertyToID("_BlitPaddingSize");

		public static readonly int _InputDepth = Shader.PropertyToID("_InputDepthTexture");
	}

	private static Material s_Blit;

	private static Material s_BlitTexArray;

	private static Material s_BlitTexArraySingleSlice;

	private static Material s_BlitColorAndDepth;

	private static MaterialPropertyBlock s_PropertyBlock = new MaterialPropertyBlock();

	private static Mesh s_TriangleMesh;

	private static Mesh s_QuadMesh;

	public static void Initialize(Shader blitPS, Shader blitColorAndDepthPS)
	{
		if (s_Blit != null)
		{
			return;
		}
		s_Blit = CoreUtils.CreateEngineMaterial(blitPS);
		s_BlitColorAndDepth = CoreUtils.CreateEngineMaterial(blitColorAndDepthPS);
		if (TextureXR.useTexArray)
		{
			s_Blit.EnableKeyword("DISABLE_TEXTURE2D_X_ARRAY");
			s_BlitTexArray = CoreUtils.CreateEngineMaterial(blitPS);
			s_BlitTexArraySingleSlice = CoreUtils.CreateEngineMaterial(blitPS);
			s_BlitTexArraySingleSlice.EnableKeyword("BLIT_SINGLE_SLICE");
		}
		if (SystemInfo.graphicsShaderLevel < 30)
		{
			float z = -1f;
			if (SystemInfo.usesReversedZBuffer)
			{
				z = 1f;
			}
			if (!s_TriangleMesh)
			{
				s_TriangleMesh = new Mesh();
				s_TriangleMesh.vertices = GetFullScreenTriangleVertexPosition(z);
				s_TriangleMesh.uv = GetFullScreenTriangleTexCoord();
				s_TriangleMesh.triangles = new int[3] { 0, 1, 2 };
			}
			if (!s_QuadMesh)
			{
				s_QuadMesh = new Mesh();
				s_QuadMesh.vertices = GetQuadVertexPosition(z);
				s_QuadMesh.uv = GetQuadTexCoord();
				s_QuadMesh.triangles = new int[6] { 0, 1, 2, 0, 2, 3 };
			}
		}
		static Vector2[] GetFullScreenTriangleTexCoord()
		{
			Vector2[] array = new Vector2[3];
			for (int i = 0; i < 3; i++)
			{
				if (SystemInfo.graphicsUVStartsAtTop)
				{
					array[i] = new Vector2((i << 1) & 2, 1f - (float)(i & 2));
				}
				else
				{
					array[i] = new Vector2((i << 1) & 2, i & 2);
				}
			}
			return array;
		}
		static Vector3[] GetFullScreenTriangleVertexPosition(float z2)
		{
			Vector3[] array = new Vector3[3];
			for (int i = 0; i < 3; i++)
			{
				Vector2 vector = new Vector2((i << 1) & 2, i & 2);
				array[i] = new Vector3(vector.x * 2f - 1f, vector.y * 2f - 1f, z2);
			}
			return array;
		}
		static Vector2[] GetQuadTexCoord()
		{
			Vector2[] array = new Vector2[4];
			for (uint num = 0u; num < 4; num++)
			{
				uint num2 = num >> 1;
				uint num3 = num & 1;
				float x = num2;
				float num4 = (num2 + num3) & 1;
				if (SystemInfo.graphicsUVStartsAtTop)
				{
					num4 = 1f - num4;
				}
				array[num] = new Vector2(x, num4);
			}
			return array;
		}
		static Vector3[] GetQuadVertexPosition(float z2)
		{
			Vector3[] array = new Vector3[4];
			for (uint num = 0u; num < 4; num++)
			{
				uint num2 = num >> 1;
				uint num3 = num & 1;
				float x = num2;
				float y = (1 - (num2 + num3)) & 1;
				array[num] = new Vector3(x, y, z2);
			}
			return array;
		}
	}

	public static void Cleanup()
	{
		CoreUtils.Destroy(s_Blit);
		s_Blit = null;
		CoreUtils.Destroy(s_BlitColorAndDepth);
		s_BlitColorAndDepth = null;
		CoreUtils.Destroy(s_BlitTexArray);
		s_BlitTexArray = null;
		CoreUtils.Destroy(s_BlitTexArraySingleSlice);
		s_BlitTexArraySingleSlice = null;
		CoreUtils.Destroy(s_TriangleMesh);
		s_TriangleMesh = null;
		CoreUtils.Destroy(s_QuadMesh);
		s_QuadMesh = null;
	}

	public static Material GetBlitMaterial(TextureDimension dimension, bool singleSlice = false)
	{
		if (dimension != TextureDimension.Tex2DArray)
		{
			return s_Blit;
		}
		if (!singleSlice)
		{
			return s_BlitTexArray;
		}
		return s_BlitTexArraySingleSlice;
	}

	private static void DrawTriangle(CommandBuffer cmd, Material material, int shaderPass)
	{
		if (SystemInfo.graphicsShaderLevel < 30)
		{
			cmd.DrawMesh(s_TriangleMesh, Matrix4x4.identity, material, 0, shaderPass, s_PropertyBlock);
		}
		else
		{
			cmd.DrawProcedural(Matrix4x4.identity, material, shaderPass, MeshTopology.Triangles, 3, 1, s_PropertyBlock);
		}
	}

	internal static void DrawQuad(CommandBuffer cmd, Material material, int shaderPass)
	{
		if (SystemInfo.graphicsShaderLevel < 30)
		{
			cmd.DrawMesh(s_QuadMesh, Matrix4x4.identity, material, 0, shaderPass, s_PropertyBlock);
		}
		else
		{
			cmd.DrawProcedural(Matrix4x4.identity, material, shaderPass, MeshTopology.Quads, 4, 1, s_PropertyBlock);
		}
	}

	public static void BlitTexture(CommandBuffer cmd, RTHandle source, Vector4 scaleBias, float mipLevel, bool bilinear)
	{
		s_PropertyBlock.SetFloat(BlitShaderIDs._BlitMipLevel, mipLevel);
		BlitTexture(cmd, source, scaleBias, GetBlitMaterial(TextureXR.dimension), bilinear ? 1 : 0);
	}

	public static void BlitTexture2D(CommandBuffer cmd, RTHandle source, Vector4 scaleBias, float mipLevel, bool bilinear)
	{
		s_PropertyBlock.SetFloat(BlitShaderIDs._BlitMipLevel, mipLevel);
		BlitTexture(cmd, source, scaleBias, GetBlitMaterial(TextureDimension.Tex2D), bilinear ? 1 : 0);
	}

	public static void BlitColorAndDepth(CommandBuffer cmd, Texture sourceColor, RenderTexture sourceDepth, Vector4 scaleBias, float mipLevel, bool blitDepth)
	{
		s_PropertyBlock.SetFloat(BlitShaderIDs._BlitMipLevel, mipLevel);
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitScaleBias, scaleBias);
		s_PropertyBlock.SetTexture(BlitShaderIDs._BlitTexture, sourceColor);
		if (blitDepth)
		{
			s_PropertyBlock.SetTexture(BlitShaderIDs._InputDepth, sourceDepth, RenderTextureSubElement.Depth);
		}
		DrawTriangle(cmd, s_BlitColorAndDepth, blitDepth ? 1 : 0);
	}

	public static void BlitTexture(CommandBuffer cmd, RTHandle source, Vector4 scaleBias, Material material, int pass)
	{
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitScaleBias, scaleBias);
		s_PropertyBlock.SetTexture(BlitShaderIDs._BlitTexture, source);
		DrawTriangle(cmd, material, pass);
	}

	public static void BlitCameraTexture(CommandBuffer cmd, RTHandle source, RTHandle destination, float mipLevel = 0f, bool bilinear = false)
	{
		Vector2 vector = new Vector2(source.rtHandleProperties.rtHandleScale.x, source.rtHandleProperties.rtHandleScale.y);
		CoreUtils.SetRenderTarget(cmd, destination);
		BlitTexture(cmd, source, vector, mipLevel, bilinear);
	}

	public static void BlitCameraTexture2D(CommandBuffer cmd, RTHandle source, RTHandle destination, float mipLevel = 0f, bool bilinear = false)
	{
		Vector2 vector = new Vector2(source.rtHandleProperties.rtHandleScale.x, source.rtHandleProperties.rtHandleScale.y);
		CoreUtils.SetRenderTarget(cmd, destination);
		BlitTexture2D(cmd, source, vector, mipLevel, bilinear);
	}

	public static void BlitCameraTexture(CommandBuffer cmd, RTHandle source, RTHandle destination, Material material, int pass)
	{
		Vector2 vector = new Vector2(source.rtHandleProperties.rtHandleScale.x, source.rtHandleProperties.rtHandleScale.y);
		CoreUtils.SetRenderTarget(cmd, destination);
		BlitTexture(cmd, source, vector, material, pass);
	}

	public static void BlitCameraTexture(CommandBuffer cmd, RTHandle source, RTHandle destination, Vector4 scaleBias, float mipLevel = 0f, bool bilinear = false)
	{
		CoreUtils.SetRenderTarget(cmd, destination);
		BlitTexture(cmd, source, scaleBias, mipLevel, bilinear);
	}

	public static void BlitCameraTexture(CommandBuffer cmd, RTHandle source, RTHandle destination, Rect destViewport, float mipLevel = 0f, bool bilinear = false)
	{
		Vector2 vector = new Vector2(source.rtHandleProperties.rtHandleScale.x, source.rtHandleProperties.rtHandleScale.y);
		CoreUtils.SetRenderTarget(cmd, destination);
		cmd.SetViewport(destViewport);
		BlitTexture(cmd, source, vector, mipLevel, bilinear);
	}

	public static void BlitQuad(CommandBuffer cmd, Texture source, Vector4 scaleBiasTex, Vector4 scaleBiasRT, int mipLevelTex, bool bilinear)
	{
		s_PropertyBlock.SetTexture(BlitShaderIDs._BlitTexture, source);
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitScaleBias, scaleBiasTex);
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitScaleBiasRt, scaleBiasRT);
		s_PropertyBlock.SetFloat(BlitShaderIDs._BlitMipLevel, mipLevelTex);
		DrawQuad(cmd, GetBlitMaterial(source.dimension), bilinear ? 3 : 2);
	}

	public static void BlitQuadWithPadding(CommandBuffer cmd, Texture source, Vector2 textureSize, Vector4 scaleBiasTex, Vector4 scaleBiasRT, int mipLevelTex, bool bilinear, int paddingInPixels)
	{
		s_PropertyBlock.SetTexture(BlitShaderIDs._BlitTexture, source);
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitScaleBias, scaleBiasTex);
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitScaleBiasRt, scaleBiasRT);
		s_PropertyBlock.SetFloat(BlitShaderIDs._BlitMipLevel, mipLevelTex);
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitTextureSize, textureSize);
		s_PropertyBlock.SetInt(BlitShaderIDs._BlitPaddingSize, paddingInPixels);
		if (source.wrapMode == TextureWrapMode.Repeat)
		{
			DrawQuad(cmd, GetBlitMaterial(source.dimension), bilinear ? 7 : 6);
		}
		else
		{
			DrawQuad(cmd, GetBlitMaterial(source.dimension), bilinear ? 5 : 4);
		}
	}

	public static void BlitQuadWithPaddingMultiply(CommandBuffer cmd, Texture source, Vector2 textureSize, Vector4 scaleBiasTex, Vector4 scaleBiasRT, int mipLevelTex, bool bilinear, int paddingInPixels)
	{
		s_PropertyBlock.SetTexture(BlitShaderIDs._BlitTexture, source);
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitScaleBias, scaleBiasTex);
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitScaleBiasRt, scaleBiasRT);
		s_PropertyBlock.SetFloat(BlitShaderIDs._BlitMipLevel, mipLevelTex);
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitTextureSize, textureSize);
		s_PropertyBlock.SetInt(BlitShaderIDs._BlitPaddingSize, paddingInPixels);
		if (source.wrapMode == TextureWrapMode.Repeat)
		{
			DrawQuad(cmd, GetBlitMaterial(source.dimension), bilinear ? 12 : 11);
		}
		else
		{
			DrawQuad(cmd, GetBlitMaterial(source.dimension), bilinear ? 10 : 9);
		}
	}

	public static void BlitOctahedralWithPadding(CommandBuffer cmd, Texture source, Vector2 textureSize, Vector4 scaleBiasTex, Vector4 scaleBiasRT, int mipLevelTex, bool bilinear, int paddingInPixels)
	{
		s_PropertyBlock.SetTexture(BlitShaderIDs._BlitTexture, source);
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitScaleBias, scaleBiasTex);
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitScaleBiasRt, scaleBiasRT);
		s_PropertyBlock.SetFloat(BlitShaderIDs._BlitMipLevel, mipLevelTex);
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitTextureSize, textureSize);
		s_PropertyBlock.SetInt(BlitShaderIDs._BlitPaddingSize, paddingInPixels);
		DrawQuad(cmd, GetBlitMaterial(source.dimension), 8);
	}

	public static void BlitOctahedralWithPaddingMultiply(CommandBuffer cmd, Texture source, Vector2 textureSize, Vector4 scaleBiasTex, Vector4 scaleBiasRT, int mipLevelTex, bool bilinear, int paddingInPixels)
	{
		s_PropertyBlock.SetTexture(BlitShaderIDs._BlitTexture, source);
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitScaleBias, scaleBiasTex);
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitScaleBiasRt, scaleBiasRT);
		s_PropertyBlock.SetFloat(BlitShaderIDs._BlitMipLevel, mipLevelTex);
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitTextureSize, textureSize);
		s_PropertyBlock.SetInt(BlitShaderIDs._BlitPaddingSize, paddingInPixels);
		DrawQuad(cmd, GetBlitMaterial(source.dimension), 13);
	}

	public static void BlitCubeToOctahedral2DQuad(CommandBuffer cmd, Texture source, Vector4 scaleBiasRT, int mipLevelTex)
	{
		s_PropertyBlock.SetTexture(BlitShaderIDs._BlitCubeTexture, source);
		s_PropertyBlock.SetFloat(BlitShaderIDs._BlitMipLevel, mipLevelTex);
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitScaleBias, new Vector4(1f, 1f, 0f, 0f));
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitScaleBiasRt, scaleBiasRT);
		DrawQuad(cmd, GetBlitMaterial(source.dimension), 14);
	}

	public static void BlitCubeToOctahedral2DQuadSingleChannel(CommandBuffer cmd, Texture source, Vector4 scaleBiasRT, int mipLevelTex)
	{
		int shaderPass = 15;
		if (GraphicsFormatUtility.GetComponentCount(source.graphicsFormat) == 1)
		{
			if (GraphicsFormatUtility.IsAlphaOnlyFormat(source.graphicsFormat))
			{
				shaderPass = 16;
			}
			if (GraphicsFormatUtility.GetSwizzleR(source.graphicsFormat) == FormatSwizzle.FormatSwizzleR)
			{
				shaderPass = 17;
			}
		}
		s_PropertyBlock.SetTexture(BlitShaderIDs._BlitCubeTexture, source);
		s_PropertyBlock.SetFloat(BlitShaderIDs._BlitMipLevel, mipLevelTex);
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitScaleBias, new Vector4(1f, 1f, 0f, 0f));
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitScaleBiasRt, scaleBiasRT);
		DrawQuad(cmd, GetBlitMaterial(source.dimension), shaderPass);
	}

	public static void BlitQuadSingleChannel(CommandBuffer cmd, Texture source, Vector4 scaleBiasTex, Vector4 scaleBiasRT, int mipLevelTex)
	{
		int shaderPass = 18;
		if (GraphicsFormatUtility.GetComponentCount(source.graphicsFormat) == 1)
		{
			if (GraphicsFormatUtility.IsAlphaOnlyFormat(source.graphicsFormat))
			{
				shaderPass = 19;
			}
			if (GraphicsFormatUtility.GetSwizzleR(source.graphicsFormat) == FormatSwizzle.FormatSwizzleR)
			{
				shaderPass = 20;
			}
		}
		s_PropertyBlock.SetTexture(BlitShaderIDs._BlitTexture, source);
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitScaleBias, scaleBiasTex);
		s_PropertyBlock.SetVector(BlitShaderIDs._BlitScaleBiasRt, scaleBiasRT);
		s_PropertyBlock.SetFloat(BlitShaderIDs._BlitMipLevel, mipLevelTex);
		DrawQuad(cmd, GetBlitMaterial(source.dimension), shaderPass);
	}
}
