using System;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.Tables;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization;

[Serializable]
public abstract class LocalizedTable<TTable, TEntry> where TTable : DetailedLocalizationTable<TEntry> where TEntry : TableEntry
{
	public delegate void ChangeHandler(TTable value);

	[SerializeField]
	private TableReference m_TableReference;

	private CallbackArray<ChangeHandler> m_ChangeHandler;

	private Action<Locale> m_SelectedLocaleChanged;

	protected abstract LocalizedDatabase<TTable, TEntry> Database { get; }

	public AsyncOperationHandle<TTable> CurrentLoadingOperationHandle { get; internal set; }

	public TableReference TableReference
	{
		get
		{
			return m_TableReference;
		}
		set
		{
			if (!value.Equals(m_TableReference))
			{
				m_TableReference = value;
				ForceUpdate();
			}
		}
	}

	public bool IsEmpty => TableReference.ReferenceType == TableReference.Type.Empty;

	[Obsolete("CurrentLoadingOperation is deprecated, use CurrentLoadingOperationHandle instead.")]
	public AsyncOperationHandle<TTable>? CurrentLoadingOperation => CurrentLoadingOperationHandle.IsValid() ? CurrentLoadingOperationHandle : default(AsyncOperationHandle<TTable>);

	public event ChangeHandler TableChanged
	{
		add
		{
			if (value == null)
			{
				throw new ArgumentNullException();
			}
			m_ChangeHandler.Add(value);
			if (m_ChangeHandler.Length == 1)
			{
				LocalizationSettings.ValidateSettingsExist();
				LocalizationSettings.SelectedLocaleChanged += m_SelectedLocaleChanged;
				ForceUpdate();
			}
			else if (CurrentLoadingOperationHandle.IsValid() && CurrentLoadingOperationHandle.IsDone)
			{
				value(CurrentLoadingOperationHandle.Result);
			}
		}
		remove
		{
			m_ChangeHandler.RemoveByMovingTail(value);
			if (m_ChangeHandler.Length == 0)
			{
				LocalizationSettings.SelectedLocaleChanged -= m_SelectedLocaleChanged;
				ClearLoadingOperation();
			}
		}
	}

	public LocalizedTable()
	{
		m_SelectedLocaleChanged = HandleLocaleChange;
	}

	public AsyncOperationHandle<TTable> GetTableAsync()
	{
		return Database.GetTableAsync(TableReference);
	}

	public TTable GetTable()
	{
		return GetTableAsync().WaitForCompletion();
	}

	protected void ForceUpdate()
	{
		if (m_ChangeHandler.Length != 0)
		{
			HandleLocaleChange(null);
		}
	}

	private void InvokeChangeHandler(TTable value)
	{
		try
		{
			m_ChangeHandler.LockForChanges();
			int length = m_ChangeHandler.Length;
			if (length == 1)
			{
				m_ChangeHandler.SingleDelegate(value);
			}
			else if (length > 1)
			{
				ChangeHandler[] multiDelegates = m_ChangeHandler.MultiDelegates;
				for (int i = 0; i < length; i++)
				{
					multiDelegates[i](value);
				}
			}
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
		m_ChangeHandler.UnlockForChanges();
	}

	private void HandleLocaleChange(Locale _)
	{
		ClearLoadingOperation();
		if (!IsEmpty)
		{
			CurrentLoadingOperationHandle = GetTableAsync();
			if (CurrentLoadingOperationHandle.IsDone)
			{
				AutomaticLoadingCompleted(CurrentLoadingOperationHandle);
				return;
			}
			AsyncOperationHandle<TTable> currentLoadingOperationHandle = CurrentLoadingOperationHandle;
			currentLoadingOperationHandle.Completed += AutomaticLoadingCompleted;
		}
	}

	private void AutomaticLoadingCompleted(AsyncOperationHandle<TTable> loadOperation)
	{
		if (loadOperation.Status != AsyncOperationStatus.Succeeded)
		{
			CurrentLoadingOperationHandle = default;
		}
		else
		{
			InvokeChangeHandler(loadOperation.Result);
		}
	}

	private void ClearLoadingOperation()
	{
		if (CurrentLoadingOperationHandle.IsValid())
		{
			if (!CurrentLoadingOperationHandle.IsDone)
			{
				AsyncOperationHandle<TTable> currentLoadingOperationHandle = CurrentLoadingOperationHandle;
				currentLoadingOperationHandle.Completed -= AutomaticLoadingCompleted;
			}
			CurrentLoadingOperationHandle = default;
		}
	}

	public override string ToString()
	{
		return TableReference;
	}
}
