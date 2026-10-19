using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class PopUpEquipMakeShowViewInputController : BaseUIViewInputController<PopUpEquipMakeShowView>
{
	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		View?.layerChapter.UnFocus();
		View?.layerCoin.UnFocus();
		View?.layerMaterial.UnFocus();
		View?.layerFilter?.UnFocus();
		View?.layerEquip.UnFocus();
		View?.ResetContinuousNavigate();
	}

	private bool IsCostCoinOrMaterialFocus()
	{
		if (View != null)
		{
			return View.IsCostCoinOrMaterialFocus;
		}
		return false;
	}

	private bool IsNonEquipNavigateFocus()
	{
		if (View != null)
		{
			return View.IsNonEquipNavigateFocus;
		}
		return false;
	}

	private bool IsFilterNavigateFocus()
	{
		if (View != null)
		{
			return View.IsFilterFocus;
		}
		return false;
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnSubmit(bool value)
	{
		if (!value)
		{
			View?.OnConfirm();
		}
	}

	[GameInputBindingBool("UI/Back")]
	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View?.OnCancle();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void OnBuildEquip(bool value)
	{
		if (!value)
		{
			if (IsFilterNavigateFocus())
			{
				View?.filterPanel.confirmBtn.OnClick?.Invoke();
			}
			else if (!IsNonEquipNavigateFocus())
			{
				View?.OnGamePadBuildEquip();
			}
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		View?.OnNavigate(value);
	}

	[GameInputBindingVector2("UI/RightStickNavigate")]
	public void OnRightStickNavigate(Vector2 value)
	{
		if (!IsNonEquipNavigateFocus())
		{
			View?.OnGamePadScrollFeatureOverview(value);
		}
	}

	[GameInputBindingBool("UI/UISpecial5")]
	public void OnSelectMaterialList(bool value)
	{
		if (!value && !IsNonEquipNavigateFocus())
		{
			View?.OnGamePadSelectMaterialList();
		}
	}

	[GameInputBindingBool("UI/UISpecial3")]
	public void OnShowFeature(bool value)
	{
		if (!value && !IsNonEquipNavigateFocus())
		{
			View?.OnShowFeature();
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OnClickFilterButton(bool value)
	{
		if (!value)
		{
			if (IsFilterNavigateFocus())
			{
				View?.filterPanel.resetBtn.OnClick?.Invoke();
			}
			else if (!IsNonEquipNavigateFocus())
			{
				View?.OnGamePadOpenFilter();
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial6")]
	public void OnSelectCoin(bool value)
	{
		if (!value && !IsNonEquipNavigateFocus())
		{
			View?.OnGamePadSelectCoin();
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void OnSwitchPageLeft(bool value)
	{
		if (!value && !IsNonEquipNavigateFocus())
		{
			View?.OnGamePadSwitchPageUp();
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void OnSwitchPageRight(bool value)
	{
		if (!value && !IsNonEquipNavigateFocus())
		{
			View?.OnGamePadSwitchPageDown();
		}
	}

	[GameInputBindingBool("UI/SwitchPageLeft")]
	public void OnSwitchLevelPreview(bool value)
	{
		if (!value && !IsNonEquipNavigateFocus())
		{
			View?.OnGamePadSwitchLevelPreview();
		}
	}

	[GameInputBindingBool("UI/SwitchPageRight")]
	public void OnOpenRandomAttributePreview(bool value)
	{
		if (!value && !IsNonEquipNavigateFocus())
		{
			View?.OnGamePadOpenRandomAttributePreview();
		}
	}
}
