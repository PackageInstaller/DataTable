using ACT.Battle;
using ACT.Event;
using Bamboo.ECS;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class SpecialEnergyBar12501 : SpecialEnergyBar
{
	private const string GuardPoint = "GuardPoint";

	[SerializeField]
	private TextMeshProUGUI _valueText;

	[SerializeField]
	private Image _fillAmount;

	[SerializeField]
	private GameObject[] _buffStack;

	private float _valuePercent;

	public override void Init(SpecialEnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		base.Init(energyBarData, transform, entity);
		CompAbility compAbility = entity.GetCompAbility();
		UpdateEnergy(compAbility.SpecialEnergyValue, compAbility.CurSpecialEnergyPercent);
		if (entity.GetCompMotion().parameters.TryGetValue("GuardPoint", out var value))
		{
			UpdateStack(value.defaultInt);
		}
		else
		{
			_ = LuminApplication.LogEnabled;
		}
	}

	private void UpdateEnergy(float value, float percent)
	{
		_fillAmount.fillAmount = percent;
		_valueText.SetText("{0:0}", value);
	}

	public override void OnSpecialEnergyValChange(CharacterSpecialEnergyChangeEvt evt)
	{
		float num = Mathf.Clamp01(evt.percent);
		if (!Mathf.Approximately(num, _valuePercent))
		{
			UpdateEnergy(evt.value, num);
			_valuePercent = num;
		}
	}

	private void UpdateStack(int stack)
	{
		for (int i = 0; i < _buffStack.Length; i++)
		{
			_buffStack[i].SetActive(i < stack);
		}
	}

	public override void OnIntParamChange(MotionIntParamChangeEvt evt)
	{
		if (evt.name == "GuardPoint")
		{
			UpdateStack(evt.value);
		}
	}
}
