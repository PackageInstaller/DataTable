using ACT.Battle;
using ACT.Model;
using ACT.UI;
using Fundamental;
using Runtime.Model;
using UnityEngine;

namespace ACT.Config.Action;

public class SetDefaultSelectedEquipmentSubviewDiscSlot : GuideStepAction
{
	public override void Execute(GuideStepData data)
	{
		if (MonoECS.instance.InputMode != DeviceInputMode.Gamepad)
		{
			Debug.Log("当前操作设备不为手柄，跳过SetDefaultSelectedEquipmentSubviewDiscSlot");
			return;
		}
		if (!Singleton<NewUIManager>.instance.TryGetFirstUIController(UI_TYPE.UI_CHARACTER, out var ui) || ui.State != UIState.Opened)
		{
			Debug.LogWarning("SetDefaultSelectedEquipmentSubviewDiscSlot Execute failed: UI_CHARACTER controller not found.");
			Model<CharacterModel>.Interface.SelectFirstDiscSlotInEquipmentSubview = true;
			return;
		}
		CharacterView characterView = ui.GetUIView() as CharacterView;
		if (!characterView)
		{
			Debug.LogWarning("SetDefaultSelectedEquipmentSubviewDiscSlot Execute failed: UIView is not CharacterView, actual type: " + (ui.GetUIView()?.GetType().Name ?? "null") + ".");
			Model<CharacterModel>.Interface.SelectFirstDiscSlotInEquipmentSubview = true;
			return;
		}
		EquipmentSubView equipmentSubView = characterView.currentCharacterSubView as EquipmentSubView;
		if (!equipmentSubView)
		{
			Debug.LogWarning("SetDefaultSelectedEquipmentSubviewDiscSlot Execute failed: currentCharacterSubView is not EquipmentSubView, actual type: " + (characterView.currentCharacterSubView?.GetType().Name ?? "null") + ".");
			Model<CharacterModel>.Interface.SelectFirstDiscSlotInEquipmentSubview = true;
		}
		else if (!equipmentSubView.TrySelectFirstDiscSlotForGamepad())
		{
			Debug.LogWarning("SetDefaultSelectedEquipmentSubviewDiscSlot Execute failed: first disc slot is invalid.");
		}
		else
		{
			Model<CharacterModel>.Interface.SelectFirstDiscSlotInEquipmentSubview = false;
		}
	}
}
