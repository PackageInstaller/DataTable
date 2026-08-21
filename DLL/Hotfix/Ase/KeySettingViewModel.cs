#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine.InputSystem;

namespace Ase;

public class KeySettingViewModel : OptionBase
{
	private InputActionAsset actions;

	private Dictionary<string, KeyValuePair<InputAction, int>> inputSystemData = new Dictionary<string, KeyValuePair<InputAction, int>>();

	private bool inputMode;

	private bool inBattle;

	private InteractionRequest saveInputSystemDataRst = new InteractionRequest();

	private InteractionRequest<InputBinding> updateDisplayRst = new InteractionRequest<InputBinding>();

	public Dictionary<string, KeyValuePair<InputAction, int>> InputSystemData => inputSystemData;

	public bool InBattle => inBattle;

	public bool InputMode
	{
		get
		{
			return inputMode;
		}
		set
		{
			Set(ref inputMode, value, "InputMode");
		}
	}

	public InteractionRequest SaveInputSystemDataRst => saveInputSystemDataRst;

	public InteractionRequest<InputBinding> UpdateDisplayRst => updateDisplayRst;

	public KeySettingViewModel()
	{
	}

	public KeySettingViewModel(OptionBase parent, bool inBattle)
	{
		base.parent = parent;
		this.inBattle = inBattle;
	}

	public void SetInputActionAsset(InputActionAsset asset)
	{
		actions = asset;
		UpdateInputSystemData();
	}

	public void UpdateInputSystemData()
	{
		inputSystemData.Clear();
		foreach (InputActionMap item in actions.actionMaps.ToList())
		{
			foreach (InputAction action in item.actions)
			{
				for (int i = 0; i < action.bindings.Count; i++)
				{
					InputBinding inputBinding = action.bindings[i];
					if (!inputBinding.isComposite)
					{
						string text = inputBinding.effectivePath.Replace(">/", "/").Replace('<', '/');
						if (inputSystemData.ContainsKey(text))
						{
							Log.Error("存在重复键位设置：" + text);
						}
						else
						{
							inputSystemData.Add(text, new KeyValuePair<InputAction, int>(action, i));
						}
					}
				}
			}
		}
	}

	public void SaveInputSystemData()
	{
		saveInputSystemDataRst.Raise();
	}

	public void EnterInputMode()
	{
		if (!InputMode)
		{
			InputMode = true;
		}
	}

	public void ExitInputMode()
	{
		InputMode = false;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (!(obj is OptionArg optionArg))
		{
			return;
		}
		if (optionArg.Obj is KeySettingItemData)
		{
			if (optionArg.OptionName.Equals("EnterInputMode"))
			{
				EnterInputMode();
			}
			else if (optionArg.OptionName.Equals("ExitInputMode"))
			{
				ExitInputMode();
			}
		}
		else if (optionArg.Obj is InputBinding context && optionArg.OptionName.Equals("UpdateDisplay"))
		{
			updateDisplayRst.Raise(context);
		}
	}
}
