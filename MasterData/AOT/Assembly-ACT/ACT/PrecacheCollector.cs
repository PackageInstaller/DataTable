using System.Collections.Generic;

namespace ACT;

public sealed class PrecacheCollector
{
	private readonly List<PrecacheRequest> _requests = new List<PrecacheRequest>();

	private readonly HashSet<string> _requestIdentities = new HashSet<string>();

	private EffectPrewarmCollector _effectPrewarm;

	public EffectPrewarmCollector EffectPrewarm => _effectPrewarm ?? (_effectPrewarm = new EffectPrewarmCollector());

	public void AddConfigCharacter(string configPath)
	{
		if (!string.IsNullOrEmpty(configPath))
		{
			AddRequest(new PrecacheRequest(configPath, PrecacheKind.Config));
		}
	}

	public void AddModel(string assetKey)
	{
		if (!string.IsNullOrEmpty(assetKey))
		{
			AddRequest(new PrecacheRequest(assetKey, PrecacheKind.Model));
		}
	}

	public void AddBattleMapping(string assetKey)
	{
		if (!string.IsNullOrEmpty(assetKey))
		{
			AddRequest(new PrecacheRequest(assetKey, PrecacheKind.BattleMapping));
		}
	}

	public void AddPreload(YooAssetReference assetRef)
	{
		if (!(assetRef == null) && !string.IsNullOrEmpty(assetRef.GUID))
		{
			AddPreload(assetRef.GUID);
		}
	}

	public void AddPreload(string assetKey)
	{
		if (!string.IsNullOrEmpty(assetKey))
		{
			AddRequest(new PrecacheRequest(assetKey, PrecacheKind.Preload));
		}
	}

	public IReadOnlyList<PrecacheRequest> Build()
	{
		return _requests;
	}

	private void AddRequest(PrecacheRequest request)
	{
		if (_requestIdentities.Add(request.GetIdentity()))
		{
			_requests.Add(request);
		}
	}
}
