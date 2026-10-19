using System;

namespace UnityEngine.Rendering;

public static class Blitter
{
	private static Material s_Blit;

	private static Material s_BlitTexArray;

	private static Material s_BlitTexArraySingleSlice;

	private static Material s_BlitColorAndDepth;

	private static MaterialPropertyBlock s_PropertyBlock = new MaterialPropertyBlock();

	private static Mesh s_TriangleMesh;

	private static Mesh s_QuadMesh;

	private static LocalKeyword s_DecodeHdrKeyword;

	public static void Initialize(Shader blitPS, Shader blitColorAndDepthPS)
	{
		if (s_Blit != null)
		{
			throw new Exception("Blitter is already initialized. Please only initialize the blitter once or you will leak engine resources. If you need to re-initialize the blitter with different shaders destroy & recreate it.");
		}
		s_Blit = CoreUtils.CreateEngineMaterial(blitPS);
		s_BlitColorAndDepth = CoreUtils.CreateEngineMaterial(blitColorAndDepthPS);
		s_DecodeHdrKeyword = new LocalKeyword(blitPS, "BLIT_DECODE_HDR");
		if (SystemInfo.supports2DArrayTextures)
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
}
