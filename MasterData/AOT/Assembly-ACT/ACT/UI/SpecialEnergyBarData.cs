using System;
using ACT.Event;

namespace ACT.UI;

public abstract class SpecialEnergyBarData
{
	public event Action<CharacterNormalEnergyChangeEvt> OnEnergyValChanged;

	public event Action<CharacterSpecialEnergyChangeEvt> OnSpecialEnergyChanged;

	public event Action<SkillCdChangeEvt> OnSkillCdChanged;

	public event Action<SkillCountChangeEvt> OnSkillCountChanged;

	public event Action<AbilityAddEvt> OnAbilityAdded;

	public event Action<AbilityRemoveEvt> OnAbilityRemoved;

	public event Action<AbilityStackChangeEvt> OnAbilityStackChanged;

	public event Action<AbilityDurationChangeEvt> OnAbilityDurationChanged;

	public event Action<MotionBoolParamChangeEvt> OnBoolParamChanged;

	public event Action<MotionIntParamChangeEvt> OnIntParamChanged;

	public event Action<MotionStateChangeEvt> OnMotionStateChanged;

	public event Action<CharacterSpecialEnergyActiveChangeEvt> OnActiveChanged;

	public void HandleEnergyChange(CharacterNormalEnergyChangeEvt evt)
	{
		OnEnergyValChanged?.Invoke(evt);
	}

	public void HandleSpecialEnergyChange(CharacterSpecialEnergyChangeEvt evt)
	{
		OnSpecialEnergyChanged?.Invoke(evt);
	}

	public void HandleSkillCdChange(SkillCdChangeEvt evt)
	{
		OnSkillCdChanged?.Invoke(evt);
	}

	public void HandleSkillCountChange(SkillCountChangeEvt evt)
	{
		OnSkillCountChanged?.Invoke(evt);
	}

	public void HandleAbilityAdd(AbilityAddEvt evt)
	{
		OnAbilityAdded?.Invoke(evt);
	}

	public void HandleAbilityRemove(AbilityRemoveEvt evt)
	{
		OnAbilityRemoved?.Invoke(evt);
	}

	public void HandleAbilityStackChange(AbilityStackChangeEvt evt)
	{
		OnAbilityStackChanged?.Invoke(evt);
	}

	public void HandleAbilityDurationChange(AbilityDurationChangeEvt evt)
	{
		OnAbilityDurationChanged?.Invoke(evt);
	}

	public void HandleBoolParamChange(MotionBoolParamChangeEvt evt)
	{
		OnBoolParamChanged?.Invoke(evt);
	}

	public void HandleIntParamChange(MotionIntParamChangeEvt evt)
	{
		OnIntParamChanged?.Invoke(evt);
	}

	public void HandleMotionStateChange(MotionStateChangeEvt evt)
	{
		OnMotionStateChanged?.Invoke(evt);
	}

	public void HandleActiveChange(CharacterSpecialEnergyActiveChangeEvt evt)
	{
		OnActiveChanged?.Invoke(evt);
	}
}
