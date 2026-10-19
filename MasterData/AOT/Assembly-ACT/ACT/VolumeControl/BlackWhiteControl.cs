using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using XPostProcessing;

namespace ACT.VolumeControl;

[ExecuteAlways]
public class BlackWhiteControl : MonoBehaviour
{
	private Volume volume;

	private BlackWhite comp;

	public Vector2 OriginalPoint = new Vector2(0.5f, 0.5f);

	[ColorUsage(true, true)]
	public Color TintColor = Color.white;

	[Range(0f, 1f)]
	public float Threshold = 0.063f;

	[Range(0f, 1f)]
	public float Range;

	public Vector4 TextureTilling = new Vector4(34.06f, 1.3f, 0f, 0f);

	public float NoisePower = 0.72f;

	public float minPower;

	[Range(0f, 1f)]
	public float DissolveWeight = 0.526f;

	[Range(0f, 1f)]
	public float change;

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
			if (components[i].GetType() == typeof(BlackWhite))
			{
				comp = components[i] as BlackWhite;
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
				comp.Enable.SetValue(new BoolParameter(value: true));
				comp.Center.SetValue(new Vector2Parameter(OriginalPoint));
				comp.TintColor.SetValue(new ColorParameter(TintColor, hdr: true, showAlpha: true, showEyeDropper: true, overrideState: true));
				comp.Threshold.SetValue(new ClampedFloatParameter(Threshold, 0f, 1f));
				comp.Range.SetValue(new ClampedFloatParameter(Range, 0f, 1f));
				comp.TextureTilling.SetValue(new Vector4Parameter(TextureTilling));
				comp.NoisePower.SetValue(new FloatParameter(NoisePower));
				comp.DissolveWeight.SetValue(new ClampedFloatParameter(DissolveWeight, 0f, 1f));
				comp.Change.SetValue(new ClampedIntParameter((int)change, 0, 1));
				comp.MinPower.SetValue(new MinFloatParameter(minPower, 0f));
			}
			else
			{
				comp.active = false;
			}
		}
	}
}
