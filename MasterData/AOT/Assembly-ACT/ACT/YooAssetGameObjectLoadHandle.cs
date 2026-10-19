using System;
using Bamboo.AssetField;
using Bamboo.Precache;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT;

public sealed class YooAssetGameObjectLoadHandle : IAssetLoadHandle<GameObject>
{
	private AssetLoadHandle _handle;

	public bool IsValid => AssetLoadHandleExtensions.IsValid(_handle);

	public bool IsDone => _handle.IsDone;

	public bool Succeeded => _handle.State == LoadState.Success;

	public Exception OperationException => new Exception();

	public GameObject Result
	{
		get
		{
			if (!IsValid)
			{
				return null;
			}
			return _handle.AsGameObject();
		}
	}

	private event Action<IAssetLoadHandle<GameObject>> _completed;

	public event Action<IAssetLoadHandle<GameObject>> Completed
	{
		add
		{
			if (IsDone)
			{
				value(this);
			}
			_completed += value;
		}
		remove
		{
			_completed -= value;
		}
	}

	public YooAssetGameObjectLoadHandle(AssetLoadHandle handle)
	{
		_handle = handle;
		_handle.Completed += OnCompleted;
	}

	private void OnCompleted(AssetLoadHandle op)
	{
		_completed?.Invoke(this);
	}

	public async UniTask EnsureCompletedAsync()
	{
		if (IsValid && !IsDone)
		{
			await _handle;
		}
	}

	public void CompleteSync()
	{
		_handle.WaitForCompletion();
	}

	public void Release()
	{
		if (IsValid)
		{
			AssetStationManager.Root.Release(_handle);
		}
		_handle = default;
		_completed = null;
	}
}
