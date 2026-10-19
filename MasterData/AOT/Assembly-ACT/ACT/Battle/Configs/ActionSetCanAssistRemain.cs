namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置援护保留", "Action", new string[] { "set", "can", "assist", "remain" })]
public class ActionSetCanAssistRemain : ConfigAction
{
	public ConfigPredicate[] predicates;

	public bool hideCharacter;

	public ConfigAction[] actions;

	public ConfigAction[] toAfterActions;

	public override void Do(ActionMemory memory)
	{
		if (memory.evt is EvtSetCanRemain evtSetCanRemain)
		{
			bool flag = true;
			ConfigPredicate[] array = predicates;
			foreach (ConfigPredicate configPredicate in array)
			{
				flag &= configPredicate.Check(memory);
			}
			evtSetCanRemain.canRemain = flag;
			evtSetCanRemain.showCharacter = !hideCharacter;
			if (evtSetCanRemain.canRemain)
			{
				SystemAbility.DoActions(memory.caster, memory.owner, FindTargetResult.EntityOnly(memory.owner), memory.evt, memory.ability, actions);
				SystemAbility.DoActions(memory.caster, evtSetCanRemain.after, FindTargetResult.EntityOnly(evtSetCanRemain.after), memory.evt, memory.ability, toAfterActions);
			}
		}
	}
}
