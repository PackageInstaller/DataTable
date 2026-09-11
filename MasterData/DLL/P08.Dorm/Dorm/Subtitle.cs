using System;
using Dorm.Character.Animation;

namespace Dorm;

[Serializable]
public struct Subtitle
{
	[EventTime(30f)]
	public float time;

	public int subtitleID;
}
