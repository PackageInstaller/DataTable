namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改技能时间", "Action", new string[] { "modify", "ability", "time", "skill", "cd" })]
public class ActionModifyAbilityTime : ConfigAction
{
	public DynamicFloat add;

	public DynamicFloat mul;

	public override void Do(ActionMemory memory)
	{
		if (memory.evt is BaseAddAbilityEvt { ability: var ability } baseAddAbilityEvt)
		{
			for (int i = 0; i < ability.Duration.StackCount; i++)
			{
				ability.Duration.SetVal(i, baseAddAbilityEvt.ability.config.fDuration.GetFloat(ability) * (1f + mul.GetFloat(memory.ability)) + add.GetFloat(memory.ability));
			}
		}
	}
}
