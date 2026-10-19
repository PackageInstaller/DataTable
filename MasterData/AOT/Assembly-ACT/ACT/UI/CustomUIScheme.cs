using System.Collections;
using System.Collections.Generic;
using ACT.Utility;
using Newtonsoft.Json;
using UnityEngine;

namespace ACT.UI;

[JsonObject]
public class CustomUIScheme : IEnumerable<KeyValuePair<CustomUICompType, CustomUITransform>>, IEnumerable
{
	[JsonIgnore]
	private SortedDictionary<CustomUICompType, CustomUITransform> _transforms;

	public int Id { get; }

	[JsonIgnore]
	public CustomUISchemeType Type { get; }

	public string Name { get; private set; }

	[JsonIgnore]
	public LocalizeStringData NameLocalizeData { get; private set; }

	public CustomUITransform HudTeamCharacters { get; }

	public CustomUITransform HookBtnTransform { get; }

	public CustomUITransform JumpBtnTransform { get; }

	public CustomUITransform DodgeBtnTransform { get; }

	public CustomUITransform AttackBtnTransform { get; }

	public CustomUITransform SpAttackBtnTransform { get; }

	public CustomUITransform UltraBtnTransform { get; }

	public CustomUITransform BloodBarTransform { get; }

	public CustomUITransform EnergyBarTransform { get; }

	public CustomUITransform BuffListTransform { get; }

	public CustomUITransform AssistTransform { get; }

	public CustomUITransform SpecialEnergyBarTransform { get; }

	public CustomUITransform PropBtnTransform { get; }

	public Dictionary<CustomUICompType, CustomUITransform> ResetTemplateTransforms { get; private set; }

	[JsonIgnore]
	public bool CanRename => Type == CustomUISchemeType.Custom;

	[JsonIgnore]
	public bool CanDelete => Type == CustomUISchemeType.Custom;

	[JsonIgnore]
	public bool CanSave => Type == CustomUISchemeType.Custom;

	[JsonIgnore]
	public bool CanSaveAs => Type == CustomUISchemeType.Fixed;

	[JsonConstructor]
	public CustomUIScheme(int Id, string Name, CustomUITransform HudTeamCharacters, CustomUITransform HookBtnTransform, CustomUITransform JumpBtnTransform, CustomUITransform DodgeBtnTransform, CustomUITransform AttackBtnTransform, CustomUITransform SpAttackBtnTransform, CustomUITransform UltraBtnTransform, CustomUITransform BloodBarTransform, CustomUITransform EnergyBarTransform, CustomUITransform BuffListTransform, CustomUITransform AssistTransform, CustomUITransform PropBtnTransform, CustomUITransform SpecialEnergyBarTransform, Dictionary<CustomUICompType, CustomUITransform> ResetTemplateTransforms = null)
	{
		this.Id = Id;
		Type = CustomUISchemeType.Custom;
		this.Name = Name;
		this.HudTeamCharacters = HudTeamCharacters;
		this.HookBtnTransform = HookBtnTransform;
		this.JumpBtnTransform = JumpBtnTransform;
		this.DodgeBtnTransform = DodgeBtnTransform;
		this.AttackBtnTransform = AttackBtnTransform;
		this.SpAttackBtnTransform = SpAttackBtnTransform;
		this.UltraBtnTransform = UltraBtnTransform;
		this.BloodBarTransform = BloodBarTransform;
		this.EnergyBarTransform = EnergyBarTransform;
		this.BuffListTransform = BuffListTransform;
		this.AssistTransform = AssistTransform;
		this.PropBtnTransform = PropBtnTransform;
		this.SpecialEnergyBarTransform = SpecialEnergyBarTransform;
		InitDic();
		InitResetTemplate(ResetTemplateTransforms);
	}

	public CustomUIScheme(CustomUISchemeConfig config)
	{
		Id = config.id;
		Type = CustomUISchemeType.Fixed;
		if (Id / 100 != 2)
		{
			NameLocalizeData = new LocalizeStringData(config.fixedName);
			Name = LocalizationUtility.GetLocalizeString(NameLocalizeData);
		}
		HudTeamCharacters = new CustomUITransform(config.HudTeamCharactersRoot);
		HookBtnTransform = new CustomUITransform(config.hookBtnConfig);
		JumpBtnTransform = new CustomUITransform(config.jumpConfig);
		DodgeBtnTransform = new CustomUITransform(config.dodgeConfig);
		AttackBtnTransform = new CustomUITransform(config.attackConfig);
		SpAttackBtnTransform = new CustomUITransform(config.spAttackConfig);
		UltraBtnTransform = new CustomUITransform(config.ultraConfig);
		BloodBarTransform = new CustomUITransform(config.bloodBarConfig);
		EnergyBarTransform = new CustomUITransform(config.energyBarConfig);
		SpecialEnergyBarTransform = new CustomUITransform(config.specialEnergyBarConfig);
		BuffListTransform = new CustomUITransform(config.buffListConfig);
		AssistTransform = new CustomUITransform(config.assistConfig);
		PropBtnTransform = new CustomUITransform(config.propBtnConfig);
		InitDic();
	}

