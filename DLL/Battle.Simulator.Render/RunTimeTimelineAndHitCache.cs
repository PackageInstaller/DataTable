using System;
using System.Collections.Generic;
using Config;
using FlowCanvas;
using Google.Protobuf;
using NodeCanvas.Framework;
using Packages.P08Base;
using UnityEngine;

public class RunTimeTimelineAndHitCache
{
	public static LRU cache = new LRU(0);

	public static Action<string, UnityEngine.Object[]> unloadTimeline = delegate(string s, UnityEngine.Object[] obj)
	{
		Asset.UnloadBundle(s, isDontDestroy: true);
	};

	public static Action<string, FlowScriptController[]> unloadBaseFlowScripts = delegate(string s, FlowScriptController[] objs)
	{
		Asset.Unload(s, isDontDestroy: true);
		UnityEngine.Object.Destroy(objs[0].gameObject);
	};

	private Dictionary<int, TimelineInfo> _datas = new Dictionary<int, TimelineInfo>(new IntComparer());

	private Dictionary<int, RoleRenderConfig> _managerInfos = new Dictionary<int, RoleRenderConfig>(new IntComparer());

	private Dictionary<int, CommonHit> _commonHitDict = new Dictionary<int, CommonHit>();

	private bool _InitCommonHitData;

	public static UnityEngine.Object[] LoadTimeline(string assetBundleName)
	{
		UnityEngine.Object[] array = cache.Get<UnityEngine.Object[]>(assetBundleName);
		if (array == null)
		{
			array = Asset.LoadAllFromBundle<UnityEngine.Object>(assetBundleName, isDontDestroy: true);
			cache.Put(assetBundleName, array, unloadTimeline);
		}
		return array;
	}

	public static FlowScriptController[] LoadBaseFlowScripts(string prefabPath)
	{
		FlowScriptController[] array = cache.Get<FlowScriptController[]>(prefabPath);
		if (array == null)
		{
			GameObject gameObject = Asset.InstantiateWithoutCache(prefabPath, dontDestroy: true);
			if (gameObject == null)
			{
				Debug.Log(prefabPath);
			}
			array = gameObject.GetComponents<FlowScriptController>();
			cache.Put(prefabPath, array, unloadBaseFlowScripts);
		}
		else
		{
			array[0].gameObject.GetComponent<Blackboard>().BinDeserialize();
		}
		return array;
	}

	public void Add(int id, TimelineInfo info)
	{
		if (!_datas.ContainsKey(id))
		{
			_datas[id] = info;
		}
	}

	public void Add(int id, RoleRenderConfig info)
	{
		if (!_managerInfos.ContainsKey(id) || _managerInfos[id] == null)
		{
			_managerInfos[id] = info;
		}
		else
		{
			_managerInfos[id].Merge(info);
		}
	}

	public TimelineInfo Get(int id)
	{
		TimelineInfo value = null;
		_datas.TryGetValue(id, out value);
		return value;
	}

	public RoleRenderConfig GetRole(int id)
	{
		RoleRenderConfig value = null;
		_managerInfos.TryGetValue(id, out value);
		return value;
	}

	public void Initialize()
	{
		InitCommonHitDict();
	}

	public void Shutdown()
	{
		_datas.Clear();
		_datas = null;
		_managerInfos.Clear();
		_managerInfos = null;
		cache.LimitSize();
	}

	public bool TryGetHitEffectPath(WeaponCategory pWeaponCategory, AttackActionCategory pAttackActionCategory, SkillDamageType pSkillDamageType, ArmourCategory pArmourCategory, out string pHitEffectPath)
	{
		if (_commonHitDict.Count <= 0)
		{
			InitCommonHitDict();
		}
		if (!TryGetCommonHitInfo(pWeaponCategory, pAttackActionCategory, pSkillDamageType, pArmourCategory, out var commonHit))
		{
			Debug.LogError($"=====>>>>> CommonHit数据中无法找到数据, 武器类型:{pWeaponCategory}, 动作类型:{pAttackActionCategory}, 伤害类型:{pSkillDamageType}, 护甲类型:{pArmourCategory}");
			pHitEffectPath = string.Empty;
			return false;
		}
		if (ConfigHelper.GetInstance().TryGetConfig<CommonEffect>(commonHit.EffectPathID, out var config))
		{
			pHitEffectPath = config.Path;
			return true;
		}
		pHitEffectPath = string.Empty;
		return false;
	}

	public bool TryGetHitAudio(WeaponCategory pWeaponCategory, AttackActionCategory pAttackActionCategory, SkillDamageType pSkillDamageType, ArmourCategory pArmourCategory, out string pCueName, out string pSheetName, out bool pAwbName)
	{
		if (_commonHitDict.Count <= 0)
		{
			InitCommonHitDict();
		}
		if (!TryGetCommonHitInfo(pWeaponCategory, pAttackActionCategory, pSkillDamageType, pArmourCategory, out var commonHit))
		{
			Debug.LogError($"=====>>>>> CommonHit数据中无法找到数据, 武器类型:{pWeaponCategory}, 动作类型:{pAttackActionCategory}, 伤害类型:{pSkillDamageType}, 护甲类型:{pArmourCategory}");
			pSheetName = string.Empty;
			pCueName = string.Empty;
			pAwbName = false;
			return false;
		}
		if (!ConfigHelper.GetInstance().TryGetConfig<CommonAudio>(commonHit.AudioID, out var config))
		{
			pSheetName = string.Empty;
			pCueName = string.Empty;
			pAwbName = false;
			return false;
		}
		pSheetName = config.CueSheet;
		pCueName = config.CueName;
		pAwbName = config.UseStream;
		return true;
	}

	private bool TryGetCommonHitInfo(WeaponCategory pWeaponCategory, AttackActionCategory pAttackActionCategory, SkillDamageType pSkillDamageType, ArmourCategory pArmourCategory, out CommonHit commonHit)
	{
		int key = (int)((int)pWeaponCategory * 1000000 + (int)pAttackActionCategory * 10000 + (int)pSkillDamageType * 100 + pArmourCategory);
		return _commonHitDict.TryGetValue(key, out commonHit);
	}

	private void InitCommonHitDict()
	{
		if (_InitCommonHitData)
		{
			return;
		}
		Dictionary<int, IMessage> allConfig = ConfigHelper.GetInstance().GetAllConfig(typeof(CommonHit));
		if (allConfig != null)
		{
			Dictionary<int, IMessage>.Enumerator enumerator = allConfig.GetEnumerator();
			while (enumerator.MoveNext())
			{
				CommonHit commonHit = (CommonHit)enumerator.Current.Value;
				if (commonHit != null)
				{
					if (!_commonHitDict.ContainsKey(commonHit.ID))
					{
						_commonHitDict.Add(commonHit.ID, commonHit);
						continue;
					}
					Debug.LogError($"=====>>>>> 重复添加, id为:{commonHit.ID}, 武器类型:{commonHit.WeaponCategory}, 动作类型:{commonHit.AttackActionCategory}, 技能伤害类型:{commonHit.SkillDamageType}, 护甲类型:{commonHit.ArmourCategory}");
				}
			}
		}
		else
		{
			Debug.LogError("找不到配置 ");
		}
		_InitCommonHitData = true;
	}
}
