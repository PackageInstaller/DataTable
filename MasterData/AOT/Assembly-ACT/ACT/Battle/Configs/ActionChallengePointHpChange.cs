using ACT.Event;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行挑战点生命值", "Action", new string[] { "challenge", "point", "hp", "change", "heal", "recover" })]
public class ActionChallengePointHpChange : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		if (memory.target.entity.TryGetCompAbility(out CompAbility component))
		{
			int maxHP = component.maxHP;
			int hp = component.hp;
			ChallengePointHpChange evt = Singleton<EventManager>.instance.GetEvt<ChallengePointHpChange>();
			float num = (float)hp * 100f / (float)maxHP;
			evt.percent = (int)num;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.ChallengePointHpChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}
}
