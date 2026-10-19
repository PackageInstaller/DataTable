namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取加层前技能层数", "Function", new string[] { "before", "add", "ability", "layers", "value", "float", "int" })]
public class BeforeAddAbilityLayers : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		int num = 0;
		if (memory.evt is EvtAddAbilityBeforeAdd evtAddAbilityBeforeAdd)
		{
			num = evtAddAbilityBeforeAdd.stack;
		}
		return num;
	}
}
