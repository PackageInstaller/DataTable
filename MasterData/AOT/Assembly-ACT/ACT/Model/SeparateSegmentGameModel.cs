using System.Collections.Generic;
using ACT.Config;
using Bamboo.AssetField;
using UnityEngine;

namespace ACT.Model;

public class SeparateSegmentGameModel : Model<SeparateSegmentGameModel>
{
	private const string ConfigPath = "Configs/SeparateSegmentConfigs";

	private bool _isInit;

	private Dictionary<SeparateSegmentConfigs.Difficulty, List<SeparateSegmentConfig>> _difficultiesConfigs;

	private AssetLoadHandle _assetHandle;

	public bool IsInitialized => _isInit;

	protected override void Init()
	{
		if (_difficultiesConfigs == null)
		{
			_difficultiesConfigs = new Dictionary<SeparateSegmentConfigs.Difficulty, List<SeparateSegmentConfig>>();
		}
		if (AssetLoadHandleExtensions.IsValid(_assetHandle))
		{
			return;
		}
		_assetHandle = AssetStationManager.BattleStation.LoadAsync<SeparateSegmentConfigs>("Configs/SeparateSegmentConfigs");
		_assetHandle.Completed += (AssetLoadHandle handle) =>
		{
			SeparateSegmentConfigs.SeparateSegmentDifficulty[] difficultiesConfigs = handle.As<SeparateSegmentConfigs>().DifficultiesConfigs;
			for (int i = 0; i < difficultiesConfigs.Length; i++)
			{
				SeparateSegmentConfigs.SeparateSegmentDifficulty separateSegmentDifficulty = difficultiesConfigs[i];
				if (_difficultiesConfigs.TryGetValue(separateSegmentDifficulty.Difficulty, out var value))
				{
					value.Add(separateSegmentDifficulty.Config);
				}
				else
				{
					_difficultiesConfigs.Add(separateSegmentDifficulty.Difficulty, new List<SeparateSegmentConfig> { separateSegmentDifficulty.Config });
				}
			}
			_isInit = true;
		};
	}

	protected override void UnInit()
	{
	}

	protected override void OnDestroy()
	{
		if (_assetHandle.IsValid)
		{
			AssetStationManager.BattleStation.Release(_assetHandle);
		}
	}

	public SeparateSegmentConfig GetRandomConfigs(SeparateSegmentConfigs.Difficulty difficulty)
	{
		if (!_isInit)
		{
			return null;
		}
		if (_difficultiesConfigs.TryGetValue(difficulty, out var value))
		{
			return value[Random.Range(0, value.Count)];
		}
		return null;
	}
}
