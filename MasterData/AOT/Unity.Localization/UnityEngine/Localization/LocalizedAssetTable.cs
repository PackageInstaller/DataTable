using System;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.Tables;

namespace UnityEngine.Localization;

[Serializable]
public class LocalizedAssetTable : LocalizedTable<AssetTable, AssetTableEntry>
{
	protected override LocalizedDatabase<AssetTable, AssetTableEntry> Database => LocalizationSettings.AssetDatabase;

	public LocalizedAssetTable()
	{
	}

	public LocalizedAssetTable(TableReference tableReference)
	{
		TableReference = tableReference;
	}
}
