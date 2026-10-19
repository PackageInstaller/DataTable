using ACT.Event;
using Bamboo.ECS;

namespace ACT.UI;

public class CharacterOperateBtnGroupData
{
	private EntityId _entityId;

	private JumpBtnData _jumpBtnData;

	private DodgeBtnData _dodgeBtnData;

	private AttackBtnData _attackBtnData;

	private SpAttackBtnData _spAttackBtnData;

	private UltraBtnData _ultraBtnData;

	private EnergyBarData _energyBarData;

	private AssistData _assistData;

	private SpecialEnergyBarData _specialEnergyBarData;

	public EntityId EntityId => _entityId;

	public JumpBtnData JumpBtnData => _jumpBtnData;

	public DodgeBtnData DodgeBtnData => _dodgeBtnData;

	public AttackBtnData AttackBtnData => _attackBtnData;

	public SpAttackBtnData SpAttackBtnData => _spAttackBtnData;

	public UltraBtnData UltraBtnData => _ultraBtnData;

	public EnergyBarData EnergyBarData => _energyBarData;

	public AssistData AssistData => _assistData;

	public SpecialEnergyBarData SpecialEnergyBarData => _specialEnergyBarData;

	public CharacterOperateBtnGroupData(CharacterOperateBtnConfig config, Entity belongEb)
	{
		_entityId = belongEb.Id;
		SetJumpBtnData(config.jumpBtnConfig, belongEb);
		SetDodgeBtnData(config.dodgeBtnConfig, belongEb);
		SetAttackBtnData(config.attackBtnConfig, belongEb);
		SetSpAttackBtnData(config.spAttackBtnConfig, belongEb);
		SetUltraBtnData(config.ultraBtnConfig, belongEb);
		SetEnergyBarData(config.energyBarConfig, belongEb);
		SetAssistData(config.assistConfig, belongEb);
		SetSpecialEnergyBarData(config.specialEnergyBarConfig, belongEb);
	}

	private void SetJumpBtnData(JumpBtnConfig config, Entity belongEb)
	{
		JumpBtnMultiFormData jumpBtnData = ((!(config is JumpBtnMultiFormConfig config2)) ? null : new JumpBtnMultiFormData(config2, belongEb));
		_jumpBtnData = jumpBtnData;
	}

	private void SetDodgeBtnData(DodgeBtnConfig config, Entity belongEb)
	{
		DodgeBtnMultiFormData dodgeBtnData = ((!(config is DodgeBtnMultiFormConfig config2)) ? null : new DodgeBtnMultiFormData(config2, belongEb));
		_dodgeBtnData = dodgeBtnData;
	}

	private void SetAttackBtnData(AttackBtnConfig config, Entity belongEb)
	{
		AttackBtnMultiFormData attackBtnData = ((!(config is AttackBtnMultiFormConfig config2)) ? null : new AttackBtnMultiFormData(config2, belongEb));
		_attackBtnData = attackBtnData;
	}

	private void SetSpAttackBtnData(SpAttackBtnConfig config, Entity belongEb)
	{
		SpAttackBtnMultiFormData spAttackBtnData = ((!(config is SpAttackBtnMultiFormConfig config2)) ? null : new SpAttackBtnMultiFormData(config2, belongEb));
		_spAttackBtnData = spAttackBtnData;
	}

	private void SetUltraBtnData(UltraBtnConfig config, Entity belongEb)
	{
		UltraBtnMultiFormData ultraBtnData = ((!(config is UltraBtnMultiFormConfig config2)) ? null : new UltraBtnMultiFormData(config2, belongEb));
		_ultraBtnData = ultraBtnData;
	}

	private void SetEnergyBarData(EnergyBarConfig config, Entity belongEb)
	{
		EnergyBarNormalData energyBarData = ((!(config is EnergyBarNormalConfig config2)) ? null : new EnergyBarNormalData(config2));
		_energyBarData = energyBarData;
	}

	private void SetAssistData(AssistConfig config, Entity belongEb)
	{
		AssistNormalData assistData = ((!(config is AssistNormalConfig config2)) ? null : new AssistNormalData(config2));
		_assistData = assistData;
	}

	private void SetSpecialEnergyBarData(SpecialEnergyBarConfig config, Entity belongEb)
	{
		SpecialEnergyBarData specialEnergyBarData;
		if (config is SpecialEnergyBarNormalConfig config2)
		{
			specialEnergyBarData = new SpecialEnergyNormalData(config2);
		}
		else
		{
			specialEnergyBarData = ((!(config is SpecialEnergyBarConfig11101 config3)) ? null : new SpecialEnergyData11101(config3));
		}
		_specialEnergyBarData = specialEnergyBarData;
	}

	public void ProcessAssistDataChange(AssistValChangeEvt data)
	{
		_assistData?.UpdateAssistPercent(data.assistPercent);
	}

	public void ProcessUltraEnergyChange(CharacterUltraEnergyUpdateEvt data)
	{
		_jumpBtnData?.formDataManager?.HandleUltraEnergyChange(data);
		_dodgeBtnData?.formDataManager?.HandleUltraEnergyChange(data);
		_attackBtnData?.formDataManager?.HandleUltraEnergyChange(data);
		_spAttackBtnData?.formDataManager?.HandleUltraEnergyChange(data);
		_ultraBtnData?.formDataManager?.HandleUltraEnergyChange(data);
	}

