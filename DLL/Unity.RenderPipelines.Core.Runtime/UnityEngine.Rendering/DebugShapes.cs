using System;

namespace UnityEngine.Rendering;

public class DebugShapes
{
	private static DebugShapes s_Instance;

	private Mesh m_sphereMesh;

	private Mesh m_boxMesh;

	private Mesh m_coneMesh;

	private Mesh m_pyramidMesh;

	public static DebugShapes instance
	{
		get
		{
			if (s_Instance == null)
			{
				s_Instance = new DebugShapes();
			}
			return s_Instance;
		}
	}

	private void BuildSphere(ref Mesh outputMesh, float radius, uint longSubdiv, uint latSubdiv)
	{
		outputMesh.Clear();
		Vector3[] array = new Vector3[(longSubdiv + 1) * latSubdiv + 2];
		float num = MathF.PI;
		float num2 = num * 2f;
		array[0] = Vector3.up * radius;
		for (int i = 0; i < latSubdiv; i++)
		{
			float f = num * (float)(i + 1) / (float)(latSubdiv + 1);
			float num3 = Mathf.Sin(f);
			float y = Mathf.Cos(f);
			for (int j = 0; j <= longSubdiv; j++)
			{
				float f2 = num2 * (float)((j != longSubdiv) ? j : 0) / (float)longSubdiv;
				float num4 = Mathf.Sin(f2);
				float num5 = Mathf.Cos(f2);
				array[j + i * (longSubdiv + 1) + 1] = new Vector3(num3 * num5, y, num3 * num4) * radius;
			}
		}
		array[array.Length - 1] = Vector3.up * (0f - radius);
		Vector3[] array2 = new Vector3[array.Length];
		for (int k = 0; k < array.Length; k++)
		{
			array2[k] = array[k].normalized;
		}
		Vector2[] array3 = new Vector2[array.Length];
		array3[0] = Vector2.up;
		array3[array3.Length - 1] = Vector2.zero;
		for (int l = 0; l < latSubdiv; l++)
		{
			for (int m = 0; m <= longSubdiv; m++)
			{
				array3[m + l * (longSubdiv + 1) + 1] = new Vector2((float)m / (float)longSubdiv, 1f - (float)(l + 1) / (float)(latSubdiv + 1));
			}
		}
		int[] array4 = new int[array.Length * 2 * 3];
		int num6 = 0;
		for (int n = 0; n < longSubdiv; n++)
		{
			array4[num6++] = n + 2;
			array4[num6++] = n + 1;
			array4[num6++] = 0;
		}
		for (uint num7 = 0u; num7 < latSubdiv - 1; num7++)
		{
			for (uint num8 = 0u; num8 < longSubdiv; num8++)
			{
				uint num9 = num8 + num7 * (longSubdiv + 1) + 1;
				uint num10 = num9 + longSubdiv + 1;
				array4[num6++] = (int)num9;
				array4[num6++] = (int)(num9 + 1);
				array4[num6++] = (int)(num10 + 1);
				array4[num6++] = (int)num9;
				array4[num6++] = (int)(num10 + 1);
				array4[num6++] = (int)num10;
			}
		}
		for (int num11 = 0; num11 < longSubdiv; num11++)
		{
			array4[num6++] = array.Length - 1;
			array4[num6++] = array.Length - (num11 + 2) - 1;
			array4[num6++] = array.Length - (num11 + 1) - 1;
		}
		outputMesh.vertices = array;
		outputMesh.normals = array2;
		outputMesh.uv = array3;
		outputMesh.triangles = array4;
		outputMesh.RecalculateBounds();
	}

