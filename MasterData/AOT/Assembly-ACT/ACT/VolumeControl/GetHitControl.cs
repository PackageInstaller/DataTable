using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using XPostProcessing;

namespace ACT.VolumeControl;

[ExecuteAlways]
public class GetHitControl : MonoBehaviour
{
	private Volume volume;

	private GetHit getHit;

	public float indensity;

	public float splitR;

	public float splitB;

	public Vector2 focus;

	public float dIndensity;

	public Vector4 dOffset = new Vector4(1f, 1f, 0f, 0f);

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
			if (components[i].GetType() == typeof(GetHit))
			{
				getHit = components[i] as GetHit;
			}
		}
	}

	private void Update()
	{
		if (getHit != null)
		{
			getHit.active = isOpen;
			if (isOpen)
			{
				getHit.distortionTexOffset.value = dOffset;
				getHit.indensity.value = indensity;
				getHit.splitR.value = splitR;
				getHit.splitB.value = splitB;
				getHit.Focus.value = focus;
				getHit.dIndensity.value = dIndensity;
			}
		}
	}
}
