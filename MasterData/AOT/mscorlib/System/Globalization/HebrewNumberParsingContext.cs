namespace System.Globalization;

internal struct HebrewNumberParsingContext(int result)
{
	internal HebrewNumber.HS state = HebrewNumber.HS.Start;

	internal int result = result;
}
