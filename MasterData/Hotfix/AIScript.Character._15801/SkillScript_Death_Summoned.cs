using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._15801;

public class SkillScript_Death_Summoned : SkillScript_Summoned
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.PlayDeathAnim();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _summoner;
		adventureActorCustomEvent.eventHashCode = Config.eventHashCode_SummonedDeathFinish;
		AdventureActorCustomEvent adventureActorCustomEvent2 = adventureActorCustomEvent;
		if (adventureActorCustomEvent2.tsVector2ParamList == null)
		{
			adventureActorCustomEvent2.tsVector2ParamList = new List<TSVector2>();
		}
		adventureActorCustomEvent.tsVector2ParamList.Clear();
		adventureActorCustomEvent.tsVector2ParamList.Add(_actor.tsTransform.Position);
		adventureActorCustomEvent.tsVector2ParamList.Add(_actor.tsTransform.Forward);
		adventureActorCustomEvent.tsVector2ParamList.Add(new TSVector2(_actor.dataID, _actor.Id));
		_summoner?.DispatchEvent(adventureActorCustomEvent);
	}
}
