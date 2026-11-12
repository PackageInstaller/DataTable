using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11901;

public class ParallelScript : ParallelBase
{
	public int windMarkTag = CommonHelper.StringToHash("Wind");

	public const string windAreaEffect = "AreaEffect_119_WindMark1_Bloom";

	public int windHitTag = CommonHelper.StringToHash("WindTag1Boom");

	private const string tipsKey_TriggerMark = "WindMark_Trigger_Effect_01";

	public int hitTag_Normal = CommonHelper.StringToHash("119NrmAtk");

	public int hitTag_MainSkill = CommonHelper.StringToHash("119Skill1Atk");

	public int hitTag_SupportSkill = CommonHelper.StringToHash("119Skill2Atk");

	public int hitTag_Boom = CommonHelper.StringToHash("119Skill2Boom");

	public int hitTag_Summon = CommonHelper.StringToHash("119FenShen");

	public int skillId_Boomerang = 11940002;

	public int skillId_KnifeFan = 11940004;

	public int skillId_Flower = 11940003;

	private int summonId = 11901111;

	private int summonId_2 = 11901311;

	private int summonCount = 2;

	private FP summonInnerRadius = 1.5;

	private FP summonOuterRadius = 3;

	private int summonInheritPercent = 100;

	private FP summonTime = 25;

	private int summonEvt = CommonHelper.StringToHash("Summon");

	private DeterministicShape shape = new DeterministicShape
	{
		shapeType = DeterministicShape.ShapeType.Circle,
		innerRadius = 2,
		radius = 2
	};

	private const int perkId_6 = 511906;

	private const int buff_6 = 11950611;

	private int perkId_41 = 511941;

	private int once_41 = 11954101;

	private const int perkId_42 = 511942;

	private int buffId_fate2 = 11980211;

	private int buffId_F1 = 11996111;

	private int buffId_F2 = 11996211;

	private int buffId_F3 = 11996311;

	private int buffId_F4 = 11996411;

	private int once_F5 = 11996511;

	public PlayerSkillCd skillMgr;

	private CoroutineNode cor_fate2;

	private SummonCfg summonCfg = new SummonCfg();

	private int finalSumCount;

	private List<long> monsterIds = new List<long>();

	private PlayerAdventureActor mainCtrActor;

	private List<MonsterAdventureActor> delayDestorys = new List<MonsterAdventureActor>();

