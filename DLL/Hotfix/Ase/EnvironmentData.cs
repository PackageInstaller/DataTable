using System;
using UnityEngine;
using UnityEngine.Rendering;

namespace Ase;

[Serializable]
public class EnvironmentData
{
	[HideInInspector]
	public bool openBlend;

	public bool enableDirectLight;

	public Vector3 rotation;

	public LayerMask cullingMask;

	public Color emissionColor;

	public float emissionIntensity;

	public float emissionIndirectMultiplier;

	public bool enableSkybox;

	public Material skyMaterial;

	public bool enableEnvironment;

	public AmbientMode ambientMode;

	[ColorUsage(true, true)]
	public Color ambientLight;

	[ColorUsage(true, true)]
	public Color ambientSkyColor;

	[ColorUsage(true, true)]
	public Color ambientEquatorColor;

	[ColorUsage(true, true)]
	public Color ambientGroundColor;

	public float ambientIntensity;

	public bool enableFog;

	[ColorUsage(true, true)]
	public Color baseColor;

	[ColorUsage(true, true)]
	public Color fogColor;

	public float fogStrength;

	public float fogDistance;

	public float fogStartDistance;

	public float fogFarDistance;

	public float planeHeight;

	public float fogScale;

	public Vector4 fogSpeed;

	public float bumpHeight;

	public Color AmbientColor
	{
		get
		{
			if (ambientMode != AmbientMode.Flat)
			{
				return ambientSkyColor;
			}
			return ambientLight;
		}
	}

	public void SetData(EnvironmentData other)
	{
		openBlend = other.openBlend;
		enableDirectLight = other.enableDirectLight;
		rotation = other.rotation;
		cullingMask = other.cullingMask;
		emissionColor = other.emissionColor;
		emissionIntensity = other.emissionIntensity;
		emissionIndirectMultiplier = other.emissionIndirectMultiplier;
		enableSkybox = other.enableSkybox;
		skyMaterial = other.skyMaterial;
		enableEnvironment = other.enableEnvironment;
		ambientMode = other.ambientMode;
		ambientEquatorColor = other.ambientEquatorColor;
		ambientGroundColor = other.ambientGroundColor;
		ambientIntensity = other.ambientIntensity;
		ambientLight = other.ambientLight;
		ambientSkyColor = other.ambientSkyColor;
		enableFog = other.enableFog;
		baseColor = other.baseColor;
		fogColor = other.fogColor;
		fogStrength = other.fogStrength;
		fogDistance = other.fogDistance;
		fogStartDistance = other.fogStartDistance;
		fogFarDistance = other.fogFarDistance;
		planeHeight = other.planeHeight;
		fogScale = other.fogScale;
		fogSpeed = other.fogSpeed;
		bumpHeight = other.bumpHeight;
	}
}
