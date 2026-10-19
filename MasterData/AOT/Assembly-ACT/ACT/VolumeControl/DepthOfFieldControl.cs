using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace ACT.VolumeControl;

public class DepthOfFieldControl : MonoBehaviour
{
	private Volume volume;

	private DepthOfField comp;

	private float tempFocus;

	public bool UseTarget;

	public GameObject Target;

	public GameObject Target2;

	[Range(0f, 1f)]
	public float TargetChange;

	public GameObject Camera;

	public float Focus = 10f;

	[Range(0f, 300f)]
	public float LensDistance;

	[Range(0f, 32f)]
	public float Ratio;

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
			if (components[i].GetType() == typeof(DepthOfField))
			{
				comp = components[i] as DepthOfField;
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
			if (UseTarget && Target != null && Camera != null)
			{
				Vector3 vector = Vector3.Lerp(Target.transform.position, Target2.transform.position, TargetChange);
				tempFocus = Vector3.Dot(vector - Camera.transform.position, Camera.transform.forward);
				tempFocus = Mathf.Abs(tempFocus);
			}
			else
			{
				tempFocus = Focus;
			}
			comp.active = true;
			comp.mode.overrideState = true;
			comp.mode.SetValue(new DepthOfFieldModeParameter(DepthOfFieldMode.Bokeh));
			comp.focalLength.SetValue(new ClampedFloatParameter(LensDistance, 0f, 300f));
			comp.focusDistance.SetValue(new MaxFloatParameter(tempFocus, 0f));
			comp.aperture.SetValue(new ClampedFloatParameter(Ratio, 0f, 32f));
		}
		else
		{
			comp.active = false;
		}
	}
}