	public CustomUIScheme(int id, CustomUISchemeConfig config)
	{
		Id = id;
		Type = CustomUISchemeType.CustomPreset;
		NameLocalizeData = new LocalizeStringData(config.customPresetName);
		Name = LocalizationUtility.GetLocalizeString(NameLocalizeData);
		HudTeamCharacters = new CustomUITransform(config.HudTeamCharactersRoot);
		HookBtnTransform = new CustomUITransform(config.hookBtnConfig);
		JumpBtnTransform = new CustomUITransform(config.jumpConfig);
		DodgeBtnTransform = new CustomUITransform(config.dodgeConfig);
		AttackBtnTransform = new CustomUITransform(config.attackConfig);
		SpAttackBtnTransform = new CustomUITransform(config.spAttackConfig);
		UltraBtnTransform = new CustomUITransform(config.ultraConfig);
		BloodBarTransform = new CustomUITransform(config.bloodBarConfig);
		EnergyBarTransform = new CustomUITransform(config.energyBarConfig);
		SpecialEnergyBarTransform = new CustomUITransform(config.specialEnergyBarConfig);
		BuffListTransform = new CustomUITransform(config.buffListConfig);
		AssistTransform = new CustomUITransform(config.assistConfig);
		PropBtnTransform = new CustomUITransform(config.propBtnConfig);
		InitDic();
	}

	public CustomUIScheme(int id, CustomUISchemeModifyWrapper modifyWrapper, CustomUIScheme other)
	{
		Id = id;
		Type = CustomUISchemeType.Custom;
		HudTeamCharacters = new CustomUITransform(other.HudTeamCharacters);
		HookBtnTransform = new CustomUITransform(other.HookBtnTransform);
		JumpBtnTransform = new CustomUITransform(other.JumpBtnTransform);
		DodgeBtnTransform = new CustomUITransform(other.DodgeBtnTransform);
		AttackBtnTransform = new CustomUITransform(other.AttackBtnTransform);
		SpAttackBtnTransform = new CustomUITransform(other.SpAttackBtnTransform);
		UltraBtnTransform = new CustomUITransform(other.UltraBtnTransform);
		BloodBarTransform = new CustomUITransform(other.BloodBarTransform);
		EnergyBarTransform = new CustomUITransform(other.EnergyBarTransform);
		SpecialEnergyBarTransform = new CustomUITransform(other.SpecialEnergyBarTransform);
		BuffListTransform = new CustomUITransform(other.BuffListTransform);
		AssistTransform = new CustomUITransform(other.AssistTransform);
		PropBtnTransform = new CustomUITransform(other.PropBtnTransform);
		InitDic();
		ModifyImply(modifyWrapper);
		RecordResetTemplate();
	}

	private void InitDic()
	{
		_transforms = new SortedDictionary<CustomUICompType, CustomUITransform>
		{
			{
				CustomUICompType.HudTeamCharactersRoot,
				HudTeamCharacters
			},
			{
				CustomUICompType.HookBtn,
				HookBtnTransform
			},
			{
				CustomUICompType.JumpBtn,
				JumpBtnTransform
			},
			{
				CustomUICompType.DodgeBtn,
				DodgeBtnTransform
			},
			{
				CustomUICompType.AttackBtn,
				AttackBtnTransform
			},
			{
				CustomUICompType.SpAttackBtn,
				SpAttackBtnTransform
			},
			{
				CustomUICompType.UltraBtn,
				UltraBtnTransform
			},
			{
				CustomUICompType.BottleBtn,
				PropBtnTransform
			}
		};
	}

	private void RecordResetTemplate()
	{
		ResetTemplateTransforms = CopyTransforms(_transforms);
	}

	private void InitResetTemplate(Dictionary<CustomUICompType, CustomUITransform> resetTemplateTransforms)
	{
		ResetTemplateTransforms = ((resetTemplateTransforms != null) ? new Dictionary<CustomUICompType, CustomUITransform>(resetTemplateTransforms) : CopyTransforms(_transforms));
	}

	public IEnumerable<KeyValuePair<CustomUICompType, CustomUITransform>> GetResetTemplateTransforms()
	{
		if (ResetTemplateTransforms != null)
		{
			return ResetTemplateTransforms;
		}
		return _transforms;
	}

	private static Dictionary<CustomUICompType, CustomUITransform> CopyTransforms(IEnumerable<KeyValuePair<CustomUICompType, CustomUITransform>> source)
	{
		Dictionary<CustomUICompType, CustomUITransform> dictionary = new Dictionary<CustomUICompType, CustomUITransform>();
		foreach (var (key, otherTransform) in source)
		{
			dictionary[key] = new CustomUITransform(otherTransform);
		}
		return dictionary;
	}

	public void Modify(CustomUISchemeModifyWrapper modifyWrapper)
	{
		if (Id == modifyWrapper.SchemeId)
		{
			ModifyImply(modifyWrapper);
		}
	}

	private void ModifyImply(CustomUISchemeModifyWrapper modifyWrapper)
	{
		Rename(modifyWrapper.Name);
		if (modifyWrapper.Modifications == null)
		{
			return;
		}
		foreach (CustomUICompModify modification in modifyWrapper.Modifications)
		{
			SetCompTransform(modification.Type, modification.Pos, modification.Diameter);
		}
	}

	public void Rename(string newName)
	{
		Name = newName;
	}

	private void SetCompTransform(CustomUICompType type, Vector2 pos, float diameter)
	{
		if (_transforms.TryGetValue(type, out var value))
		{
			value.SetVal(pos, diameter);
		}
	}

	public IEnumerator<KeyValuePair<CustomUICompType, CustomUITransform>> GetEnumerator()
	{
		return _transforms.GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public string GetName()
	{
		if (Type != CustomUISchemeType.Custom)
		{
			return LocalizationUtility.GetLocalizeString(NameLocalizeData);
		}
		return Name;
	}
}
