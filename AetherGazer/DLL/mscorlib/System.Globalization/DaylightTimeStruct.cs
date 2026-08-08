namespace System.Globalization;

internal readonly struct DaylightTimeStruct(DateTime start, DateTime end, TimeSpan delta)
{
	public readonly DateTime Start = start;

	public readonly DateTime End = end;

	public readonly TimeSpan Delta = delta;
}
