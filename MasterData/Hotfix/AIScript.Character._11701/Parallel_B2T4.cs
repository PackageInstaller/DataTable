using AIScript.Utils;

namespace AIScript.Character._11701;

public class Parallel_B2T4 : Parallel_B2
{
	private static readonly int _attackTag = CommonHelper.StringToHash("117_B2_Hit");

	protected override void OnDamage(IEvent evt)
	{
		base.OnDamage(evt);
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(adventureActorReceiveDamageEvent.from != _actor) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, _attackTag) && adventureActorReceiveDamageEvent.isKill)
		{
			(_actor as PlayerAdventureActor).playerSkillCd.AddSkillSection(ActionKey.B);
			_actor.logicVariable.ToggleLogicTag("SkillDoubleAttack", value: true);
		}
	}
}
