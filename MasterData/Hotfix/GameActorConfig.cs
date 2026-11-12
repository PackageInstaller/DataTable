using System;
using System.Collections.Generic;
using Newtonsoft.Json;
using Nova.Hotfix;
using UnityEngine;

[Serializable]
public class GameActorConfig
{
	public int actorID;

	public int skin;

	public tmpActorBTalentList talentList;

	public ActorSkillSlotLevelInfos skillSlotLevelInfos;

	public int actorLv;

	public int breakCount;

	public int level = 1;

	[JsonIgnore]
	public int Level
	{
		get
		{
			if (actorID <= 0)
			{
				Debug.LogError("请填写角色ID");
				return 1;
			}
			if (!Singleton<GameDataController>.Instance.loaded)
			{
				Singleton<GameDataController>.Instance.Load("zh_CN");
			}
			Dictionary<string, Nova.Hotfix.Attribute> attributeData = Singleton<HotfixDataController>.Instance.AttributeData;
			List<int> list = new List<int>();
			foreach (Nova.Hotfix.Attribute value in attributeData.Values)
			{
				if (value.GroupId == actorID && breakCount == value.Break)
				{
					list.Add(value.Lvl);
				}
			}
			int num = int.MaxValue;
			int num2 = int.MinValue;
			for (int i = 0; i < list.Count; i++)
			{
				int b = list.get_Item(i);
				num = Mathf.Min(num, b);
				num2 = Mathf.Max(num2, b);
			}
			num = Mathf.Min(1, num);
			return Mathf.Clamp(level, num, num2);
		}
	}

	public void LoadFrom(GameActorConfig other)
	{
		actorID = other.actorID;
		if (talentList == null)
		{
			talentList = new tmpActorBTalentList();
		}
		talentList.perkList.Clear();
		if (other.talentList != null)
		{
			talentList.LoadFrom(other.talentList);
		}
		if (skillSlotLevelInfos == null)
		{
			skillSlotLevelInfos = new ActorSkillSlotLevelInfos();
		}
		skillSlotLevelInfos.skillSlotLevelInfos.Clear();
		if (other.skillSlotLevelInfos != null)
		{
			skillSlotLevelInfos.LoadFrom(other.skillSlotLevelInfos);
		}
		actorLv = other.actorLv;
		breakCount = other.breakCount;
		level = other.level;
	}

	private void OnActorIDChanged()
	{
		OnBreakValueChanged();
	}

	private void OnLevelChanged()
	{
		OnBreakValueChanged();
	}

	public void OnBreakValueChanged()
	{
		if (actorID <= 0)
		{
			Debug.LogError("请填写角色ID");
			return;
		}
		if (!Singleton<GameDataController>.Instance.loaded)
		{
			Singleton<GameDataController>.Instance.Load("zh_CN");
		}
		Dictionary<string, Nova.Hotfix.Attribute> attributeData = Singleton<HotfixDataController>.Instance.AttributeData;
		List<int> list = new List<int>();
		List<int> list2 = new List<int>();
		foreach (Nova.Hotfix.Attribute value in attributeData.Values)
		{
			if (value.GroupId == actorID)
			{
				list.Add(value.Break);
				if (value.Break == breakCount)
				{
					list2.Add(value.Lvl);
				}
			}
		}
		if (list.Count == 0 || list2.Count == 0)
		{
			level = 1;
			Debug.Log($"{actorID} 找不到突破数据");
			return;
		}
		int num = int.MaxValue;
		int num2 = int.MinValue;
		for (int i = 0; i < list.Count; i++)
		{
			int b = list.get_Item(i);
			num = Mathf.Min(num, b);
			num2 = Mathf.Max(num2, b);
		}
		breakCount = Mathf.Clamp(breakCount, num, num2);
		Debug.Log($"{actorID} 突破次数范围:[{num},{num2}]");
		num = int.MaxValue;
		num2 = int.MinValue;
		for (int j = 0; j < list2.Count; j++)
		{
			int b2 = list2.get_Item(j);
			num = Mathf.Min(num, b2);
			num2 = Mathf.Max(num2, b2);
		}
		level = Mathf.Clamp(level, num, num2);
		Debug.Log($"{actorID} 突破次数为 {breakCount} 时,等级范围:[{num},{num2}]");
	}

	public void ResetBTalent(tmpActorBTalentList talent)
	{
		talentList = talent;
		ResetBTalent();
	}

	public void ResetActorLevel(int stoneHeartLv)
	{
		actorLv = stoneHeartLv;
		ResetActorLevel();
	}

	public void ResetBTalent()
	{
		List<Lua2CSharpInfo_TPPerkInfo> list = new List<Lua2CSharpInfo_TPPerkInfo>();
		AddPerkInfoList(list, talentList.perkList);
		ModuleController<AdventureModuleController>.Instance.SetPersonalPerks(actorID, list.ToArray());
	}

	private void AddPerkInfoList(List<Lua2CSharpInfo_TPPerkInfo> tempPerkInfos, List<tempPerkInfo> perkList)
	{
		foreach (tempPerkInfo perk in perkList)
		{
			Lua2CSharpInfo_TPPerkInfo item = new Lua2CSharpInfo_TPPerkInfo
			{
				perkId = perk.perkId,
				nCount = perk.perkLv
			};
			tempPerkInfos.Add(item);
		}
	}

	public void ResetActorLevel()
	{
		ModuleController<AdventureModuleController>.Instance.SetActorLevelInfo(actorID, actorLv);
	}

	public void ResetActorTalentActiveInfo()
	{
	}

	public void ResetActorSkillSlotInfos(bool isInit)
	{
		if (skillSlotLevelInfos == null || skillSlotLevelInfos.skillSlotLevelInfos == null || skillSlotLevelInfos.skillSlotLevelInfos.Count == 0)
		{
			return;
		}
		int[] array = new int[3];
		foreach (ActorSkillSlotLevelInfo skillSlotLevelInfo in skillSlotLevelInfos.skillSlotLevelInfos)
		{
			if (skillSlotLevelInfo.key == ActionKey.Normal)
			{
				array[0] = skillSlotLevelInfo.level;
			}
			else if (skillSlotLevelInfo.key == ActionKey.B)
			{
				array[1] = skillSlotLevelInfo.level;
			}
			else if (skillSlotLevelInfo.key == ActionKey.D)
			{
				array[2] = skillSlotLevelInfo.level;
			}
		}
		ModuleController<AdventureModuleController>.Instance?.ResetActorSkillSlotLevel(actorID, array, isInit);
	}
}
