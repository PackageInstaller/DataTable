using System;
using UnityEngine;

namespace Com.ForbiddenByte.OSA.Core.Data.Animations;

[Serializable]
public class AnimationParams
{
	[SerializeField]
	private AnimationFunctionType _SmoothScrollType;

	[SerializeField]
	private AnimationCancelling _Cancel = new AnimationCancelling();

	[SerializeField]
	private bool _OnDoneWhenCancelled;

	public AnimationFunctionType SmoothScrollType
	{
		get
		{
			return _SmoothScrollType;
		}
		set
		{
			_SmoothScrollType = value;
		}
	}

	public AnimationCancelling Cancel
	{
		get
		{
			return _Cancel;
		}
		set
		{
			_Cancel = value;
		}
	}

	public bool CallDoneOnScrollCancel
	{
		get
		{
			return _OnDoneWhenCancelled;
		}
		set
		{
			_OnDoneWhenCancelled = value;
		}
	}
}
