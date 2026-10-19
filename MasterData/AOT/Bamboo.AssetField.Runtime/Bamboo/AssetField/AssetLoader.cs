using System;
using System.Collections.Generic;
using Bamboo.Pool;
using UnityEngine;

namespace Bamboo.AssetField;

internal sealed class AssetLoader
{
	private static long NumberSign;

	private readonly IAssetAdapter _assetAdapter;

	private readonly RecyclePool<AssetCount> _assetCountPool;

	internal RecyclePool<HandleOption> _optionsPool;

	private readonly Dictionary<string, AssetCount> _assetMap = new Dictionary<string, AssetCount>();

	private readonly Dictionary<string, Action<AssetLoadHandle>> _callbackMap = new Dictionary<string, Action<AssetLoadHandle>>();

	internal AssetLoader(IAssetAdapter assetAdapter)
	{
		_assetAdapter = assetAdapter;
		_assetCountPool = RecyclePool<AssetCount>.Default;
		_optionsPool = RecyclePool<HandleOption>.Default;
	}

	internal bool Has(string assetID)
	{
		return _assetMap.ContainsKey(assetID);
	}

	internal bool AssetExists(string assetID)
	{
		return _assetAdapter.AssetExists(assetID);
	}

	internal bool TryGetAssetCount(string assetID, out AssetCount assetCount)
	{
		if (_assetMap.TryGetValue(assetID, out assetCount))
		{
			return true;
		}
		return false;
	}

	private AssetLoadHandle CreateHandle(string assetID, out HandleOption option)
	{
		option = _optionsPool.Get();
		option.NumberSign = NumberSign++;
		AssetLoadHandle result = new AssetLoadHandle(option);
		option.AssetID = assetID;
		option.State = LoadState.Loading;
		return result;
	}

	private bool TryRetainAssetCount(string assetID, out AssetCount assetCount)
	{
		if (!_assetMap.TryGetValue(assetID, out assetCount))
		{
			return false;
		}
		assetCount.Count++;
		return true;
	}

	private void AddAssetCount(string assetID, object asset, int count = 1)
	{
		AssetCount assetCount = _assetCountPool.Get();
		assetCount.Asset = asset;
		assetCount.Count = count;
		_assetMap[assetID] = assetCount;
	}

	private void SetWaitForCommit<T>(HandleOption option, string assetID) where T : UnityEngine.Object
	{
		option.SetWaitForCompletion(() =>
		{
			_assetAdapter.WaitForCommit<T>(assetID);
		});
	}

	internal AssetLoadHandle Load<T>(string assetID) where T : UnityEngine.Object
	{
		HandleOption option = null;
		bool flag = false;
		try
		{
			AssetLoadHandle result = CreateHandle(assetID, out option);
			if (TryRetainAssetCount(assetID, out var assetCount))
			{
				flag = true;
				if (assetCount.Asset == null)
				{
					_assetAdapter.WaitForCommit<T>(assetID);
				}
				if (assetCount.Asset != null)
				{
					option.Result = assetCount.Asset;
					option.State = LoadState.Success;
				}
				else
				{
					ReleaseAssetCount(assetID);
					flag = false;
					option.State = LoadState.Failed;
				}
			}
			else
			{
				T val = _assetAdapter.Load<T>(assetID);
				if (null != val)
				{
					if (!_assetMap.ContainsKey(assetID))
					{
						AddAssetCount(assetID, val);
					}
					option.Result = val;
					option.State = LoadState.Success;
				}
				else
				{
					option.State = LoadState.Failed;
				}
			}
			return result;
		}
		catch (Exception)
		{
			if (flag)
			{
				ReleaseAssetCount(assetID);
			}
			_optionsPool.Recycle(option);
			throw;
		}
	}

	internal AssetLoadHandle LoadAsync<T>(string assetID, Action<AssetLoadHandle> callback = null) where T : UnityEngine.Object
	{
		HandleOption option = null;
		try
		{
			AssetLoadHandle handle = CreateHandle(assetID, out option);
			if (TryRetainAssetCount(assetID, out var assetCount))
			{
				if (assetCount.Asset == null)
				{
					if (!_callbackMap.ContainsKey(assetID))
					{
						_callbackMap.Add(assetID, null);
					}
					SetWaitForCommit<T>(option, assetID);
					Dictionary<string, Action<AssetLoadHandle>> callbackMap = _callbackMap;
					string key = assetID;
					callbackMap[key] = (Action<AssetLoadHandle>)Delegate.Combine(callbackMap[key], (Action<AssetLoadHandle>)((AssetLoadHandle _) =>
					{
						option.Result = _.Result;
						if (option.State != LoadState.Release)
						{
							callback?.Invoke(handle);
						}
						option.State = ((_.Result == null) ? LoadState.Failed : LoadState.Success);
					}));
				}
				else
				{
					option.Result = assetCount.Asset;
					callback?.Invoke(handle);
					option.State = LoadState.Success;
				}
			}
			else
			{
				AddAssetCount(assetID, null);
				SetWaitForCommit<T>(option, assetID);
				_assetAdapter.LoadAsync(assetID, (T newAssetT) =>
				{
					if (_assetMap.TryGetValue(assetID, out var value))
					{
						value.Asset = newAssetT;
					}
					option.Result = newAssetT;
					if (_callbackMap.ContainsKey(assetID))
					{
						_callbackMap[assetID]?.Invoke(handle);
						_callbackMap.Remove(assetID);
					}
					if (option.State != LoadState.Release)
					{
						callback?.Invoke(handle);
					}
					option.State = ((newAssetT == null) ? LoadState.Failed : LoadState.Success);
				});
			}
			return handle;
		}
		catch (Exception)
		{
			_assetMap.Remove(assetID);
			_callbackMap.Remove(assetID);
			_optionsPool.Recycle(option);
			throw;
		}
	}

	internal void Unload(AssetLoadHandle handle, int count = 1)
	{
		ReleaseAssetCount(handle.AssetID, count);
		_optionsPool.Recycle(handle.HandleOption);
	}

	private void ReleaseAssetCount(string assetID, int count = 1)
	{
		if (_assetMap.TryGetValue(assetID, out var value))
		{
			value.Count -= count;
			if (value.Count <= 0)
			{
				_assetMap.Remove(assetID);
				_assetAdapter.Unload(assetID);
				_assetCountPool.Recycle(value);
				_callbackMap.Remove(assetID);
			}
		}
	}
}
