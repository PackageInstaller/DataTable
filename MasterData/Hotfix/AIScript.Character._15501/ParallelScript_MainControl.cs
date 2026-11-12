using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._15501;

public class ParallelScript_MainControl : ParallelScript
{
	private class SkillContext
	{
		public int hitCount;
	}

	public int hitTag_Boom = CommonHelper.StringToHash("155_P03");

	private int summonInherit_L = 100;

	private FP summonLeftTime_L = -1;

	private int summonId_LW = 15510011;

	private int summonId_LB = 15510021;

	private FP angleRange = 180;

	private FP angleOffset = 0;

	private FP innerRange_trace = 3;

	private FP outerRange_trace = 4;

	private string orbit_base = "Orbit_15501_Main_Skill";

	private int summonId_BW = 15531011;

	private int summonId_BB = 15531021;

	private string bullet_LB_B = "Bullet_15501_Summon_Missile_P09_2";

	private int bullet_LB_TagA = CommonHelper.StringToHash("LB_TagA");

	private string bullet_BB_B = "Bullet_15501_Summon_Missile_P09_2";

	private int bullet_BB_TagA = CommonHelper.StringToHash("BB_TagA");

	private int summonEvt = CommonHelper.StringToHash("summonEvt");

	private int clearEvt = CommonHelper.StringToHash("clearEvt");

	private string markEffect = "Actor/Character/15501/Fx/fx_15501_Base_Skill_Main_Lock";

	private FP fxAngleThreshold = 20;

	private FP fxAngleThreshold2 = 30;

	private FP fxCd = 0.5;

	private float fadeTime = 0.5f;

	private int showOrHideIdleEvt = CommonHelper.StringToHash("showOrHideIdleEvt");

	private const int perkId_1 = 515501;

	private int buffId_1 = 15501011;

	private int maxCount_1 = 20;

	private const int hitDmgId_1 = 155310101;

	private const string hitEffect_1 = "fx_15501_Base_Skill_Mail_Summon_1_boom";

	private FP delayTime_1 = 0;

	private const int perkId_2 = 515502;

	private int buffId_2 = 15501011;

	private int maxCount_2 = 20;

	private const int hitDmgId_2 = 155310101;

	private const string hitEffect_2 = "fx_15501_Base_Skill_Mail_Summon_1_boom";

	private FP delayTime_2 = 0;

	private FP addLeftTime_2 = 1.85;

	private int perkId_3 = 515503;

	private int buffId_3 = 15503011;

	private int once_3 = 15503011;

	private int perkId_4 = 515504;

	private int buffId_4 = 15503011;

	private int once_4 = 15503011;

	private int perkId_5 = 515505;

	private int once_5 = 15505001;

	private int perkId_6 = 515506;

	private int once_6 = 15506001;

	private string orbit_6 = "Orbit_15501_Main_Skill_P06";

	private int perkId_7 = 515507;

	private int buff_7 = 15507011;

	private int once_7 = 15507001;

	private int perkId_8 = 515508;

	private int once_8 = 15508001;

	private int paramId_8_maxCount = 15508011;

	private int perkId_9 = 515509;

	private int radius_9 = 20;

	private int split_9 = 3;

	private FP cd_9 = 1;

	private int perkId_10 = 515510;

	private int buff_10 = 15510011;

	private int once_10 = 15510001;

	private int perkId_11 = 515511;

	private int buff_11 = 15511011;

	private int once_11 = 15511001;

	private FP radius_11 = 4;

	private int perkId_12 = 515512;

	private int buff_12 = 15512011;

	private int perkId_13 = 515513;

	private int once_13 = 15513001;

	private FP hp_13 = 0.5;

	private SkillContext curContext;

	private SkillContext lastContext;

	private SummonCfg summonCfg = new SummonCfg();

	private List<MonsterAdventureActor> monsters = new List<MonsterAdventureActor>();

	private List<LogicEntity> entities = new List<LogicEntity>();

