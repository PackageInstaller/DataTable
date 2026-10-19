using System;
using System.Collections.Generic;
using Bamboo.Chronos;

namespace ACT.UI;

public class AnimationQueueDriver
{
	private class AnimationQueue
	{
		private string _name;

		private AnimationBuilder _animation;

		private Queue<AnimationBuilder> _waitAnimation;

		private Delayer _delayer;

		private Action<string> _OnDestroy;

		public AnimationQueue(string name, Action<string> onDestroy)
		{
			_name = name;
			_OnDestroy = onDestroy;
			_animation = null;
			_waitAnimation = new Queue<AnimationBuilder>();
		}

		public void EnqueueAnimation(AnimationBuilder animationBuilder)
		{
			_waitAnimation.Enqueue(animationBuilder);
			if (_animation == null)
			{
				TryPlayHeadAnimation();
			}
		}

		private bool TryPlayHeadAnimation()
		{
			if (_waitAnimation.Count > 0)
			{
				_animation = _waitAnimation.Dequeue();
				_animation.Play();
				_delayer = UpdateTimer.Default.DelayMs(_animation.DurationToMs(), () =>
				{
					_animation = null;
					if (!TryPlayHeadAnimation())
					{
						OnDestroy();
					}
				});
				return true;
			}
			return false;
		}

		private void OnDestroy()
		{
			_animation = null;
			if (_delayer.IsValid())
			{
				_delayer.Cancel();
			}
			_OnDestroy?.Invoke(_name);
		}
	}

	private static AnimationQueueDriver _default;

	private readonly Dictionary<string, AnimationQueue> _animationQueues = new Dictionary<string, AnimationQueue>();

	public static AnimationQueueDriver Default
	{
		get
		{
			if (_default == null)
			{
				_default = new AnimationQueueDriver();
			}
			return _default;
		}
	}

	public void PlayInQueue(string queueName, AnimationBuilder animation)
	{
		if (_animationQueues.TryGetValue(queueName, out var value))
		{
			value.EnqueueAnimation(animation);
			return;
		}
		AnimationQueue animationQueue = new AnimationQueue(queueName, OnQueueDestroy);
		_animationQueues[queueName] = animationQueue;
		animationQueue.EnqueueAnimation(animation);
	}

	private void OnQueueDestroy(string queueName)
	{
		if (_animationQueues.ContainsKey(queueName))
		{
			_animationQueues.Remove(queueName);
		}
	}
}
