using UnityEngine;

namespace ACT.UI;

public sealed class EliteElementEffectView : MonoBehaviour
{
	[SerializeField]
	private GameObject _consumeEnoughEffect;

	[SerializeField]
	private GameObject _maxLevelEffect;

	[SerializeField]
	private GameObject _maxLevelIcon;

	private ParticleSystem[] _particleSystems;

	public void PrepareForRefresh(bool isMaxLevel)
	{
		gameObject.SetActive(isMaxLevel);
		_maxLevelEffect.SetActive(isMaxLevel);
		_maxLevelIcon.SetActive(isMaxLevel);
	}

	public void SetRootVisible(bool visible)
	{
		gameObject.SetActive(visible);
	}

	public void SetConsumeEnoughVisible(bool visible)
	{
		_consumeEnoughEffect.SetActive(visible);
	}

	internal void PrepareForPoolRecycle()
	{
		CacheParticleSystems();
		for (int i = 0; i < _particleSystems.Length; i++)
		{
			_particleSystems[i].Stop(withChildren: true, ParticleSystemStopBehavior.StopEmittingAndClear);
		}
		_consumeEnoughEffect.SetActive(value: false);
		_maxLevelEffect.SetActive(value: false);
		_maxLevelIcon.SetActive(value: false);
		gameObject.SetActive(value: false);
	}

	internal void PrepareForPoolReuse(bool active)
	{
		_consumeEnoughEffect.SetActive(value: false);
		_maxLevelEffect.SetActive(value: false);
		_maxLevelIcon.SetActive(value: false);
		gameObject.SetActive(active);
	}

	private void CacheParticleSystems()
	{
		if (_particleSystems == null)
		{
			_particleSystems = GetComponentsInChildren<ParticleSystem>(includeInactive: true);
		}
	}
}
