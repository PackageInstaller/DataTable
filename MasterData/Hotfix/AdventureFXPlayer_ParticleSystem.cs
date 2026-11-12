using UnityEngine;

public class AdventureFXPlayer_ParticleSystem : AdventureFXPlayer_Component
{
	internal ParticleSystem rootParticleSystem;

	protected ParticleSystem[] _particleSystems;

	protected bool _hasDistanceBasedEmissionParticleSystem;

	public override bool isLoop
	{
		get
		{
			if (rootParticleSystem != null)
			{
				return rootParticleSystem.main.loop;
			}
			return false;
		}
	}

	public override bool isStoped
	{
		get
		{
			if (rootParticleSystem != null && rootParticleSystem.IsAlive(withChildren: true))
			{
				return false;
			}
			return true;
		}
	}

	public override void Initialize(AdventureFXPlayer fxPlayer)
	{
		base.Initialize(fxPlayer);
		if (!(rootParticleSystem != null))
		{
			return;
		}
		_particleSystems = GetComponentsInChildren<ParticleSystem>();
		for (int i = 0; i < _particleSystems.Length; i++)
		{
			if (IsDistanceBasedEmissionParticleSystem(_particleSystems[i]))
			{
				_hasDistanceBasedEmissionParticleSystem = true;
				break;
			}
		}
	}

	public override void Release()
	{
		if (rootParticleSystem != null)
		{
			rootParticleSystem.Stop(withChildren: true, ParticleSystemStopBehavior.StopEmittingAndClear);
		}
	}

	public override void Play()
	{
		if (rootParticleSystem != null)
		{
			rootParticleSystem.Clear(withChildren: true);
			rootParticleSystem.Play(withChildren: true);
		}
	}

	public override void Stop()
	{
		if (rootParticleSystem != null)
		{
			rootParticleSystem.Stop(withChildren: true, ParticleSystemStopBehavior.StopEmittingAndClear);
		}
	}

	public override void Pause()
	{
		if (rootParticleSystem != null)
		{
			rootParticleSystem.Pause(withChildren: true);
		}
	}

	public override void Resume()
	{
		if (rootParticleSystem != null)
		{
			rootParticleSystem.Play(withChildren: true);
		}
	}

	public override void PlayInRemain()
	{
		if (!(rootParticleSystem != null))
		{
			return;
		}
		if (!_hasDistanceBasedEmissionParticleSystem)
		{
			rootParticleSystem.Stop(withChildren: true, ParticleSystemStopBehavior.StopEmitting);
			return;
		}
		for (int i = 0; i < _particleSystems.Length; i++)
		{
			if (!IsDistanceBasedEmissionParticleSystem(_particleSystems[i]))
			{
				_particleSystems[i].Stop(withChildren: false, ParticleSystemStopBehavior.StopEmitting);
			}
		}
	}

	public override void OnUpdatePlaybackSpeed(float playbackSpeed, float timeScale)
	{
		if (rootParticleSystem != null)
		{
			for (int i = 0; i < _particleSystems.Length; i++)
			{
				ParticleSystem.MainModule main = _particleSystems[i].main;
				main.simulationSpeed = playbackSpeed * timeScale;
			}
		}
	}

	public override void OnIndependentUpdateChanged(bool value)
	{
		if (rootParticleSystem != null)
		{
			for (int i = 0; i < _particleSystems.Length; i++)
			{
				ParticleSystem.MainModule main = _particleSystems[i].main;
				main.useUnscaledTime = value;
			}
		}
	}

	protected bool IsDistanceBasedEmissionParticleSystem(ParticleSystem particleSystem)
	{
		ParticleSystem.MinMaxCurve rateOverDistance = particleSystem.emission.rateOverDistance;
		if ((rateOverDistance.mode == ParticleSystemCurveMode.Constant && rateOverDistance.constant > float.Epsilon) || rateOverDistance.mode == ParticleSystemCurveMode.TwoConstants || rateOverDistance.mode == ParticleSystemCurveMode.Curve || rateOverDistance.mode == ParticleSystemCurveMode.TwoCurves)
		{
			return true;
		}
		return false;
	}
}
