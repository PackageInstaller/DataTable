using System;

namespace ACT.Battle;

[Serializable]
public class Timer
{
	public int index;

	public float time;

	[NonSerialized]
	public float maxTime;

	[NonSerialized]
	public float enterTime;

	[NonSerialized]
	public float count;
}
