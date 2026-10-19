namespace ACT.Battle.Configs;

[AbilityTypeMetadata("献祭生命值值", "Function", new string[] { "sacrifice", "hp", "value", "float", "int" })]
public class SacrificeHpValue : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		if (memory.evt is EvtSacrificeHp evtSacrificeHp)
		{
			return evtSacrificeHp.before - evtSacrificeHp.after;
		}
		return 0f;
	}
}
