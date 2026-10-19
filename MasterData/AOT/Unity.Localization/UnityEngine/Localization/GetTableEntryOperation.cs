using System;
using System.Collections.Generic;
using UnityEngine.Localization.Metadata;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.Tables;
using UnityEngine.Pool;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization;

internal class GetTableEntryOperation<TTable, TEntry> : WaitForCurrentOperationAsyncOperationBase<LocalizedDatabase<TTable, TEntry>.TableEntryResult> where TTable : DetailedLocalizationTable<TEntry> where TEntry : TableEntry
{
	private readonly Action<AsyncOperationHandle<TTable>> m_ExtractEntryFromTableAction;

	private AsyncOperationHandle<TTable> m_LoadTableOperation;

	private TableReference m_TableReference;

	private TableEntryReference m_TableEntryReference;

	private LocalizedDatabase<TTable, TEntry> m_Database;

	private Locale m_SelectedLocale;

	private Locale m_CurrentLocale;

	private HashSet<Locale> m_HandledFallbacks;

	private List<Locale> m_FallbackQueue;

	private bool m_UseFallback;

	private bool m_AutoRelease;

	public GetTableEntryOperation()
	{
		m_ExtractEntryFromTableAction = ExtractEntryFromTable;
	}

	public void Init(LocalizedDatabase<TTable, TEntry> database, AsyncOperationHandle<TTable> loadTableOperation, TableReference tableReference, TableEntryReference tableEntryReference, Locale selectedLoale, bool UseFallBack, bool autoRelease)
	{
		m_Database = database;
		m_LoadTableOperation = loadTableOperation;
		AddressablesInterface.Acquire(m_LoadTableOperation);
		m_TableReference = tableReference;
		m_TableEntryReference = tableEntryReference;
		m_SelectedLocale = selectedLoale;
		m_UseFallback = UseFallBack;
		m_AutoRelease = autoRelease;
	}

	protected override void Execute()
	{
		AsyncOperationHandle<TTable> loadTableOperation = m_LoadTableOperation;
		m_LoadTableOperation = default;
		if (m_SelectedLocale == null)
		{
			m_SelectedLocale = LocalizationSettings.SelectedLocaleAsync.Result;
			if (m_SelectedLocale == null)
			{
				CompleteAndRelease(default, success: false, "SelectedLocale is null. Could not get table entry.");
				AddressablesInterface.SafeRelease(loadTableOperation);
				return;
			}
		}
		m_CurrentLocale = m_SelectedLocale;
		ExtractEntryFromTable(loadTableOperation);
	}

	private void ExtractEntryFromTable(AsyncOperationHandle<TTable> asyncOperation)
	{
		TTable result = asyncOperation.Result;
		TEntry entry = (((object)result != null) ? result.GetEntryFromReference(m_TableEntryReference) : null);
		if (!HandleEntryOverride(asyncOperation, entry) && !HandleFallback(asyncOperation, entry))
		{
			m_LoadTableOperation = asyncOperation;
			CompleteAndRelease(new LocalizedDatabase<TTable, TEntry>.TableEntryResult(entry, asyncOperation.Result), success: true, null);
		}
	}

	private bool HandleEntryOverride(AsyncOperationHandle<TTable> asyncOperation, TEntry entry)
	{
		if (entry != null)
		{
			for (int i = 0; i < entry.MetadataEntries.Count; i++)
			{
				if (entry.MetadataEntries[i] is IEntryOverride entryOverride && ApplyEntryOverride(entryOverride, asyncOperation, entry))
				{
					return true;
				}
			}
		}
		SharedTableData.SharedTableEntry sharedTableEntry = entry?.SharedEntry ?? asyncOperation.Result?.SharedData.GetEntryFromReference(m_TableEntryReference);
		if (sharedTableEntry != null)
		{
			for (int j = 0; j < sharedTableEntry.Metadata.MetadataEntries.Count; j++)
			{
				if (sharedTableEntry.Metadata.MetadataEntries[j] is IEntryOverride entryOverride2 && ApplyEntryOverride(entryOverride2, asyncOperation, entry))
				{
					return true;
				}
			}
		}
		return false;
	}

