using System;
using UnityEngine.Localization.Settings;
using UnityEngine.Pool;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization;

[Serializable]
public class LocalizedAsset<TObject> : LocalizedAssetBase where TObject : Object
{
	public delegate void ChangeHandler(TObject value);

	private class ConvertToObjectOperation : WaitForCurrentOperationAsyncOperationBase<Object>
	{
		private AsyncOperationHandle<TObject> m_Operation;

		public void Init(AsyncOperationHandle<TObject> operation)
		{
			AddressablesInterface.ResourceManager.Acquire(operation);
			m_Operation = operation;
			CurrentOperation = operation;
		}

		protected override void Execute()
		{
			if (m_Operation.IsDone)
			{
				OnCompleted(m_Operation);
			}
			else
			{
				m_Operation.Completed += OnCompleted;
			}
		}

		private void OnCompleted(AsyncOperationHandle<TObject> op)
		{
			Complete((Object)op.Result, op.Status == AsyncOperationStatus.Succeeded, (string)null);
		}

		protected override void Destroy()
		{
			AddressablesInterface.Release(m_Operation);
			GenericPool<ConvertToObjectOperation>.Release(this);
		}
	}

	private CallbackArray<ChangeHandler> m_ChangeHandler;

	private Action<Locale> m_SelectedLocaleChanged;

	private Action<AsyncOperationHandle<TObject>> m_AutomaticLoadingCompleted;

	public override bool WaitForCompletion
	{
		set
		{
			if (value != WaitForCompletion)
			{
				base.WaitForCompletion = value;
				if (value && CurrentLoadingOperationHandle.IsValid() && !CurrentLoadingOperationHandle.IsDone)
				{
					CurrentLoadingOperationHandle.WaitForCompletion();
				}
			}
		}
	}

	public AsyncOperationHandle<TObject> CurrentLoadingOperationHandle { get; internal set; }

	public bool HasChangeHandler => m_ChangeHandler.Length != 0;

	public event ChangeHandler AssetChanged
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
				ForceUpdate();
				LocalizationSettings.SelectedLocaleChanged += m_SelectedLocaleChanged;
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

	public LocalizedAsset()
	{
		m_SelectedLocaleChanged = HandleLocaleChange;
		m_AutomaticLoadingCompleted = AutomaticLoadingCompleted;
	}

	public AsyncOperationHandle<TObject> LoadAssetAsync()
	{
		LocalizationSettings.ValidateSettingsExist("Can not Load Asset.");
		return LocalizationSettings.AssetDatabase.GetLocalizedAssetAsync<TObject>(TableReference, TableEntryReference, LocaleOverride);
	}

	public override AsyncOperationHandle<Object> LoadAssetAsObjectAsync()
	{
		AsyncOperationHandle<TObject> operation = LoadAssetAsync();
		ConvertToObjectOperation convertToObjectOperation = GenericPool<ConvertToObjectOperation>.Get();
		convertToObjectOperation.Init(operation);
		return AddressablesInterface.ResourceManager.StartOperation(convertToObjectOperation, default);
	}

	public TObject LoadAsset()
	{
		return LoadAssetAsync().WaitForCompletion();
	}

	protected internal override void ForceUpdate()
	{
		if (m_ChangeHandler.Length != 0)
		{
			HandleLocaleChange(null);
		}
	}

	private void HandleLocaleChange(Locale _)
	{
		ClearLoadingOperation();
		if (IsEmpty)
		{
			return;
		}
		CurrentLoadingOperationHandle = LoadAssetAsync();
		AddressablesInterface.Acquire(CurrentLoadingOperationHandle);
		if (!CurrentLoadingOperationHandle.IsDone)
		{
			if (!WaitForCompletion)
			{
				AsyncOperationHandle<TObject> currentLoadingOperationHandle = CurrentLoadingOperationHandle;
				currentLoadingOperationHandle.Completed += m_AutomaticLoadingCompleted;
				return;
			}
			CurrentLoadingOperationHandle.WaitForCompletion();
		}
		AutomaticLoadingCompleted(CurrentLoadingOperationHandle);
	}

	private void AutomaticLoadingCompleted(AsyncOperationHandle<TObject> loadOperation)
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

	private void InvokeChangeHandler(TObject value)
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

	internal void ClearLoadingOperation()
	{
		if (CurrentLoadingOperationHandle.IsValid())
		{
			if (!CurrentLoadingOperationHandle.IsDone)
			{
				AsyncOperationHandle<TObject> currentLoadingOperationHandle = CurrentLoadingOperationHandle;
				currentLoadingOperationHandle.Completed -= m_AutomaticLoadingCompleted;
			}
			AddressablesInterface.Release(CurrentLoadingOperationHandle);
			CurrentLoadingOperationHandle = default;
		}
	}

	protected override void Reset()
	{
		ClearLoadingOperation();
	}
}
