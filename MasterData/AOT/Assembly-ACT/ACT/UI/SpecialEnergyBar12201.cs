using ACT.Battle;
using ACT.Event;
using Bamboo.ECS;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class SpecialEnergyBar12201 : SpecialEnergyBar
{
	private const string AbilityName = "Role_22_01_gaosu";

	[SerializeField]
	private Image _gaoSuFill;

	[SerializeField]
	private Image _normalFill;

	[SerializeField]
	private TextMeshProUGUI _textValue;

	private float _valuePercent;

	public override void Init(SpecialEnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		base.Init(energyBarData, transform, entity);
		_normalFill.gameObject.SetActive(value: true);
		_gaoSuFill.gameObject.SetActive(value: false);
		CompAbility compAbility = entity.GetCompAbility();
		UpdateFillText(compAbility.SpecialEnergyValue, compAbility.CurSpecialEnergyPercent);
	}

	public override void OnAbilityAdd(AbilityAddEvt abilityAddEvt)
	{
		if (abilityAddEvt.abilityName == "Role_22_01_gaosu")
		{
			_normalFill.gameObject.SetActive(value: false);
			_gaoSuFill.gameObject.SetActive(value: true);
		}
	}

	public override void OnAbilityRemove(AbilityRemoveEvt abilityRemoveEvt)
	{
		if (abilityRemoveEvt.abilityName == "Role_22_01_gaosu")
		{
			_normalFill.gameObject.SetActive(value: true);
			_gaoSuFill.gameObject.SetActive(value: false);
		}
	}

	private void UpdateEnergy(float value, float percent)
	{
		float num = Mathf.Clamp01(percent);
		if (!Mathf.Approximately(num, _valuePercent))
		{
			UpdateFillText(value, percent);
			_valuePercent = num;
		}
	}

	private void UpdateFillText(float value, float percent)
	{
		_textValue.SetText("{0:0}", value);
		_normalFill.fillAmount = percent;
		_gaoSuFill.fillAmount = percent;
	}

	public override void OnSpecialEnergyValChange(CharacterSpecialEnergyChangeEvt evt)
	{
		UpdateEnergy(evt.value, evt.percent);
	}
}
