using System;
using UnityEngine;

namespace Dorm.Character.Animation;

[AttributeUsage(AttributeTargets.Field)]
public class EventTimeAttribute : PropertyAttribute
{
	public float? SuggestedFramePerSec;

	public EventTimeAttribute()
	{
	}

	public EventTimeAttribute(float suggestedFps)
	{
		SuggestedFramePerSec = suggestedFps;
	}
}
