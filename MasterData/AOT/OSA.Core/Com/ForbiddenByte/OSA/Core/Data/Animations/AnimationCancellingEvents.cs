using System;
using UnityEngine;

namespace Com.ForbiddenByte.OSA.Core.Data.Animations;

[Serializable]
public abstract class AnimationCancellingEvents
{
	[SerializeField]
	[Tooltip("Whether to cancel on any count change event: Insert/Remove/Reset")]
	private bool _OnCountChanges = true;

	[SerializeField]
	[Tooltip("Whether to cancel on any event that changes sizes of the items or content")]
	private bool _OnSizeChanges = true;

	[SerializeField]
	[Tooltip("Whether to cancel on OSA.ScrollTo")]
	private bool _OnScrollTo = true;

	public bool OnCountChanges
	{
		get
		{
			return _OnCountChanges;
		}
		set
		{
			_OnCountChanges = value;
		}
	}

	public bool OnSizeChanges
	{
		get
		{
			return _OnSizeChanges;
		}
		set
		{
			_OnSizeChanges = value;
		}
	}

	public bool OnScrollTo
	{
		get
		{
			return _OnScrollTo;
		}
		set
		{
			_OnScrollTo = value;
		}
	}
}
