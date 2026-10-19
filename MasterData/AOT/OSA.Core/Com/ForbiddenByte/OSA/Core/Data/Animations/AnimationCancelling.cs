using System;
using UnityEngine;

namespace Com.ForbiddenByte.OSA.Core.Data.Animations;

[Serializable]
public class AnimationCancelling
{
	[SerializeField]
	[Tooltip("This decides whether or not to stop an existing SmoothScrollTo animation on certain events")]
	private SmoothScrollCancellingEvents _SmoothScroll = new SmoothScrollCancellingEvents();

	[SerializeField]
	[Tooltip("Custom animations you may have. This decides whether or not to call CancelUserAnimations() on certain events, which you can override to comply")]
	private UserAnimationsCancellingEvents _UserAnimations = new UserAnimationsCancellingEvents();

	public SmoothScrollCancellingEvents SmoothScroll
	{
		get
		{
			return _SmoothScroll;
		}
		set
		{
			_SmoothScroll = value;
		}
	}

	public UserAnimationsCancellingEvents UserAnimations
	{
		get
		{
			return _UserAnimations;
		}
		set
		{
			_UserAnimations = value;
		}
	}
}
