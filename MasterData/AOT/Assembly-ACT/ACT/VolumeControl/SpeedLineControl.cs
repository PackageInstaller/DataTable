using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using XPostProcessing;

namespace ACT.VolumeControl;

[ExecuteAlways]
public class SpeedLineControl : MonoBehaviour
{
	private Volume volume;

	private SpeedLine comp;

	[ColorUsage(false, true)]
	public Color color;

	public float angle;

	public float weight;

	public float dissolve;

	public float dissolveRange;

	public float dissolveMapScale;

	public Vector2 noiseScale;

	public Vector2 noiseOffset;

	public Vector2 fadeNoiseScale;

	public Vector2 fadeNoiseOffset;

	public float fadeNoisePower;

	public float fadeRangeMin;

	public float fadeRangeMax;

	public bool isOpen;

	private void Awake()
	{
		volume = GetComponent<Volume>();
		if (!(volume != null))
		{
			return;
		}
		List<VolumeComponent> components = volume.profile.components;
		for (int i = 0; i < components.Count; i++)
		{
			if (components[i].GetType() == typeof(SpeedLine))
			{
				comp = components[i] as SpeedLine;
			}
		}
	}

	private void Update()
	{
		if (comp != null)
		{
			if (isOpen)
			{
				comp.active = true;
				comp.Color.value = color;
				comp.angle.value = angle;
				comp.Weight.value = weight;
				comp.Threshold.value = dissolve;
				comp.ThresholdRange.value = dissolveRange;
				comp.DissolveMapScale.value = dissolveMapScale;
				comp.NoiseScale.value = noiseScale;
				comp.NoiseOffset.value = noiseOffset;
				comp.FadeNoiseScale.value = fadeNoiseScale;
				comp.FadeNoiseOffset.value = fadeNoiseOffset;
				comp.FadeNoisePower.value = fadeNoisePower;
				comp.FadeRangeMin.value = fadeRangeMin;
				comp.FadeRangeMax.value = fadeRangeMax;
			}
			else
			{
				comp.active = false;
			}
		}
	}
}
