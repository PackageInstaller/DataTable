using ACT.Battle;
using ACT.UI.EquipSort;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class EquipSortPanelSubInputController : SubUIViewInputController<EquipSortPanel>
{
	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!value)
		{
			View?.OnConfirm();
			Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		EquipSortPanel view = View;
		if ((object)view != null && view.IsPanelOpen())
		{
			View.OnNavigate(value);
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void OnResetSortOptions(bool value)
	{
		if (!value)
		{
			View?.Confirm();
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OnConfirmSortOptions(bool value)
	{
		if (!value)
		{
			View?.ResetOptions();
			Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
		}
	}

	[GameInputBindingBool("UI/Back")]
	public void OnBack(bool value)
	{
		if (value)
		{
			return;
		}
		EquipmentSubView equipmentSubView = ((View != null) ? View.GetComponentInParent<EquipmentSubView>() : null);
		if (equipmentSubView != null && equipmentSubView.TryConsumeSubviewBack())
		{
			Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
			return;
		}
		if (View != null && View.gameObject.activeInHierarchy)
		{
			View.Close();
		}
		Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void OnOpenSetting(bool value)
	{
		if (!value)
		{
			View?.OpenSortSettingPanel();
			Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
		}
	}
}
