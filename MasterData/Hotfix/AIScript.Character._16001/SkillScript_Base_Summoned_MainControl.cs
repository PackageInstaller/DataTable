using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._16001;

public class SkillScript_Base_Summoned_MainControl : SkillAdvancedBase
{
	protected PlayerAdventureActor _summoner;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent != null)
		{
			_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		}
	}

	protected virtual void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "160_JumpBounce"))
		{
			TriggerBounce();
		}
	}

	protected void TriggerBounce()
	{
		if (!(_summoner == null))
		{
			int num = _actor.logicVariable.GetLogicTagValue("BounceTimes_Summoned").AsInt();
			num++;
			_actor.logicVariable.SetLogicTagValue("BounceTimes_Summoned", num);
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _summoner;
			adventureActorCustomEvent.intParam = num;
			if (adventureActorCustomEvent.tsVector2ParamList == null)
			{
				adventureActorCustomEvent.tsVector2ParamList = new List<TSVector2>();
			}
			else
			{
				adventureActorCustomEvent.tsVector2ParamList.Clear();
			}
			adventureActorCustomEvent.tsVector2ParamList.Add(_actor.tsTransform.Position);
			adventureActorCustomEvent.eventHashCode = Config_MainControl.eventHashCode_Bounce_Summoned;
			_summoner.DispatchEvent(adventureActorCustomEvent);
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_summoner = null;
	}
}
