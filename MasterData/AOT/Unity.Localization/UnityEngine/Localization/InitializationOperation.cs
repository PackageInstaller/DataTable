using System;
using System.Collections.Generic;
using UnityEngine.Localization.Settings;
using UnityEngine.Pool;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization;

internal class InitializationOperation : WaitForCurrentOperationAsyncOperationBase<LocalizationSettings>
{
	private readonly Action<AsyncOperationHandle<Locale>> m_PreloadTablesAction;

	private readonly Action<AsyncOperationHandle> m_FinishInitializingAction;

	private LocalizationSettings m_Settings;

	private readonly List<AsyncOperationHandle> m_LoadDatabasesOperations = new List<AsyncOperationHandle>();

	private int m_RemainingSteps;

	private const int k_PreloadSteps = 3;

	protected override float Progress
	{
		get
		{
			if (CurrentOperation.IsValid())
			{
				return ((float)(3 - m_RemainingSteps) + CurrentOperation.PercentComplete) / 4f;
			}
			return base.Progress;
		}
	}

	protected override string DebugName => "Localization Settings Initialization";

	public InitializationOperation()
	{
		m_PreloadTablesAction = (AsyncOperationHandle<Locale> a) =>
		{
			PreloadTables();
		};
		m_FinishInitializingAction = FinishInitializing;
	}

	public void Init(LocalizationSettings settings)
	{
		m_Settings = settings;
		m_LoadDatabasesOperations.Clear();
		m_RemainingSteps = 3;
	}

	protected override void Execute()
	{
		LoadLocales();
	}

	private void LoadLocales()
	{
		AsyncOperationHandle<Locale> selectedLocaleAsync = m_Settings.GetSelectedLocaleAsync();
		if (!selectedLocaleAsync.IsDone)
		{
			CurrentOperation = selectedLocaleAsync;
			selectedLocaleAsync.Completed += m_PreloadTablesAction;
		}
		else
		{
			PreloadTables();
		}
	}

	private void PreloadTables()
	{
		m_RemainingSteps--;
		IPreloadRequired assetDatabase = m_Settings.GetAssetDatabase();
		if (assetDatabase != null && !assetDatabase.PreloadOperation.IsDone)
		{
			m_LoadDatabasesOperations.Add(assetDatabase.PreloadOperation);
		}
		else
		{
			m_RemainingSteps--;
		}
		IPreloadRequired stringDatabase = m_Settings.GetStringDatabase();
		if (stringDatabase != null && !stringDatabase.PreloadOperation.IsDone)
		{
			m_LoadDatabasesOperations.Add(stringDatabase.PreloadOperation);
		}
		else
		{
			m_RemainingSteps--;
		}
		if (m_LoadDatabasesOperations.Count > 0)
		{
			AsyncOperationHandle<IList<AsyncOperationHandle>> asyncOperationHandle = AddressablesInterface.ResourceManager.CreateGenericGroupOperation(m_LoadDatabasesOperations, releasedCachedOpOnComplete: true);
			CurrentOperation = asyncOperationHandle;
			asyncOperationHandle.CompletedTypeless += m_FinishInitializingAction;
		}
		else
		{
			FinishInitializing(success: true, null);
		}
	}

	private void PostInitializeExtensions()
	{
		foreach (IStartupLocaleSelector startupLocaleSelector in m_Settings.GetStartupLocaleSelectors())
		{
			(startupLocaleSelector as IInitialize)?.PostInitialization(m_Settings);
		}
		(m_Settings.GetAvailableLocales() as IInitialize)?.PostInitialization(m_Settings);
		(m_Settings.GetAssetDatabase() as IInitialize)?.PostInitialization(m_Settings);
		(m_Settings.GetStringDatabase() as IInitialize)?.PostInitialization(m_Settings);
	}

	private void FinishInitializing(AsyncOperationHandle op)
	{
		FinishInitializing(op.Status == AsyncOperationStatus.Succeeded, op.OperationException?.Message);
	}

	private void FinishInitializing(bool success, string error)
	{
		PostInitializeExtensions();
		Complete(m_Settings, success, error);
	}

	protected override void Destroy()
	{
		base.Destroy();
		GenericPool<InitializationOperation>.Release(this);
	}
}