	public void ProcessSkillCdChange(SkillCdChangeEvt evt)
	{
		_jumpBtnData?.formDataManager?.HandleSkillCdChange(evt);
		_dodgeBtnData?.formDataManager?.HandleSkillCdChange(evt);
		_attackBtnData?.formDataManager?.HandleSkillCdChange(evt);
		_spAttackBtnData?.formDataManager?.HandleSkillCdChange(evt);
		_ultraBtnData?.formDataManager?.HandleSkillCdChange(evt);
		_energyBarData?.HandleSkillCdChange(evt);
		_specialEnergyBarData?.HandleSkillCdChange(evt);
	}

	public void ProcessSkillCountChange(SkillCountChangeEvt evt)
	{
		_jumpBtnData?.formDataManager?.HandleSkillCountChange(evt);
		_dodgeBtnData?.formDataManager?.HandleSkillCountChange(evt);
		_attackBtnData?.formDataManager?.HandleSkillCountChange(evt);
		_spAttackBtnData?.formDataManager?.HandleSkillCountChange(evt);
		_ultraBtnData?.formDataManager?.HandleSkillCountChange(evt);
		_energyBarData?.HandleSkillCountChange(evt);
		_specialEnergyBarData?.HandleSkillCountChange(evt);
	}

	public void ProcessAbilityDurationChange(AbilityDurationChangeEvt abilityData)
	{
		_jumpBtnData?.formDataManager?.HandleAbilityDurationChange(abilityData);
		_dodgeBtnData?.formDataManager?.HandleAbilityDurationChange(abilityData);
		_attackBtnData?.formDataManager?.HandleAbilityDurationChange(abilityData);
		_spAttackBtnData?.formDataManager?.HandleAbilityDurationChange(abilityData);
		_ultraBtnData?.formDataManager?.HandleAbilityDurationChange(abilityData);
		_energyBarData?.HandleAbilityDurationChange(abilityData);
		_specialEnergyBarData?.HandleAbilityDurationChange(abilityData);
	}

	public void ProcessAbilityAdd(AbilityAddEvt evt)
	{
		_jumpBtnData?.formDataManager?.HandleAbilityAdd(evt);
		_dodgeBtnData?.formDataManager?.HandleAbilityAdd(evt);
		_attackBtnData?.formDataManager?.HandleAbilityAdd(evt);
		_spAttackBtnData?.formDataManager?.HandleAbilityAdd(evt);
		_ultraBtnData?.formDataManager?.HandleAbilityAdd(evt);
		_energyBarData?.HandleAbilityAdd(evt);
		_specialEnergyBarData?.HandleAbilityAdd(evt);
	}

	public void ProcessAbilityRemove(AbilityRemoveEvt evt)
	{
		_jumpBtnData?.formDataManager?.HandleAbilityRemove(evt);
		_dodgeBtnData?.formDataManager?.HandleAbilityRemove(evt);
		_attackBtnData?.formDataManager?.HandleAbilityRemove(evt);
		_spAttackBtnData?.formDataManager?.HandleAbilityRemove(evt);
		_ultraBtnData?.formDataManager?.HandleAbilityRemove(evt);
		_energyBarData?.HandleAbilityRemove(evt);
		_specialEnergyBarData?.HandleAbilityRemove(evt);
	}

	public void ProcessEnergyChange(CharacterNormalEnergyChangeEvt energyData)
	{
		_jumpBtnData?.formDataManager?.HandleEnergyChange(energyData);
		_dodgeBtnData?.formDataManager?.HandleEnergyChange(energyData);
		_attackBtnData?.formDataManager?.HandleEnergyChange(energyData);
		_spAttackBtnData?.formDataManager?.HandleEnergyChange(energyData);
		_ultraBtnData?.formDataManager?.HandleEnergyChange(energyData);
		_energyBarData?.HandleEnergyChange(energyData);
		_specialEnergyBarData?.HandleEnergyChange(energyData);
	}

	public void ProcessAbilityStackChange(AbilityStackChangeEvt evt)
	{
		_energyBarData?.HandleAbilityStackChange(evt);
		_specialEnergyBarData?.HandleAbilityStackChange(evt);
	}

	public void ProcessSpecialEnergyChange(CharacterSpecialEnergyChangeEvt evt)
	{
		_specialEnergyBarData?.HandleSpecialEnergyChange(evt);
	}

	public void ProcessMotionBoolParamChange(MotionBoolParamChangeEvt evt)
	{
		_specialEnergyBarData?.HandleBoolParamChange(evt);
	}

	public void ProcessMotionIntParamChange(MotionIntParamChangeEvt evt)
	{
		_specialEnergyBarData?.HandleIntParamChange(evt);
	}

	public void ProcessMotionStateChange(MotionStateChangeEvt evt)
	{
		_specialEnergyBarData?.HandleMotionStateChange(evt);
	}

	public void ProcessNormalEnergyActiveChange(CharacterNormalEnergyActiveChangeEvt evt)
	{
		_energyBarData?.HandleActiveChange(evt);
	}

	public void ProcessSpecialEnergyActiveChange(CharacterSpecialEnergyActiveChangeEvt evt)
	{
		_specialEnergyBarData?.HandleActiveChange(evt);
	}

	public void ProcessAssistActiveChange(CharacterAssistActiveChangeEvt evt)
	{
		_assistData?.HandleActiveChange(evt);
	}

	public void ProcessRebindSkillChangeBtnState(RebindSkillBtnEvt newData)
	{
		_jumpBtnData?.formDataManager?.HandleRebindSkillChangeBtnState(newData);
		_dodgeBtnData?.formDataManager?.HandleRebindSkillChangeBtnState(newData);
		_attackBtnData?.formDataManager?.HandleRebindSkillChangeBtnState(newData);
		_spAttackBtnData?.formDataManager?.HandleRebindSkillChangeBtnState(newData);
		_ultraBtnData?.formDataManager?.HandleRebindSkillChangeBtnState(newData);
	}
}
