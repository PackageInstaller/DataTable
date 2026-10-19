using System.Collections.Generic;
using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

internal class GamepadModifierKeyChangeSupportBindingKeysNotice : MonoBehaviour
{
	[SerializeField]
	private GampadKeyPrompt _templatePrompt;

	private List<GampadKeyPrompt> _prompts;

	private void Start()
	{
		if (_templatePrompt == null)
		{
			return;
		}
		_prompts = new List<GampadKeyPrompt>();
		foreach (var (_, value) in InputActionKeyCodeChangeSupport.GamepadModifierModeSupports)
		{
			GampadKeyPrompt gampadKeyPrompt = Object.Instantiate(_templatePrompt, transform);
			gampadKeyPrompt.ResetKeyBinding(value);
			_prompts.Add(gampadKeyPrompt);
		}
		MonoECS.instance.onInputModeChange.AddListener(UpdateAllPrompts);
		UpdateAllPrompts();
	}

	private void OnDestroy()
	{
		MonoECS.instance.onInputModeChange.RemoveListener(UpdateAllPrompts);
	}

	private void UpdateAllPrompts(DeviceInputMode mode)
	{
		UpdateAllPrompts();
	}

	private void UpdateAllPrompts()
	{
		foreach (GampadKeyPrompt prompt in _prompts)
		{
			prompt.UpdateDeviceKeyIcon();
		}
	}
}
