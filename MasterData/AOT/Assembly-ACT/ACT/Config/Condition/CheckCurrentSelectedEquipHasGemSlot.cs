using ACT.Game;
using ACT.Game.Data;
using ACT.UI;
using Fundamental;

namespace ACT.Config.Condition;

public class CheckCurrentSelectedEquipHasGemSlot : GuideStepCondition
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
		return equip2.GemSlots.Count > 0;
	}
}
