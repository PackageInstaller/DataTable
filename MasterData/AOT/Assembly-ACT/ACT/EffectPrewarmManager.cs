using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle.Configs;
using Bamboo.Precache;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT;

public sealed class EffectPrewarmManager
{
	private readonly struct OwnerKey : IEquatable<OwnerKey>
	{
		private const byte StringKind = 0;

		private const byte WorldAssetKind = 1;

		private readonly byte _kind;

		private readonly string _stringValue;

		private readonly int _intValue;

		public bool IsValid
		{
			get
			{
				if (_kind != 1)
				{
					return !string.IsNullOrEmpty(_stringValue);
				}
				return true;
			}
		}

		private OwnerKey(byte kind, string stringValue, int intValue)
		{
			_kind = kind;
			_stringValue = stringValue;
			_intValue = intValue;
		}

		public static OwnerKey FromString(string ownerKey)
		{
			return new OwnerKey(0, ownerKey, 0);
		}

		public static OwnerKey FromWorldAsset(int stateWorldAssetUid)
		{
			return new OwnerKey(1, null, stateWorldAssetUid);
		}

		public bool Equals(OwnerKey other)
		{
			if (_kind == other._kind)
			{
				if (_kind != 1)
				{
					return string.Equals(_stringValue, other._stringValue, StringComparison.Ordinal);
				}
				return _intValue == other._intValue;
			}
			return false;
		}

		public override bool Equals(object obj)
		{
			if (obj is OwnerKey other)
			{
				return Equals(other);
			}
			return false;
		}

		public override int GetHashCode()
		{
			return (_kind * 397) ^ ((_kind == 1) ? _intValue : ((_stringValue != null) ? StringComparer.Ordinal.GetHashCode(_stringValue) : 0));
		}

		public override string ToString()
		{
			if (_kind != 1)
			{
				return _stringValue;
			}
			return $"StateWorldAsset:{_intValue}";
		}
	}

	private sealed class OwnerState
	{
		public readonly List<EffectPrewarmRequest> Requests = new List<EffectPrewarmRequest>();
	}

	public const int DefaultInstanceCount = 1;

	private static readonly EffectPrewarmManager _instance = new EffectPrewarmManager();

	private bool _enabled = true;

	private readonly Dictionary<OwnerKey, OwnerState> _owners = new Dictionary<OwnerKey, OwnerState>();

	private readonly Dictionary<string, int> _activeAssetOwnerCount = new Dictionary<string, int>();

	private readonly Dictionary<string, int> _activeAssetTargetCount = new Dictionary<string, int>();

	public static EffectPrewarmManager Instance => _instance;

	public static bool Enabled
	{
		get
		{
			return Instance._enabled;
		}
		set
		{
			Instance.SetEnabled(value);
		}
	}

	public bool IsEnabled => _enabled;

	public int MaxInstancesPerEffect { get; set; } = 1;

	public int MaxInstancesPerOwner { get; set; } = 64;

	public int MaxInstancesGlobal { get; set; } = 256;

	public float ReadyTimeoutSeconds { get; set; } = 3f;

	public int ActiveOwnerCount => _owners.Count;

	public int ActiveAssetCount => _activeAssetOwnerCount.Count;

	public int ActiveTargetCount
	{
		get
		{
			int num = 0;
			foreach (int value in _activeAssetTargetCount.Values)
			{
				num += value;
			}
			return num;
		}
	}

	public void SetEnabled(bool enabled)
	{
		if (_enabled != enabled)
		{
			_enabled = enabled;
			if (!enabled)
			{
				ReleaseAll();
			}
		}
	}

	public void Enable()
	{
		SetEnabled(enabled: true);
	}

	public void Disable()
	{
		SetEnabled(enabled: false);
	}

	public UniTask<bool> PrewarmCharacterAsync(string ownerKey, ConfigCharacter config, ConfigSkinBattleMapping mapping = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (!_enabled || config == null)
		{
			return UniTask.FromResult(value: false);
		}
		try
		{
			EffectPrewarmCollector effectPrewarmCollector = new EffectPrewarmCollector();
			config.CollectEffectPrewarm(effectPrewarmCollector, mapping);
			return AcquireAsync(ownerKey, effectPrewarmCollector.Build(), cancellationToken);
		}
		catch (Exception arg)
		{
			Debug.LogError($"[EffectPrewarm] Character plan build failed: owner={ownerKey}, exception={arg}");
			return UniTask.FromResult(value: false);
		}
	}

