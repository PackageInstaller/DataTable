namespace System;

internal static class AppContextDefaultValues
{
	internal static readonly string SwitchEnforceJapaneseEraYearRanges = "Switch.System.Globalization.EnforceJapaneseEraYearRanges";

	internal static readonly string SwitchFormatJapaneseFirstYearAsANumber = "Switch.System.Globalization.FormatJapaneseFirstYearAsANumber";

	internal static readonly string SwitchEnforceLegacyJapaneseDateParsing = "Switch.System.Globalization.EnforceLegacyJapaneseDateParsing";

	public static void PopulateDefaultValues()
	{
	}

	public static bool TryGetSwitchOverride(string switchName, out bool overrideValue)
	{
		overrideValue = false;
		return false;
	}
}
