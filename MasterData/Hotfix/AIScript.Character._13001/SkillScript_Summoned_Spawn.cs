using AIScript.Utils;

namespace AIScript.Character._13001;

public class SkillScript_Summoned_Spawn : SkillScript_Summoned_SkillBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		(_actor as MonsterAdventureActor).ShowBlood(isShow: false);
		if (HavePersonalPerk(513004, out var perkLevel))
		{
			_actor.buffComponent?.AddBuff(13004011, _actor);
		}
		if (HavePersonalPerk(513008, out perkLevel))
		{
			_actor.buffComponent?.AddBuff(13008011, _actor);
		}
		if (_summoner != null && CommonUtils.HavePersonalPerk(_summoner.dataID, 513010, out perkLevel))
		{
			_actor.actorShield.AddShield(13010001, _summoner);
		}
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.eventHashCode = Config_MainControl.eventHashCode_DonutSummonedEvent;
		adventureActorCustomEvent.boolParam = true;
		_summoner?.DispatchEvent(adventureActorCustomEvent);
	}

	protected override string GetActionTag()
	{
		if (HavePersonalPerk(513008, out var _))
		{
			return "Born_Skill_P08_Large";
		}
		return "Born_Skill";
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		(_actor as MonsterAdventureActor).ShowBlood(isShow: true);
		_actor.Action(makeThreatAlert: false);
	}
}
