using System;
using System.Collections.Generic;
using UnityEngine.Localization.Pseudo;
using UnityEngine.Localization.SmartFormat;
using UnityEngine.Localization.SmartFormat.PersistentVariables;
using UnityEngine.Localization.Tables;
using UnityEngine.Pool;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization.Settings;

[Serializable]
public class LocalizedStringDatabase : LocalizedDatabase<StringTable, StringTableEntry>
{
	[SerializeField]
	private MissingTranslationBehavior m_MissingTranslationState = MissingTranslationBehavior.ShowMissingTranslationMessage;

	private const string k_DefaultNoTranslationMessage = "No translation found for '{key}' in {table.TableCollectionName}";

	[SerializeField]
	[Tooltip("The string that will be used when a localized value is missing. This is a Smart String which has access to the following placeholders:\n\t{key}: The name of the key\n\t{keyId}: The numeric Id of the key\n\t{table}: The table object, this can be further queried, for example {table.TableCollectionName}\n\t{locale}: The locale asset, this can be further queried, for example {locale.name}")]
	private string m_NoTranslationFoundMessage = "No translation found for '{key}' in {table.TableCollectionName}";

	[SerializeReference]
	private SmartFormatter m_SmartFormat = Smart.CreateDefaultSmartFormat();

	private StringTable m_MissingTranslationTable;

	public string NoTranslationFoundMessage
	{
		get
		{
			return m_NoTranslationFoundMessage;
		}
		set
		{
			m_NoTranslationFoundMessage = value;
		}
	}

	public MissingTranslationBehavior MissingTranslationState
	{
		get
		{
			return m_MissingTranslationState;
		}
		set
		{
			m_MissingTranslationState = value;
		}
	}

	public SmartFormatter SmartFormatter
	{
		get
		{
			return m_SmartFormat;
		}
		set
		{
			m_SmartFormat = value;
		}
	}

	public AsyncOperationHandle<string> GetLocalizedStringAsync(TableEntryReference tableEntryReference, Locale locale = null, FallbackBehavior fallbackBehavior = FallbackBehavior.UseProjectSettings, params object[] arguments)
	{
		return GetLocalizedStringAsyncInternal(GetDefaultTable(), tableEntryReference, arguments, locale, fallbackBehavior);
	}

	public string GetLocalizedString(TableEntryReference tableEntryReference, Locale locale = null, FallbackBehavior fallbackBehavior = FallbackBehavior.UseProjectSettings, params object[] arguments)
	{
		return GetLocalizedString(GetDefaultTable(), tableEntryReference, arguments, locale, fallbackBehavior);
	}

	public AsyncOperationHandle<string> GetLocalizedStringAsync(TableEntryReference tableEntryReference, IList<object> arguments, Locale locale = null, FallbackBehavior fallbackBehavior = FallbackBehavior.UseProjectSettings)
	{
		return GetLocalizedStringAsyncInternal(GetDefaultTable(), tableEntryReference, arguments, locale, fallbackBehavior);
	}

	public string GetLocalizedString(TableEntryReference tableEntryReference, IList<object> arguments, Locale locale = null, FallbackBehavior fallbackBehavior = FallbackBehavior.UseProjectSettings)
	{
		return GetLocalizedString(GetDefaultTable(), tableEntryReference, arguments, locale, fallbackBehavior);
	}

	public virtual AsyncOperationHandle<string> GetLocalizedStringAsync(TableReference tableReference, TableEntryReference tableEntryReference, Locale locale = null, FallbackBehavior fallbackBehavior = FallbackBehavior.UseProjectSettings, params object[] arguments)
	{
		return GetLocalizedStringAsyncInternal(tableReference, tableEntryReference, arguments, locale, fallbackBehavior);
	}

	public virtual string GetLocalizedString(TableReference tableReference, TableEntryReference tableEntryReference, Locale locale = null, FallbackBehavior fallbackBehavior = FallbackBehavior.UseProjectSettings, params object[] arguments)
	{
		return GetLocalizedString(tableReference, tableEntryReference, arguments, locale, fallbackBehavior);
	}

	public virtual AsyncOperationHandle<string> GetLocalizedStringAsync(TableReference tableReference, TableEntryReference tableEntryReference, IList<object> arguments, Locale locale = null, FallbackBehavior fallbackBehavior = FallbackBehavior.UseProjectSettings, IVariableGroup localVariables = null)
	{
		return GetLocalizedStringAsyncInternal(tableReference, tableEntryReference, arguments, locale, fallbackBehavior, localVariables);
	}

