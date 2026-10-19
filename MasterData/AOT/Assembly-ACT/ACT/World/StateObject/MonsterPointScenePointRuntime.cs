using System;
using System.Collections.Generic;
using Bamboo.AssetField;
using UnityEngine;

namespace ACT.World.StateObject;

internal sealed class MonsterPointScenePointRuntime
{
	private readonly List<AssetLoadHandle> _handles = new List<AssetLoadHandle>();

	private readonly string _ownerLabel;

	private bool _released;

	public MonsterPointScenePointRuntime(string ownerLabel)
	{
		_ownerLabel = ownerLabel;
	}

	public void Instantiate(YooAssetReference assetReference, Vector3 position, Quaternion rotation, Transform parent)
	{
		if (_released || assetReference == null || string.IsNullOrEmpty(assetReference.GUID))
		{
			return;
		}
		if (!assetReference.RuntimeKeyIsValid())
		{
			LogLoadFailed(assetReference.GUID, "资源引用无效");
			return;
		}
		try
		{
			AssetStationManager.BattleStation.InstantiateAsync(assetReference, position, rotation, parent, (AssetLoadHandle handle) =>
			{
				OnPrefabLoaded(handle, assetReference.GUID);
			});
		}
		catch (Exception ex)
		{
			LogLoadFailed(assetReference.GUID, ex.Message);
		}
	}

	public void Release()
	{
		if (!_released)
		{
			_released = true;
			for (int i = 0; i < _handles.Count; i++)
			{
				ReleaseInstance(_handles[i]);
			}
			_handles.Clear();
		}
	}

	private void OnPrefabLoaded(AssetLoadHandle handle, string assetGuid)
	{
		if (_released)
		{
			ReleaseInstance(handle);
		}
		else if (!AssetLoadHandleExtensions.IsValid(handle))
		{
			LogLoadFailed(assetGuid, "资源加载或实例化失败");
		}
		else if (handle.AsGameObject() == null)
		{
			LogLoadFailed(assetGuid, "资源不是可实例化的 GameObject");
			ReleaseInstance(handle);
		}
		else if (_released)
		{
			ReleaseInstance(handle);
		}
		else
		{
			_handles.Add(handle);
		}
	}

	private void LogLoadFailed(string assetGuid, string reason)
	{
		Debug.LogError(_ownerLabel + " 的 Boss/技能场景点预设加载失败。asset: " + (assetGuid ?? "<empty>") + "; reason: " + reason);
	}

	private static void ReleaseInstance(AssetLoadHandle handle)
	{
		if (AssetLoadHandleExtensions.IsValid(handle))
		{
			AssetStationManager.BattleStation.ReleaseInstance(handle);
		}
	}
}
