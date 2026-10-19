using ACT.Battle.Configs;
using ACT.Event;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.UI;

public class SpecialEnergyBar10301 : SpecialEnergyBar
{
	[SerializeField]
	private GameObject _board;

	[SerializeField]
	private GameObject _state1;

	[SerializeField]
	private GameObject _state2;

	[SerializeField]
	private GameObject _starLight;

	[SerializeField]
	private GameObject _starDark;

	private bool _onGround;

	private float _valuePercent;

	private const string OnGround = "OnGround";

	private MotionState _motionState;

	public override void Init(SpecialEnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		base.Init(energyBarData, transform, entity);
		_board.SetActive(value: true);
		_state1.SetActive(value: false);
		_state2.SetActive(value: false);
		_onGround = entity.GetMotionBool("OnGround");
		_motionState = entity.GetCompMotion().curMotionState;
		_valuePercent = entity.GetCompAbility().CurNormalEnergyPercent;
		UpdateSword();
		UpdateStar();
	}

	public override void OnEnergyValChange(CharacterNormalEnergyChangeEvt characterUltraEnergyUpdateEvt)
	{
		UpdateEnergy(characterUltraEnergyUpdateEvt.percent);
	}

	public override void OnBoolParamChange(MotionBoolParamChangeEvt evt)
	{
		if (evt.name == "OnGround")
		{
			_onGround = evt.value;
			UpdateStar();
		}
	}

	public override void OnMotionStateChange(MotionStateChangeEvt evt)
	{
		_motionState = evt.curState;
		UpdateStar();
	}

	private void UpdateEnergy(float newValue)
	{
		newValue = Mathf.Clamp01(newValue);
		_valuePercent = newValue;
		UpdateSword();
	}

	private void UpdateStar()
	{
		_starLight.SetActive(!_onGround && _motionState != MotionState.Climb);
		_starDark.SetActive(_onGround || _motionState == MotionState.Climb);
	}

	private void UpdateSword()
	{
		if (Mathf.Approximately(_valuePercent, 1f))
		{
			_board.SetActive(value: false);
			_state1.SetActive(value: false);
			_state2.SetActive(value: true);
			return;
		}
		if (_valuePercent < 0.5f)
		{
			_board.SetActive(value: true);
			_state1.SetActive(value: false);
			_state2.SetActive(value: false);
			return;
		}
		float valuePercent = _valuePercent;
		if (valuePercent >= 0.5f && valuePercent < 1f)
		{
			_board.SetActive(value: false);
			_state1.SetActive(value: true);
			_state2.SetActive(value: false);
		}
		else
		{
			_board.SetActive(value: true);
			_state1.SetActive(value: false);
			_state2.SetActive(value: false);
		}
	}
}
