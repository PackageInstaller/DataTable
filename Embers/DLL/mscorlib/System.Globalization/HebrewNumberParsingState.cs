namespace System.Globalization;

internal enum HebrewNumberParsingState
{
	InvalidHebrewNumber,
	NotHebrewDigit,
	FoundEndOfHebrewNumber,
	ContinueParsing
}
