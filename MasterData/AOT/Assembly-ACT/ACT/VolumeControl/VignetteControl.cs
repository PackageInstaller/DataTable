using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace ACT.VolumeControl;

[ExecuteAlways]
public class VignetteControl : MonoBehaviour
{
	private Volume volume;

	private Vignette comp;

	[Range(0f, 1f)]
	public float x;

	[Range(0f, 1f)]
	public float y;

	[Range(0f, 1f)]
	public float Intensity = 1f;

	[Range(0f, 1f)]
	public float smoothness = 0.2f;

	public bool Rounded;

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
			if (components[i].GetType() == typeof(Vignette))
			{
				comp = components[i] as Vignette;
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
				comp.smoothness.SetValue(new ClampedFloatParameter(smoothness, 0f, 1f, overrideState: true));
				comp.center.SetValue(new Vector2Parameter(new Vector2(x, y), overrideState: true));
				comp.intensity.SetValue(new ClampedFloatParameter(Intensity, 0f, 1f, overrideState: true));
				comp.rounded.SetValue(new BoolParameter(Rounded, overrideState: true));
			}
			else
			{
				comp.active = false;
			}
		}
	}
}
