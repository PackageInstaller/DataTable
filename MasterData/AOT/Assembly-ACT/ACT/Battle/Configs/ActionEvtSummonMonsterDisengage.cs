using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行事件怪物Disengage", "Action", new string[] { "evt", "summon", "monster", "disengage" })]
public class ActionEvtSummonMonsterDisengage : ConfigAction
{
	public MemoryEntityRef sendTo;

	public MemoryEntityRef monster;

	public override void Do(ActionMemory memory)
	{
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtSummonMonsterDisengage evt = systemAbility.GetEvt<EvtSummonMonsterDisengage>(memory.owner, memory.ability);
		evt.mainEntity = GetTarget(memory, sendTo);
		evt.monster = GetTarget(memory, monster);
		systemAbility.FireEvt(evt);
		systemAbility.ReleaseEvt(evt);
	}

	private Entity GetTarget(ActionMemory memory, MemoryEntityRef @ref)
	{
		return @ref switch
		{
			MemoryEntityRef.Caster => memory.caster, 
			MemoryEntityRef.Owner => memory.owner, 
			MemoryEntityRef.Target => memory.target.entity, 
		};
	}
}
