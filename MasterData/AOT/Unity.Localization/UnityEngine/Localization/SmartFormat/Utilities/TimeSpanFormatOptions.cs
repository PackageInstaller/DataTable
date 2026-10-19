using System;

namespace UnityEngine.Localization.SmartFormat.Utilities;

[Flags]
public enum TimeSpanFormatOptions
{
	InheritDefaults = 0,
	Abbreviate = 1,
	AbbreviateOff = 2,
	LessThan = 4,
	LessThanOff = 8,
	TruncateShortest = 0x10,
	TruncateAuto = 0x20,
	TruncateFill = 0x40,
	TruncateFull = 0x80,
	RangeMilliSeconds = 0x100,
	RangeSeconds = 0x200,
	RangeMinutes = 0x400,
	RangeHours = 0x800,
	RangeDays = 0x1000,
	RangeWeeks = 0x2000
}
