using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using XPostProcessing;

namespace ACT.VolumeControl;

[ExecuteAlways]
public class RadialBlurV2Control : MonoBehaviour
{
	private Volume volume;

	private RadialBlurV2 comp;

	private RadialBlurV2Helper radialBlurHelper;

	[Range(-1f, 1f)]
	public float blurRadius;

	[Range(-1f, 1f)]
	public float radialCenterX;

	[Range(-1f, 1f)]
	public float radialCenterY;

	public bool isOpen;

	private void Awake()
	{
		volume = GetComponent<Volume>();
		radialBlurHelper = GetComponent<RadialBlurV2Helper>();
		if (!(volume != null))
		{
			return;
		}
		List<VolumeComponent> components = volume.profile.components;
		for (int i = 0; i < components.Count; i++)
		{
			if (components[i].GetType() == typeof(RadialBlurV2))
			{
				comp = components[i] as RadialBlurV2;
			}
		}
	}

	private void Update()
	{
		if (!(comp != null))
		{
			return;
		}
		if (isOpen)
		{
			comp.active = true;
			comp.BlurRadius.value = blurRadius;
			if (radialBlurHelper == null)
			{
				comp.RadialCenterX.value = radialCenterX;
				comp.RadialCenterY.value = radialCenterY;
			}
		}
		else
		{
			comp.active = false;
		}
	}
}
