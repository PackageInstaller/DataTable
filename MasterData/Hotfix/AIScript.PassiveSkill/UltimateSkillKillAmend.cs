using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.PassiveSkill;

public class UltimateSkillKillAmend : PassiveSkillBase
{
	private HotfixEnum.skillSlotType skillType = HotfixEnum.skillSlotType.D;

	private FP checkTime = 3;

	private int atkAmendBuffId;

	private bool killMonster;

	private CoroutineNode timeCoroutine;

	protected override void OnSkillEnable()
	{
		killMonster = false;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		StopCoroutine(ref timeCoroutine);
	}

	private void OnCastSkill(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEvent adventureActorCastSkillEvent && !(adventureActorCastSkillEvent.sender as AdventureActor != _actor) && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == skillType)
		{
			StartCoroutine(ref timeCoroutine, Countdown());
		}
	}

	private void OnDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && adventureActorReceiveDamageEvent.from.Id == _actor.Id && adventureActorReceiveDamageEvent.isKill)
		{
			killMonster = true;
		}
	}

	private IEnumerator Countdown()
	{
		killMonster = false;
		yield return _actor.WaitTime(checkTime);
		if (!killMonster)
		{
			_actor.buffComponent.AddBuff(atkAmendBuffId, _actor);
		}
	}
}
