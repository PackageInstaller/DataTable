using System.Collections.Generic;
using UnityEngine;

public class TimelineAnimationClipPlayer
{
	public Animator animator;

	public AgentHuman agent;

	private bool _isPause;

	private int _currentIndex;

	private float _lastNormalize;

	private float _transitionTime;

	private float _timescale = 1f;

	private TimelineAnimationClip _currentClip;

	private List<TimelineAnimationClip> _clips = new List<TimelineAnimationClip>();

	private int frame;

	private string name = "";

	public float lastSpeedBeforePause = 1f;

	private int lastState;

	public void Initialize(List<TimelineAnimationClip> clips, float transitionTime, float timeScale)
	{
		_clips = clips;
		_currentIndex = 0;
		_lastNormalize = 0f;
		_transitionTime = transitionTime;
		SetAnimatorSpeed(timeScale);
		frame = Time.frameCount;
		if (clips.Count > 0)
		{
			animator.Play(clips[0].clip, clips[0].layerIndex, 0f);
			SetAnimatorSpeed(0f);
		}
		else
		{
			SetAnimatorSpeed(0f);
		}
	}

	public void SetTimeScale(float timescale)
	{
		SetAnimatorSpeed(timescale);
		_timescale = timescale;
	}

	private void CheckAnimationPlayClip(float normalize)
	{
		if (!(null == animator) && _currentIndex < _clips.Count)
		{
			TimelineAnimationClip currentClip = _clips[_currentIndex];
			if (normalize >= currentClip.begin)
			{
				_currentClip = currentClip;
				name = _currentClip.clip;
				frame = 0;
				SetAnimatorSpeed(_timescale);
				animator.CrossFade(_currentClip.clip, _transitionTime * _timescale, _currentClip.layerIndex, normalize - currentClip.begin);
				_currentIndex++;
			}
		}
	}

	public string GetCurrentClip()
	{
		return _currentClip.clip;
	}

	public void Update(float normalize)
	{
		CheckAnimationPlayClip(normalize);
		_lastNormalize = normalize;
	}

	public void Pause(bool isPause = true)
	{
		_isPause = isPause;
		if (!(null == animator))
		{
			if (isPause)
			{
				lastSpeedBeforePause = animator.speed;
				SetAnimatorSpeed(0f);
			}
			else
			{
				SetAnimatorSpeed(_timescale);
			}
		}
	}

	public void Stop()
	{
	}

	internal void UpdateTransform(Vector3 position, Vector3 forward)
	{
	}

	internal void Shutdown()
	{
		lastState = 0;
	}

	private void SetAnimatorSpeed(float pSpeed)
	{
		if (!(animator == null))
		{
			animator.speed = pSpeed;
			if (pSpeed == 0f || pSpeed >= 1f)
			{
				animator.SetFloat("speed", 1f);
			}
			else
			{
				animator.SetFloat("speed", 1f / pSpeed);
			}
		}
	}

	public void PlayCustomAnimation(string animationName, int layerIndex, float normalized)
	{
		if (!(animator == null) && !animator.GetCurrentAnimatorStateInfo(layerIndex).IsName(animationName))
		{
			animator.Play(animationName, layerIndex, normalized);
		}
	}

	public void SetTrigger(string triggerName)
	{
		if (!(animator == null))
		{
			int trigger = Animator.StringToHash(triggerName);
			if (lastState != 0)
			{
				animator.ResetTrigger(lastState);
			}
			animator.SetTrigger(trigger);
			lastState = trigger;
		}
	}
}
