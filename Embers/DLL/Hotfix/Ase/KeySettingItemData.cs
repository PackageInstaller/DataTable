using System.Collections.Generic;
using UnityEngine.InputSystem;

namespace Ase;

public class KeySettingItemData : GameSettingItemViewModel
{
	private bool selected;

	public bool Selected
	{
		get
		{
			return selected;
		}
		set
		{
			Set(ref selected, value, "Selected");
		}
	}

	public KeySettingItemData()
	{
	}

	public KeySettingItemData(OptionBase parent, bool inBattle)
	{
		base.parent = parent;
		base.InBattle = inBattle;
	}

	public Dictionary<string, KeyValuePair<InputAction, int>> GetInputSystemData()
	{
		if (parent is KeySettingViewModel keySettingViewModel)
		{
			return keySettingViewModel.InputSystemData;
		}
		return new Dictionary<string, KeyValuePair<InputAction, int>>();
	}

	public void UpdateTargetItemDisplay(InputBinding targetBinding)
	{
		parent?.ItemOnClick(new OptionArg(targetBinding, "UpdateDisplay"));
	}

	public void OnRebindingFinished()
	{
		if (parent is KeySettingViewModel keySettingViewModel)
		{
			keySettingViewModel.UpdateInputSystemData();
			keySettingViewModel.SaveInputSystemData();
		}
	}

	public void EnterInputMode()
	{
		Selected = true;
		parent?.ItemOnClick(new OptionArg(this, "EnterInputMode"));
	}

	public void ExitInputMode()
	{
		Selected = false;
		parent?.ItemOnClick(new OptionArg(this, "ExitInputMode"));
	}
}
