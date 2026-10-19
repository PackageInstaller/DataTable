using System.Collections.Generic;
using Bamboo.AssetField;
using UnityEngine;

namespace Bamboo.ImageCenter;

public class ImageManager
{
	private static ImageManager _instance;

	private readonly Dictionary<int, ImageAssetStation> _stationMap = new Dictionary<int, ImageAssetStation>();

	private int _id = 100;

	private ImageConfigs _configs;

	private AssetLoader _assetAdapter;

	private ImageAssetStation _Root;

	public static ImageManager instance
	{
		get
		{
			if (_instance == null)
			{
				Debug.LogWarning("ImageManager not initialized");
				return null;
			}
			return _instance;
		}
	}

	public ImageAssetStation Root => _Root;

	public static void SpawnImageManager(IAssetAdapter assetAdapter)
	{
		if (_instance != null)
		{
			Debug.LogWarning("ImageManager already initialized");
		}
		else
		{
			_instance = new ImageManager(assetAdapter);
		}
	}

	public ImageManager(IAssetAdapter assetAdapter)
	{
		_assetAdapter = new AssetLoader(assetAdapter);
		_Root = new ImageAssetStation(_id, null, _assetAdapter);
		_configs = Root.Load<ImageConfigs>("ImageConfigs").As<ImageConfigs>();
		_stationMap.Add(_id, _Root);
	}

	public ImageAssetStation GetAssetStation()
	{
		foreach (KeyValuePair<int, ImageAssetStation> item in _stationMap)
		{
			if (item.Value.IsReleased)
			{
				item.Value.SetToUse();
				return item.Value;
			}
		}
		int num = ++_id;
		ImageAssetStation imageAssetStation = new ImageAssetStation(num, Root, _assetAdapter);
		_stationMap.Add(num, imageAssetStation);
		return imageAssetStation;
	}

	public void UnloadAssetStation(ImageAssetStation station)
	{
		station?.ReleaseStation();
	}

	public static void UnloadAllTemporaryAssetStations()
	{
		if (_instance == null)
		{
			return;
		}
		foreach (ImageAssetStation value in _instance._stationMap.Values)
		{
			if (value != _instance._Root)
			{
				value.ReleaseStation();
			}
		}
	}

	public bool TryGetKey(int configId, int id, out string key)
	{
		if (TryGetImageData(configId, id, out var _, out var imageData))
		{
			key = imageData.key;
			return true;
		}
		key = "";
		return false;
	}

	public bool TryGetImageData(int configId, int id, out ImageConfig config, out ImageData imageData)
	{
		if (_configs.TryGetConfigData(configId, out config))
		{
			foreach (ImageData imageData2 in config.imageDatas)
			{
				if (imageData2.id == id)
				{
					imageData = imageData2;
					return true;
				}
			}
		}
		imageData = null;
		return false;
	}
}