	public UniTask<bool> PrewarmEffectAsync(string ownerKey, YooAssetReference effectReference, int instanceCount = 1, bool waitUntilReady = true, EffectPrewarmPriority priority = EffectPrewarmPriority.Critical, string sourceTag = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (!_enabled)
		{
			return UniTask.FromResult(value: false);
		}
		EffectPrewarmCollector effectPrewarmCollector = new EffectPrewarmCollector();
		effectPrewarmCollector.AddFinal(effectReference?.GUID, instanceCount, priority, waitUntilReady, sourceTag);
		return AcquireAsync(ownerKey, effectPrewarmCollector.Build(), cancellationToken);
	}

	public UniTask<bool> AcquireAsync(string ownerKey, IReadOnlyList<EffectPrewarmRequest> requests, CancellationToken cancellationToken = default(CancellationToken))
	{
		return AcquireAsync(OwnerKey.FromString(ownerKey), requests, cancellationToken);
	}

	public UniTask<bool> AcquireAsync(int stateWorldAssetUid, IReadOnlyList<EffectPrewarmRequest> requests, CancellationToken cancellationToken = default(CancellationToken))
	{
		return AcquireAsync(OwnerKey.FromWorldAsset(stateWorldAssetUid), requests, cancellationToken);
	}

	private async UniTask<bool> AcquireAsync(OwnerKey ownerKey, IReadOnlyList<EffectPrewarmRequest> requests, CancellationToken cancellationToken)
	{
		if (!_enabled || !ownerKey.IsValid || requests == null || requests.Count == 0)
		{
			return false;
		}
		if (_owners.ContainsKey(ownerKey))
		{
			return true;
		}
		Dictionary<string, EffectPrewarmRequest> dictionary = new Dictionary<string, EffectPrewarmRequest>();
		for (int i = 0; i < requests.Count; i++)
		{
			EffectPrewarmRequest value = requests[i];
			if (!string.IsNullOrEmpty(value.AssetKey) && value.InstanceCount > 0)
			{
				if (!dictionary.TryGetValue(value.AssetKey, out var value2))
				{
					dictionary.Add(value.AssetKey, value);
				}
				else
				{
					dictionary[value.AssetKey] = new EffectPrewarmRequest(value.AssetKey, Mathf.Max(value2.InstanceCount, value.InstanceCount), ((int)value2.Priority >= (int)value.Priority) ? value2.Priority : value.Priority, value2.WaitUntilReady || value.WaitUntilReady, string.IsNullOrEmpty(value2.SourceTag) ? value.SourceTag : value2.SourceTag);
				}
			}
		}
		List<EffectPrewarmRequest> candidates = new List<EffectPrewarmRequest>(dictionary.Values);
		candidates.Sort((EffectPrewarmRequest left, EffectPrewarmRequest right) =>
		{
			int num4 = right.Priority.CompareTo(left.Priority);
			return (num4 == 0) ? string.CompareOrdinal(left.AssetKey, right.AssetKey) : num4;
		});
		OwnerState ownerState = new OwnerState();
		int ownerInstanceCount = 0;
		bool committed = false;
		try
		{
			for (int i2 = 0; i2 < candidates.Count; i2++)
			{
				cancellationToken.ThrowIfCancellationRequested();
				if (!_enabled)
				{
					return false;
				}
				EffectPrewarmRequest request = candidates[i2];
				int num = Mathf.Clamp(request.InstanceCount, 1, Mathf.Max(1, MaxInstancesPerEffect));
				if (ownerInstanceCount + num > Mathf.Max(0, MaxInstancesPerOwner))
				{
					LogBudgetSkip(ownerKey, request, "owner");
					continue;
				}
				int num2 = (_activeAssetTargetCount.TryGetValue(request.AssetKey, out var value3) ? value3 : 0);
				int num3 = Mathf.Max(0, num - num2);
				if (ActiveTargetCount + num3 > Mathf.Max(0, MaxInstancesGlobal))
				{
					LogBudgetSkip(ownerKey, request, "global");
					continue;
				}
				int preInstantiateCount = Mathf.Max(num2, num);
				PrecacheHandle precacheHandle = PrecacheManager.Instance.Preload(request.AssetKey, preInstantiateCount);
				if (precacheHandle == null)
				{
					Debug.LogWarning($"[EffectPrewarm] Preload failed to create handle: owner={ownerKey}, key={request.AssetKey}");
					continue;
				}
				EffectPrewarmRequest item = new EffectPrewarmRequest(request.AssetKey, num, request.Priority, request.WaitUntilReady, request.SourceTag);
				ownerState.Requests.Add(item);
				ownerInstanceCount += num;
				if (num > num2)
				{
					_activeAssetTargetCount[request.AssetKey] = num;
				}
				if (_activeAssetOwnerCount.TryGetValue(request.AssetKey, out var value4))
				{
					_activeAssetOwnerCount[request.AssetKey] = value4 + 1;
				}
				else
				{
					_activeAssetOwnerCount.Add(request.AssetKey, 1);
				}
				if (request.WaitUntilReady)
				{
					await WaitUntilReadyAsync(precacheHandle, request, cancellationToken);
					if (!_enabled)
					{
						return false;
					}
				}
			}
			cancellationToken.ThrowIfCancellationRequested();
			if (ownerState.Requests.Count == 0 || !_enabled)
			{
				return false;
			}
			_owners.Add(ownerKey, ownerState);
			committed = true;
			return true;
		}
		catch (OperationCanceledException) when (cancellationToken.IsCancellationRequested)
		{
			throw;
		}
		catch (OperationCanceledException arg)
		{
			Debug.LogError($"[EffectPrewarm] Acquire canceled by provider: owner={ownerKey}, exception={arg}");
			return false;
		}
		catch (Exception arg2)
		{
			Debug.LogError($"[EffectPrewarm] Acquire failed: owner={ownerKey}, exception={arg2}");
			return false;
		}
		finally
		{
			if (!committed)
			{
				ReleaseState(ownerState);
				RebuildAssetTargets();
			}
		}
	}

