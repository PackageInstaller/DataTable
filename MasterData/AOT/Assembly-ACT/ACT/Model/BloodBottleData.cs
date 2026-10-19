using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using Fundamental;
using UnityEngine;
using Utility;

namespace ACT.Model;

public class BloodBottleData : IBagItem
{
	public int id { get; private set; }

	public int uid { get; private set; }

	public int[] belongScene { get; private set; }

	public int curLevel { get; private set; }

	public int maxLevel { get; private set; }

	public int maxSoltCount { get; private set; }

	public int maxUseCount { get; private set; }

	public int alreadyUseCount { get; private set; }

	public bool isEquip { get; private set; }

	public bool isLock { get; private set; } = true;

	public List<BottleMaterialSlot> wineMaterialSlots { get; private set; }

	public List<int> materialIds { get; private set; }

	public int healSkillId { get; private set; }

	public int usedSkillId { get; private set; }

	public bool isLocalBottle { get; private set; }

	public BloodBottleData()
	{
	}

	public BloodBottleData(PotionData data)
		: this()
	{
		BindPotionData(data);
	}

	public void BindPotionData(PotionData data)
	{
		id = data.itemId;
		uid = data.id;
		belongScene = data.availableSceneTypes;
		curLevel = 1;
		maxLevel = data.levelLimit;
		isEquip = false;
		healSkillId = data.healSkillId;
		usedSkillId = data.useExtraSkillId;
		maxSoltCount = data.capacityLimit?.LastOrDefault() ?? 0;
		maxUseCount = data.usageLimit?.FirstOrDefault() ?? 0;
		alreadyUseCount = 0;
		isLock = true;
		SetSlotOriginalData(data);
	}

	public BloodBottleData(PotionData data, PotionItem ntfData)
	{
		id = data.itemId;
		uid = ntfData.Id;
		belongScene = data.availableSceneTypes;
		curLevel = ntfData.Level;
		maxLevel = data.levelLimit;
		foreach (PresetTeam presetTeam in G.localPlayer.teamInfo.PresetTeams)
		{
			if (presetTeam.EquipPotionId == uid)
			{
				isEquip = true;
				break;
			}
			isEquip = false;
		}
		isLock = false;
		healSkillId = data.healSkillId;
		usedSkillId = data.useExtraSkillId;
		maxSoltCount = data.capacityLimit?.LastOrDefault() ?? 0;
		alreadyUseCount = ntfData.UseCount;
		maxUseCount = ntfData.MaxUse;
	}

	public void RefreshBottleData(PotionItem ntfData)
	{
		SetCurLevel(ntfData.Level);
		SetRightCount(ntfData.MaxUse);
		SetWineMatListByCurLevel(ntfData.Additives);
	}

	private void SetSlotOriginalData(PotionData data)
	{
		wineMaterialSlots = new List<BottleMaterialSlot>();
		materialIds = new List<int>();
		for (int i = 0; i < data.capacityLimit.LastOrDefault(); i++)
		{
			materialIds.Add(-1);
			wineMaterialSlots.Add(new BottleMaterialSlot(data.capacitytype[i]));
		}
	}

	public void SetLockState(bool state)
	{
		isLock = state;
	}

	public void SetCurLevel(int _curLevel)
	{
		curLevel = _curLevel;
	}

	public void SetRightCount(int count)
	{
		maxUseCount = count;
	}

	public void SetAlreadyUseCount(int count)
	{
		alreadyUseCount = count;
	}

	public void SetEquipState(bool state)
	{
		isEquip = state;
	}

	public void SetLocalManaged(bool state)
	{
		isLocalBottle = state;
	}

	public void InitializeLocalData(int level, int useCountLimit, int alreadyUseCount, IList<int> sourceMatIds)
	{
		SetLockState(state: false);
		SetCurLevel(level);
		SetRightCount(useCountLimit);
		SetAlreadyUseCount(Mathf.Clamp(alreadyUseCount, 0, useCountLimit));
		SetLocalManaged(state: true);
		SetWineMatListByCurLevel(sourceMatIds);
	}

	public void SetWineMatList(List<int> newList)
	{
		if (newList.Count != wineMaterialSlots.Count)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("传进来的泡酒物id集合长度和槽位对不上");
			}
			return;
		}
		materialIds.Clear();
		materialIds.AddRange(newList);
		for (int i = 0; i < wineMaterialSlots.Count; i++)
		{
			BottleMaterialSlot bottleMaterialSlot = wineMaterialSlots[i];
			SlotState state = ((newList[i] == -1) ? SlotState.IsLock : ((newList[i] != 0) ? SlotState.Filled : SlotState.Empty));
			bottleMaterialSlot.ChangeSlotState(state);
			bottleMaterialSlot.FillMaterial(newList[i]);
		}
	}

	public void RefreshWineMatListByCurLevel()
	{
		SetWineMatListByCurLevel(materialIds);
	}

	private void SetWineMatListByCurLevel(IList<int> sourceMatIds)
	{
		int valueOrDefault = CoreUtils.GetData(uid, RuntimeConfigs.data.potionDatas).capacityLimit.GetValueOrDefault(curLevel - 1, 0);
		List<int> list = ListPool<int>.Get();
		for (int i = 0; i < wineMaterialSlots.Count; i++)
		{
			if (i >= valueOrDefault)
			{
				list.Add(-1);
				continue;
			}
			int num = ((i < sourceMatIds.Count) ? sourceMatIds[i] : 0);
			list.Add((num > 0) ? num : 0);
		}
		SetWineMatList(list);
		ListPool<int>.Release(list);
	}

	public void SetWineMatOnSolt(int matId, int soltIndex)
	{
		materialIds[soltIndex] = matId;
		BottleMaterialSlot bottleMaterialSlot = wineMaterialSlots[soltIndex];
		bottleMaterialSlot.ChangeSlotState((matId != 0) ? SlotState.Filled : SlotState.Empty);
		bottleMaterialSlot.FillMaterial(matId);
	}

	public void SyncWineMatFromNtfData(PotionData tableData, int[] additives)
	{
		SetSlotOriginalData(tableData);
		SetWineMatListByCurLevel(additives);
	}

	public void UnlockSlot(int soltIndex)
	{
		if (wineMaterialSlots[soltIndex].curState == SlotState.IsLock)
		{
			wineMaterialSlots[soltIndex].ChangeSlotState(SlotState.Empty);
			wineMaterialSlots[soltIndex].FillMaterial(0);
			materialIds[soltIndex] = 0;
		}
	}

	public int GetId()
	{
		return id;
	}

	public int GetCount()
	{
		return 1;
	}

	public int GetQuality()
	{
		return CoreUtils.GetData(id, RuntimeConfigs.data.itemDatas)?.quality ?? 0;
	}

	public int GetLocalizationName()
	{
		return CoreUtils.GetData(id, RuntimeConfigs.data.itemDatas)?.nameLocal ?? 0;
	}

	public int GetUid()
	{
		return uid;
	}
}
