using System.Collections.Generic;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.Tables;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization;

internal class LoadAllTablesOperation<TTable, TEntry> : WaitForCurrentOperationAsyncOperationBase<IList<TTable>> where TTable : DetailedLocalizationTable<TEntry> where TEntry : TableEntry
{
	private AsyncOperationHandle<IList<TTable>> m_AllTablesOperation;

	private Locale m_Locale;

	public void Init(Locale locale)
	{
		m_Locale = locale;
	}

	protected override void Execute()
	{
		string label = ((m_Locale != null) ? AddressHelper.FormatAssetLabel(m_Locale.Identifier) : AddressHelper.FormatAssetLabel(LocalizationSettings.SelectedLocaleAsync.Result.Identifier));
		m_AllTablesOperation = AddressablesInterface.LoadAssetsWithLabel<TTable>(label, null);
		m_AllTablesOperation.Completed += LoadingCompleted;
		CurrentOperation = m_AllTablesOperation;
	}

	private void LoadingCompleted(AsyncOperationHandle<IList<TTable>> obj)
	{
		Complete(obj.Result, obj.Status == AsyncOperationStatus.Succeeded, obj.OperationException?.Message);
	}

	protected override void Destroy()
	{
		base.Destroy();
		AddressablesInterface.SafeRelease(m_AllTablesOperation);
		m_AllTablesOperation = default;
	}
}
