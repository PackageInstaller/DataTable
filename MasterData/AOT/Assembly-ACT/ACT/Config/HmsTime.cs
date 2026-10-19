using System;

namespace ACT.Config;

[Serializable]
public class HmsTime
{
	public readonly int hour;

	public readonly int minute;

	public readonly int second;

	public HmsTime(int hour, int minute, int second)
	{
		this.hour = hour;
		this.minute = minute;
		this.second = second;
	}
}
