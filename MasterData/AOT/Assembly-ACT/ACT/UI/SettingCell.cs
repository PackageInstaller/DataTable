using System.Collections.Generic;
using ACT.LocalizationExtension;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT.UI;

public class SettingCell : MonoBehaviour, ISubmitHandler, IEventSystemHandler, IMoveHandler
{
	[SerializeField]
	private bool _disableInReleaseVersion;

	[Header("Data")]
	public LocalizedString titleText;

	public bool useDescription;

	public LocalizedString descriptionText;

	[Header("Resolver")]
	public List<SettingCellBindings> bindings = new List<SettingCellBindings>();

	[Header("Components")]
	public LocalizeStringEvent title;

	public GameObject disableMask;

	public Selectable selectable;

	public LimitedSlider slider;

	public TextMeshProUGUI num;

	[FormerlySerializedAs("icon")]
	public Image toggleIcon;

	[FormerlySerializedAs("toggle")]
	public PublicToggle muteToggle;

	public LocalizeTMP_Dropdown dropdown;

	public SettingSwitch settingSwitch;

	public ActButton jumpButton;

	public GameObject optionDescription;

	public LocalizeStringEvent optionDescriptionText;

	public ActButton optionDescriptionBtn;

	public ButtonSound sound;

	public AnimateToggle animateToggle;

	public LocalizeStringEvent buttonLabel;

	public TextMeshProUGUI buttonLabelText;

	private bool _muteToggleDefaultInteractable = true;

	[Header("Resources")]
	[FormerlySerializedAs("iconSprs")]
	public List<Sprite> iconSprites = new List<Sprite>();

	private bool showDescription;

	public bool DescriptionShown => showDescription;

	private void Start()
	{
		if (_disableInReleaseVersion)
		{
			gameObject?.SetActive(value: false);
		}
	}

	public void SetInteract(bool interactable)
	{
		disableMask.SetActive(!interactable);
		selectable.interactable = interactable;
	}

	public void Init()
	{
		num.SetText("{0:0}", slider.value);
		SetIcon(muteToggle.isOn);
	}

	public void SetButtonLabel(int content)
	{
		if (buttonLabel != null)
		{
			buttonLabel.StringReference.TableEntryReference = content;
		}
	}

	public void SetButtonLabel(string text)
	{
		if (buttonLabelText != null)
		{
			buttonLabelText.text = text;
		}
	}

	private void Awake()
	{
		if (muteToggle != null)
		{
			_muteToggleDefaultInteractable = muteToggle.interactable;
		}
		if (dropdown != null)
		{
			dropdown.onHide.AddListener(() =>
			{
				EventSystemHelper.SetSelectedGameObject(gameObject);
			});
			dropdown.onPostShow.AddListener(OnDropdownShow);
		}
		if (useDescription)
		{
			optionDescriptionText.StringReference = descriptionText;
			optionDescriptionText.RefreshString();
			optionDescriptionBtn.gameObject.SetActive(value: true);
		}
		else
		{
			optionDescriptionBtn.gameObject.SetActive(value: false);
		}
		title.StringReference = titleText;
		title.RefreshString();
		if (IsBindingEnabled(SettingCellType.Slider))
		{
			num.SetText("{0:0}", slider.value);
		}
		if (IsBindingEnabled(SettingCellType.Toggle))
		{
			SetIcon(muteToggle.isOn);
			muteToggle.onValueChanged.AddListener(SetIcon);
		}
		CreateBindings();
	}

	public void CreateBindings()
	{
		foreach (SettingCellBindings binding in bindings)
		{
			binding.SetActive(value: false);
		}
		foreach (SettingCellBindings binding2 in bindings)
		{
			if (binding2.enabled)
			{
				binding2.SetActive(value: true);
				if (!string.IsNullOrWhiteSpace(binding2.settingsKey))
				{
					CreateResolver(binding2)?.Init(binding2.settingsKey, binding2.DependsOnSettings);
				}
			}
		}
	}

	private void OnEnable()
	{
		optionDescriptionBtn.OnClick.AddListener(ToggleDescription);
	}

	private void OnDisable()
	{
		optionDescriptionBtn.OnClick.RemoveListener(ToggleDescription);
	}

	public void SetSliderValue()
	{
		num.SetText("{0:0}", slider.value);
		if (!IsBindingEnabled(SettingCellType.Toggle))
		{
			SetIcon(slider.value <= 0f);
		}
		else
		{
			SetIcon(muteToggle.isOn);
		}
	}

	public void SetIcon(bool isMute = false)
	{
		if (ShouldForceMuteIcon())
		{
			isMute = true;
		}
		toggleIcon.sprite = iconSprites[(!isMute) ? 1 : 0];
		RefreshMuteToggleInteractable();
	}

