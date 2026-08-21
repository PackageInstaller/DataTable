using System;
using System.Collections.Generic;
using Spine;
using Spine.Unity;
using UnityEngine;

namespace Ase;

[RequireComponent(typeof(SkeletonGraphic))]
public class SpineGraphicController : MonoBehaviour, ISpineAnimationPlayer
{
	[SerializeField]
	[HideInInspector]
	private FusionData _idleFusionData;

	[SerializeField]
	[HideInInspector]
	private List<FusionData> _fusionDatas;

	private SkeletonGraphic skeletonGraphic;

	private SpineAnimationPlayerCore animationPlayer;

	private Func<bool> openMixGetter;

	private Func<SpineEventHandler> onSpineEventGetter;

	private bool eventSubscribed;

	public SkeletonGraphic SkeletonGraphic
	{
		get
		{
			if ((UnityEngine.Object)(object)skeletonGraphic == null)
			{
				skeletonGraphic = base.gameObject.GetComponent<SkeletonGraphic>();
			}
			return skeletonGraphic;
		}
	}

	public void InitializeFromMaster(Func<bool> masterOpenMixGetter, Action<FusionData> playAudio, Action stopAllAudio, Action<string> logInfo = null)
	{
		openMixGetter = masterOpenMixGetter;
		animationPlayer = new SpineAnimationPlayerCore(this, () => SkeletonGraphic, () => openMixGetter != null && openMixGetter(), () => _idleFusionData, () => _fusionDatas, playAudio, stopAllAudio, logInfo);
	}

	public bool PlayAction(string aniName, Action onActionFinish = null)
	{
		if (animationPlayer != null)
		{
			return animationPlayer.PlayAction(aniName, onActionFinish);
		}
		return false;
	}

	public bool PlayLegacyAction(string aniName, Action onActionFinish = null)
	{
		if (animationPlayer != null)
		{
			return animationPlayer.PlayLegacyAction(aniName, onActionFinish);
		}
		return false;
	}

	public bool PlayLegacyAction(string aniName, int track, Action onActionFinish = null)
	{
		if (animationPlayer != null)
		{
			return animationPlayer.PlayLegacyAction(aniName, track, onActionFinish);
		}
		return false;
	}

	public bool PlayAction(string aniName, int trackIndex, Action onActionFinish = null)
	{
		if (animationPlayer != null)
		{
			return animationPlayer.PlayAction(aniName, trackIndex, onActionFinish);
		}
		return false;
	}

	public void PlayIdle(bool playAudio = true)
	{
		animationPlayer?.PlayIdle(playAudio);
	}

	public void ResetToIdle(bool stopAudio = true)
	{
		animationPlayer?.ResetToIdle(stopAudio);
	}

	public void StopAnimation()
	{
		animationPlayer?.StopAnimation();
	}

	public void SetEventHandler(Func<SpineEventHandler> spineEventHandler)
	{
		UnsubscribeEvents();
		onSpineEventGetter = spineEventHandler;
		SubscribeEvents();
	}

	public void Oestroy()
	{
		UnsubscribeEvents();
		skeletonGraphic = null;
		animationPlayer = null;
		openMixGetter = null;
		onSpineEventGetter = null;
	}

	private void OnDestroy()
	{
		UnsubscribeEvents();
	}

	private void SubscribeEvents()
	{
		if (!eventSubscribed && onSpineEventGetter != null)
		{
			SkeletonGraphic obj = SkeletonGraphic;
			if (((obj != null) ? obj.AnimationState : null) != null)
			{
				SkeletonGraphic.AnimationState.Event += HandleAnimationEvent;
				eventSubscribed = true;
			}
		}
	}

	private void UnsubscribeEvents()
	{
		if (eventSubscribed)
		{
			SkeletonGraphic obj = SkeletonGraphic;
			if (((obj != null) ? obj.AnimationState : null) != null)
			{
				SkeletonGraphic.AnimationState.Event -= HandleAnimationEvent;
				eventSubscribed = false;
			}
		}
	}

	private void HandleAnimationEvent(TrackEntry trackEntry, Event e)
	{
		if (e != null)
		{
			onSpineEventGetter().HandleEvent(new SpineEventData(e, trackEntry));
		}
	}

	public bool HasAction(string aniName)
	{
		return animationPlayer?.HasAction(aniName) ?? false;
	}

	public float GetAniLength(string aniName)
	{
		if ((UnityEngine.Object)(object)skeletonGraphic == null || skeletonGraphic.SkeletonData == null)
		{
			return -1f;
		}
		return skeletonGraphic.SkeletonData.Animations.ToList().Find((Animation p) => p.Name.Equals(aniName))?.Duration ?? (-1f);
	}
}
