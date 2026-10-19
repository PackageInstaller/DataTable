using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("触发援护返回", "Action", new string[] { "trigger", "assist", "back", "event", "signal" })]
public class ActionTriggerAssistBack : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		if (memory.target.entity.IsValid && memory.target.entity.IsCharacter())
		{
			Singleton<GameManager>.instance.ecsManager.systemAssist.TriggerAssistBack(memory.target.entity, memory.ability);
		}
	}
}
