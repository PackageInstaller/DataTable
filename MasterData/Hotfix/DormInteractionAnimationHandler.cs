using System;
using UnityEngine;
using UnityEngine.Playables;

public class DormInteractionAnimationHandler
{
	private DormActor _actor;

	private DormFurObj _furObj;

	private DormInteractionAnimationConfigData.PlaybackData _currentPlayingPlayback;

	private int _segmentIndex;

	private DormCommonInteractionAnimationLibrary _actorCommonAnimationLibrary;

	private Transform _actorRootBone;

	private int _actorLoopRemaining;

	private int _furLoopRemaining;

	private bool _actorSegDone;

	private bool _furSegDone;

	private Action _onComplete;

	private bool _isPlaying;

	public bool isPlaying => _isPlaying;

	public DormInteractionAnimationConfigData.PlaybackData currentPlayingPlayback => _currentPlayingPlayback;

	public void Play(DormInteractionAnimationConfigData config, DormActor actor, DormFurObj furObj, Action onComplete = null)
	{
		if (_isPlaying)
		{
			Stop();
		}
		_currentPlayingPlayback = config.Resolve();
		_actor = actor;
		_furObj = furObj;
		_onComplete = onComplete;
		if (_currentPlayingPlayback == null || _currentPlayingPlayback.sequence.Count == 0)
		{
			Finish();
			return;
		}
		if (_actor != null)
		{
			_actorCommonAnimationLibrary = _actor.animLibrary;
			if (_actor.slotConfig != null)
			{
				_actorRootBone = _actor.slotConfig.GetSlotNode(AnimationSlotConfigComponent.SlotType.Root);
			}
			if (_actor.animator != null)
			{
				_actor.animator.applyRootMotion = true;
			}
		}
		_segmentIndex = 0;
		_isPlaying = true;
		PlayCurrentSegment();
	}

	public void Stop(bool isInterrupt = true)
	{
		if (!_isPlaying)
		{
			return;
		}
		if (_actor != null)
		{
			_actor.StopTimelineAnimation(isInterrupt);
			if (_actor.animator != null)
			{
				_actor.animator.applyRootMotion = false;
			}
		}
		if (_furObj != null)
		{
			_furObj.StopTimelineAnimation(isInterrupt);
		}
		_currentPlayingPlayback = null;
		_actor = null;
		_furObj = null;
		_actorCommonAnimationLibrary = null;
		_actorRootBone = null;
		_actorLoopRemaining = 0;
		_furLoopRemaining = 0;
		_actorSegDone = false;
		_furSegDone = false;
		_onComplete = null;
		_segmentIndex = 0;
		_isPlaying = false;
	}

	public void Update()
	{
		if (_isPlaying)
		{
			if (!_actorSegDone && PollTimelineReachedEnd(_actor.currentTimelineAnimationDirector, ref _actorLoopRemaining))
			{
				_actorSegDone = true;
			}
			if (!_furSegDone && PollTimelineReachedEnd(_furObj.currentTimelineAnimationDirector, ref _furLoopRemaining))
			{
				_furSegDone = true;
			}
			if (_actorSegDone && _furSegDone)
			{
				AdvanceSegment();
			}
			if (_actorRootBone != null)
			{
				_actorRootBone.SetLocalPositionAndRotation(Vector3.zero, Quaternion.identity);
			}
		}
	}

	private static bool PollTimelineReachedEnd(PlayableDirector director, ref int loopRemaining)
	{
		if (director == null || director.state != PlayState.Playing)
		{
			return false;
		}
		if (director.time < director.duration)
		{
			return false;
		}
		if (loopRemaining > 0)
		{
			loopRemaining--;
			director.time = 0.0;
			return false;
		}
		return true;
	}

	private void PlayCurrentSegment()
	{
		DormInteractionAnimationConfigData.InteractionPlaybackSegment interactionPlaybackSegment = _currentPlayingPlayback.sequence.get_Item(_segmentIndex);
		_actorSegDone = false;
		_furSegDone = false;
		GameObject gameObject = ResolveActorPrefab(interactionPlaybackSegment);
		if (_actor != null && gameObject != null)
		{
			_actor.PlayTimelineAnimation(gameObject, interactionPlaybackSegment.loopCount, null, DirectorWrapMode.Hold, isInterruptOnReplace: false);
			_actorLoopRemaining = Mathf.Max(1, interactionPlaybackSegment.loopCount) - 1;
		}
		else
		{
			_actorSegDone = true;
		}
		if (_furObj != null && interactionPlaybackSegment.interacteeTimelinePrefab != null)
		{
			_furObj.PlayTimelineAnimation(interactionPlaybackSegment.interacteeTimelinePrefab, interactionPlaybackSegment.loopCount, null, DirectorWrapMode.Hold, isInterruptOnReplace: false);
			_furLoopRemaining = Mathf.Max(1, interactionPlaybackSegment.loopCount) - 1;
		}
		else
		{
			_furSegDone = true;
		}
		if (_actorSegDone && _furSegDone)
		{
			AdvanceSegment();
		}
	}

	private GameObject ResolveActorPrefab(DormInteractionAnimationConfigData.InteractionPlaybackSegment seg)
	{
		if (seg.actorCommonAnimationType == DormCommonInteractionAnimationType.None)
		{
			return seg.actorTimelinePrefab;
		}
		GameObject gameObject = null;
		if (_actorCommonAnimationLibrary != null)
		{
			gameObject = _actorCommonAnimationLibrary.GetAnimationTimeline(seg.actorCommonAnimationType);
		}
		if (gameObject == null)
		{
			Debug.LogWarning("[DormInteractionAnimationHandler] 角色\"" + ((_actor != null) ? _actor.name : "null") + "\"" + $"的通用动作库缺少动作：{seg.actorCommonAnimationType}，该段角色侧跳过");
		}
		return gameObject;
	}

	private void AdvanceSegment()
	{
		_segmentIndex++;
		if (_segmentIndex < _currentPlayingPlayback.sequence.Count)
		{
			PlayCurrentSegment();
		}
		else
		{
			Finish();
		}
	}

	private void Finish()
	{
		Action onComplete = _onComplete;
		Stop(isInterrupt: false);
		onComplete?.Invoke();
	}
}
