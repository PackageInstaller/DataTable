using System;
using UnityEngine;

namespace Com.ForbiddenByte.OSA.Core.Data.Animations;

[Serializable]
public class UserAnimationsCancellingEvents : AnimationCancellingEvents
{
	[Tooltip("Whether to cancel on OSA.SmoothScrollTo")]
	[SerializeField]
	private bool _OnBeginSmoothScroll = true;

	public bool OnBeginSmoothScroll
	{
		get
		{
			return _OnBeginSmoothScroll;
		}
		set
		{
			_OnBeginSmoothScroll = value;
		}
	}
}
