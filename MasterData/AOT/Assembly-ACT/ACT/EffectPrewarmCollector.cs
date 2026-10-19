using System.Collections.Generic;
using ACT.Battle.Configs;
using UnityEngine;

namespace ACT;

public sealed class EffectPrewarmCollector
{
	private readonly Dictionary<string, EffectPrewarmRequest> _requests = new Dictionary<string, EffectPrewarmRequest>();

	public int Count => _requests.Count;

	public void Add(YooAssetReference sourceReference, ConfigSkinBattleMapping mapping = null, string sourceTag = null)
	{
		if (!(sourceReference == null) && sourceReference.RuntimeKeyIsValid())
		{
			YooAssetReference yooAssetReference = sourceReference;
			if (mapping?.effects != null && mapping.effects.TryGetValue(sourceReference, out var value) && value != null && value.RuntimeKeyIsValid())
			{
				yooAssetReference = value;
			}
			AddFinal(yooAssetReference.GUID, 1, EffectPrewarmPriority.Normal, waitUntilReady: false, sourceTag);
		}
	}

	public void AddFinal(string assetKey, int instanceCount, EffectPrewarmPriority priority, bool waitUntilReady = false, string sourceTag = null)
	{
		if (!string.IsNullOrEmpty(assetKey) && instanceCount > 0)
		{
			EffectPrewarmRequest value = new EffectPrewarmRequest(assetKey, instanceCount, priority, waitUntilReady, sourceTag);
			if (!_requests.TryGetValue(assetKey, out var value2))
			{
				_requests.Add(assetKey, value);
			}
			else
			{
				_requests[assetKey] = new EffectPrewarmRequest(assetKey, Mathf.Max(value2.InstanceCount, value.InstanceCount), ((int)value2.Priority >= (int)value.Priority) ? value2.Priority : value.Priority, value2.WaitUntilReady || value.WaitUntilReady, string.IsNullOrEmpty(value2.SourceTag) ? value.SourceTag : value2.SourceTag);
			}
		}
	}

	public IReadOnlyList<EffectPrewarmRequest> Build()
	{
		return new List<EffectPrewarmRequest>(_requests.Values);
	}
}
