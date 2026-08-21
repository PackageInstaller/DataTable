using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class PreloadBattleData
{
	private Dictionary<string, GameObject> cacheEffectViewList = new Dictionary<string, GameObject>();

	private Dictionary<string, GameObject> cacheHeroViewList = new Dictionary<string, GameObject>();

	private Dictionary<string, GameObject> cacheHeroSummonedViewList = new Dictionary<string, GameObject>();

	private Dictionary<string, GameObject> cacheMapItemViewList = new Dictionary<string, GameObject>();

	private Dictionary<string, GameObject> cacheMonsterViewList = new Dictionary<string, GameObject>();

	private Dictionary<int, GameObject> cacheParadoxViewList = new Dictionary<int, GameObject>();

	private Dictionary<string, GameObject> cacheWarningIndicator = new Dictionary<string, GameObject>();

	private Dictionary<string, GameObject> _cacheBattleEntity = new Dictionary<string, GameObject>();

	private Dictionary<string, GameObject> _cacheHeroTimeline = new Dictionary<string, GameObject>();

	public int CacheWarningIndicatorNumber;

	private List<int> effectIdList = new List<int>();

	private List<int> heroIdList = new List<int>();

	private List<int> mapItemIdList = new List<int>();

	private Dictionary<int, int> battlePropList = new Dictionary<int, int>();

	private Dictionary<int, int> _monsterIdDic = new Dictionary<int, int>();

	private Dictionary<int, int> _summonedIdDic = new Dictionary<int, int>();

	private List<int> npcList = new List<int>();

	private Dictionary<string, GameObject> npcViewList = new Dictionary<string, GameObject>();

	private Dictionary<int, int> paradoxIdDic = new Dictionary<int, int>();

	private List<string> battleEntityList = new List<string>();

	private List<string> heroTimelineList = new List<string>();

	private List<int> skinList = new List<int>();

	public List<int> HeroIdList => heroIdList;

	public List<int> SkinList => skinList;

	public List<int> HeroSkinList
	{
		get
		{
			List<int> list = new List<int>();
			list.AddRange(heroIdList);
			list.AddRange(skinList);
			return list;
		}
	}

	public Dictionary<int, int> BattlePropList => battlePropList;

	public Dictionary<int, int> MonsterIdDic => _monsterIdDic;

	public Dictionary<int, int> SummonedIdDic => _summonedIdDic;

	public List<int> EffectIdList => effectIdList;

	public Dictionary<int, int> ParadoxIdDic => paradoxIdDic;

	public List<int> MapItemIdList => mapItemIdList;

	public List<int> NpcList => npcList;

	public List<string> BattleEntityList => battleEntityList;

	public List<string> HeroTimelineList => heroTimelineList;

	public Dictionary<string, GameObject> CacheHeroData => cacheHeroViewList;

	public Dictionary<string, GameObject> CacheHeroSummonedViewList => cacheHeroSummonedViewList;

	public Dictionary<string, GameObject> CacheMonsterData => cacheMonsterViewList;

	public Dictionary<string, GameObject> CacheEffectData => cacheEffectViewList;

	public Dictionary<int, GameObject> CacheParadoxData => cacheParadoxViewList;

	public Dictionary<string, GameObject> CacheMapItemData => cacheMapItemViewList;

	public Dictionary<string, GameObject> NpcViewList => npcViewList;

	public Dictionary<string, GameObject> CacheWarningIndicator => cacheWarningIndicator;

	public Dictionary<string, GameObject> CacheBattleEntity => _cacheBattleEntity;

	public Dictionary<string, GameObject> CacheHeroTimeline => _cacheHeroTimeline;

	public bool ContainsHeroView(string heroId)
	{
		return cacheHeroViewList.ContainsKey(heroId);
	}

	public bool ContainsHeroSummonedView(string heroSummonedId)
	{
		return cacheHeroSummonedViewList.ContainsKey(heroSummonedId);
	}

	public void AddHeroView(string heroId, GameObject obj)
	{
		if (!ContainsHeroView(heroId))
		{
			cacheHeroViewList.Add(heroId, obj);
		}
	}

	public void AddHeroSummonedView(string heroSummonedId, GameObject obj)
	{
		if (!ContainsHeroSummonedView(heroSummonedId))
		{
			cacheHeroSummonedViewList.Add(heroSummonedId, obj);
		}
	}

	public bool ContainsMonsterView(string heroId)
	{
		return cacheMonsterViewList.ContainsKey(heroId);
	}

	public bool ContainsNpcView(string heroId)
	{
		return npcViewList.ContainsKey(heroId);
	}

	public void AddMonsterView(string heroId, GameObject obj)
	{
		if (!ContainsMonsterView(heroId))
		{
			cacheMonsterViewList.Add(heroId, obj);
		}
	}

	public bool ContainsEffectView(string effectId)
	{
		return cacheEffectViewList.ContainsKey(effectId);
	}

	public void AddEffectView(string effectId, GameObject obj)
	{
		if (!ContainsEffectView(effectId))
		{
			cacheEffectViewList.Add(effectId, obj);
		}
	}

	public void AddBattleEntityView(string path, GameObject obj)
	{
		if (!_cacheBattleEntity.ContainsKey(path))
		{
			_cacheBattleEntity.Add(path, obj);
		}
	}

	public void AddHeroTimelineView(string path, GameObject obj)
	{
		if (!_cacheHeroTimeline.ContainsKey(path))
		{
			_cacheHeroTimeline.Add(path, obj);
		}
	}

	public bool ContainsParadoxView(int paradoxId)
	{
		return cacheParadoxViewList.ContainsKey(paradoxId);
	}

	public void AddParadoxView(int paradoxId, GameObject obj)
	{
		if (!ContainsParadoxView(paradoxId))
		{
			cacheParadoxViewList.Add(paradoxId, obj);
		}
	}

	public bool ContainsMapItemView(string paradoxId)
	{
		return cacheMapItemViewList.ContainsKey(paradoxId);
	}

	public void AddMapItemView(string mapItemId, GameObject obj)
	{
		if (!ContainsMapItemView(mapItemId))
		{
			cacheMapItemViewList.Add(mapItemId, obj);
		}
	}

	public void AddWarningIndicator(string id, GameObject obj)
	{
		if (!cacheWarningIndicator.ContainsKey(id))
		{
			cacheWarningIndicator.Add(id, obj);
		}
	}

	public void AddNpcView(string id, GameObject obj)
	{
		if (!npcViewList.ContainsKey(id))
		{
			npcViewList.Add(id, obj);
		}
	}

	public void Close()
	{
		heroIdList.Clear();
		skinList.Clear();
		_monsterIdDic.Clear();
		_summonedIdDic.Clear();
		effectIdList.Clear();
		paradoxIdDic.Clear();
		mapItemIdList.Clear();
		npcList.Clear();
		cacheHeroViewList.Clear();
		cacheHeroSummonedViewList.Clear();
		cacheMonsterViewList.Clear();
		cacheEffectViewList.Clear();
		cacheParadoxViewList.Clear();
		cacheMapItemViewList.Clear();
		cacheWarningIndicator.Clear();
		heroIdList = null;
		skinList = null;
		_monsterIdDic = null;
		_summonedIdDic = null;
		effectIdList = null;
		paradoxIdDic = null;
		mapItemIdList = null;
		npcList = null;
		cacheHeroViewList = null;
		cacheHeroSummonedViewList = null;
		cacheMonsterViewList = null;
		cacheEffectViewList = null;
		cacheParadoxViewList = null;
		cacheMapItemViewList = null;
		cacheWarningIndicator = null;
	}

	public void AddHero(int heroId)
	{
		if (!heroIdList.Contains(heroId))
		{
			heroIdList.Add(heroId);
		}
	}

	public void AddSkin(int skinId)
	{
		if (!skinList.Contains(skinId))
		{
			skinList.Add(skinId);
		}
	}

	public void AddBattleProp(int battlePropId, int count)
	{
		if (battlePropList.TryGetValue(battlePropId, out var _))
		{
			battlePropList[battlePropId] += count;
		}
		else
		{
			battlePropList[battlePropId] = count;
		}
	}

	public void AddMonster(int monsterId, int number, bool add = false)
	{
		if (!_monsterIdDic.ContainsKey(monsterId))
		{
			_monsterIdDic.Add(monsterId, number);
		}
		else if (add)
		{
			_monsterIdDic[monsterId] += number;
		}
	}

	public void AddSummoned(int summonedId, int number)
	{
		if (!_summonedIdDic.ContainsKey(summonedId))
		{
			_summonedIdDic.Add(summonedId, number);
		}
	}

	public void AddMapItem(int mapItemId)
	{
		if (!mapItemIdList.Contains(mapItemId))
		{
			mapItemIdList.Add(mapItemId);
		}
	}

	public void AddEffect(int effectId)
	{
		if (!effectIdList.Contains(effectId))
		{
			effectIdList.Add(effectId);
		}
	}

	public void AddBattleEntityView(string battleEntityViewPath)
	{
		if (!battleEntityList.Contains(battleEntityViewPath))
		{
			battleEntityList.Add(battleEntityViewPath);
		}
	}

	public void AddHeroTimelineView(string timelineViewPath)
	{
		if (!heroTimelineList.Contains(timelineViewPath))
		{
			heroTimelineList.Add(timelineViewPath);
		}
	}

	public void AddNpc(int effectId)
	{
		if (!npcList.Contains(effectId))
		{
			npcList.Add(effectId);
		}
	}

	public void AddParadox(int paradoxId, int number, bool add = false)
	{
		if (!paradoxIdDic.ContainsKey(paradoxId))
		{
			paradoxIdDic.Add(paradoxId, number);
		}
		else if (add)
		{
			paradoxIdDic[paradoxId] += number;
		}
		else
		{
			paradoxIdDic[paradoxId] = Math.Max(paradoxIdDic[paradoxId], number);
		}
	}
}
