using System.Collections.Generic;
using UnityEngine;

public class EffectHelper : MonoBehaviour
{
	private ChangeEffectPlaySpeed _changeEffectPlaySpeed;

	private ParticleSystem _particleSystem;

	private List<DelayPlayAction> _delayPlayAction = new List<DelayPlayAction>();

	public float LifeTime { get; set; }

	public void InitHelper()
	{
		_particleSystem = base.gameObject.GetComponent<ParticleSystem>();
		_changeEffectPlaySpeed = base.gameObject.GetComponent<ChangeEffectPlaySpeed>();
		if (!_changeEffectPlaySpeed)
		{
			_changeEffectPlaySpeed = base.gameObject.AddComponent<ChangeEffectPlaySpeed>();
		}
		FindDelayPlayActions(base.transform);
		LifeTime = ParticleSystemLength(base.transform);
	}

	private static float ParticleSystemLength(Transform transform)
	{
		ParticleSystem[] componentsInChildren = transform.GetComponentsInChildren<ParticleSystem>();
		float num = 0f;
		ParticleSystem[] array = componentsInChildren;
		foreach (ParticleSystem particleSystem in array)
		{
			float num2 = 0f;
			num2 = particleSystem.main.startDelay.constant + Mathf.Max(particleSystem.main.duration, particleSystem.main.startLifetimeMultiplier);
			if (num2 > num)
			{
				num = num2;
			}
		}
		return num;
	}

	private void FindDelayPlayActions(Transform tf)
	{
		DelayPlayAction component = tf.GetComponent<DelayPlayAction>();
		if (null != component)
		{
			_delayPlayAction.Add(component);
		}
		for (int i = 0; i < tf.childCount; i++)
		{
			FindDelayPlayActions(tf.GetChild(i));
		}
	}

	public void Stop()
	{
		_changeEffectPlaySpeed.StopSpeed();
		for (int i = 0; i < _delayPlayAction.Count; i++)
		{
			_delayPlayAction[i].PauseAction = true;
		}
	}

	public void Revert()
	{
		_changeEffectPlaySpeed.RevertSpeed();
		for (int i = 0; i < _delayPlayAction.Count; i++)
		{
			_delayPlayAction[i].PauseAction = false;
		}
	}
}
