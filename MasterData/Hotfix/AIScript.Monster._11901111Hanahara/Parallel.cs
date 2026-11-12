using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Monster._11901111Hanahara;

public class Parallel : AIBase
{
	public int windMarkTag = CommonHelper.StringToHash("Wind");

	public const string windAreaEffect = "AreaEffect_119_WindMark1_Bloom";

	public int windHitTag = CommonHelper.StringToHash("WindTag1Boom");

	private const string tipsKey_TriggerMark = "WindMark_Trigger_Effect_01";

	private const int perkId_6 = 511906;

	private const int buff_6 = 11950611;

	private const int perkId_43 = 511943;

	private const int parameterId_43 = 11954301;

	protected PlayerAdventureActor summoner;

	public void OnEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent != null)
		{
			summoner = logicComponent.SummonActor as PlayerAdventureActor;
		}
		if (summoner != null)
		{
			if (GetPerkLv(511906, out var lv))
			{
				summoner?.buffComponent.AddBuffNum(11950611, 1, _actor);
			}
			if (GetPerkLv(511943, out lv))
			{
				(_actor as MonsterAdventureActor).monsterSummonInfo.AddLeftTime(CommonUtils.GetScriptValue(_actor, 11954301));
			}
		}
	}

	public void OnDisable()
	{
		if (summoner != null)
		{
			summoner.GetLogicComponent<PlayerSkillCd>();
		}
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		summoner = null;
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (_actor != null && adventureActorCastSkillEvent.sender as AdventureActor == _actor)
		{
			OnCastSkill(adventureActorCastSkillEvent);
		}
	}

	private void OnCastEndSkill(IEvent evt)
	{
		AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent = evt as AdventureActorCastSkillEndEvent;
		if (_actor != null && adventureActorCastSkillEndEvent.sender as AdventureActor == _actor)
		{
			OnCastEndSkill(adventureActorCastSkillEndEvent);
		}
	}

	private void OnReceiveBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (_actor != null && adventureActorReceiveDamageBeforeHitEvent.from.Id == _actor.Id)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeHitEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnBeforeHit(adventureActorReceiveDamageBeforeHitEvent, monsterAdventureActor);
			}
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageEvent.to as MonsterAdventureActor;
		if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.from.Id && monsterAdventureActor != null)
		{
			OnHitPost(adventureActorReceiveDamageEvent, monsterAdventureActor);
		}
	}

	public void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
	}

	public void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
	}

	private void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
	}

	private void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		if (CommonUtils.CheckElementMark(CommonDefine.Wind, monster) && CommonUtils.CheckHitByTag(evt.hitDamageTag, windHitTag))
		{
			TriggerWindMark(monster);
		}
	}

	public void TriggerWindMark(AdventureActor target)
	{
		if (!(summoner == null) && CommonUtils.CheckTriggerElementMarkCD(summoner, target))
		{
			target.buffComponent?.RemoveBuffByTag(CommonDefine.Wind);
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_119_WindMark1_Bloom", target.tsTransform.Position);
			CommonUtils.TriggerElementMarkEvent(CommonDefine.Wind, HotfixEnum.AdventureActorElementTriggerType.WindElementTriggerType2, summoner, target, "WindMark_Trigger_Effect_01");
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		if (summoner == null)
		{
			lv = 0;
			return false;
		}
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(summoner.dataID, perkId, out lv);
	}
}
