using ACT.Config;
using ACT.Core;
using ACT.Model;
using Runtime.Model;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断Rogue技能使用限制", "Predicate", new string[] { "check", "rogue", "ability", "use", "limit", "predicate", "condition" })]
public class CheckRogueAbilityUseLimit : ConfigPredicate
{
	public string abName;

	private int useLimit;

	public override bool Check(ActionMemory memory)
	{
		string text = ((!string.IsNullOrEmpty(abName)) ? abName : memory.ability?.config?.name);
		int num = Model<RogueNewModel>.Interface.CheckAbilityUsed(text);
		CombatEffect data = CoreUtils.GetData(memory.ability.skillLevelInfo.id, RuntimeConfigs.data.combatEffects);
		if (data != null)
		{
			int maxTriggerCount = data.maxTriggerCount;
			useLimit = maxTriggerCount;
		}
		return num < useLimit;
	}
}
