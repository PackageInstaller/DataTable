using System;

namespace UnityEngine.Localization.Metadata;

[Flags]
public enum MetadataType
{
	Locale = 1,
	SharedTableData = 2,
	StringTable = 4,
	AssetTable = 8,
	StringTableEntry = 0x10,
	AssetTableEntry = 0x20,
	SharedStringTableEntry = 0x40,
	SharedAssetTableEntry = 0x80,
	LocalizationSettings = 0x100,
	AllTables = StringTable | AssetTable,
	AllTableEntries = StringTableEntry | AssetTableEntry,
	AllSharedTableEntries = SharedStringTableEntry | SharedAssetTableEntry,
	All = AllTables | AllTableEntries | Locale | SharedTableData
}
