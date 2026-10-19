namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取 Rogue 技能角色索引", "Function", new string[] { "rogue", "skill", "character", "index" })]
public class RogueSkillCharacterIndex : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		int num = 0;
		if (memory.evt is EvtAssistSKill evtAssistSKill)
		{
			num = evtAssistSKill.index;
		}
		return num;
	}
}
