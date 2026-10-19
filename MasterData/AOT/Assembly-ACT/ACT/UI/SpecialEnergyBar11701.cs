using System.Collections;
using ACT.Battle;
using ACT.Event;
using Bamboo.ECS;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class SpecialEnergyBar11701 : SpecialEnergyBar
{
	[SerializeField]
	private TextMeshProUGUI _specialEnergyValue;

	[SerializeField]
	private GameObject state1;

	[SerializeField]
	private GameObject state2;

	[SerializeField]
	private GameObject state3;

	[SerializeField]
	private BetterAnimation _animation;

	private float _valuePercent;

	private bool _inState3;

	public override void Init(SpecialEnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		base.Init(energyBarData, transform, entity);
		state1.SetActive(value: true);
		state2.SetActive(value: false);
		state3.SetActive(value: false);
		CompAbility compAbility = entity.GetCompAbility();
		UpdateEnergy(compAbility.CurSpecialEnergyPercent, compAbility.SpecialEnergyValue);
	}

	public override void OnSpecialEnergyValChange(CharacterSpecialEnergyChangeEvt evt)
	{
		UpdateEnergy(evt.percent, evt.value);
	}

	private IEnumerator ShowState3()
	{
		_inState3 = true;
		yield return new WaitForSeconds(0.5f);
		float valuePercent = _valuePercent;
		if (valuePercent >= 0f && valuePercent <= 0.5f)
		{
			state1.SetActive(value: true);
			state2.SetActive(value: false);
			state3.SetActive(value: false);
		}
		else
		{
			valuePercent = _valuePercent;
			if (valuePercent > 0.5f && valuePercent < 1f)
			{
				state1.SetActive(value: false);
				state2.SetActive(value: true);
				state3.SetActive(value: false);
			}
			else
			{
				state1.SetActive(value: false);
				state2.SetActive(value: false);
				state3.SetActive(value: true);
			}
		}
		_inState3 = false;
	}

	private void UpdateEnergy(float newValuePercent, float newValue)
	{
		_specialEnergyValue.SetText("{0:0}", newValue);
		newValuePercent = Mathf.Clamp01(newValuePercent);
		if (!Mathf.Approximately(newValuePercent, _valuePercent))
		{
			if (!Mathf.Approximately(_valuePercent, 0f) && Mathf.Approximately(newValuePercent, 0f))
			{
				StartCoroutine(ShowState3());
			}
			else if ((double)_valuePercent <= 0.5 && newValuePercent > 0.5f && newValuePercent < 1f && !_inState3)
			{
				state1.SetActive(value: false);
				state2.SetActive(value: true);
				state3.SetActive(value: false);
			}
			else if (_valuePercent < 1f && Mathf.Approximately(newValuePercent, 1f) && !_inState3)
			{
				state1.SetActive(value: false);
				state2.SetActive(value: false);
				state3.SetActive(value: true);
			}
			_valuePercent = newValuePercent;
		}
	}
}
