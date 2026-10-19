using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle.Configs;
using Bamboo.AssetField;
using Bamboo.Precache;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT;

public sealed class PrecacheCoordinator
{
	private static readonly PrecacheCoordinator _instance = new PrecacheCoordinator();

	private readonly Dictionary<int, List<PrecacheRequest>> _owners = new Dictionary<int, List<PrecacheRequest>>();

	public static PrecacheCoordinator Instance => _instance;

	public bool IsLoaded(int ownerKey)
	{
		return _owners.ContainsKey(ownerKey);
	}

	public async UniTask ExecuteAsync(int ownerKey, IReadOnlyList<PrecacheRequest> requests, CancellationToken ct = default(CancellationToken))
	{
		if (requests == null || requests.Count == 0 || IsLoaded(ownerKey))
		{
			return;
		}
		List<PrecacheRequest> ownerRequests = new List<PrecacheRequest>(requests.Count);
		try
		{
			for (int i = 0; i < requests.Count; i++)
			{
				ct.ThrowIfCancellationRequested();
				PrecacheRequest request = requests[i];
				List<PrecacheRequest> list = ownerRequests;
				list.Add(await LoadRequestAsync(request, ct));
			}
			_owners[ownerKey] = ownerRequests;
		}
		catch
		{
			Rollback(ownerRequests);
			throw;
		}
	}

	public void Release(int ownerKey)
	{
		if (_owners.TryGetValue(ownerKey, out var value))
		{
			for (int num = value.Count - 1; num >= 0; num--)
			{
				ReleaseRequest(value[num]);
			}
			_owners.Remove(ownerKey);
		}
	}

	private async UniTask<PrecacheRequest> LoadRequestAsync(PrecacheRequest request, CancellationToken ct)
	{
		if (request.Kind == PrecacheKind.Preload)
		{
			PrecacheManager.Instance.Preload(request.AssetKey);
			return request;
		}
		AssetLoadHandle handle = await LoadBattleAssetAsync(request, ct);
		return new PrecacheRequest(request.AssetKey, request.Kind, handle);
	}

	private async UniTask<AssetLoadHandle> LoadBattleAssetAsync(PrecacheRequest request, CancellationToken ct)
	{
		AssetLoadHandle handle = request.Kind switch
		{
			PrecacheKind.Config => AssetStationManager.BattleStation.LoadAsync<ConfigCharacter>(request.AssetKey), 
			PrecacheKind.BattleMapping => AssetStationManager.BattleStation.LoadAsync<ConfigSkinBattleMapping>(request.AssetKey), 
			PrecacheKind.Model => AssetStationManager.BattleStation.LoadAsync<GameObject>(request.AssetKey), 
			_ => default, 
		};
		if (!handle.IsValid)
		{
			return handle;
		}
		try
		{
			await UniTask.WaitUntil(() => !handle.IsValid || handle.IsDone, PlayerLoopTiming.Update, ct);
			return handle;
		}
		catch (OperationCanceledException)
		{
			if (handle.IsValid)
			{
				AssetStationManager.BattleStation.Release(handle);
			}
			throw;
		}
	}

	private void Rollback(List<PrecacheRequest> requests)
	{
		for (int num = requests.Count - 1; num >= 0; num--)
		{
			ReleaseRequest(requests[num]);
		}
	}

	private void ReleaseRequest(PrecacheRequest request)
	{
		if (!string.IsNullOrEmpty(request.AssetKey))
		{
			if (request.Kind == PrecacheKind.Preload)
			{
				PrecacheManager.Instance.ReleasePreload(request.AssetKey);
			}
			else if (request.Handle.IsValid)
			{
				AssetStationManager.BattleStation.Release(request.Handle, showError: false);
			}
		}
	}
}
