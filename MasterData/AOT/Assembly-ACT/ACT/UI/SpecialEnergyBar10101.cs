using ACT.Event;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.UI;

public class SpecialEnergyBar10101 : SpecialEnergyBar
{
	private const string AbilityName = "Role_01_01_Quick";

	[SerializeField]
	private BetterAnimation _betterAnimation;

	private const string state1 = "State_1";

	private const string state2 = "State_2";

	private const string state3 = "State_3";

	private float _valuePercent;

	private bool _inQuickState;

	public override void Init(SpecialEnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		base.Init(energyBarData, transform, entity);
		_betterAnimation.GetSequence("State_1").Play();
		UpdateEnergy(entity.GetCompAbility().CurSpecialEnergyPercent);
	}

	public override void OnAbilityAdd(AbilityAddEvt abilityAddEvt)
	{
		if (abilityAddEvt.abilityName == "Role_01_01_Quick")
		{
			_inQuickState = true;
			if (Mathf.Approximately(_valuePercent, 1f))
			{
				_betterAnimation.GetSequence("State_3").Play();
			}
		}
	}

	public override void OnAbilityRemove(AbilityRemoveEvt abilityRemoveEvt)
	{
		if (abilityRemoveEvt.abilityName == "Role_01_01_Quick")
		{
			_inQuickState = false;
			if (Mathf.Approximately(_valuePercent, 1f))
			{
				_betterAnimation.GetSequence("State_2").Play();
			}
			else
			{
				_betterAnimation.GetSequence("State_1").Play();
			}
		}
	}

	public override void OnEnergyValChange(CharacterNormalEnergyChangeEvt characterUltraEnergyUpdateEvt)
	{
		UpdateEnergy(characterUltraEnergyUpdateEvt.percent);
	}

	private void UpdateEnergy(float percent)
	{
		float num = Mathf.Clamp01(percent);
		if (Mathf.Approximately(_valuePercent, num))
		{
			return;
		}
		if (_valuePercent < 1f && Mathf.Approximately(1f, num))
		{
			if (_inQuickState)
			{
				_betterAnimation.GetSequence("State_3").Play();
			}
			else
			{
				_betterAnimation.GetSequence("State_2").Play();
			}
		}
		if (num < 1f && Mathf.Approximately(_valuePercent, 1f))
		{
			_betterAnimation.GetSequence("State_1").Play();
		}
		_valuePercent = num;
	}
}
