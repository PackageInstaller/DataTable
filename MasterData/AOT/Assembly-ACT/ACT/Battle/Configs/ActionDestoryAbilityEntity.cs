using ACT.Event;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行销毁技能实体", "Action", new string[] { "destory", "ability", "entity", "skill", "cd" })]
public class ActionDestoryAbilityEntity : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		if (memory.target.entity.IsMonster())
		{
			memory.target.entity.SetTrigger("trap_die");
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.TrapKillMonster, null);
		}
		memory.target.entity.KillEntity();
	}
}