	private Dictionary<long, FP> dicMonsterCd = new Dictionary<long, FP>();

	private PlayFX playFX_Mark = new PlayFX();

	private HashSet<long> hashMonster = new HashSet<long>();

	private FP _delayTime_1;

	private FP _delayTime_2;

	private bool isInSkill;

	private TSVector2 lastInput;

	private TSVector2 lastForward;

	private FP curTime;

	private bool showFx;

	private int _orbitCount;

	private float curScale;

	public int orbitCount
	{
		get
		{
			return _orbitCount;
		}
		set
		{
			_orbitCount = value;
			_actor.logicVariable.SetLogicTagValue("obritCount", _orbitCount);
		}
	}

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("PLAYER_SPAWN_COMPLETE", OnMainPlayerSpawn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("SPECIAL_ENTITY_BEGIN", OnSpecialEntitySpawn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("SPECIAL_ENTITY_FINISH", OnSpecialEntityFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonSpawned);
		summonCfg.summonFollowType = SummonFollowType.NotFollow;
		summonCfg.summonAttrType = SummonAttrType.InheritByInitialSnapshot;
		summonCfg.summonRelation = SummonRelation.Coexisted;
		summonCfg.retainWhenCrossLevel = false;
		summonCfg.useSummonHit = true;
		summonCfg.summonType = SummonType.None;
		_delayTime_2 = (_delayTime_1 = 0);
		curTime = 0;
		showFx = true;
		orbitCount = 0;
		curContext = new SkillContext();
		lastContext = new SkillContext();
		if (GetPerk(perkId_12))
		{
			global::SkillInfo skillCD = skillMgr.GetSkillCD(ActionKey.A);
			skillMgr.SetSkillTotalSection(ActionKey.A, skillCD.originalTotalSectionAmount + 1, forceMaxSection: true);
		}
		playFX_Run1.Play(_actor, runEffect1, 1f, _actor.transform.position, _actor.transform.rotation);
		playFX_Run.Play(_actor, runEffect, 1f, _actor.transform.position, _actor.transform.rotation);
		curScale = playFX_Run.fxInstance.sizeScale;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("PLAYER_SPAWN_COMPLETE", OnMainPlayerSpawn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("SPECIAL_ENTITY_BEGIN", OnSpecialEntitySpawn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("SPECIAL_ENTITY_FINISH", OnSpecialEntityFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonSpawned);
		monsters.Clear();
		entities.Clear();
		skillMgr.ResetSkillTotalSection(ActionKey.A);
		hashMonster.Clear();
		dicMonsterCd.Clear();
	}

	public void OnUpdate()
	{
		if (!showFx)
		{
			return;
		}
		if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget)
		{
			TSVector2 movementInputDirection = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
			if (movementInputDirection != TSVector2.zero)
			{
				FP fP = TSVector2.Angle(_actor.tsTransform.Forward, movementInputDirection);
				FP fP2 = 0.35 + 1.2999999999999998 * TSMath.Abs(TSMath.Sin(fP * TSMath.Deg2Rad));
				if (lastInput != TSVector2.zero)
				{
					if (TSVector2.Angle(lastInput, movementInputDirection) > fxAngleThreshold)
					{
						playFX_Run.Stop();
						curTime = _actor.LogicTime;
					}
					else if (_actor.LogicTime - curTime > fxCd)
					{
						curScale = Mathf.Lerp(curScale, fP2.AsFloat() * defaultScale, fadeTime);
						if (!playFX_Run.isPlaying)
						{
							playFX_Run.Play(_actor, runEffect, 1f, _actor.transform.position, _actor.transform.rotation);
						}
						if (playFX_Run.fxInstance != null)
						{
							playFX_Run.fxInstance.sizeScale = Mathf.Lerp(playFX_Run.fxInstance.sizeScale, fP2.AsFloat() * defaultScale, fadeTime);
						}
					}
				}
				else
				{
					playFX_Run.Stop();
				}
			}
			if (TSVector2.Angle(lastForward, _actor.tsTransform.Forward) > fxAngleThreshold2)
			{
				playFX_Run.Stop();
				curTime = _actor.LogicTime;
			}
			else if (_actor.LogicTime - curTime > fxCd)
			{
				if (!playFX_Run.isPlaying)
				{
					playFX_Run.Play(_actor, runEffect, 1f, _actor.transform.position, _actor.transform.rotation);
				}
				if (playFX_Run.fxInstance != null)
				{
					playFX_Run.fxInstance.sizeScale = curScale;
				}
			}
			lastInput = movementInputDirection;
			lastForward = _actor.tsTransform.Forward;
		}
		else if (playFX_Run.fxInstance != null)
		{
			curScale = Mathf.Lerp(curScale, defaultScale * 0.35f, fadeTime);
			if (!playFX_Run.isPlaying)
			{
				playFX_Run.Play(_actor, runEffect, 1f, _actor.transform.position, _actor.transform.rotation);
			}
			if (playFX_Run.fxInstance != null)
			{
				playFX_Run.fxInstance.sizeScale = curScale;
			}
		}
	}

	private void OnMainPlayerSpawn(IEvent evt)
	{
		if (evt is AdventurePlayeSpawnCompleteEvent)
		{
			summonCfg.attrPercent = summonInherit_L;
			summonCfg.leftTime = summonLeftTime_L;
			FP angle = _actor.tsTransform.Forward.GetAngle();
			FP angleBase = ((1 != 0) ? (angle + angleOffset) : (angle - angleOffset));
			TSVector2 pos = TrueSyncExtensions.RandomPointInsideFan(_actor.tsTransform.Position, innerRange_trace, outerRange_trace, angleBase, angleRange);
			ILRuntimeAPI.SummonMonster(_actor, 0, summonId_LW, pos, _actor.tsTransform.Forward, summonCfg);
			angleBase = (false ? (angle + angleOffset) : (angle - angleOffset));
			pos = TrueSyncExtensions.RandomPointInsideFan(_actor.tsTransform.Position, innerRange_trace, outerRange_trace, angleBase, angleRange);
			ILRuntimeAPI.SummonMonster(_actor, 0, summonId_LB, pos, _actor.tsTransform.Forward, summonCfg);
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnBeforeHit(evt, monster, isSelf);
		AdventureActor adventureActor = evt.from as AdventureActor;
		if (!isSelf)
		{
			return;
		}
		if (GetPerk(perkId_3) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Boom))
		{
			int buffNumByID = adventureActor.buffComponent.GetBuffNumByID(buffId_3);
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(once_3, adventureActor, buffNumByID);
			}
		}
		if (GetPerk(perkId_4) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Boom))
		{
			int buffNumByID2 = adventureActor.buffComponent.GetBuffNumByID(buffId_4);
			if (buffNumByID2 > 0)
			{
				AdventureActor.AddFromAttr(once_4, adventureActor, buffNumByID2);
			}
		}
		if (GetPerk(perkId_5) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_LW))
		{
			AdventureActor.AddFromAttr(once_5, adventureActor);
		}
		if (GetPerk(perkId_6) && isInSkill && (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_BW) || CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_LW)))
		{
			AdventureActor.AddFromAttr(once_6, adventureActor);
		}
		if (GetPerk(perkId_7) && _actor.buffComponent.CheckBuffByBuffID(buff_7) && (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_BW) || CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_LW) || CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Boom_1) || CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Boom_2)))
		{
			int buffNumByID3 = _actor.buffComponent.GetBuffNumByID(buff_7);
			AdventureActor.AddFromAttr(once_7, adventureActor, buffNumByID3);
		}
		if (GetPerk(perkId_8) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_LB))
		{
			int val = CommonUtils.GetScriptValue(_actor, paramId_8_maxCount).AsInt();
			AdventureActor.AddFromAttr(once_8, adventureActor, Math.Min(lastContext.hitCount, val));
		}
		if (GetPerk(perkId_10) && isInSkill && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_BB))
		{
			AdventureActor.AddFromAttr(once_10, adventureActor);
		}
		if (GetPerk(perkId_11))
		{
			CommonUtils.SearchNearTargetsByCircle(_actor, radius_11, isConfront: true, includeSelf: false, entities);
			if (entities.Count == 0)
			{
				AdventureActor.AddFromAttr(once_11, adventureActor);
			}
		}
		if (GetPerk(perkId_13) && monster.actorHealthInfo.hpPercentage < hp_13)
		{
			AdventureActor.AddFromAttr(once_13, adventureActor);
		}
	}

	public override void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPre(evt, monster, isSelf);
		AdventureActor adventureActor = evt.from as AdventureActor;
		if (!isSelf)
		{
			return;
		}
		if (GetPerk(perkId_3) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_LB_Berize_P3))
		{
			adventureActor.buffComponent.AddBuff(buffId_3, adventureActor);
		}
		if (GetPerk(perkId_4) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_BB_Berize_P4))
		{
			adventureActor.buffComponent.AddBuff(buffId_4, adventureActor);
		}
		if (GetPerk(perkId_8) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_LB) && !hashMonster.Contains(monster.Id))
		{
			curContext.hitCount = ++curContext.hitCount;
			hashMonster.Add(monster.Id);
		}
		if (!GetPerk(perkId_9) || !(evt.weapon != null) || !(evt.weapon is AdventureBulletBase adventureBulletBase))
		{
			return;
		}
		if (adventureBulletBase.BulletHashCode == bullet_LB_TagA)
		{
			if (!dicMonsterCd.TryGetValue(monster.Id, out var value))
			{
				dicMonsterCd.Add(monster.Id, _actor.LogicTime);
				ShootSplit(bullet_LB_B, monster);
			}
			else if (_actor.LogicTime - value > cd_9)
			{
				ShootSplit(bullet_LB_B, monster);
				dicMonsterCd.set_Item(monster.Id, _actor.LogicTime);
			}
		}
		else if (adventureBulletBase.BulletHashCode == bullet_BB_TagA)
		{
			if (!dicMonsterCd.TryGetValue(monster.Id, out var value2))
			{
				dicMonsterCd.Add(monster.Id, _actor.LogicTime);
				ShootSplit(bullet_BB_B, monster);
			}
			else if (_actor.LogicTime - value2 > cd_9)
			{
				ShootSplit(bullet_BB_B, monster);
				dicMonsterCd.set_Item(monster.Id, _actor.LogicTime);
			}
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		_ = evt.from;
		if (!isSelf)
		{
			return;
		}
		if (GetPerk(515501) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Boom_1))
		{
			if (_actor.LogicTime - _delayTime_1 > delayTime_1)
			{
				monster.buffComponent.AddBuff(buffId_1, _actor);
			}
			if (monster.buffComponent.GetBuffNumByID(buffId_1) >= maxCount_1)
			{
				monster.buffComponent.RemoveBuffByBuffId(buffId_1);
				ILRuntimeAPI.HitActor(_actor, monster, 155310101, "fx_15501_Base_Skill_Mail_Summon_1_boom");
				_delayTime_1 = _actor.LogicTime;
			}
		}
		if (GetPerk(515502) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Boom_2))
		{
			if (_actor.LogicTime - _delayTime_2 > delayTime_2)
			{
				monster.buffComponent.AddBuff(buffId_2, _actor);
			}
			if (monster.buffComponent.GetBuffNumByID(buffId_2) >= maxCount_2)
			{
				monster.buffComponent.RemoveBuffByBuffId(buffId_2);
				ILRuntimeAPI.HitActor(_actor, monster, 155310101, "fx_15501_Base_Skill_Mail_Summon_1_boom");
				_delayTime_2 = _actor.LogicTime;
			}
		}
	}

	public override void OnTriggerMasked(AdventureActor actor)
	{
		base.OnTriggerMasked(actor);
		if (GetPerk(perkId_7))
		{
			_actor.buffComponent.AddBuff(buff_7, _actor);
		}
		if (GetPerk(perkId_12))
		{
			_actor.buffComponent.AddBuff(buff_12, _actor);
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		base.OnCustomEvent(evt);
		if (evt.eventHashCode == summonEvt)
		{
			if (_actor.attackTarget != null)
			{
				playFX_Mark.Play(_actor.attackTarget as AdventureActor, markEffect, 1f, _actor.attackTarget.transform.position, _actor.attackTarget.transform.rotation);
				string alias = (GetPerk(perkId_6) ? orbit_6 : orbit_base);
				GameObject fXByAlias = _actor.comboGroup.relatedResourceConfig.GetFXByAlias(alias);
				SceneSingleton<SpecialEntityManager>.Instance.PlaySpecialProcess(_actor, fXByAlias, _actor.attackTarget.transform.position, Quaternion.identity);
			}
		}
		else if (evt.eventHashCode == clearEvt)
		{
			hashMonster.Clear();
			lastContext.hitCount = curContext.hitCount;
			curContext.hitCount = 0;
		}
		else if (evt.eventHashCode == showOrHideIdleEvt)
		{
			bool flag = (showFx = evt.boolParam);
			curScale = defaultScale * 0.35f;
			curTime = _actor.LogicTime;
			if (!flag)
			{
				playFX_Run.Stop();
				playFX_Run1.Stop();
			}
			else
			{
				playFX_Run1.Play(_actor, runEffect1, 1f, _actor.transform.position, _actor.transform.rotation);
			}
		}
	}

	private void OnSpecialEntitySpawn(IEvent evt)
	{
		if (evt is SpecialEntityBeginEvent { entity: OrbitEntity entity })
		{
			orbitCount++;
			isInSkill = true;
			if (GetPerk(perkId_11))
			{
				_actor.buffComponent.AddBuff(buff_11, _actor);
			}
			if (GetPerk(515502))
			{
				entity.AddLeftTime(addLeftTime_2);
			}
		}
	}

	private void OnSpecialEntityFinish(IEvent evt)
	{
		if (evt is SpecialEntityFinishEvent specialEntityFinishEvent && specialEntityFinishEvent.entity is OrbitEntity)
		{
			orbitCount--;
			isInSkill = false;
			if (GetPerk(perkId_11))
			{
				_actor.buffComponent.RemoveBuffByBuffId(buff_11);
			}
		}
	}

	private void ShootSplit(string bullet, MonsterAdventureActor monster)
	{
		CommonUtils.SearchNearTargetsByCircle(monster, monster.tsTransform.Position, radius_9, isConfront: false, includeSelf: false, entities);
		if (entities.Count <= 0)
		{
			return;
		}
		int num = Math.Min(entities.Count, split_9);
		for (int i = 0; i < num; i++)
		{
			LogicEntity logicEntity = entities.get_Item(i);
			if (!logicEntity.IsSearchedImmunity())
			{
				TSVector2 position = monster.tsTransform.Position;
				AdventureActor actor = _actor;
				TSVector2 position2 = logicEntity.tsTransform.Position;
				ILRuntimeAPI.Shoot(bullet, actor, default, position, default, position2, null, AimType.Position, BulletDirectionType.BulletToTarget);
			}
		}
	}

	public override void OnAnimatorStateEnter(AdventureActorAnimatorStateEnterEvent evt)
	{
	}

	private void OnSummonSpawned(IEvent evt)
	{
		if (evt is AdventureMonsterSummonerSpawnedEvent adventureMonsterSummonerSpawnedEvent && adventureMonsterSummonerSpawnedEvent.dataId == summonId_BB && GetPerk(perkId_10))
		{
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(adventureMonsterSummonerSpawnedEvent.id);
			if (logicEntity != null && logicEntity is MonsterAdventureActor monsterAdventureActor)
			{
				monsterAdventureActor.buffComponent.AddBuff(buff_10, _actor);
			}
		}
	}
}