	private Dictionary<int, FP> perkCd = new Dictionary<int, FP>();

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("HANAHARA_SKILL_SHOOT", OnSkillShoot);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnReceiveDamageBeforeSettlement);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REBIND_SKILL", OnRebindSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDied);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		mainCtrActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		summonCfg.summonAttrType = SummonAttrType.InheritByInitialSnapshot;
		summonCfg.summonRelation = SummonRelation.Independent;
		summonCfg.attrPercent = summonInheritPercent;
		summonCfg.leftTime = summonTime;
		summonCfg.useSummonHit = true;
		summonCfg.summonType = SummonType.None;
		finalSumCount = summonCount;
		if (GetPerkLv(511942, out var _))
		{
			finalSumCount++;
		}
		StartCoroutine(ref cor_fate2, DoAddBuff(buffId_fate2));
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("HANAHARA_SKILL_SHOOT", OnSkillShoot);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnReceiveDamageBeforeSettlement);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REBIND_SKILL", OnRebindSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDied);
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		StopCoroutine(ref cor_fate2);
		monsterIds.Clear();
		perkCd.Clear();
		delayDestorys.Clear();
	}

	public void OnUpdate()
	{
		for (int num = delayDestorys.Count - 1; num >= 0; num--)
		{
			MonsterAdventureActor monsterAdventureActor = delayDestorys.get_Item(num);
			if (monsterAdventureActor != null)
			{
				if (monsterAdventureActor.state != ActorState.Spawn && !monsterAdventureActor.IsDead())
				{
					monsterAdventureActor.DestroySelf();
					delayDestorys.RemoveAt(num);
				}
			}
			else
			{
				delayDestorys.RemoveAt(num);
			}
		}
	}

	private void OnPrefectDodge(IEvent evt)
	{
		AdventurePerfectDodgeTrigger adventurePerfectDodgeTrigger = evt as AdventurePerfectDodgeTrigger;
		if (adventurePerfectDodgeTrigger.actor == _actor)
		{
			OnPrefectDodge(adventurePerfectDodgeTrigger);
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEvent adventureActorCastSkillEvent)
		{
			if (_actor != null && adventureActorCastSkillEvent.sender as AdventureActor == _actor)
			{
				OnCastSkill(adventureActorCastSkillEvent);
			}
			if (adventureActorCastSkillEvent.sender as AdventureActor == SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor)
			{
				OnMainControlCastSkill(adventureActorCastSkillEvent);
			}
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

	private void OnReceiveDamageBeforeSettlement(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeSettlementEvent adventureActorReceiveDamageBeforeSettlementEvent = evt as AdventureActorReceiveDamageBeforeSettlementEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveDamageBeforeSettlementEvent.from.Id)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeSettlementEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnHitPre(adventureActorReceiveDamageBeforeSettlementEvent, monsterAdventureActor);
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
		else if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.to.Id)
		{
			OnHurt(adventureActorReceiveDamageEvent);
		}
	}

	private void OnFinishReload(IEvent evt)
	{
		AdventureActorFinishReload adventureActorFinishReload = evt as AdventureActorFinishReload;
		if (_actor != null && adventureActorFinishReload.sender as AdventureActor == _actor)
		{
			OnFinishReload(adventureActorFinishReload);
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

	private void OnReceiveCrit(IEvent evt)
	{
		AdventureActorReceiveCritDamageEvent adventureActorReceiveCritDamageEvent = evt as AdventureActorReceiveCritDamageEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveCritDamageEvent.from.Id && adventureActorReceiveCritDamageEvent.to as MonsterAdventureActor != null)
		{
			OnCrit(adventureActorReceiveCritDamageEvent);
		}
	}

	private void OnRebindSkill(IEvent _evt)
	{
		if (_evt is AdventurRebindSkill adventurRebindSkill && adventurRebindSkill.sender as AdventureActor == _actor)
		{
			OnRebindSkill(adventurRebindSkill);
		}
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent evt2)
		{
			OnCustomEvent(evt2);
		}
	}

	private void OnBattleReady(IEvent evt)
	{
		AdventureBattleReadyEvent evt2 = evt as AdventureBattleReadyEvent;
		if (_actor != null)
		{
			OnBattleReady(evt2);
		}
	}

	private void OnMonsterDied(IEvent evt)
	{
		AdventureMonsterDiedEvent evt2 = evt as AdventureMonsterDiedEvent;
		if (_actor != null)
		{
			OnMonsterDied(evt2);
		}
	}

	public virtual void OnPrefectDodge(AdventurePerfectDodgeTrigger evt)
	{
	}

	public virtual void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		if (CheckTalentLevel(3) && (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B || evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D))
		{
			_actor.buffComponent.AddBuff(buffId_F3, _actor);
		}
	}

	protected virtual void OnMainControlCastSkill(AdventureActorCastSkillEvent evt)
	{
	}

	public virtual void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
	}

	public virtual void OnHurt(AdventureActorReceiveDamageEvent evt)
	{
	}

	public virtual void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		if (CheckTalentLevel(5) && (monster.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monster.IsBossMonster()))
		{
			AdventureActor.AddFromAttr(once_F5, _actor);
		}
		if (GetPerk(perkId_41) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Summon))
		{
			AdventureActor.AddFromAttr(once_41, _actor);
		}
	}

	public virtual void OnHitPre(AdventureActorReceiveDamageBeforeSettlementEvent evt, MonsterAdventureActor monster)
	{
		if (CheckTalentLevel(4) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Normal))
		{
			_actor.buffComponent.AddBuff(buffId_F4, _actor);
		}
	}

	public virtual void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		if (CommonUtils.CheckElementMark(CommonDefine.Wind, monster) && CommonUtils.CheckHitByTag(evt.hitDamageTag, windHitTag))
		{
			TriggerWindMark(monster);
		}
	}

	public virtual void OnCrit(AdventureActorReceiveCritDamageEvent evt)
	{
	}

	public virtual void OnSkillShoot(IEvent evt)
	{
	}

	public virtual void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (evt.eventHashCode != summonEvt)
		{
			return;
		}
		if (GetPerkLv(511906, out var _))
		{
			_actor.buffComponent.RemoveBuffByBuffId(11950611, monsterIds.Count);
		}
		for (int num = monsterIds.Count - 1; num >= 0; num--)
		{
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterIds.get_Item(num));
			monsterIds.RemoveAt(num);
			if (logicEntity != null && logicEntity is MonsterAdventureActor monsterAdventureActor && !monsterAdventureActor.IsDead())
			{
				if (monsterAdventureActor.state != ActorState.Spawn)
				{
					monsterAdventureActor.DestroySelf();
				}
				else
				{
					delayDestorys.Add(monsterAdventureActor);
				}
			}
		}
		for (int i = 0; i < finalSumCount; i++)
		{
			TSVector2 tSVector = _actor.RandomActorReachablePointInsideRing(_actor.tsTransform.Position, summonInnerRadius, summonOuterRadius);
			TSVector2 dir = _actor.tsTransform.Forward;
			LogicEntity attackTarget = GetAttackTarget();
			if (attackTarget != null)
			{
				dir = (attackTarget.tsTransform.Position - tSVector).normalized;
			}
			int monsterId = summonId;
			if (_actor.skinID == 11903)
			{
				monsterId = summonId_2;
			}
			ILRuntimeAPI.SummonMonster(_actor, 0, monsterId, tSVector, dir, summonCfg, null, (MonsterAdventureActor monster) =>
			{
				monsterIds.Add(monster.Id);
			});
		}
		if (CheckTalentLevel(1))
		{
			_actor.buffComponent.AddBuff(buffId_F1, _actor);
		}
	}

	public virtual void OnBattleReady(AdventureBattleReadyEvent evt)
	{
		for (int num = monsterIds.Count - 1; num >= 0; num--)
		{
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterIds.get_Item(num));
			monsterIds.RemoveAt(num);
			if (logicEntity != null && logicEntity is MonsterAdventureActor monsterAdventureActor && !monsterAdventureActor.IsDead())
			{
				if (monsterAdventureActor.state != ActorState.Spawn)
				{
					monsterAdventureActor.DestroySelf();
				}
				else
				{
					delayDestorys.Add(monsterAdventureActor);
				}
			}
		}
		monsterIds.Clear();
	}

	public virtual void OnMonsterDied(AdventureMonsterDiedEvent evt)
	{
		if ((evt.monsterID == summonId || evt.monsterID == summonId_2) && CheckTalentLevel(1))
		{
			if (monsterIds.Contains(evt.id))
			{
				monsterIds.Remove(evt.id);
			}
			if (monsterIds.Count == 0)
			{
				_actor.buffComponent.RemoveBuffByBuffId(buffId_F1);
			}
		}
	}

	private LogicEntity GetAttackTarget()
	{
		if ((_actor as PlayerAdventureActor).isAssist)
		{
			return CommonUtils.GetAssistantAttackTarget(_actor);
		}
		return _actor.attackTarget;
	}

	public void TriggerWindMark(AdventureActor target)
	{
		if (CommonUtils.CheckTriggerElementMarkCD(_actor, target))
		{
			target.buffComponent?.RemoveBuffByTag(CommonDefine.Wind);
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_119_WindMark1_Bloom", target.tsTransform.Position);
			CommonUtils.TriggerElementMarkEvent(CommonDefine.Wind, HotfixEnum.AdventureActorElementTriggerType.WindElementTriggerType2, _actor, target, "WindMark_Trigger_Effect_01");
			if (CheckTalentLevel(2))
			{
				_actor.buffComponent.AddBuff(buffId_F2, _actor);
			}
		}
	}

	private IEnumerator DoAddBuff(int buffId)
	{
		bool isAdd = false;
		while (true)
		{
			if (_actor.movementState == ActorState.StandBy)
			{
				if (isAdd)
				{
					_actor.buffComponent.RemoveBuffByBuffId(buffId, 1);
					isAdd = false;
				}
			}
			else if (!isAdd)
			{
				isAdd = true;
				_actor.buffComponent.AddBuff(buffId, _actor);
			}
			yield return null;
		}
	}

	public bool CheckCd(int perkId, FP Cd)
	{
		if (Cd <= 0)
		{
			return true;
		}
		bool result = false;
		if (perkCd.TryGetValue(perkId, out var value))
		{
			if (_actor.LogicTime - value > Cd)
			{
				result = true;
				perkCd.set_Item(perkId, _actor.LogicTime);
			}
		}
		else
		{
			perkCd.Add(perkId, _actor.LogicTime);
			result = true;
		}
		return result;
	}

	public bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
