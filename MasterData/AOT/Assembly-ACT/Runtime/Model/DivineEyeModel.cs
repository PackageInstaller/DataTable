using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI;
using Fundamental;

namespace Runtime.Model;

public class DivineEyeModel : Model<DivineEyeModel>
{
	private Dictionary<int, List<MapExploreAwardData>> _exploreAreaAwardDataMap;

	private Dictionary<int, string> _redDotMap;

	public Dictionary<int, List<MapExploreAwardData>> exploreAreaAwardDataMap => _exploreAreaAwardDataMap;

	public Dictionary<int, string> redDotMap => _redDotMap;

	protected override void Init()
	{
		_exploreAreaAwardDataMap = DictionaryPool<int, List<MapExploreAwardData>>.Get();
		_redDotMap = DictionaryPool<int, string>.Get();
		InitExploreAreaRewardMapData();
		RegisterRedDot();
	}

	protected override void UnInit()
	{
		DictionaryPool<int, List<MapExploreAwardData>>.Release(_exploreAreaAwardDataMap);
		DictionaryPool<int, string>.Release(_redDotMap);
	}

	private void RegisterRedDot()
	{
		_redDotMap.Clear();
		foreach (ExploreType value in RuntimeConfigs.data.exploreTypes.Values)
		{
			string text = RedDotPathDefine.DivineExplore + $"|{value.id}";
			Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(text);
			_redDotMap[value.id] = text;
		}
	}

	public MapExploreAwardData FindExploreRewardData(int exploreType, int level)
	{
		if (_exploreAreaAwardDataMap.TryGetValue(exploreType, out var value))
		{
			foreach (MapExploreAwardData item in value)
			{
				if (item.level == level)
				{
					return item;
				}
			}
		}
		return null;
	}

	private void InitExploreAreaRewardMapData()
	{
		foreach (ExploreType value2 in RuntimeConfigs.data.exploreTypes.Values)
		{
			foreach (MapExploreAwardData value3 in RuntimeConfigs.data.mapExploreAwardDatas.Values)
			{
				if (value3.exploreType == value2.id)
				{
					if (!_exploreAreaAwardDataMap.TryGetValue(value2.id, out var _))
					{
						_exploreAreaAwardDataMap[value2.id] = new List<MapExploreAwardData>();
						_exploreAreaAwardDataMap[value2.id].Add(value3);
					}
					else
					{
						_exploreAreaAwardDataMap[value2.id].Add(value3);
					}
				}
			}
		}
	}
}
