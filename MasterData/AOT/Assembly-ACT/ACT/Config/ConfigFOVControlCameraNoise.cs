using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Config;

public class ConfigFOVControlCameraNoise : ScriptableObject
{
	[Serializable]
	public class FOVNoiseData
	{
		[Min(0f)]
		public float minFOV;

		[Min(0f)]
		public float maxFOV = 100f;

		[Min(0f)]
		public float forceMultiplier = 1f;
	}

	[Serializable]
	public class CamDisNoiseData
	{
		[Min(0f)]
		public float minCamDis;

		[Min(0f)]
		public float maxCamDIs = 30f;

		[Min(0f)]
		public float forceMultiplier = 1f;
	}

	public List<FOVNoiseData> fovNoiseDataList = new List<FOVNoiseData>();

	public List<CamDisNoiseData> camDisNoiseDataList = new List<CamDisNoiseData>();

	public float GetForceMultiplierByFOV(float currentFOV, float currentCamDis)
	{
		float num = 1f;
		foreach (FOVNoiseData fovNoiseData in fovNoiseDataList)
		{
			if (currentFOV >= fovNoiseData.minFOV && currentFOV <= fovNoiseData.maxFOV)
			{
				num *= fovNoiseData.forceMultiplier;
				break;
			}
		}
		foreach (CamDisNoiseData camDisNoiseData in camDisNoiseDataList)
		{
			if (currentCamDis >= camDisNoiseData.minCamDis && currentCamDis <= camDisNoiseData.maxCamDIs)
			{
				num *= camDisNoiseData.forceMultiplier;
				break;
			}
		}
		return num;
	}
}
