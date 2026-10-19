using System;
using System.Collections.Generic;
using UnityEngine;

public static class WindField
{
	[Serializable]
	public class Wind
	{
		public float WaveLength;

		public float WaveHeight;

		[Range(0f, 0.5f)]
		public float WaveIntensity;

		[Range(0f, 0.99f)]
		public float smoothness;

		public float timeScale;

		public Vector3 WaveForward;
	}

	public const float MaxSmoothness = 0.99f;

	public static List<Wind> GlobalWindList = new List<Wind>();

	public static float windGlobalSize;

	public static float windGlobalIntensity;

	public static float windGlobalTimeScale;
}
