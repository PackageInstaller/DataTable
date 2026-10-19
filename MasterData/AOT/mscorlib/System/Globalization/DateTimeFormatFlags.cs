namespace System.Globalization;

[Flags]
internal enum DateTimeFormatFlags
{
	None = 0,
	UseGenitiveMonth = 1,
	UseLeapYearMonth = 2,
	UseSpacesInMonthNames = 4,
	UseHebrewRule = 8,
	UseSpacesInDayNames = 0x10,
	UseDigitPrefixInTokens = 0x20,
	NotInitialized = -1
}