	public void Release(string ownerKey)
	{
		Release(OwnerKey.FromString(ownerKey));
	}

	public void Release(int stateWorldAssetUid)
	{
		Release(OwnerKey.FromWorldAsset(stateWorldAssetUid));
	}

	private void Release(OwnerKey ownerKey)
	{
		if (ownerKey.IsValid && _owners.TryGetValue(ownerKey, out var value))
		{
			_owners.Remove(ownerKey);
			ReleaseState(value);
			RebuildAssetTargets();
		}
	}

	public void ReleaseAll()
	{
		if (_owners.Count == 0)
		{
			_activeAssetOwnerCount.Clear();
			_activeAssetTargetCount.Clear();
			return;
		}
		List<OwnerKey> list = new List<OwnerKey>(_owners.Keys);
		for (int i = 0; i < list.Count; i++)
		{
			Release(list[i]);
		}
		_activeAssetOwnerCount.Clear();
		_activeAssetTargetCount.Clear();
	}

	private async UniTask WaitUntilReadyAsync(PrecacheHandle handle, EffectPrewarmRequest request, CancellationToken cancellationToken)
	{
		if (handle != null && !handle.IsDone)
		{
			float deadline = Time.realtimeSinceStartup + Mathf.Max(0.1f, ReadyTimeoutSeconds);
			while (handle.IsValid && !handle.IsDone && Time.realtimeSinceStartup < deadline)
			{
				cancellationToken.ThrowIfCancellationRequested();
				await UniTask.Yield();
			}
			if (handle.IsValid && !handle.IsDone)
			{
				Debug.LogWarning("[EffectPrewarm] Ready timeout: key=" + request.AssetKey + ", tag=" + request.SourceTag);
			}
		}
	}

	private void ReleaseState(OwnerState ownerState)
	{
		for (int num = ownerState.Requests.Count - 1; num >= 0; num--)
		{
			EffectPrewarmRequest effectPrewarmRequest = ownerState.Requests[num];
			PrecacheManager.Instance.ReleasePreload(effectPrewarmRequest.AssetKey);
			if (_activeAssetOwnerCount.TryGetValue(effectPrewarmRequest.AssetKey, out var value))
			{
				if (value <= 1)
				{
					_activeAssetOwnerCount.Remove(effectPrewarmRequest.AssetKey);
				}
				else
				{
					_activeAssetOwnerCount[effectPrewarmRequest.AssetKey] = value - 1;
				}
			}
		}
		ownerState.Requests.Clear();
	}

	private void RebuildAssetTargets()
	{
		_activeAssetTargetCount.Clear();
		foreach (OwnerState value2 in _owners.Values)
		{
			for (int i = 0; i < value2.Requests.Count; i++)
			{
				EffectPrewarmRequest effectPrewarmRequest = value2.Requests[i];
				int instanceCount = effectPrewarmRequest.InstanceCount;
				if (!_activeAssetTargetCount.TryGetValue(effectPrewarmRequest.AssetKey, out var value) || instanceCount > value)
				{
					_activeAssetTargetCount[effectPrewarmRequest.AssetKey] = instanceCount;
				}
			}
		}
	}

	private static void LogBudgetSkip(OwnerKey ownerKey, EffectPrewarmRequest request, string budgetName)
	{
	}
}
