using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.World;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.SmartFormat.PersistentVariables;
using UnityEngine.Localization.Tables;

namespace ACT.Utility;

public static class LocalizationUtility
{
	public static readonly string localizeTableName_Common = "Common";

	public static readonly string localizeTableName_longcommon = "longcommon";

	public static readonly string localizeTableName_shortcommon = "shortcommon";

	public static readonly string localizeTableName_MainStory = "MainStory";

	public const int LocalizeId_NoQuestionnaire = 1813;

	public const int LocalizeId_DAY = 609;

	public const int LocalizeId_HOUR = 610;

	public const int LocalizeId_MINUTE = 623;

	public static int GetMapAreaName(ACT.World.MapArea area)
	{
		return CoreUtils.GetData((int)area, RuntimeConfigs.data.mapAreas)?.name ?? 0;
	}

	public static Variable<T> GetVariable<T>(this LocalizeStringEvent localizeStringEvent, string name)
	{
		return localizeStringEvent.StringReference[name] as Variable<T>;
	}

	public static Variable<T> GetVariable<T>(this LocalizedString localizedString, string name)
	{
		return localizedString[name] as Variable<T>;
	}

	public static LocalizedString GetVariable(this LocalizedString localizedString, string name)
	{
		return localizedString[name] as LocalizedString;
	}

	public static LocalizedString GetVariable(this LocalizeStringEvent localizeStringEvent, string name)
	{
		return localizeStringEvent.StringReference[name] as LocalizedString;
	}

	public static string GetLocalizeString(LocalizationCommonData.CommonString commonString)
	{
		return GetLocalizeString(LocalizationTableHelper.TableEnum2TableString(LocalizeTable.Common), (int)commonString);
	}

	public static string GetLocalizeString(string tableName, int localizeId, bool isSmart = true)
	{
		StringTableEntry entry = LocalizationSettings.StringDatabase.GetTable(tableName).GetEntry(localizeId);
		if (entry != null)
		{
			entry.IsSmart = isSmart;
			return entry.GetLocalizedString();
		}
		_ = LuminApplication.LogEnabled;
		return "String Not Found!";
	}

	public static string GetLocalizeString(string tableName, int localizeId, IList<object> args)
	{
		StringTableEntry entry = LocalizationSettings.StringDatabase.GetTable(tableName).GetEntry(localizeId);
		if (entry != null)
		{
			return entry.GetLocalizedString(null, args);
		}
		_ = LuminApplication.LogEnabled;
		return "String Not Found!";
	}

	public static string GetLocalizeString(LocalizeStringConfig config)
	{
		return GetLocalizeString(LocalizationTableHelper.TableEnum2TableString(config.table), config.id);
	}

	public static string GetLocalizeString(LocalizeStringData data)
	{
		return GetLocalizeString(LocalizationTableHelper.TableEnum2TableString(data.Table), data.Id);
	}

	public static void SetReference(this LocalizeStringEvent localizeStringEvent, LocalizeStringData data)
	{
		localizeStringEvent.SetReference(data.Table, data.Id);
	}

	public static void SetReference(this LocalizeStringEvent localizeStringEvent, LocalizeTable table, int id)
	{
		localizeStringEvent.StringReference.SetReference(LocalizationTableHelper.TableEnum2TableString(table), id);
	}

	public static void SetTable(this LocalizeStringEvent localizeStringEvent, LocalizeTable table)
	{
		localizeStringEvent.StringReference.TableReference = LocalizationTableHelper.TableEnum2TableString(table);
	}

	public static void SetEntry(this LocalizeStringEvent localizeStringEvent, int id)
	{
		localizeStringEvent.StringReference.TableEntryReference = id;
	}
}
