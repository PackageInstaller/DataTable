using ACT.Model;
using Runtime.Model;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行Rogue标记技能已使用", "Action", new string[] { "rogue", "mark", "ability", "used" })]
public class ActionRogueMarkAbilityUsed : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		if (memory.ability != null)
		{
			string name = memory.ability.config.name;
			Model<RogueNewModel>.Interface.OnAbilityUsed(name);
		}
	}
}
