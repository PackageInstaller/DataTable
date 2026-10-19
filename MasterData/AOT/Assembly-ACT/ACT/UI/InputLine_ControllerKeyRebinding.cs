using System;
using ACT.Battle;
using ACT.Sound;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT.UI;

public class InputLine_ControllerKeyRebinding : MonoBehaviour, ISubmitHandler, IEventSystemHandler
{
	[SerializeField]
	[FormerlySerializedAs("Label")]
	private TextMeshProUGUI _label;

	[SerializeField]
	[FormerlySerializedAs("BtnRebinding")]
	private Button _btnRebinding;

	[SerializeField]
	[FormerlySerializedAs("Text")]
	private TextMeshProUGUI _text;

	[SerializeField]
	[FormerlySerializedAs("InputPrompt")]
	private InputPromptByBindingPath _inputPrompt;

	[FormerlySerializedAs("_modifierKeyPrompt")]
	[SerializeField]
	private GampadKeyPrompt modifierGampadKeyPrompt;

	[HideInInspector]
	public string ActionPath;

	[HideInInspector]
	public int BindingIndex = -1;

	public bool Editable = true;

	public string ButtonBindingKey;

	public InputPromptByBindingPath InputPrompt => _inputPrompt;

	public TextMeshProUGUI Text => _text;

	public TextMeshProUGUI Label => _label;

	public Button BtnRebinding => _btnRebinding;

	private void Awake()
	{
		_btnRebinding.onClick.AddListener(OnButtonClick);
	}

	private void OnEnable()
	{
		InputPromptByBindingPath inputPrompt = InputPrompt;
		inputPrompt.onBindingPathChanged = (Action)Delegate.Remove(inputPrompt.onBindingPathChanged, new Action(UpdateBindingKeyMode));
		InputPromptByBindingPath inputPrompt2 = InputPrompt;
		inputPrompt2.onBindingPathChanged = (Action)Delegate.Combine(inputPrompt2.onBindingPathChanged, new Action(UpdateBindingKeyMode));
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		UpdateBindingKeyMode();
	}

	private void OnInputModeChanged(DeviceInputMode inputMode)
	{
		UpdateBindingKeyMode();
	}

	private void OnDisable()
	{
		InputPromptByBindingPath inputPrompt = InputPrompt;
		inputPrompt.onBindingPathChanged = (Action)Delegate.Remove(inputPrompt.onBindingPathChanged, new Action(UpdateBindingKeyMode));
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
	}

	private void UpdateBindingKeyMode()
	{
		bool flag = MonoECS.instance.TryGetInputActionKeyBindingInfo(MonoECS.PromptIconDeviceType.Gamepad, InputPrompt.InputActionPath, out var bindingInfo) && bindingInfo.GetMode() == MonoECS.CompositeMode.OneModifier;
		modifierGampadKeyPrompt.gameObject.SetActive(flag);
		if (flag)
		{
			modifierGampadKeyPrompt.UpdateDeviceKeyIcon();
		}
		else
		{
			modifierGampadKeyPrompt.gameObject.SetActive(value: false);
		}
	}

	public void OnSubmit(BaseEventData eventData)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Set/Key/Select", new AudioPlayOptions
		{
			attachTarget = Camera.main.transform
		});
	}

	private void OnButtonClick()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Set/Key/Select", new AudioPlayOptions
		{
			attachTarget = Camera.main.transform
		});
	}
}
