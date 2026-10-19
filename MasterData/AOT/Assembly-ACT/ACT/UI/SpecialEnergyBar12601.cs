using ACT.Event;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.UI;

public class SpecialEnergyBar12601 : SpecialEnergyBar
{
	[SerializeField]
	private EnergyFill12601 _normalStateEnergy;

	[SerializeField]
	private EnergyFill12601 _ultraStateEnergy;

	[SerializeField]
	private GameObject[] _buffs;

	private const string SkillNum = "skillnum";

	private const string UltraAbilityName = "Role_26_01_ground_U";

	private bool _ultraState;

	private float _valuePercent;

	public override void Init(SpecialEnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		base.Init(energyBarData, transform, entity);
		SetEnergyBarState();
		UpdateEnergy(entity.GetCompAbility().CurSpecialEnergyPercent);
		UpdateBuff(0);
	}

	private void SetEnergyBarState()
	{
		_normalStateEnergy.root.SetActive(!_ultraState);
		_ultraStateEnergy.root.SetActive(_ultraState);
		_normalStateEnergy.complete.SetActive(value: false);
		_ultraStateEnergy.complete.SetActive(value: false);
	}

	private void SetCompleteState(GameObject completeObj, float oldPercent, float newPercent)
	{
		if (oldPercent < 1f && Mathf.Approximately(newPercent, 1f))
		{
			completeObj.SetActive(value: true);
		}
		else if (newPercent < 1f && Mathf.Approximately(oldPercent, 1f))
		{
			completeObj.SetActive(value: false);
		}
	}

	private void UpdateEnergy(float percent)
	{
		if (_ultraState)
		{
			_ultraStateEnergy.fill.fillAmount = percent;
			SetCompleteState(_ultraStateEnergy.complete, _valuePercent, percent);
			return;
		}
		float num = Mathf.Clamp(percent * 100f, 0f, 10f) / 10f;
		float oldPercent = Mathf.Clamp(_valuePercent * 100f, 0f, 10f) / 10f;
		_normalStateEnergy.fill.fillAmount = num;
		SetCompleteState(_normalStateEnergy.complete, oldPercent, num);
	}

	public override void OnIntParamChange(MotionIntParamChangeEvt evt)
	{
		if (evt.name == "skillnum")
		{
			UpdateBuff(evt.value);
		}
	}

	private void UpdateBuff(int stack)
	{
		for (int i = 0; i < _buffs.Length; i++)
		{
			_buffs[i].SetActive(i <= stack);
		}
	}

	public override void OnSpecialEnergyValChange(CharacterSpecialEnergyChangeEvt evt)
	{
		float num = Mathf.Clamp01(evt.percent);
		if (!Mathf.Approximately(num, _valuePercent))
		{
			UpdateEnergy(num);
			_valuePercent = num;
		}
	}

	public override void OnAbilityAdd(AbilityAddEvt abilityAddEvt)
	{
		if (abilityAddEvt.abilityName == "Role_26_01_ground_U")
		{
			_ultraState = true;
			SetEnergyBarState();
			UpdateEnergy(_valuePercent);
		}
	}

	public override void OnAbilityRemove(AbilityRemoveEvt abilityRemoveEvt)
	{
		if (abilityRemoveEvt.abilityName == "Role_26_01_ground_U")
		{
			_ultraState = false;
			SetEnergyBarState();
			UpdateEnergy(_valuePercent);
		}
	}
}
