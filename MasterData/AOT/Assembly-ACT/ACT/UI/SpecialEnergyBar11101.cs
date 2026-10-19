using ACT.Battle;
using ACT.Event;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.UI;

public class SpecialEnergyBar11101 : SpecialEnergyBar
{
	[SerializeField]
	private BetterAnimation _betterAnimation;

	private const string Filled = "Filled";

	private const string Normal = "Normal";

	private float _targetValue;

	public override void Init(SpecialEnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		_targetValue = ((SpecialEnergyData11101)energyBarData).targetValue;
		base.Init(energyBarData, transform, entity);
		CompAbility compAbility = entity.GetCompAbility();
		UpdateEnergy(compAbility.CurNormalEnergyPercent, compAbility.EnergyValue);
	}

	public override void OnEnergyValChange(CharacterNormalEnergyChangeEvt evt)
	{
		UpdateEnergy(evt.percent, evt.value);
	}

	private void UpdateEnergy(float percent, float value)
	{
		if (value >= _targetValue)
		{
			_betterAnimation.GetSequence("Filled").Play();
		}
		else if (value <= 0f)
		{
			_betterAnimation.GetSequence("Normal").Play();
		}
	}
}
