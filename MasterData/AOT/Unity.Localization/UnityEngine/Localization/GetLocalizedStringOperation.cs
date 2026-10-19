using System;
using System.Collections.Generic;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.SmartFormat.Core.Formatting;
using UnityEngine.Localization.SmartFormat.PersistentVariables;
using UnityEngine.Localization.Tables;
using UnityEngine.Pool;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization;

internal class GetLocalizedStringOperation : WaitForCurrentOperationAsyncOperationBase<string>
{
	private LocalizedStringDatabase m_Database;

	private AsyncOperationHandle<LocalizedDatabase<StringTable, StringTableEntry>.TableEntryResult> m_TableEntryOperation;

	private TableReference m_TableReference;

	private TableEntryReference m_TableEntryReference;

	private Locale m_SelectedLocale;

	private IList<object> m_Arguments;

	private IVariableGroup m_LocalVariables;

	private bool m_AutoRelease;

	public void Init(AsyncOperationHandle<LocalizedDatabase<StringTable, StringTableEntry>.TableEntryResult> tableEntryOperation, Locale locale, LocalizedStringDatabase database, TableReference tableReference, TableEntryReference tableEntryReference, IList<object> arguments, IVariableGroup localVariables, bool autoRelease)
	{
		m_TableEntryOperation = tableEntryOperation;
		m_SelectedLocale = locale;
		AddressablesInterface.Acquire(m_TableEntryOperation);
		m_Database = database;
		m_TableReference = tableReference;
		m_TableEntryReference = tableEntryReference;
		m_Arguments = arguments;
		m_LocalVariables = localVariables;
		m_AutoRelease = autoRelease;
	}

	protected override void Execute()
	{
		if (m_SelectedLocale == null)
		{
			m_SelectedLocale = LocalizationSettings.SelectedLocaleAsync.Result;
			if (m_SelectedLocale == null)
			{
				CompleteAndRelease(null, success: false, "SelectedLocale is null. Could not get localized string.");
				return;
			}
		}
		if (m_TableEntryOperation.Status != AsyncOperationStatus.Succeeded)
		{
			CompleteAndRelease(null, success: false, "Load Table Operation Failed");
			return;
		}
		StringTableEntry entry = m_TableEntryOperation.Result.Entry;
		FormatCache formatCache = entry?.GetOrCreateFormatCache();
		if (formatCache != null)
		{
			formatCache.LocalVariables = m_LocalVariables;
		}
		try
		{
			string result = m_Database.GenerateLocalizedString(m_TableEntryOperation.Result.Table, entry, m_TableReference, m_TableEntryReference, m_SelectedLocale, m_Arguments);
			if (formatCache != null)
			{
				formatCache.LocalVariables = null;
			}
			CompleteAndRelease(result, success: true, null);
		}
		catch (Exception ex)
		{
			CompleteAndRelease(null, success: false, ex.Message);
		}
	}

	public void CompleteAndRelease(string result, bool success, string errorMsg)
	{
		Complete(result, success, errorMsg);
		AddressablesInterface.SafeRelease(m_TableEntryOperation);
		if (m_AutoRelease && LocalizationSettings.Instance.IsPlaying)
		{
			LocalizationBehaviour.ReleaseNextFrame(Handle);
		}
	}

	protected override void Destroy()
	{
		base.Destroy();
		GenericPool<GetLocalizedStringOperation>.Release(this);
	}

	public override string ToString()
	{
		return $"{GetType().Name}, Locale: {m_SelectedLocale}, Table: {m_TableReference}, Entry: {m_TableEntryReference}";
	}
}
