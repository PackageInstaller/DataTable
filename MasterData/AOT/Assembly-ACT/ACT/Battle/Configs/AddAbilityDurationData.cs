namespace ACT.Battle.Configs;

public struct AddAbilityDurationData
{
	public enum AddAbilityDurationType
	{
		None,
		AddWithRoleBuild,
		AddWithNewSkillID,
		SystemAdd
	}

	public enum AbilityStackType
	{
		add,
		set
	}

	public enum AbilitySourceType
	{
		defaultType,
		forceNewType
	}

	public bool casterIsTargetSelf;

	public AddAbilityDurationType type;

	public AbilityStackType abilityStackType;

	public int skillId;

	public AbilitySourceType abilitysourceType;
}
