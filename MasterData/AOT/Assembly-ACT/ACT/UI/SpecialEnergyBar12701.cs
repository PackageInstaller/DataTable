using ACT.Event;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.UI;

public class SpecialEnergyBar12701 : SpecialEnergyBar
{
	private const string CanFlash = "CanFlash";

	private const string ArousalAbilityName = "Role_27_01_Burst_Ultimate";

	[SerializeField]
	private BetterAnimation _animation;

	private readonly string _showAnimationName = "Show";

	private readonly string _hideAnimationName = "Hide";

	[SerializeField]
	private GameObject _canFlash;

	[SerializeField]
	private GameObject _canFlashAndArousal;

	private bool _inArousal;

	public override void Init(SpecialEnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		base.Init(energyBarData, transform, entity);
		_canFlash.SetActive(value: false);
		_canFlashAndArousal.SetActive(value: false);
	}

	public override void OnAbilityAdd(AbilityAddEvt abilityAddEvt)
	{
		if (abilityAddEvt.abilityName == "Role_27_01_Burst_Ultimate")
		{
			_inArousal = true;
		}
	}

	public override void OnAbilityRemove(AbilityRemoveEvt abilityRemoveEvt)
	{
		if (abilityRemoveEvt.abilityName == "Role_27_01_Burst_Ultimate")
		{
			_canFlashAndArousal.SetActive(value: false);
			_inArousal = false;
		}
	}

	public override void OnBoolParamChange(MotionBoolParamChangeEvt evt)
	{
		if (evt.name == "CanFlash")
		{
			if (evt.value)
			{
				_canFlash.SetActive(value: true);
				_canFlashAndArousal.SetActive(_inArousal);
			}
			else
			{
				_canFlash.SetActive(value: false);
				_canFlashAndArousal.SetActive(value: false);
			}
		}
	}
}
