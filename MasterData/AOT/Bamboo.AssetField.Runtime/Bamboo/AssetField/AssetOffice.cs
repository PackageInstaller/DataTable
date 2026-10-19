using System;
using System.Collections.Generic;

namespace Bamboo.AssetField;

public sealed class AssetOffice
{
	private readonly AssetLoader _assetLoader;

	private readonly AssetStation _root;

	private readonly Dictionary<int, AssetStation> _stationMap = new Dictionary<int, AssetStation>();

	public AssetStation Root => _root;

	public AssetOffice(int rootID, IAssetAdapter assetAdapter)
	{
		_assetLoader = new AssetLoader(assetAdapter);
		_root = new AssetStation(rootID, null, _assetLoader);
		_stationMap.Add(rootID, _root);
	}

	public AssetStation NewStation(int id, int parentID)
	{
		_stationMap.TryGetValue(parentID, out var value);
		if (value == null)
		{
			throw new Exception($"parent is null. parentName: {parentID}");
		}
		return NewStation(id, value);
	}

	public AssetStation NewStation(int id, AssetStation parent)
	{
		AssetStation assetStation = new AssetStation(id, parent, _assetLoader);
		_stationMap.Add(id, assetStation);
		return assetStation;
	}

	public AssetStation GetStation(int id)
	{
		_stationMap.TryGetValue(id, out var value);
		return value;
	}
}
