using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

internal static class TextAnimatorEffectPool
{
	private sealed class EffectPool
	{
		private readonly GameObject m_prefab;

		private readonly Stack<PooledEffect> m_inactiveEffects = new Stack<PooledEffect>();

		private int m_inactiveCount;

		public EffectPool(GameObject prefab)
		{
			m_prefab = prefab;
		}

		public PooledEffect Get(Transform parent)
		{
			while (m_inactiveCount > 0)
			{
				PooledEffect pooledEffect = m_inactiveEffects.Pop();
				m_inactiveCount--;
				if (pooledEffect.IsValid)
				{
					return pooledEffect;
				}
			}
			GameObject gameObject = Object.Instantiate(m_prefab, parent);
			return new PooledEffect(this, gameObject);
		}

		public void Recycle(PooledEffect effect, int maxPoolSize)
		{
			if (effect.IsValid)
			{
				if (m_inactiveCount >= maxPoolSize)
				{
					Object.Destroy(effect.GameObject);
					return;
				}
				m_inactiveEffects.Push(effect);
				m_inactiveCount++;
			}
		}
	}

	private sealed class PooledEffect
	{
		private readonly EffectPool m_pool;

		private readonly GameObject m_gameObject;

		private readonly Transform m_transform;

		private readonly ParticleSystem[] m_particles;

		private readonly Animator[] m_animators;

		private readonly Quaternion m_initialLocalRotation;

		private readonly Vector3 m_initialLocalScale;

		private float m_remainingMilliseconds;

		private int m_maxPoolSize;

		public bool IsValid => m_gameObject;

		public GameObject GameObject => m_gameObject;

		public PooledEffect(EffectPool pool, GameObject gameObject)
		{
			m_pool = pool;
			m_gameObject = gameObject;
			m_transform = gameObject.transform;
			m_particles = gameObject.GetComponentsInChildren<ParticleSystem>(includeInactive: true);
			m_animators = gameObject.GetComponentsInChildren<Animator>(includeInactive: true);
			m_initialLocalRotation = m_transform.localRotation;
			m_initialLocalScale = m_transform.localScale;
		}

		public void Play(Transform parent, Vector3 localPosition, int lifetimeMilliseconds, int maxPoolSize)
		{
			m_maxPoolSize = maxPoolSize;
			m_remainingMilliseconds = lifetimeMilliseconds;
			m_transform.SetParent(parent, worldPositionStays: false);
			m_transform.localPosition = localPosition;
			m_transform.localRotation = m_initialLocalRotation;
			m_transform.localScale = m_initialLocalScale;
			m_gameObject.SetActive(value: true);
			for (int i = 0; i < m_particles.Length; i++)
			{
				ParticleSystem particleSystem = m_particles[i];
				if ((bool)particleSystem)
				{
					ParticleSystem.MainModule main = particleSystem.main;
					main.loop = false;
					particleSystem.Stop(withChildren: true, ParticleSystemStopBehavior.StopEmittingAndClear);
					particleSystem.Play(withChildren: true);
				}
			}
			for (int j = 0; j < m_animators.Length; j++)
			{
				Animator animator = m_animators[j];
				if ((bool)animator)
				{
					animator.speed = 1f;
					animator.Rebind();
					animator.Update(0f);
				}
			}
		}

		public bool Advance(float deltaMilliseconds)
		{
			m_remainingMilliseconds -= deltaMilliseconds;
			return m_remainingMilliseconds <= 0f;
		}

		public void Recycle(Transform poolRoot)
		{
			if (!m_gameObject)
			{
				return;
			}
			for (int i = 0; i < m_particles.Length; i++)
			{
				ParticleSystem particleSystem = m_particles[i];
				if ((bool)particleSystem)
				{
					particleSystem.Stop(withChildren: true, ParticleSystemStopBehavior.StopEmittingAndClear);
				}
			}
			m_gameObject.SetActive(value: false);
			m_transform.SetParent(poolRoot, worldPositionStays: false);
			m_pool.Recycle(this, m_maxPoolSize);
		}
	}

	private sealed class Runner : MonoBehaviour
	{
		private void Update()
		{
			TextAnimatorEffectPool.Update(Time.unscaledDeltaTime);
		}
	}

	private const int DefaultLifetimeMilliseconds = 1000;

	private const int DefaultMaxPoolSize = 16;

	private static readonly Dictionary<int, EffectPool> s_pools = new Dictionary<int, EffectPool>();

	private static readonly List<PooledEffect> s_activeEffects = new List<PooledEffect>();

	private static Transform s_poolRoot;

	private static Runner s_runner;

	public static void Play(TextAnimatorEffectBinding binding, Transform parent, Vector3 localPosition)
	{
		if (binding != null && (bool)binding.prefab)
		{
			EnsureRunner();
			int instanceID = binding.prefab.GetInstanceID();
			if (!s_pools.TryGetValue(instanceID, out var value))
			{
				value = new EffectPool(binding.prefab);
				s_pools.Add(instanceID, value);
			}
			int lifetimeMilliseconds = ((binding.lifetimeMilliseconds > 0) ? binding.lifetimeMilliseconds : 1000);
			int maxPoolSize = ((binding.maxPoolSize > 0) ? binding.maxPoolSize : 16);
			PooledEffect pooledEffect = value.Get(parent ? parent : s_poolRoot);
			pooledEffect.Play(parent ? parent : s_poolRoot, localPosition, lifetimeMilliseconds, maxPoolSize);
			s_activeEffects.Add(pooledEffect);
		}
	}

	private static void Update(float deltaTime)
	{
		if (s_activeEffects.Count == 0)
		{
			return;
		}
		float deltaMilliseconds = deltaTime * 1000f;
		for (int num = s_activeEffects.Count - 1; num >= 0; num--)
		{
			PooledEffect pooledEffect = s_activeEffects[num];
			if (!pooledEffect.IsValid)
			{
				s_activeEffects.RemoveAt(num);
			}
			else if (pooledEffect.Advance(deltaMilliseconds))
			{
				s_activeEffects.RemoveAt(num);
				pooledEffect.Recycle(s_poolRoot);
			}
		}
	}

	private static void EnsureRunner()
	{
		if (!s_runner)
		{
			GameObject gameObject = new GameObject("TextAnimatorEffectPool");
			Object.DontDestroyOnLoad(gameObject);
			gameObject.hideFlags = HideFlags.HideAndDontSave;
			s_poolRoot = gameObject.transform;
			s_runner = gameObject.AddComponent<Runner>();
		}
	}
}
