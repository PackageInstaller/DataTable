using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace ACT.VolumeControl;

[ExecuteAlways]
public class DeSaturateControl : MonoBehaviour
{
	private Volume volume;

	private DeSaturate comp;

	public bool isOpen;

	[Range(-1f, 1f)]
	public float deSaturate;

	[Range(-1f, 1f)]
	public float darken;

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
			if (components[i].GetType() == typeof(DeSaturate))
			{
				comp = components[i] as DeSaturate;
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
				comp.deSaturate.SetValue(new ClampedFloatParameter(deSaturate, 0f, 1f));
				comp.darken.SetValue(new ClampedFloatParameter(darken, 0f, 1f));
			}
			else
			{
				comp.active = false;
			}
		}
	}
}
