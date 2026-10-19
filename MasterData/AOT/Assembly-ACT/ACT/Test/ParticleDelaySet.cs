using UnityEngine;

namespace ACT.Test;

public class ParticleDelaySet : MonoBehaviour
{
	private float[] OriginalDelay;

	public float AddDelay;

	private ParticleSystem[] particles;

	private void StoreData()
	{
		particles = GetComponentsInChildren<ParticleSystem>();
		OriginalDelay = new float[particles.Length];
		for (int i = 0; i < particles.Length; i++)
		{
			OriginalDelay[i] = particles[i].main.startDelay.constant;
		}
	}

	private void HardSet()
	{
		for (int i = 0; i < particles.Length; i++)
		{
			ParticleSystem.MainModule main = particles[i].main;
			main.startDelay = AddDelay;
		}
	}

	private void setDelay()
	{
		for (int i = 0; i < particles.Length; i++)
		{
			ParticleSystem.MainModule main = particles[i].main;
			main.startDelay = particles[i].main.startDelay.constant + AddDelay;
		}
	}

	private void reSet()
	{
		for (int i = 0; i < particles.Length; i++)
		{
			ParticleSystem.MainModule main = particles[i].main;
			main.startDelay = OriginalDelay[i];
		}
	}
}