	public bool ShouldForceMuteIcon()
	{
		if (IsAudioMuteBindingEnabled() && IsBindingEnabled(SettingCellType.Slider) && IsBindingEnabled(SettingCellType.Toggle) && slider != null)
		{
			return slider.value <= 0f;
		}
		return false;
	}

	private bool IsAudioMuteBindingEnabled()
	{
		for (int i = 0; i < bindings.Count; i++)
		{
			SettingCellBindings settingCellBindings = bindings[i];
			if (settingCellBindings.enabled && settingCellBindings.type == SettingCellType.Toggle)
			{
				string settingsKey = settingCellBindings.settingsKey;
				switch (settingsKey)
				{
				default:
					return settingsKey == "Audio.Mute.Talk";
				case "Audio.Mute.Main":
				case "Audio.Mute.Music":
				case "Audio.Mute.Effect":
					return true;
				}
			}
		}
		return false;
	}

	private void RefreshMuteToggleInteractable()
	{
		if (!(muteToggle == null) && IsAudioMuteBindingEnabled())
		{
			muteToggle.interactable = _muteToggleDefaultInteractable && !ShouldForceMuteIcon();
		}
	}

	public void PlaySound()
	{
		sound.PlaySound(slider.value / slider.maxValue);
	}

	public void ToggleDescription()
	{
		showDescription = !showDescription;
		optionDescription.SetActive(showDescription);
		Canvas.ForceUpdateCanvases();
	}

	void ISubmitHandler.OnSubmit(BaseEventData eventData)
	{
		if (IsBindingEnabled(SettingCellType.Button))
		{
			jumpButton?.OnSubmit(eventData);
		}
		if (IsBindingEnabled(SettingCellType.Toggle))
		{
			muteToggle?.OnSubmit(eventData);
		}
		if (IsBindingEnabled(SettingCellType.Dropdown) && dropdown != null && dropdown.interactable)
		{
			dropdown?.OnSubmit(eventData);
		}
		if (IsBindingEnabled(SettingCellType.Switch))
		{
			settingSwitch?.OnSubmit(eventData);
		}
	}

	void IMoveHandler.OnMove(AxisEventData eventData)
	{
		if (IsBindingEnabled(SettingCellType.Slider) || IsBindingEnabled(SettingCellType.IntSlider))
		{
			slider.value += eventData.moveVector.x;
		}
	}

	private void OnDropdownShow()
	{
		Transform transform = dropdown.transform.Find("Dropdown List/Viewport/Content");
		if (transform == null)
		{
			return;
		}
		ViewControlLayer orAddComponent = transform.gameObject.GetOrAddComponent<ViewControlLayer>();
		LocalizeTMPDropdownHighPerformanceMarksManager component = dropdown.GetComponent<LocalizeTMPDropdownHighPerformanceMarksManager>();
		for (int i = 0; i < transform.childCount; i++)
		{
			Transform child = transform.GetChild(i);
			ACT.ViewControl.SelectableEx orAddComponent2 = child.gameObject.GetOrAddComponent<ACT.ViewControl.SelectableEx>();
			if (child.gameObject.activeInHierarchy)
			{
				PublicToggle component2 = child.GetComponent<PublicToggle>();
				if ((object)component2 != null && component2.isOn)
				{
					EventSystemHelper.SetSelectedGameObject(component2.gameObject);
					orAddComponent.DefaultSelect = orAddComponent2;
				}
				if ((bool)child.GetComponent<LocalizeTMPDropdownHighPerformanceMark>())
				{
					LocalizeTMPDropdownHighPerformanceMark component3 = child.GetComponent<LocalizeTMPDropdownHighPerformanceMark>();
					int dropdownOptionIndex = i - 1;
					component3.ResetOption(component, dropdownOptionIndex);
				}
			}
		}
	}

	private ISettingResolver CreateResolver(SettingCellBindings binding)
	{
		switch (binding.type)
		{
		case SettingCellType.Slider:
			return gameObject.AddComponent<SettingCellSliderResolver>();
		case SettingCellType.IntSlider:
			return gameObject.AddComponent<SettingCellIntSliderResolver>();
		case SettingCellType.Toggle:
			return gameObject.AddComponent<SettingCellToggleResolver>();
		case SettingCellType.Dropdown:
			if (binding.localizedDropdown)
			{
				return gameObject.AddComponent<LocalizeTMPDropdownResolver>();
			}
			if (!binding.localizedDropdown)
			{
				return gameObject.AddComponent<TMPDropdownResolver>();
			}
			break;
		case SettingCellType.Switch:
			return gameObject.AddComponent<SettingSwitchBoolResolver>();
		}
		return null;
	}

	private bool IsBindingEnabled(SettingCellType type)
	{
		return bindings.Find((SettingCellBindings x) => x.type == type)?.enabled ?? false;
	}
}
