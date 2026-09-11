using System.Collections.Generic;
using UnityEngine;

public class EffectPaticleSystemRenderHelper : MonoBehaviour
{
	[SerializeField]
	private List<ParticleSystem> _particleSystems = new List<ParticleSystem>();

	[SerializeField]
	private List<Renderer> _renders = new List<Renderer>();

	private MaterialPropertyBlock _mpbForCPUParticle;

	public void Clear()
	{
		_particleSystems.Clear();
		_renders.Clear();
	}

	public void Add(ParticleSystem particleSystem, Renderer renderer)
	{
		_particleSystems.Add(particleSystem);
		_renders.Add(renderer);
	}

	public void Play(ParticleSystem particleSystem)
	{
		HideRenderer(particleSystem, hide: false);
	}

	public void Stop(ParticleSystem particleSystem)
	{
		HideRenderer(particleSystem, hide: true);
	}

	public void HideRenderer(ParticleSystem particleSystem, bool hide)
	{
		for (int i = 0; i < _particleSystems.Count; i++)
		{
			if (_particleSystems[i] == particleSystem)
			{
				_renders[i].enabled = !hide;
				break;
			}
		}
	}

	public void SetParticleSystemRendererMPB(int property, float value)
	{
		if (_renders == null)
		{
			return;
		}
		for (int i = 0; i < _renders.Count; i++)
		{
			if (_renders[i].enabled)
			{
				if (_mpbForCPUParticle == null)
				{
					_mpbForCPUParticle = new MaterialPropertyBlock();
				}
				_renders[i].GetPropertyBlock(_mpbForCPUParticle);
				_mpbForCPUParticle.SetFloat(property, value);
				_renders[i].SetPropertyBlock(_mpbForCPUParticle);
			}
		}
	}

	internal bool RemoveNoneComponents()
	{
		bool result = false;
		for (int num = _particleSystems.Count - 1; num >= 0; num--)
		{
			if (_particleSystems[num] == null)
			{
				_particleSystems.RemoveAt(num);
				_renders.RemoveAt(num);
				result = true;
			}
		}
		return result;
	}
}
