using System.Collections.Generic;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("PredicateAction", "Action", new string[] { })]
public class PredicateAction : ConfigAction
{
	public ConfigPredicate[] predicates = new ConfigPredicate[0];

	public ConfigAction[] onTrue;

	public ConfigAction[] onFalse;

	protected override AbilityAuth defaultAuth => AbilityAuth.Both;

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, onTrue, ab);
		ConfigAbility.CacheActionList(list, onFalse, ab);
	}

	public override void Do(ActionMemory memory)
	{
		ConfigPredicate[] array = predicates;
		foreach (ConfigPredicate configPredicate in array)
		{
			if (configPredicate.Inverse ? configPredicate.Check(memory) : (!configPredicate.Check(memory)))
			{
				SystemAbility.DoActions(memory, onFalse);
				return;
			}
		}
		SystemAbility.DoActions(memory, onTrue);
	}
}
