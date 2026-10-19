using System;

namespace ACT.Config;

[Serializable]
public class DateTime
{
	public readonly int year;

	public readonly int month;

	public readonly int day;

	public readonly int hour;

	public readonly int minute;

	public readonly int second;

	public DateTime(int year, int month, int day, int hour, int minute, int second)
	{
		this.year = year;
		this.month = month;
		this.day = day;
		this.hour = hour;
		this.minute = minute;
		this.second = second;
	}
}