	internal virtual AsyncOperationHandle<string> GetLocalizedStringAsyncInternal(TableReference tableReference, TableEntryReference tableEntryReference, IList<object> arguments, Locale locale = null, FallbackBehavior fallbackBehavior = FallbackBehavior.UseProjectSettings, IVariableGroup localVariables = null, bool autoRelease = true)
	{
		AsyncOperationHandle<TableEntryResult> tableEntryAsync = GetTableEntryAsync(tableReference, tableEntryReference, locale, fallbackBehavior);
		GetLocalizedStringOperation getLocalizedStringOperation = GenericPool<GetLocalizedStringOperation>.Get();
		getLocalizedStringOperation.Dependency = tableEntryAsync;
		getLocalizedStringOperation.Init(tableEntryAsync, locale, this, tableReference, tableEntryReference, arguments, localVariables, autoRelease);
		return AddressablesInterface.ResourceManager.StartOperation(getLocalizedStringOperation, tableEntryAsync);
	}

	public virtual string GetLocalizedString(TableReference tableReference, TableEntryReference tableEntryReference, IList<object> arguments, Locale locale = null, FallbackBehavior fallbackBehavior = FallbackBehavior.UseProjectSettings)
	{
		AsyncOperationHandle<string> localizedStringAsyncInternal = GetLocalizedStringAsyncInternal(tableReference, tableEntryReference, arguments, locale, fallbackBehavior, null, autoRelease: false);
		string result = localizedStringAsyncInternal.WaitForCompletion();
		AddressablesInterface.Release(localizedStringAsyncInternal);
		return result;
	}

	protected internal virtual string GenerateLocalizedString(StringTable table, StringTableEntry entry, TableReference tableReference, TableEntryReference tableEntryReference, Locale locale, IList<object> arguments)
	{
		string text = entry?.GetLocalizedString(locale?.Formatter, arguments, locale as PseudoLocale);
		if (string.IsNullOrEmpty(text))
		{
			SharedTableData sharedTableData = table?.SharedData;
			if (sharedTableData == null && tableReference.ReferenceType == TableReference.Type.Guid)
			{
				AsyncOperationHandle<SharedTableData> sharedTableData2 = GetSharedTableData(tableReference.TableCollectionNameGuid);
				if (sharedTableData2.IsDone)
				{
					sharedTableData = sharedTableData2.Result;
				}
			}
			string key = tableEntryReference.ResolveKeyName(sharedTableData);
			return ProcessUntranslatedText(key, tableEntryReference.KeyId, tableReference, table, locale);
		}
		return text;
	}

	private StringTable GetUntranslatedTextTempTable(TableReference tableReference)
	{
		if (m_MissingTranslationTable == null)
		{
			m_MissingTranslationTable = ScriptableObject.CreateInstance<StringTable>();
			m_MissingTranslationTable.SharedData = ScriptableObject.CreateInstance<SharedTableData>();
		}
		if (tableReference.ReferenceType == TableReference.Type.Guid)
		{
			m_MissingTranslationTable.SharedData.TableCollectionNameGuid = tableReference;
			AsyncOperationHandle<SharedTableData> sharedTableData = GetSharedTableData(tableReference.TableCollectionNameGuid);
			if (sharedTableData.IsDone && sharedTableData.Result != null)
			{
				m_MissingTranslationTable.SharedData.TableCollectionName = sharedTableData.Result.TableCollectionName;
			}
			else
			{
				m_MissingTranslationTable.SharedData.TableCollectionName = tableReference.TableCollectionNameGuid.ToString();
			}
		}
		else if (tableReference.ReferenceType == TableReference.Type.Name)
		{
			m_MissingTranslationTable.SharedData.TableCollectionName = tableReference.TableCollectionName;
			m_MissingTranslationTable.SharedData.TableCollectionNameGuid = Guid.Empty;
		}
		return m_MissingTranslationTable;
	}

	internal string ProcessUntranslatedText(string key, long keyId, TableReference tableReference, StringTable table, Locale locale)
	{
		if (table == null)
		{
			table = GetUntranslatedTextTempTable(tableReference);
		}
		if (MissingTranslationState != 0)
		{
			Dictionary<string, object> value;
			using (CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get(out value))
			{
				value["key"] = key;
				value["keyId"] = keyId;
				value["table"] = table;
				value["locale"] = locale;
				string text = m_SmartFormat.Format(string.IsNullOrEmpty(NoTranslationFoundMessage) ? "No translation found for '{key}' in {table.TableCollectionName}" : NoTranslationFoundMessage, value);
				if (MissingTranslationState.HasFlag(MissingTranslationBehavior.PrintWarning))
				{
					Debug.LogWarning(text);
				}
				if (MissingTranslationState.HasFlag(MissingTranslationBehavior.ShowMissingTranslationMessage))
				{
					return text;
				}
			}
		}
		return string.Empty;
	}
}
