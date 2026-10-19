using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class LightHalo
{
	[Serializable]
	public class LightHaloData
	{
		[Range(0f, 1f)]
		public float offset;

		[Range(0f, 1f)]
		public float rotation;

		[ColorUsage(true, true)]
		public Color color = Color.white;

		public Vector2 size;

		public Material material;
	}

	[Range(0f, 2f)]
	public float Intensity = 1f;

	public float DepthOffset;

	public List<LightHaloData> HaloData = new List<LightHaloData>();
}
