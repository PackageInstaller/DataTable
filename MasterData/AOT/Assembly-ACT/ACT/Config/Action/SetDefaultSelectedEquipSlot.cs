using System.Linq;
using ACT.Model;
using ACT.UI;
using ACT.ViewControl;
using Fundamental;
using Runtime.Model;
using UnityEngine;

namespace ACT.Config.Action;

public class SetDefaultSelectedEquipSlot : GuideStepAction
{
	public override void Execute(GuideStepData data)
	{
		if (!Singleton<NewUIManager>.instance.TryGetFirstUIController(UI_TYPE.UI_CHARACTER, out var ui) || ui.State != UIState.Opened)
		{
			Debug.LogWarning("SetDefaultSelectedEquipSlot Execute failed: UI_CHARACTER controller not found.");
			Model<CharacterModel>.Interface.SelectFirstEquipSlotInOverview = true;
			return;
		}
		CharacterView characterView = ui.GetUIView() as CharacterView;
		if (!characterView)
		{
			Debug.LogWarning("SetDefaultSelectedEquipSlot Execute failed: UIView is not CharacterView, actual type: " + (ui.GetUIView()?.GetType().Name ?? "null") + ".");
			return;
		}
		CvOverview cvOverview = characterView.currentCharacterSubView as CvOverview;
		if (!cvOverview)
		{
			Debug.LogWarning("SetDefaultSelectedEquipSlot Execute failed: currentCharacterSubView is not CvOverview, actual type: " + (characterView.currentCharacterSubView?.GetType().Name ?? "null") + ".");
			return;
		}
		CvOverview.EquipSlotStyle equipSlotStyle = cvOverview.equipSlotStyles.FirstOrDefault();
		if (!equipSlotStyle.equipItemUIComponent)
		{
			Debug.LogWarning("SetDefaultSelectedEquipSlot Execute failed: equipItemUIComponent is null.");
			return;
		}
		cvOverview.subViewLayer.DefaultSelect = equipSlotStyle.equipItemUIComponent.GetComponent<ACT.ViewControl.SelectableEx>();
		cvOverview.subViewLayer?.Focus();
		Model<CharacterModel>.Interface.SelectFirstEquipSlotInOverview = false;
	}
}