	private bool ApplyEntryOverride(IEntryOverride entryOverride, AsyncOperationHandle<TTable> asyncOperation, TEntry entry)
	{
		if (entryOverride == null)
		{
			return false;
		}
		TableReference tableReference;
		TableEntryReference tableEntryReference;
		switch (entryOverride.GetOverride(out tableReference, out tableEntryReference))
		{
		case EntryOverrideType.None:
			return false;
		case EntryOverrideType.Entry:
			m_TableEntryReference = tableEntryReference;
			ExtractEntryFromTable(asyncOperation);
			return true;
		case EntryOverrideType.Table:
		{
			SharedTableData.SharedTableEntry sharedTableEntry = entry?.SharedEntry ?? asyncOperation.Result?.SharedData.GetEntryFromReference(m_TableEntryReference);
			m_TableEntryReference = sharedTableEntry.Key;
			break;
		}
		case EntryOverrideType.TableAndEntry:
			m_TableEntryReference = tableEntryReference;
			break;
		}
		AddressablesInterface.Release(asyncOperation);
		asyncOperation = m_Database.GetTableAsync(tableReference, m_CurrentLocale);
		AddressablesInterface.Acquire(asyncOperation);
		if (asyncOperation.IsDone)
		{
			ExtractEntryFromTable(asyncOperation);
		}
		else
		{
			CurrentOperation = asyncOperation;
			asyncOperation.Completed += m_ExtractEntryFromTableAction;
		}
		return true;
	}

	private Locale GetNextFallback(Locale currentLocale)
	{
		if (m_FallbackQueue == null)
		{
			m_FallbackQueue = CollectionPool<List<Locale>, Locale>.Get();
			m_HandledFallbacks = CollectionPool<HashSet<Locale>, Locale>.Get();
		}
		if (!m_HandledFallbacks.Contains(currentLocale))
		{
			m_HandledFallbacks.Add(currentLocale);
		}
		IEnumerable<Locale> fallbacks = currentLocale.GetFallbacks();
		if (fallbacks != null)
		{
			foreach (Locale item in fallbacks)
			{
				if (!m_HandledFallbacks.Contains(item))
				{
					m_HandledFallbacks.Add(item);
					m_FallbackQueue.Add(item);
				}
			}
		}
		if (m_FallbackQueue.Count == 0)
		{
			return null;
		}
		Locale result = m_FallbackQueue[0];
		m_FallbackQueue.RemoveAt(0);
		return result;
	}

	private bool HandleFallback(AsyncOperationHandle<TTable> asyncOperation, TEntry entry)
	{
		if ((entry == null || string.IsNullOrEmpty(entry.Data.Localized)) && m_UseFallback)
		{
			Locale nextFallback = GetNextFallback(m_CurrentLocale);
			if (nextFallback != null)
			{
				m_CurrentLocale = nextFallback;
				AddressablesInterface.Release(asyncOperation);
				asyncOperation = m_Database.GetTableAsync(m_TableReference, m_CurrentLocale);
				AddressablesInterface.Acquire(asyncOperation);
				if (asyncOperation.IsDone)
				{
					ExtractEntryFromTable(asyncOperation);
				}
				else
				{
					CurrentOperation = asyncOperation;
					asyncOperation.Completed += m_ExtractEntryFromTableAction;
				}
				return true;
			}
		}
		return false;
	}

	private void CompleteAndRelease(LocalizedDatabase<TTable, TEntry>.TableEntryResult result, bool success, string errorMsg)
	{
		Complete(result, success, errorMsg);
		if (m_AutoRelease && LocalizationSettings.Instance.IsPlaying)
		{
			LocalizationBehaviour.ReleaseNextFrame(Handle);
		}
	}

	protected override void Destroy()
	{
		AddressablesInterface.SafeRelease(m_LoadTableOperation);
		m_LoadTableOperation = default;
		base.Destroy();
		GenericPool<GetTableEntryOperation<TTable, TEntry>>.Release(this);
		if (m_FallbackQueue != null)
		{
			CollectionPool<List<Locale>, Locale>.Release(m_FallbackQueue);
			CollectionPool<HashSet<Locale>, Locale>.Release(m_HandledFallbacks);
			m_FallbackQueue = null;
			m_HandledFallbacks = null;
		}
	}

	public override string ToString()
	{
		return $"{GetType().Name}, Current Locale: {m_CurrentLocale}, Selected Locale: {m_SelectedLocale}, Table: {m_TableReference}, Entry: {m_TableEntryReference}, Fallback: {m_UseFallback}";
	}
}
