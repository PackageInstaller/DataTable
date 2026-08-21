using Ase.ECS;
using UnityEngine;

namespace Ase;

public class BaseMechanism : InteractiveMonoCom, IInit
{
	[SerializeField]
	private ParticleSystem[] _allParticleSystems;

	[SerializeField]
	private float[] _allParticleSpeed;

	[SerializeField]
	private Animator[] _allAnimators;

	[SerializeField]
	private float[] _allAnimatorSpeed;

	public virtual void OnInit(object data = null)
	{
		MechanismNode mechanismNode = data as MechanismNode;
		if ((Object)(object)mechanismNode != null && mechanismNode.SceneSystem != null)
		{
			float num = mechanismNode.SceneSystem?.GetWorld()?.WorldSpeed ?? 1f;
			if (num != 1f)
			{
				OnGameSpeedChanged(num);
			}
		}
	}

	public virtual void OnClose()
	{
	}

	public virtual void OnOpen()
	{
	}

	public virtual void ResetData()
	{
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		if (_allParticleSystems != null)
		{
			for (int i = 0; i < _allParticleSystems.Length; i++)
			{
				MainModule main = _allParticleSystems[i].main;
				((MainModule)(ref main)).simulationSpeed = _allParticleSpeed[i];
			}
		}
		if (_allAnimators != null)
		{
			for (int j = 0; j < _allAnimators.Length; j++)
			{
				_allAnimators[j].speed = _allAnimatorSpeed[j];
			}
		}
	}

	public virtual void OnGameSpeedChanged(float gameSpeed)
	{
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		if (_allParticleSystems != null)
		{
			for (int i = 0; i < _allParticleSystems.Length; i++)
			{
				MainModule main = _allParticleSystems[i].main;
				((MainModule)(ref main)).simulationSpeed = gameSpeed;
			}
		}
		if (_allAnimators != null)
		{
			for (int j = 0; j < _allAnimators.Length; j++)
			{
				_allAnimators[j].speed = gameSpeed;
			}
		}
	}
}
