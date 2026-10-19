namespace ACT.Battle.Configs;

public sealed class AbilityBlackboard : BattleBlackboard
{
	public AbilityBlackboard(AbilityBlackboardVariable[] variables = null)
	{
		Initialize(variables);
	}

	public void Initialize(AbilityBlackboardVariable[] variables)
	{
		Clear();
		if (variables == null)
		{
			return;
		}
		foreach (AbilityBlackboardVariable abilityBlackboardVariable in variables)
		{
			if (abilityBlackboardVariable != null)
			{
				SetInitialValue(abilityBlackboardVariable.key, abilityBlackboardVariable.valueType, abilityBlackboardVariable.CreateDefaultValue());
			}
		}
	}

	public void Reset()
	{
		Clear();
	}
}
