using System;
using System.Collections.Generic;
using System.IO;
using ACT.Sound.Core;
using UnityEngine;
using YooAsset;

namespace ACT.Sound.Management;

public class AudioBankManager
{
	private readonly Dictionary<string, BankReference> _loadedBanks = new Dictionary<string, BankReference>();

	private readonly List<string> _banksToUnload = new List<string>(8);

	private readonly List<string> _banksToFinalize = new List<string>(8);

	private const float UnloadDelaySeconds = 30f;

	public void Update(float deltaTime)
	{
		FinalizeLoadingBanks();
		_banksToUnload.Clear();
		foreach (KeyValuePair<string, BankReference> loadedBank in _loadedBanks)
		{
			BankReference value = loadedBank.Value;
			if (value.State == BankState.PendingUnload)
			{
				value.UnloadTimer -= deltaTime;
				if (value.UnloadTimer <= 0f)
				{
					_banksToUnload.Add(loadedBank.Key);
				}
			}
		}
		foreach (string item in _banksToUnload)
		{
			UnloadBankImmediate(item);
		}
	}

	public void LoadBank(YooAssetReference bankAsset, Action onComplete = null)
	{
		if (bankAsset == null)
		{
			onComplete?.Invoke();
			return;
		}
		string gUID = bankAsset.GUID;
		LoadBankByGuid(gUID);
		onComplete?.Invoke();
	}

	public void LoadBanks(List<YooAssetReference> banks, Action onComplete = null)
	{
		if (banks == null || banks.Count == 0)
		{
			onComplete?.Invoke();
			return;
		}
		int remainingCount = banks.Count;
		foreach (YooAssetReference bank in banks)
		{
			LoadBank(bank, () =>
			{
				remainingCount--;
				if (remainingCount == 0)
				{
					onComplete?.Invoke();
				}
			});
		}
	}

