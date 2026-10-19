using System;
using System.Collections.Generic;
using Bamboo.AssetField;
using UnityEngine;

namespace ACT;

public class ACTLoadStation<T> where T : UnityEngine.Object
{
	private Action<T> _action;

	private string _latestAddress;

	private readonly Dictionary<string, AssetLoadHandle> _handles = new Dictionary<string, AssetLoadHandle>();

	public void LoadAsset(string address, Action<T> action)
	{
		_action = action;
		_latestAddress = address;
		if (_handles.TryGetValue(address, out var value))
		{
			if (value.IsValid)
			{
				_action?.Invoke(value.As<T>());
			}
			return;
		}
		_handles.Add(address, default);
		AssetStationManager.BattleStation.LoadAsync<T>(address, (AssetLoadHandle result) =>
		{
			_handles[address] = result;
			if (_latestAddress == address)
			{
				_action?.Invoke(result.As<T>());
			}
		});
	}

	public void Release()
	{
		foreach (KeyValuePair<string, AssetLoadHandle> handle in _handles)
		{
			if (AssetLoadHandleExtensions.IsValid(handle.Value))
			{
				AssetStationManager.BattleStation.Release(handle.Value);
			}
		}
		_handles.Clear();
		_action = null;
		_latestAddress = null;
	}
}
