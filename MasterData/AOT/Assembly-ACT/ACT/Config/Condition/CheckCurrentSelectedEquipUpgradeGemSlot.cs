using System;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI;
using Fundamental;

namespace ACT.Config.Condition;

public class CheckCurrentSelectedEquipUpgradeGemSlot : GuideStepCondition
{
	public override bool CheckCondition()
	{
		CharacterView characterView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CHARACTER) as CharacterView;
		if (characterView == null || characterView.UIController.State != UIState.Opened || Singleton<NewUIManager>.instance.IsActivePanelBusy())
		{
			return false;
		}
		if (!(characterView.currentCharacterSubView is EquipmentSubView equipmentSubView))
		{
			return false;
		}
		Equip equip = equipmentSubView.SelectedEquip.As<Equip>();
		Equip equip2 = G.localPlayer.Inventory.GetEquip(equip.Uid);
		if (equip2 == null)
		{
			return false;
		}
		if (equip2.Level >= 20)
		{
			return false;
		}
		EquipData data = CoreUtils.GetData(equip2.Id, RuntimeConfigs.data.equipDatas);
		if (data == null)
		{
			return false;
		}
		EquipStrengthenListData data2 = CoreUtils.GetData(data.strengthen, RuntimeConfigs.data.equipStrengthenListDatas);
		if (data2 == null)
		{
			return false;
		}
		_ = data2.equipHoleList0;
		int[] equipHoleList = data2.equipHoleList10;
		int[] equipHoleList2 = data2.equipHoleList20;
		int level = equip2.Level;
		int[] array;
		if (level >= 10)
		{
			if (level >= 20)
			{
				throw new ArgumentOutOfRangeException();
			}
			array = equipHoleList2;
		}
		else
		{
			array = equipHoleList;
		}
		int[] array2 = array;
		if (array2.Length > equip2.GemSlots.Count)
		{
			return true;
		}
		for (int i = 0; i < equip.GemSlots.Count; i++)
		{
			GemSlot gemSlot = equip.GemSlots[i];
			if (array2[i] > gemSlot.SlotLevel)
			{
				return true;
			}
		}
		return false;
	}
}
