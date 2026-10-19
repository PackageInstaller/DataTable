namespace System.Globalization;

internal enum FORMATFLAGS
{
	None = 0,
	UseGenitiveMonth = 1,
	UseLeapYearMonth = 2,
	UseSpacesInMonthNames = 4,
	UseHebrewParsing = 8,
	UseSpacesInDayNames = 0x10,
	UseDigitPrefixInTokens = 0x20
}
