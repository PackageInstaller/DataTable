namespace System;

[Flags]
internal enum ParseFlags
{
	HaveYear = 1,
	HaveMonth = 2,
	HaveDay = 4,
	HaveHour = 8,
	HaveMinute = 0x10,
	HaveSecond = 0x20,
	HaveTime = 0x40,
	HaveDate = 0x80,
	TimeZoneUsed = 0x100,
	TimeZoneUtc = 0x200,
	ParsedMonthName = 0x400,
	CaptureOffset = 0x800,
	YearDefault = 0x1000,
	Rfc1123Pattern = 0x2000,
	UtcSortPattern = 0x4000
}
