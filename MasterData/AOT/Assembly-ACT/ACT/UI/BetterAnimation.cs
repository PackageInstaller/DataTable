using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace ACT.UI;

[RequireComponent(typeof(Animation))]
public class BetterAnimation : MonoBehaviour, IAnimationClipSource
{
	public bool playOnAwake;

	[SerializeField]
	private List<AnimationClip> AnimationClip = new List<AnimationClip>();

	private AnimationBuilder _currentPlayingAnimation;

	private Animation _animation;

	private bool _animationInit;

	public void GetAnimationClips(List<AnimationClip> results)
	{
		results.AddRange(AnimationClip);
	}

	private void Awake()
	{
		TryInitAnimation();
		if (playOnAwake)
		{
			AnimationClip animationClip = AnimationClip.FirstOrDefault();
			if (animationClip != null)
			{
				GetSequence(animationClip.name).SetLoops(-1).Play();
			}
		}
	}

	private void TryInitAnimation()
	{
		if (_animationInit)
		{
			return;
		}
		_animation = gameObject.GetComponent<Animation>();
		if (!_animation)
		{
			_animation = gameObject.AddComponent<Animation>();
		}
		_animation.playAutomatically = false;
		foreach (AnimationClip item in AnimationClip)
		{
			if ((bool)item)
			{
				string text = item.name;
				if (!string.IsNullOrEmpty(text) && !_animation.GetClip(text))
				{
					_animation.AddClip(item, text);
				}
			}
		}
		_animationInit = true;
	}

	public void PauseAnimation()
	{
		if (_currentPlayingAnimation != null)
		{
			_currentPlayingAnimation.Pause();
		}
	}

	public void StopAnimation()
	{
		if (_currentPlayingAnimation != null)
		{
			_currentPlayingAnimation.Stop();
			AnimationBuilder.Pool.Release(_currentPlayingAnimation);
			_currentPlayingAnimation = null;
		}
	}

	public AnimationBuilder GetSequence(string animationName)
	{
		TryInitAnimation();
		StopAnimation();
		return _currentPlayingAnimation = BuildSequence(animationName);
	}

	public AnimationBuilder GetSequenceLastPlayPause(string animationName)
	{
		return GetSequence(animationName);
	}

	public AnimationBuilder GetSequenceLastPlayKeep(string animationName)
	{
		return GetSequence(animationName);
	}

	private AnimationBuilder BuildSequence(string animationName)
	{
		if (!_animation)
		{
			return null;
		}
		if (!_animation.GetClip(animationName))
		{
			return null;
		}
		AnimationBuilder animationBuilder = AnimationBuilder.Pool.Get();
		animationBuilder.Init(this, _animation, animationName);
		return animationBuilder;
	}

	private void OnDisable()
	{
		StopAnimation();
	}

	private void OnDestroy()
	{
		StopAnimation();
	}

	public float GetCurrentPlayingAnimationDuration()
	{
		if (_currentPlayingAnimation == null)
		{
			return 0f;
		}
		return _currentPlayingAnimation.Duration();
	}

	public string CurrentAnimationName()
	{
		if (_currentPlayingAnimation == null)
		{
			return null;
		}
		return _currentPlayingAnimation.Name;
	}

	public bool CurrentAnimationPlaying()
	{
		if (_currentPlayingAnimation != null)
		{
			return !_currentPlayingAnimation.IsComplete();
		}
		return false;
	}

	public float GetAnimationDuration(string animationName)
	{
		AnimationClip clip = _animation.GetClip(animationName);
		if (!clip)
		{
			return 0f;
		}
		return clip.length;
	}
}
