using ACT.Event;
using Bamboo.ECS;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class SpecialEnergyBar : UIBehaviour
{
	private SpecialEnergyBarData _data;

	public virtual void Init(SpecialEnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		_data = energyBarData;
		SetTransform(transform);
		_data.OnEnergyValChanged += OnEnergyValChange;
		_data.OnSpecialEnergyChanged += OnSpecialEnergyValChange;
		_data.OnSkillCdChanged += OnSkillCdChange;
		_data.OnSkillCountChanged += OnSkillCountChange;
		_data.OnAbilityAdded += OnAbilityAdd;
		_data.OnAbilityRemoved += OnAbilityRemove;
		_data.OnAbilityStackChanged += OnAbilityStackChange;
		_data.OnAbilityDurationChanged += OnAbilityDurationChange;
		_data.OnBoolParamChanged += OnBoolParamChange;
		_data.OnIntParamChanged += OnIntParamChange;
		_data.OnMotionStateChanged += OnMotionStateChange;
		_data.OnActiveChanged += OnActiveChanged;
	}

	public virtual void UnInit()
	{
		if (_data != null)
		{
			_data.OnEnergyValChanged -= OnEnergyValChange;
			_data.OnSpecialEnergyChanged -= OnSpecialEnergyValChange;
			_data.OnSkillCdChanged -= OnSkillCdChange;
			_data.OnSkillCountChanged -= OnSkillCountChange;
			_data.OnAbilityAdded -= OnAbilityAdd;
			_data.OnAbilityRemoved -= OnAbilityRemove;
			_data.OnAbilityStackChanged -= OnAbilityStackChange;
			_data.OnAbilityDurationChanged -= OnAbilityDurationChange;
			_data.OnBoolParamChanged -= OnBoolParamChange;
			_data.OnIntParamChanged -= OnIntParamChange;
			_data.OnMotionStateChanged -= OnMotionStateChange;
			_data.OnActiveChanged -= OnActiveChanged;
			_data = null;
		}
	}

	public void OnUpdateScheme(CustomUITransform transform)
	{
		SetTransform(transform);
	}

	private void SetTransform(CustomUITransform transform)
	{
		(base.transform as RectTransform).anchoredPosition = transform.Pos;
	}

	public virtual void OnSpecialEnergyValChange(CharacterSpecialEnergyChangeEvt evt)
	{
	}

	public virtual void OnEnergyValChange(CharacterNormalEnergyChangeEvt characterUltraEnergyUpdateEvt)
	{
	}

	public virtual void OnAbilityAdd(AbilityAddEvt abilityAddEvt)
	{
	}

	public virtual void OnAbilityRemove(AbilityRemoveEvt abilityRemoveEvt)
	{
	}

	public virtual void OnAbilityStackChange(AbilityStackChangeEvt abilityStackChangeEvt)
	{
	}

	public virtual void OnAbilityDurationChange(AbilityDurationChangeEvt abilityDurationChangeEvt)
	{
	}

	public virtual void OnSkillCdChange(SkillCdChangeEvt skillCdChangeEvt)
	{
	}

	public virtual void OnSkillCountChange(SkillCountChangeEvt skillCountChangeEvt)
	{
	}

	public virtual void OnBoolParamChange(MotionBoolParamChangeEvt evt)
	{
	}

	public virtual void OnIntParamChange(MotionIntParamChangeEvt evt)
	{
	}

	public virtual void OnMotionStateChange(MotionStateChangeEvt evt)
	{
	}

	private void OnActiveChanged(CharacterSpecialEnergyActiveChangeEvt evt)
	{
		gameObject.SetActive(evt.active);
	}
}
