using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("取消援护返回", "Action", new string[] { "cancel", "assist", "back" })]
public class ActionCancelAssistBack : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		if (memory.target.entity.IsValid && memory.target.entity.IsCharacter())
		{
			Singleton<GameManager>.instance.ecsManager.systemAssist.CancelAssistBack(memory.target.entity, memory.ability);
		}
	}
}
