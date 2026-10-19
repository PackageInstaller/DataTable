using ACT.Event;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.UI;

public class SpecialEnergyBar11601 : SpecialEnergyBar
{
	private const string UltimateAbilityName = "Role_16_01_Burst_Ultimate";

	private const string QuicklyChargeName = "Role_16_01_QuicklyCharge";

	private bool _quickChargeState;

	private bool _ultimateState;

	[SerializeField]
	private GameObject _unQuicklyCharge;

	[SerializeField]
	private GameObject _quicklyCharge;

	[SerializeField]
	private GameObject _ultimate;

	public override void Init(SpecialEnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		base.Init(energyBarData, transform, entity);
		_unQuicklyCharge.SetActive(value: true);
		_quicklyCharge.SetActive(value: false);
		_ultimate.SetActive(value: false);
	}

	public override void OnAbilityAdd(AbilityAddEvt abilityAddEvt)
	{
		string abilityName = abilityAddEvt.abilityName;
		if (!(abilityName == "Role_16_01_Burst_Ultimate"))
		{
			if (abilityName == "Role_16_01_QuicklyCharge")
			{
				_quickChargeState = true;
				_unQuicklyCharge.SetActive(value: false);
				_quicklyCharge.SetActive(!_ultimateState);
				_ultimate.SetActive(_ultimateState);
			}
		}
		else
		{
			_ultimateState = true;
			_unQuicklyCharge.SetActive(value: false);
			_quicklyCharge.SetActive(value: false);
			_ultimate.SetActive(value: true);
		}
	}

	public override void OnAbilityRemove(AbilityRemoveEvt abilityRemoveEvt)
	{
		string abilityName = abilityRemoveEvt.abilityName;
		if (!(abilityName == "Role_16_01_Burst_Ultimate"))
		{
			if (abilityName == "Role_16_01_QuicklyCharge")
			{
				_quickChargeState = false;
				_unQuicklyCharge.SetActive(value: true);
				_quicklyCharge.SetActive(value: false);
				_ultimate.SetActive(_ultimateState);
			}
		}
		else
		{
			_ultimateState = false;
			_unQuicklyCharge.SetActive(!_quickChargeState);
			_quicklyCharge.SetActive(_quickChargeState);
			_ultimate.SetActive(value: false);
		}
	}
}