	private void BuildBox(ref Mesh outputMesh, float length, float width, float height)
	{
		outputMesh.Clear();
		Vector3 vector = new Vector3((0f - length) * 0.5f, (0f - width) * 0.5f, height * 0.5f);
		Vector3 vector2 = new Vector3(length * 0.5f, (0f - width) * 0.5f, height * 0.5f);
		Vector3 vector3 = new Vector3(length * 0.5f, (0f - width) * 0.5f, (0f - height) * 0.5f);
		Vector3 vector4 = new Vector3((0f - length) * 0.5f, (0f - width) * 0.5f, (0f - height) * 0.5f);
		Vector3 vector5 = new Vector3((0f - length) * 0.5f, width * 0.5f, height * 0.5f);
		Vector3 vector6 = new Vector3(length * 0.5f, width * 0.5f, height * 0.5f);
		Vector3 vector7 = new Vector3(length * 0.5f, width * 0.5f, (0f - height) * 0.5f);
		Vector3 vector8 = new Vector3((0f - length) * 0.5f, width * 0.5f, (0f - height) * 0.5f);
		Vector3[] vertices = new Vector3[24]
		{
			vector, vector2, vector3, vector4, vector8, vector5, vector, vector4, vector5, vector6,
			vector2, vector, vector7, vector8, vector4, vector3, vector6, vector7, vector3, vector2,
			vector8, vector7, vector6, vector5
		};
		Vector3 up = Vector3.up;
		Vector3 down = Vector3.down;
		Vector3 forward = Vector3.forward;
		Vector3 back = Vector3.back;
		Vector3 left = Vector3.left;
		Vector3 right = Vector3.right;
		Vector3[] normals = new Vector3[24]
		{
			down, down, down, down, left, left, left, left, forward, forward,
			forward, forward, back, back, back, back, right, right, right, right,
			up, up, up, up
		};
		Vector2 vector9 = new Vector2(0f, 0f);
		Vector2 vector10 = new Vector2(1f, 0f);
		Vector2 vector11 = new Vector2(0f, 1f);
		Vector2 vector12 = new Vector2(1f, 1f);
		Vector2[] uv = new Vector2[24]
		{
			vector12, vector11, vector9, vector10, vector12, vector11, vector9, vector10, vector12, vector11,
			vector9, vector10, vector12, vector11, vector9, vector10, vector12, vector11, vector9, vector10,
			vector12, vector11, vector9, vector10
		};
		int[] triangles = new int[36]
		{
			3, 1, 0, 3, 2, 1, 7, 5, 4, 7,
			6, 5, 11, 9, 8, 11, 10, 9, 15, 13,
			12, 15, 14, 13, 19, 17, 16, 19, 18, 17,
			23, 21, 20, 23, 22, 21
		};
		outputMesh.vertices = vertices;
		outputMesh.normals = normals;
		outputMesh.uv = uv;
		outputMesh.triangles = triangles;
		outputMesh.RecalculateBounds();
	}

	private void BuildCone(ref Mesh outputMesh, float height, float topRadius, float bottomRadius, int nbSides)
	{
		outputMesh.Clear();
		int num = nbSides + 1;
		Vector3[] array = new Vector3[num + num + nbSides * 2 + 2];
		int i = 0;
		float num2 = MathF.PI * 2f;
		array[i++] = new Vector3(0f, 0f, 0f);
		for (; i <= nbSides; i++)
		{
			float f = (float)i / (float)nbSides * num2;
			array[i] = new Vector3(Mathf.Sin(f) * bottomRadius, Mathf.Cos(f) * bottomRadius, 0f);
		}
		array[i++] = new Vector3(0f, 0f, height);
		for (; i <= nbSides * 2 + 1; i++)
		{
			float f2 = (float)(i - nbSides - 1) / (float)nbSides * num2;
			array[i] = new Vector3(Mathf.Sin(f2) * topRadius, Mathf.Cos(f2) * topRadius, height);
		}
		int num3 = 0;
		while (i <= array.Length - 4)
		{
			float f3 = (float)num3 / (float)nbSides * num2;
			array[i] = new Vector3(Mathf.Sin(f3) * topRadius, Mathf.Cos(f3) * topRadius, height);
			array[i + 1] = new Vector3(Mathf.Sin(f3) * bottomRadius, Mathf.Cos(f3) * bottomRadius, 0f);
			i += 2;
			num3++;
		}
		array[i] = array[nbSides * 2 + 2];
		array[i + 1] = array[nbSides * 2 + 3];
		Vector3[] array2 = new Vector3[array.Length];
		i = 0;
		while (i <= nbSides)
		{
			array2[i++] = new Vector3(0f, 0f, -1f);
		}
		while (i <= nbSides * 2 + 1)
		{
			array2[i++] = new Vector3(0f, 0f, 1f);
		}
		num3 = 0;
		while (i <= array.Length - 4)
		{
			float f4 = (float)num3 / (float)nbSides * num2;
			float y = Mathf.Cos(f4);
			float x = Mathf.Sin(f4);
			array2[i] = new Vector3(x, y, 0f);
			array2[i + 1] = array2[i];
			i += 2;
			num3++;
		}
		array2[i] = array2[nbSides * 2 + 2];
		array2[i + 1] = array2[nbSides * 2 + 3];
		Vector2[] array3 = new Vector2[array.Length];
		int j = 0;
		array3[j++] = new Vector2(0.5f, 0.5f);
		for (; j <= nbSides; j++)
		{
			float f5 = (float)j / (float)nbSides * num2;
			array3[j] = new Vector2(Mathf.Cos(f5) * 0.5f + 0.5f, Mathf.Sin(f5) * 0.5f + 0.5f);
		}
		array3[j++] = new Vector2(0.5f, 0.5f);
		for (; j <= nbSides * 2 + 1; j++)
		{
			float f6 = (float)j / (float)nbSides * num2;
			array3[j] = new Vector2(Mathf.Cos(f6) * 0.5f + 0.5f, Mathf.Sin(f6) * 0.5f + 0.5f);
		}
		int num4 = 0;
		while (j <= array3.Length - 4)
		{
			float x2 = (float)num4 / (float)nbSides;
			array3[j] = new Vector3(x2, 1f);
			array3[j + 1] = new Vector3(x2, 0f);
			j += 2;
			num4++;
		}
		array3[j] = new Vector2(1f, 1f);
		array3[j + 1] = new Vector2(1f, 0f);
		int num5 = nbSides + nbSides + nbSides * 2;
		int[] array4 = new int[num5 * 3 + 3];
		int num6 = 0;
		int num7 = 0;
		while (num6 < nbSides - 1)
		{
			array4[num7] = 0;
			array4[num7 + 1] = num6 + 1;
			array4[num7 + 2] = num6 + 2;
			num6++;
			num7 += 3;
		}
		array4[num7] = 0;
		array4[num7 + 1] = num6 + 1;
		array4[num7 + 2] = 1;
		num6++;
		num7 += 3;
		while (num6 < nbSides * 2)
		{
			array4[num7] = num6 + 2;
			array4[num7 + 1] = num6 + 1;
			array4[num7 + 2] = num;
			num6++;
			num7 += 3;
		}
		array4[num7] = num + 1;
		array4[num7 + 1] = num6 + 1;
		array4[num7 + 2] = num;
		num6++;
		num7 += 3;
		num6++;
		while (num6 <= num5)
		{
			array4[num7] = num6 + 2;
			array4[num7 + 1] = num6 + 1;
			array4[num7 + 2] = num6;
			num6++;
			num7 += 3;
			array4[num7] = num6 + 1;
			array4[num7 + 1] = num6 + 2;
			array4[num7 + 2] = num6;
			num6++;
			num7 += 3;
		}
		outputMesh.vertices = array;
		outputMesh.normals = array2;
		outputMesh.uv = array3;
		outputMesh.triangles = array4;
		outputMesh.RecalculateBounds();
	}

