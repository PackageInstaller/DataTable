using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using XPostProcessing;

[ExecuteAlways]
public class CameraShakeControl : MonoBehaviour
{
	public Vector2 shake;

	[Range(0f, 1f)]
	public float Scale = 0.1f;

	private Volume volume;

	private CameraShake comp;

	private void Start()
	{
		volume = GetComponent<Volume>();
		if (!(volume != null))
		{
			return;
		}
		List<VolumeComponent> components = volume.profile.components;
		for (int i = 0; i < components.Count; i++)
		{
			if (components[i].GetType() == typeof(CameraShake))
			{
				comp = components[i] as CameraShake;
			}
		}
	}

	private void Update()
	{
		comp.ShakeOffset.SetValue(new Vector2Parameter(shake));
	}
}
