using UnityEngine;

namespace ACT.UI;

public class DamageNumberCriticalEffect : MonoBehaviour
{
	[SerializeField]
	private ParticleSystem ring;

	[SerializeField]
	private ParticleSystem particle;

	[SerializeField]
	private ParticleSystem glow;

	[SerializeField]
	private ParticleSystem ray;

	[SerializeField]
	private ParticleSystem screen;

	public void Init(CriticalGlowColor color)
	{
		SetParticleColor(ring, color.ring);
		SetParticleColor(particle, color.particle);
		SetParticleColor(glow, color.glow);
		SetParticleColor(ray, color.ray);
		SetParticleColor(screen, color.screen);
	}

	private void SetParticleColor(ParticleSystem particleSystem, ParticleSystem.MinMaxGradient color)
	{
		ParticleSystem.MainModule main = particleSystem.main;
		main.startColor = color;
	}
}