	public void UnloadBank(YooAssetReference bankAsset)
	{
		if (bankAsset == null)
		{
			return;
		}
		string gUID = bankAsset.GUID;
		if (!_loadedBanks.TryGetValue(gUID, out var value))
		{
			return;
		}
		value.ReferenceCount--;
		if (value.ReferenceCount <= 0)
		{
			value.State = BankState.PendingUnload;
			value.UnloadTimer = 30f;
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"[AudioBankManager] Bank marked for delayed unload: {gUID}, will unload in {30f}s");
			}
		}
	}

	public bool IsBankLoaded(string bankGuid)
	{
		return AudioCore.IsBankLoaded(bankGuid);
	}

	public bool AreBanksLoaded(List<YooAssetReference> banks)
	{
		if (banks == null || banks.Count == 0)
		{
			return true;
		}
		foreach (YooAssetReference bank in banks)
		{
			if (!IsBankLoaded(bank.GUID))
			{
				return false;
			}
		}
		return true;
	}

	public bool IsBankLoadedByGuid(string bankGuid)
	{
		if (string.IsNullOrEmpty(bankGuid))
		{
			return false;
		}
		return IsBankLoaded(bankGuid);
	}

	public void LoadBankByGuid(string bankGuid)
	{
		LoadBankInternal(bankGuid, waitForComplete: true, null);
	}

	public void LoadBankByGuidAsync(string bankGuid, Action<bool> onComplete = null)
	{
		LoadBankInternal(bankGuid, waitForComplete: false, onComplete);
	}

	private void LoadBankInternal(string bankGuid, bool waitForComplete, Action<bool> onComplete)
	{
		BankReference value;
		if (string.IsNullOrEmpty(bankGuid))
		{
			onComplete?.Invoke(obj: false);
		}
		else if (_loadedBanks.TryGetValue(bankGuid, out value))
		{
			value.ReferenceCount++;
			if (value.PendingHandle != null)
			{
				if (value.State == BankState.PendingUnload)
				{
					value.State = BankState.Loading;
					value.UnloadTimer = 0f;
				}
				AddLoadCallback(value, onComplete);
				if (waitForComplete)
				{
					WaitPendingLoad(bankGuid, value);
				}
				return;
			}
			if (value.State == BankState.PendingUnload)
			{
				value.State = BankState.Loaded;
				value.UnloadTimer = 0f;
				if (LuminApplication.LogEnabled)
				{
					Debug.Log("[AudioBankManager] Cancelled unload for bank: " + bankGuid);
				}
			}
			onComplete?.Invoke(obj: true);
		}
		else
		{
			value = new BankReference
			{
				Guid = bankGuid,
				ReferenceCount = 1,
				State = BankState.Loading,
				UnloadTimer = 0f,
				AssetReference = null,
				Handle = default,
				PendingHandle = null,
				LoadCompleteCallbacks = null
			};
			AddLoadCallback(value, onComplete);
			_loadedBanks[bankGuid] = value;
			StartLoadRawFile(bankGuid, value);
			if (waitForComplete)
			{
				WaitPendingLoad(bankGuid, value);
			}
		}
	}

	private void StartLoadRawFile(string bankGuid, BankReference bankRef)
	{
		try
		{
			ResourcePackage resourcePackage = YooAssets.TryGetPackage("RawFile");
			if (resourcePackage == null)
			{
				Debug.LogError("[AudioBankManager] LoadBankByGuid failed: YooAsset package not found");
				FinishLoadFailed(bankGuid, bankRef);
			}
			else
			{
				bankRef.PendingHandle = resourcePackage.LoadRawFileAsync(bankGuid);
			}
		}
		catch (Exception ex)
		{
			Debug.LogError("[AudioBankManager] LoadBankByGuid error '" + bankGuid + "': " + ex.Message);
			FinishLoadFailed(bankGuid, bankRef);
		}
	}

	private void WaitPendingLoad(string bankGuid, BankReference bankRef)
	{
		RawFileHandle pendingHandle = bankRef.PendingHandle;
		if (pendingHandle != null)
		{
			pendingHandle.WaitForAsyncComplete();
			TryFinishLoad(bankGuid, bankRef);
		}
	}

	private void FinalizeLoadingBanks()
	{
		_banksToFinalize.Clear();
		foreach (KeyValuePair<string, BankReference> loadedBank in _loadedBanks)
		{
			BankReference value = loadedBank.Value;
			if (value.PendingHandle != null && value.PendingHandle.IsDone)
			{
				_banksToFinalize.Add(loadedBank.Key);
			}
		}
		for (int i = 0; i < _banksToFinalize.Count; i++)
		{
			string text = _banksToFinalize[i];
			if (_loadedBanks.TryGetValue(text, out var value2))
			{
				TryFinishLoad(text, value2);
			}
		}
	}

	private void TryFinishLoad(string bankGuid, BankReference bankRef)
	{
		RawFileHandle pendingHandle = bankRef.PendingHandle;
		if (pendingHandle == null || !pendingHandle.IsDone)
		{
			return;
		}
		bankRef.PendingHandle = null;
		if (!_loadedBanks.TryGetValue(bankGuid, out var value) || value != bankRef)
		{
			pendingHandle.Release();
			return;
		}
		bool flag = false;
		try
		{
			if (pendingHandle.Status == EOperationStatus.Succeed)
			{
				string text = ResolveBankFilePath(pendingHandle.GetRawFilePath());
				if (!string.IsNullOrEmpty(text))
				{
					AudioCore.LoadBankFromFile(text, bankGuid);
					flag = AudioCore.IsBankLoaded(bankGuid);
					if (LuminApplication.LogEnabled)
					{
						Debug.Log("[AudioBankManager] Loaded bank from file: " + bankGuid + ", path=" + text);
					}
				}
				else if (LuminApplication.LogEnabled)
				{
					Debug.LogWarning("[AudioBankManager] LoadBankByGuid failed: file path is empty for " + bankGuid);
				}
			}
			else
			{
				Debug.LogError("[AudioBankManager] LoadBankByGuid failed '" + bankGuid + "': " + pendingHandle.LastError);
			}
		}
		catch (Exception ex)
		{
			Debug.LogError("[AudioBankManager] LoadBankByGuid error '" + bankGuid + "': " + ex.Message);
		}
		finally
		{
			pendingHandle.Release();
		}
		if (!flag)
		{
			_loadedBanks.Remove(bankGuid);
		}
		else if (bankRef.ReferenceCount > 0)
		{
			bankRef.State = BankState.Loaded;
		}
		else
		{
			bankRef.State = BankState.PendingUnload;
			bankRef.UnloadTimer = 30f;
		}
		NotifyLoadComplete(bankRef, flag);
	}

	private void FinishLoadFailed(string bankGuid, BankReference bankRef)
	{
		if (_loadedBanks.TryGetValue(bankGuid, out var value) && value == bankRef)
		{
			bankRef.PendingHandle?.Release();
			bankRef.PendingHandle = null;
			_loadedBanks.Remove(bankGuid);
			NotifyLoadComplete(bankRef, success: false);
		}
	}

	private static string ResolveBankFilePath(string filePath)
	{
		if (!string.IsNullOrEmpty(filePath) && filePath.EndsWith(".bytes", StringComparison.OrdinalIgnoreCase))
		{
			return Path.ChangeExtension(filePath, ".bank");
		}
		return filePath;
	}

	private static void AddLoadCallback(BankReference bankRef, Action<bool> onComplete)
	{
		if (onComplete != null)
		{
			if (bankRef.LoadCompleteCallbacks == null)
			{
				List<Action<bool>> list = (bankRef.LoadCompleteCallbacks = new List<Action<bool>>());
			}
			bankRef.LoadCompleteCallbacks.Add(onComplete);
		}
	}

	private static void NotifyLoadComplete(BankReference bankRef, bool success)
	{
		List<Action<bool>> loadCompleteCallbacks = bankRef.LoadCompleteCallbacks;
		bankRef.LoadCompleteCallbacks = null;
		if (loadCompleteCallbacks != null)
		{
			for (int i = 0; i < loadCompleteCallbacks.Count; i++)
			{
				loadCompleteCallbacks[i]?.Invoke(success);
			}
		}
	}

	public void UnloadBankByGuid(string bankGuid)
	{
		if (string.IsNullOrEmpty(bankGuid) || !_loadedBanks.TryGetValue(bankGuid, out var value))
		{
			return;
		}
		value.ReferenceCount--;
		if (value.ReferenceCount <= 0)
		{
			value.State = BankState.PendingUnload;
			value.UnloadTimer = 30f;
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"[AudioBankManager] Bank marked for delayed unload: {bankGuid}, will unload in {30f}s");
			}
		}
	}

	private void UnloadBankImmediate(string guid)
	{
		if (!_loadedBanks.TryGetValue(guid, out var value))
		{
			return;
		}
		if (value.ReferenceCount > 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("[AudioBankManager] Bank " + guid + " was reused, cancelling unload");
			}
			return;
		}
		if (value.PendingHandle != null)
		{
			value.PendingHandle.Release();
			value.PendingHandle = null;
			_loadedBanks.Remove(guid);
			NotifyLoadComplete(value, success: false);
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("[AudioBankManager] Cancelled loading bank: " + guid);
			}
			return;
		}
		AudioCore.UnloadBank(guid);
		if (value.Handle.IsValid)
		{
			AssetStationManager.Root.Release(value.Handle);
		}
		_loadedBanks.Remove(guid);
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("[AudioBankManager] Unloaded bank: " + guid);
		}
	}

	public void UnloadAll()
	{
		foreach (KeyValuePair<string, BankReference> loadedBank in _loadedBanks)
		{
			loadedBank.Value.PendingHandle?.Release();
			loadedBank.Value.PendingHandle = null;
			AudioCore.UnloadBank(loadedBank.Key);
			if (loadedBank.Value.Handle.IsValid)
			{
				AssetStationManager.Root.Release(loadedBank.Value.Handle);
			}
		}
		_loadedBanks.Clear();
	}
}
