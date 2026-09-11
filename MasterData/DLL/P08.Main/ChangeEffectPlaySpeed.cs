using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

public class ChangeEffectPlaySpeed : MonoBehaviour
{
	private List<Animation> m_animations = new List<Animation>();

	private List<Animator> m_animators = new List<Animator>();

	private List<ParticleSystem> m_particleSystems = new List<ParticleSystem>();

	private List<List<float>> m_animationSpeeds = new List<List<float>>();

	private List<float> m_animatorSpeeds = new List<float>();

	private List<float> m_particleSystemSpeeds = new List<float>();

	private List<PlayableDirector> m_playableDirectors = new List<PlayableDirector>();

	private bool isStop;

	private void Awake()
	{
		FindComponents(base.transform);
	}

	private void FindComponents(Transform tf)
	{
		Animation component = tf.GetComponent<Animation>();
		if ((bool)component)
		{
			m_animations.Add(component);
		}
		Animator component2 = tf.GetComponent<Animator>();
		if ((bool)component2)
		{
			m_animators.Add(component2);
		}
		ParticleSystem component3 = tf.GetComponent<ParticleSystem>();
		if ((bool)component3)
		{
			m_particleSystems.Add(component3);
		}
		PlayableDirector component4 = tf.GetComponent<PlayableDirector>();
		if ((bool)component4)
		{
			m_playableDirectors.Add(component4);
		}
		for (int i = 0; i < tf.childCount; i++)
		{
			FindComponents(tf.GetChild(i));
		}
	}

	public void StopSpeed()
	{
		isStop = true;
		for (int i = 0; i < m_animations.Count; i++)
		{
			List<float> list = new List<float>();
			foreach (AnimationState item in m_animations[i])
			{
				list.Add(item.speed);
				item.speed = 0f;
			}
			m_animationSpeeds.Add(list);
		}
		m_animatorSpeeds.Clear();
		for (int j = 0; j < m_animators.Count; j++)
		{
			m_animatorSpeeds.Add(m_animators[j].speed);
			m_animators[j].speed = 0f;
		}
		m_particleSystemSpeeds.Clear();
		for (int k = 0; k < m_particleSystems.Count; k++)
		{
			ParticleSystem.MainModule main = m_particleSystems[k].main;
			m_particleSystemSpeeds.Add(main.simulationSpeed);
			main.simulationSpeed = 0f;
		}
		for (int l = 0; l < m_playableDirectors.Count; l++)
		{
			m_playableDirectors[l].Pause();
		}
	}

	public void RevertSpeed()
	{
		if (!isStop)
		{
			return;
		}
		for (int i = 0; i < m_animations.Count; i++)
		{
			int num = 0;
			foreach (AnimationState item in m_animations[i])
			{
				item.speed = m_animationSpeeds[i][num];
				num++;
			}
		}
		for (int j = 0; j < m_animators.Count; j++)
		{
			m_animators[j].speed = m_animatorSpeeds[j];
		}
		for (int k = 0; k < m_particleSystems.Count; k++)
		{
			ParticleSystem.MainModule main = m_particleSystems[k].main;
			main.simulationSpeed = m_particleSystemSpeeds[k];
		}
		for (int l = 0; l < m_playableDirectors.Count; l++)
		{
			m_playableDirectors[l].Resume();
		}
	}
}
