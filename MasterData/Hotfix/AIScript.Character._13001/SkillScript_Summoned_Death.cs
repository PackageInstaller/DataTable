namespace AIScript.Character._13001;

public class SkillScript_Summoned_Death : SkillScript_Summoned_SkillBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.PlayDeathAnim();
		MonoSingleton<LuaManager>.Instance.FireEvent("MonsterHUDChange", _actor.Id, (int)(_actor as MonsterAdventureActor).monsterInfo.bloodType, a3: false, _actor.dataID);
	}

	protected override string GetActionTag()
	{
		if (HavePersonalPerk(513004, out var perkLevel))
		{
			if (!HavePersonalPerk(513008, out perkLevel))
			{
				return "B1P04_Boom";
			}
			return "B1P04P08_LargeBoom";
		}
		return "130_Summon_End";
	}

	protected override void OnSkillDisable()
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.eventHashCode = Config_MainControl.eventHashCode_DonutSummonedEvent;
		adventureActorCustomEvent.boolParam = false;
		_summoner?.DispatchEvent(adventureActorCustomEvent);
		base.OnSkillDisable();
	}
}
