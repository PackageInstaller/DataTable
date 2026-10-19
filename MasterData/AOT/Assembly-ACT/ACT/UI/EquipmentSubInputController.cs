using ACT.Battle;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class EquipmentSubInputController : SubUIViewInputController<EquipmentSubView>
{
	[GameInputBindingBool("UI/Back")]
	public void OnBack(bool value)
	{
		if (!value && !(View == null))
		{
			if (View.TryConsumeSubviewBack())
			{
				Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
				return;
			}
			View.CloseEquipmentSubview();
			Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
		}
	}

	private bool IsEquipSortOpen()
	{
		if (View != null)
		{
			return View.SubviewInputState == EquipmentSubviewInputState.EquipSortOpen;
		}
		return false;
	}

	private bool IsFilterNavigate()
	{
		if (View != null)
		{
			return View.SubviewInputState == EquipmentSubviewInputState.FilterNavigate;
		}
		return false;
	}

	private bool IsPopUpOpen()
	{
		if (View != null)
		{
			return View.SubviewInputState == EquipmentSubviewInputState.PopUpOpen;
		}
		return false;
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!value && !IsEquipSortOpen() && !IsPopUpOpen())
		{
			View?.OnConfirm();
			Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void OnUpgrade(bool value)
	{
		if (!value && !IsEquipSortOpen() && !IsFilterNavigate() && !IsPopUpOpen())
		{
			View?.OnUpgrade();
			Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
		}
	}

	[GameInputBindingVector2("UI/RightStickNavigate")]
	public void OnRightStickNavigate(Vector2 value)
	{
		if (!IsEquipSortOpen() && !IsFilterNavigate())
		{
			View?.OnRightStickNavigate(value);
		}
	}

	[GameInputBindingBool("UI/UISpecial5")]
	public void OnEquipSuitFilter(bool value)
	{
		if (!value && !IsEquipSortOpen() && !IsFilterNavigate() && !IsPopUpOpen())
		{
			View?.OnEquipSuitFilter();
			Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
		}
	}

	[GameInputBindingBool("UI/SwitchPageLeft")]
	public void OnChangeLockState(bool value)
	{
		if (!value && !IsEquipSortOpen() && !IsFilterNavigate() && !IsPopUpOpen())
		{
			View?.OnChangeLockState();
			Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
		}
	}

	[GameInputBindingBool("UI/UISpecial3")]
	public void ShowEquipFeature(bool value)
	{
		if (!value && !IsEquipSortOpen() && !IsFilterNavigate() && !IsPopUpOpen())
		{
			View?.ShowEquipFeature();
			Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
		}
	}

	[GameInputBindingBool("UI/UISpecial4")]
	public void TakeOnGem(bool value)
	{
		if (!value && !IsEquipSortOpen() && !IsFilterNavigate() && !IsPopUpOpen())
		{
			View?.TakeOnGem();
			Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OpenPopUp(bool value)
	{
		if (!value && !IsEquipSortOpen() && !IsFilterNavigate() && !IsPopUpOpen())
		{
			View?.OpenPopUp();
			Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
		}
	}

	[GameInputBindingBool("UI/View")]
	public void ShowAllFeature(bool value)
	{
		if (!value && IsPopUpOpen())
		{
			View?.ShowAllFeature();
			Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void OnPagePre(bool value)
	{
		if (!value && !IsEquipSortOpen() && !IsFilterNavigate())
		{
			View?.OnPagePre();
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void OnPageNext(bool value)
	{
		if (!value && !IsEquipSortOpen() && !IsFilterNavigate())
		{
			View?.OnPageNext();
			Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
		}
	}
}
