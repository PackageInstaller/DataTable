using System;
using PigeonCoopToolkit.Utillities;
using UnityEngine;

namespace PigeonCoopToolkit.Effects.Trails;

public class PCTrail : IDisposable
{
	public CircularBuffer<PCTrailPoint> Points;

	public Mesh Mesh;

	public Vector3[] verticies;

	public Vector3[] normals;

	public Vector2[] uvs;

	public Color[] colors;

	public int[] indicies;

	public int activePointCount;

	public bool IsActiveTrail;

	public Material material;

	public float material_Dissolution_Intensity = 1f;

	public bool have_Dissolution_Intensity;

	public PCTrail(int numPoints)
	{
		Mesh = new Mesh();
		Mesh.MarkDynamic();
		verticies = new Vector3[2 * numPoints];
		normals = new Vector3[2 * numPoints];
		uvs = new Vector2[2 * numPoints];
		colors = new Color[2 * numPoints];
		indicies = new int[(2 * numPoints - 2) * 3];
		Points = new CircularBuffer<PCTrailPoint>(numPoints);
	}

	public void Clear()
	{
		Points.Clear();
		for (int i = 0; i < verticies.Length; i++)
		{
			verticies[i] = Vector3.zero;
		}
		for (int j = 0; j < normals.Length; j++)
		{
			normals[j] = Vector3.zero;
		}
		for (int k = 0; k < uvs.Length; k++)
		{
			uvs[k] = Vector2.zero;
		}
		for (int l = 0; l < colors.Length; l++)
		{
			colors[l] = Color.white;
		}
		for (int m = 0; m < indicies.Length; m++)
		{
			indicies[m] = 0;
		}
		activePointCount = 0;
		IsActiveTrail = false;
	}

	public void Dispose()
	{
		if (Mesh != null)
		{
			if (Application.isEditor)
			{
				UnityEngine.Object.DestroyImmediate(Mesh, allowDestroyingAssets: true);
			}
			else
			{
				UnityEngine.Object.Destroy(Mesh);
			}
		}
		Points.Clear();
		Points = null;
		material = null;
	}
}
