using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Model;
using ACT.Utility;
using Bamboo.AssetField;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;
using UnityEngine.InputSystem.DualShock;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class CharacterTrialTipsItem : MonoBehaviour
{
	[SerializeField]
	private LocalizeStringEvent _title;

	[SerializeField]
	private BImage _skillIcon;

	[SerializeField]
	private LocalizeStringEvent _desc;

	private Dictionary<string, object> _promptTMPVariables = new Dictionary<string, object>();

	private StringBuilder _bindingKeyNameBuilder = new StringBuilder();

	private int _titleLocalizeId;

	private int _descLocalizeId;

	private int _skillIconId;

	private string[] _actionPrompts;

	private ImageAssetStation _station;

	private void OnEnable()
	{
		MonoECS.instance.onInputModeChange.AddListener(InternalOnInputDeviceChange);
	}

	private void OnDisable()
	{
		MonoECS.instance.onInputModeChange.RemoveListener(InternalOnInputDeviceChange);
	}

	public void InternalOnInputDeviceChange(DeviceInputMode type)
	{
		YooAssetReference assetID = ((type == DeviceInputMode.TouchScreen) ? GameLoader.meta.SkillSheet : GameLoader.meta.TmpPrompt);
		AssetLoadHandle assetLoadHandle = AssetStationManager.BattleStation.LoadAsync<TMP_SpriteAsset>(assetID);
		assetLoadHandle.Completed += (AssetLoadHandle h) =>
		{
			TMP_SpriteAsset spriteAsset = h.As<TMP_SpriteAsset>();
			_desc.GetComponent<TextMeshProUGUI>().spriteAsset = spriteAsset;
			RefreshUI(_titleLocalizeId, _skillIconId, _descLocalizeId, _actionPrompts, _station);
		};
	}

	public void RefreshUI(int titleLocalizeId, int skillIconId, int descLocalizeId, string[] actionPrompts, ImageAssetStation station)
	{
		_titleLocalizeId = titleLocalizeId;
		_skillIconId = skillIconId;
		_descLocalizeId = descLocalizeId;
		_actionPrompts = actionPrompts;
		_station = station;
		_title.StringReference.TableEntryReference = titleLocalizeId;
		_skillIcon.icon.gameObject.SetActive(skillIconId > 0);
		if (skillIconId > 0)
		{
			station.LoadImage(187, skillIconId, _skillIcon);
			_skillIcon.icon.SetNativeSize();
		}
		SetDescription(_desc, descLocalizeId, actionPrompts);
		LayoutRebuilder.ForceRebuildLayoutImmediate((RectTransform)transform);
	}

	private void SetDescription(LocalizeStringEvent localizeStringEvent, int longCommonId, string[] actionPrompts)
	{
		localizeStringEvent.StringReference.TableEntryReference = 0L;
		if (actionPrompts.Length == 0)
		{
			localizeStringEvent.StringReference.Clear();
			localizeStringEvent.SetTable(LocalizationUtility.localizeTableName_longcommon);
			localizeStringEvent.StringReference.TableEntryReference = longCommonId;
			return;
		}
		_promptTMPVariables.Clear();
		for (int i = 0; i < actionPrompts.Length; i++)
		{
			string text = actionPrompts[i];
			if (MonoECS.instance.InputMode != DeviceInputMode.TouchScreen)
			{
				if (MonoECS.instance.GetInputDeviceButtonBindingKeyName(text, out var bindingKeyName))
				{
					if (!string.IsNullOrEmpty(bindingKeyName))
					{
						_bindingKeyNameBuilder.Clear();
						_bindingKeyNameBuilder.Append(bindingKeyName);
						_bindingKeyNameBuilder.Replace("/", "_");
						if (MonoECS.instance.GetPromptIconDevice() is DualShockGamepad)
						{
							_bindingKeyNameBuilder.Replace("gamepad", "gamepad_Sony");
						}
						_promptTMPVariables[i.FastToString()] = _bindingKeyNameBuilder.ToString();
					}
					else if (!LuminApplication.LogEnabled)
					{
					}
				}
				else if (!LuminApplication.LogEnabled)
				{
				}
			}
			else if (!string.IsNullOrEmpty(text))
			{
				_promptTMPVariables[i.FastToString()] = text;
			}
		}
		Model<GuideTipModel>.Interface.SetVariablesWithoutCache(localizeStringEvent, _promptTMPVariables);
		localizeStringEvent.SetTable(LocalizationUtility.localizeTableName_longcommon);
		localizeStringEvent.StringReference.TableEntryReference = longCommonId;
	}
}
