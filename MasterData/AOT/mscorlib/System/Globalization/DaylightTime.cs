namespace System.Globalization;

[Serializable]
public class DaylightTime
{
	private readonly DateTime _start;

	private readonly DateTime _end;

	private readonly TimeSpan _delta;

	public DateTime Start => _start;

	public DateTime End => _end;

	public TimeSpan Delta => _delta;

	public DaylightTime(DateTime start, DateTime end, TimeSpan delta)
	{
		_start = start;
		_end = end;
		_delta = delta;
	}
}
