using System;

namespace UnityEngine.Localization;

internal class AddressHelper
{
	private const char k_Separator = '_';

	private const string k_AssetLabelPrefix = "Locale-";

	public static string GetTableAddress(string tableName, LocaleIdentifier localeId)
	{
		return $"{tableName}{'_'}{localeId.Code}";
	}

	public static string GetSharedTableAddress(string tableName)
	{
		return tableName + " Shared Data";
	}

	public static string FormatAssetLabel(LocaleIdentifier localeIdentifier)
	{
		return "Locale-" + localeIdentifier.Code;
	}

	public static bool IsLocaleLabel(string label)
	{
		return label.StartsWith("Locale-", StringComparison.InvariantCulture);
	}

	public static LocaleIdentifier LocaleLabelToId(string label)
	{
		return default;
	}

	public static bool TryGetLocaleLabelToId(string label, out LocaleIdentifier localeId)
	{
		if (!IsLocaleLabel(label))
		{
			localeId = default;
			return false;
		}
		localeId = label.Substring("Locale-".Length, label.Length - "Locale-".Length);
		return true;
	}
}