	private void BuildPyramid(ref Mesh outputMesh, float width, float height, float depth)
	{
		outputMesh.Clear();
		Vector3[] array = new Vector3[16]
		{
			new Vector3(0f, 0f, 0f),
			new Vector3((0f - width) / 2f, height / 2f, depth),
			new Vector3(width / 2f, height / 2f, depth),
			new Vector3(0f, 0f, 0f),
			new Vector3(width / 2f, height / 2f, depth),
			new Vector3(width / 2f, (0f - height) / 2f, depth),
			new Vector3(0f, 0f, 0f),
			new Vector3(width / 2f, (0f - height) / 2f, depth),
			new Vector3((0f - width) / 2f, (0f - height) / 2f, depth),
			new Vector3(0f, 0f, 0f),
			new Vector3((0f - width) / 2f, (0f - height) / 2f, depth),
			new Vector3((0f - width) / 2f, height / 2f, depth),
			new Vector3((0f - width) / 2f, height / 2f, depth),
			new Vector3((0f - width) / 2f, (0f - height) / 2f, depth),
			new Vector3(width / 2f, (0f - height) / 2f, depth),
			new Vector3(width / 2f, height / 2f, depth)
		};
		Vector3[] normals = new Vector3[array.Length];
		Vector2[] uv = new Vector2[array.Length];
		int[] array2 = new int[18];
		for (int i = 0; i < 12; i++)
		{
			array2[i] = i;
		}
		array2[12] = 12;
		array2[13] = 13;
		array2[14] = 14;
		array2[15] = 12;
		array2[16] = 14;
		array2[17] = 15;
		outputMesh.vertices = array;
		outputMesh.normals = normals;
		outputMesh.uv = uv;
		outputMesh.triangles = array2;
		outputMesh.RecalculateBounds();
	}

	private void BuildShapes()
	{
		m_sphereMesh = new Mesh();
		BuildSphere(ref m_sphereMesh, 1f, 24u, 16u);
		m_boxMesh = new Mesh();
		BuildBox(ref m_boxMesh, 1f, 1f, 1f);
		m_coneMesh = new Mesh();
		BuildCone(ref m_coneMesh, 1f, 1f, 0f, 16);
		m_pyramidMesh = new Mesh();
		BuildPyramid(ref m_pyramidMesh, 1f, 1f, 1f);
	}

	private void RebuildResources()
	{
		if (m_sphereMesh == null || m_boxMesh == null || m_coneMesh == null || m_pyramidMesh == null)
		{
			BuildShapes();
		}
	}

	public Mesh RequestSphereMesh()
	{
		RebuildResources();
		return m_sphereMesh;
	}

	public Mesh RequestBoxMesh()
	{
		RebuildResources();
		return m_boxMesh;
	}

	public Mesh RequestConeMesh()
	{
		RebuildResources();
		return m_coneMesh;
	}

	public Mesh RequestPyramidMesh()
	{
		RebuildResources();
		return m_pyramidMesh;
	}
}
