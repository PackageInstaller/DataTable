using System;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using Sirenix.Utilities;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.UI;

public class GemHoleItems : BaseUIComponent
{
	public EquipGemSlot[] levelHoles;

	public Action<EquipGemSlot> OnSlotSelected { get; set; }

	public Action<EquipGemSlot> OnSlotClick { get; set; }

	private void Awake()
	{
		for (int i = 0; i < levelHoles.Length; i++)
		{
			levelHoles[i].Register(i);
			EquipGemSlot obj = levelHoles[i];
			obj.OnSlotSelected = (UnityAction<EquipGemSlot>)Delegate.Combine(obj.OnSlotSelected, (UnityAction<EquipGemSlot>)((EquipGemSlot x) =>
			{
				OnSlotSelected?.Invoke(x);
			}));
			EquipGemSlot obj2 = levelHoles[i];
			obj2.OnEmptyButtonClick = (UnityAction<EquipGemSlot>)Delegate.Combine(obj2.OnEmptyButtonClick, (UnityAction<EquipGemSlot>)((EquipGemSlot x) =>
			{
				OnSlotClick?.Invoke(x);
			}));
			EquipGemSlot obj3 = levelHoles[i];
			obj3.OnSlotClick = (UnityAction<EquipGemSlot>)Delegate.Combine(obj3.OnSlotClick, (UnityAction<EquipGemSlot>)((EquipGemSlot x) =>
			{
				OnSlotClick?.Invoke(x);
			}));
		}
	}

	private void OnDestroy()
	{
		EquipGemSlot[] array = levelHoles;
		foreach (EquipGemSlot obj in array)
		{
			obj.OnSlotSelected = null;
			obj.OnSlotClick = null;
			obj.OnEmptyButtonClick = null;
		}
	}

	public void Init(Equip equip, bool isTrialCharacter = false, int defaultSelect = -1)
	{
		if (equip == null)
		{
			ResetAllHoleToEmpty();
			return;
		}
		CharacterDependSnapshot snapshot = equip.Snapshot;
		EquipData data = CoreUtils.GetData(equip.Id, RuntimeConfigs.data.equipDatas);
		if (data == null)
		{
			ResetAllHoleToEmpty();
			return;
		}
		EquipStrengthenListData data2 = CoreUtils.GetData(data.strengthen, RuntimeConfigs.data.equipStrengthenListDatas);
		if (data2 == null)
		{
			ResetAllHoleToEmpty();
			return;
		}
		int[] equipHoleList = data2.equipHoleList0;
		int[] equipHoleList2 = data2.equipHoleList10;
		int[] equipHoleList3 = data2.equipHoleList20;
		ResetAllHoleToEmpty();
		equip.GemSlots.Sort((GemSlot x, GemSlot y) => x.SlotId - y.SlotId);
		for (int num = 0; num < levelHoles.Length; num++)
		{
			EquipGemSlot equipGemSlot = levelHoles[num];
			if (num >= equip.GemSlots.Count)
			{
				SetLevelHoleVisible(num, visible: false);
				equipGemSlot.ApplyStyle(0, Station);
				equipGemSlot.SetGem(null);
				continue;
			}
			GemSlot gemSlot = equip.GemSlots[num];
			if (gemSlot.SlotLevel == 0)
			{
				if (GetGemSlotLevel(equipHoleList, num) <= 0 && GetGemSlotLevel(equipHoleList2, num) <= 0 && GetGemSlotLevel(equipHoleList3, num) <= 0)
				{
					SetLevelHoleVisible(num, visible: false);
					continue;
				}
				SetLevelHoleVisible(num, visible: true);
				equipGemSlot.ApplyStyle(0, Station);
				continue;
			}
			SetLevelHoleVisible(num, visible: true);
			equipGemSlot.ApplyStyle(gemSlot.SlotLevel, Station);
			if (gemSlot.GemId == 0)
			{
				equipGemSlot.SetGem(null);
			}
			else
			{
				equipGemSlot.SetGem(CharacterDependHelper.GetGemBySnapshot(gemSlot.GemId, snapshot));
			}
		}
		if (defaultSelect >= 0 && defaultSelect < levelHoles.Length)
		{
			if (levelHoles[defaultSelect].IsOn)
			{
				levelHoles[defaultSelect].IsOn = false;
			}
			levelHoles[defaultSelect].IsOn = true;
		}
	}

	private void ResetAllHoleToEmpty()
	{
		for (int i = 0; i < levelHoles.Length; i++)
		{
			SetLevelHoleVisible(i, visible: false);
			levelHoles[i].ResetGemSlot();
		}
	}

	private void SetLevelHoleVisible(int index, bool visible)
	{
		if (levelHoles == null || index < 0 || index >= levelHoles.Length)
		{
			return;
		}
		EquipGemSlot equipGemSlot = levelHoles[index];
		if ((bool)equipGemSlot)
		{
			GameObject gameObject = equipGemSlot.gameObject;
			if (gameObject.activeSelf != visible)
			{
				gameObject.SetActive(visible);
			}
		}
	}

	private static int GetGemSlotLevel(int[] gemSlots, int index)
	{
		if (gemSlots == null || index < 0 || index >= gemSlots.Length)
		{
			return 0;
		}
		return gemSlots[index];
	}

	public void PlayAnimation()
	{
		EquipGemSlot[] array = levelHoles;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].PlayShowAnimation();
		}
	}

	public void ReplaceGemSlot(int slot, Gem newGem)
	{
		if (newGem == null)
		{
			levelHoles[slot].SetGem(null);
		}
		else
		{
			levelHoles[slot].SetGem(newGem);
		}
	}

	public void ReplaceGemSlot(int slot, int newGemUid)
	{
		ReplaceGemSlot(slot, G.localPlayer.Inventory.GetGem(newGemUid));
	}
}
