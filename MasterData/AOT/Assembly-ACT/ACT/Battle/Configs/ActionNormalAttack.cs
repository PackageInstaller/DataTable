using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行普通攻击", "Action", new string[] { "normal", "attack", "damage", "hit" })]
public class ActionNormalAttack : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtNormalAttack evt = systemAbility.GetEvt<EvtNormalAttack>(memory.owner, memory.ability);
		evt.mainEntity = memory.owner;
		systemAbility.FireEvt(evt);
		systemAbility.ReleaseEvt(evt);
	}
}
