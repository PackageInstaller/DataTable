using System;
using UnityEngine;

namespace ACT.UI;

public class BloodWarn : MonoBehaviour
{
	[NonSerialized]
	public bool playing;

	private ParticleSystem[] particles;

	private void Awake()
	{
		particles = GetComponentsInChildren<ParticleSystem>();
	}

	public void PlayReset()
	{
		if (playing)
		{
			StopPlay();
		}
	}

	public void RePlay()
	{
		if (particles != null)
		{
			ParticleSystem[] array = particles;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].Play();
			}
		}
	}

	public void StartPlay()
	{
		gameObject.SetActive(value: true);
		playing = true;
		if (particles != null)
		{
			ParticleSystem[] array = particles;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].Play(withChildren: false);
			}
		}
	}

	public void StopPlay()
	{
		gameObject.SetActive(value: false);
		playing = false;
		if (particles != null)
		{
			ParticleSystem[] array = particles;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].Stop(withChildren: false);
			}
		}
	}
}
