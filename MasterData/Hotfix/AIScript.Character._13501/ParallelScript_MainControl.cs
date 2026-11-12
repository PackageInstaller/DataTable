using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13501;

public class ParallelScript_MainControl : ParallelScript
{
	private int summonId = 13500010;

	private int summonInherit = 100;

	private FP summonLeftTime = 15;

	private int maxLiveCount = 4;

	private string bullet_summon = "Bullet_135_Skil_Main_Call_Bullt";

	private string bulletTag_Trace = "trace";

	private string bulletTag_NoTrace = "noTrace";

	private string summonEffect_Trace = "fx_13501_base_P3_PowerUp";

	private DeterministicShape shape = new DeterministicShape
	{
		shapeType = DeterministicShape.ShapeType.Fan,
		innerRadius = 3,
		radius = 4,
		angle = 360
	};

	private DeterministicShape shape2 = new DeterministicShape
	{
		shapeType = DeterministicShape.ShapeType.Circle,
		innerRadius = 1,
		radius = 2
	};

	private int delayFrame = 30;

	private int buff_summon = 13590031;

	private FP interval_summon = 3;

	private int singleSummonCount = 1;

	private int killEvt = CommonHelper.StringToHash("killEvt");

	private int casSkillEvt = CommonHelper.StringToHash("casSkillEvt");

	private const int perkId_1 = 513501;

	private FP reduceCd_1 = 2;

	private const int perkId_2 = 513502;

	private int perkId_3 = 513503;

	private int buff_3 = 13550311;

	private const int perkId_4 = 513504;

	private FP cd_4 = 2.5;

	private const int perkId_6 = 513506;

	private const int shield_6 = 13550601;

	private const int perkId_7 = 513507;

	private const int buff_7 = 13550711;

	private const int perkId_11 = 513511;

	private int cd_11 = 1;

	private const int buff_11 = 13551111;

	private const int perkId_12 = 513512;

	private const int buff_12 = 13551211;

	private const int section_12 = 1;

	private const int perkId_13 = 513513;

	private const int buff_13 = 13551311;

	private Func<LogicEntity, LogicEntity, bool> filter;

	private List<LogicEntity> monsters = new List<LogicEntity>();

	private FP leftTime;

	private int maxCount;

	private List<long> monsterIds = new List<long>();

	private SummonCfg summonCfg = new SummonCfg();

	private List<TSVector2> points = new List<TSVector2>();

	private List<TSVector2> delayPoints = new List<TSVector2>();

	private PlayFX playFx = new PlayFX();

	private CoroutineNode corSummon;

	private CoroutineNode corDelaySummon;

	private CoroutineNode corSetCD;

	private int tempSummonCount;

	private List<AdventureBulletBase> bulletList = new List<AdventureBulletBase>();

	private new PlayerAdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		leftTime = summonLeftTime;
		maxCount = maxLiveCount;
		if (GetPerkLv(513501, out var lv))
		{
			StartCoroutine(ref corSetCD, DoSetCD());
		}
		filter = (LogicEntity a, LogicEntity b) => TSVector2.Distance(a.tsTransform.Position, b.tsTransform.Position) < CommonUtils.GetAttackRange(_actor);
		if (GetPerkLv(513512, out lv))
		{
			SkillInfo skillCD = skillMgr.GetSkillCD(ActionKey.A);
			skillMgr.SetSkillTotalSection(ActionKey.A, skillCD.totalSectionAmount + 1, forceMaxSection: true);
		}
		summonCfg.summonFollowType = SummonFollowType.NotFollow;
		summonCfg.summonAttrType = SummonAttrType.InheritByInitialSnapshot;
		summonCfg.summonRelation = SummonRelation.Independent;
		summonCfg.attrPercent = summonInherit;
		summonCfg.leftTime = leftTime;
		summonCfg.retainWhenCrossLevel = true;
		StartCoroutine(ref corSummon, SummonLogic());
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		StopCoroutine(ref corSummon);
		StopCoroutine(ref corDelaySummon);
		skillMgr.ResetSkillTotalSection(ActionKey.A);
		monsterIds.Clear();
		delayPoints.Clear();
		points.Clear();
		if (corSetCD != null)
		{
			StopCoroutine(corSetCD);
			corSetCD = null;
		}
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		if (evt.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.B || !GetPerkLv(513502, out var _))
		{
			return;
		}
		bulletList.Clear();
		_actor.QueryOwnedAliveBullets(bulletList);
		foreach (AdventureBulletBase bullet in bulletList)
		{
			if (bullet.bulletTag.Equals(bulletTag_NoTrace))
			{
				bullet.Kill();
			}
		}
		tempSummonCount = monsterIds.Count;
		for (int num = monsterIds.Count - 1; num >= 0; num--)
		{
			long num2 = monsterIds.get_Item(num);
			if (num2 != 0L)
			{
				LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(num2);
				if (logicEntity != null && logicEntity is MonsterAdventureActor monsterAdventureActor)
				{
					if (monsterAdventureActor.state != ActorState.Spawn)
					{
						monsterIds.RemoveAt(num);
					}
					else
					{
						tempSummonCount--;
					}
					if (!monsterAdventureActor.inDying && monsterAdventureActor.state != ActorState.Spawn)
					{
						monsterAdventureActor.DestroySelf();
					}
				}
			}
		}
	}

	public override void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		base.OnCastEndSkill(evt);
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.A && GetPerkLv(513512, out var _))
		{
			_actor.buffComponent.AddBuff(13551211, _actor);
			for (int i = 0; i < monsterIds.Count; i++)
			{
				(ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterIds.get_Item(i)) as MonsterAdventureActor)?.buffComponent.AddBuff(13551211, _actor);
			}
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnBeforeHit(evt, monster, isSelf);
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		if (isSelf)
		{
			int lv;
			if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Normal))
			{
				if (GetPerkLv(513511, out lv) && CheckCd(513511, cd_11))
				{
					GetSummonsByFilter(_actor, monsters, filter);
					foreach (LogicEntity monster2 in monsters)
					{
						(monster2 as AdventureActor).buffComponent.AddBuff(13551111, _actor);
					}
				}
			}
			else
			{
				CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MainSkill);
			}
			if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra) && GetPerkLv(513513, out lv) && CommonUtils.CheckElementMark(CommonDefine.Dark, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
			{
				_actor.buffComponent.AddBuff(13551311, _actor);
				monster.buffComponent.RemoveBuffByTag(CommonDefine.Dark);
				monster.buffComponent.AddBuff(buffId_Dark, _actor);
				ILRuntimeAPI.HitActor(_actor, monster, hitDmgId_Dark, hitEffect_Dark);
			}
			if (GetPerkLv(513504, out lv) && CheckCd(513504, cd_4))
			{
				AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent.sender = _actor;
				adventureActorCustomEvent.eventHashCode = casSkillEvt;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
			}
		}
		base.OnHitPost(evt, monster, isSelf);
	}

	public override void OnBattleReady(AdventureBattleReadyEvent evt)
	{
		for (int i = 0; i < monsterIds.Count; i++)
		{
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterIds.get_Item(i));
			if (logicEntity != null)
			{
				shape2.position = mainCtrActor.tsTransform.Position;
				TSVector2 targetPosition = _actor.RandomActorReachablePointInsideShape(shape2);
				(logicEntity as MonsterAdventureActor).Teleport(targetPosition);
			}
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		AdventureBulletFinishEvent adventureBulletFinishEvent = evt as AdventureBulletFinishEvent;
		if (!(_actor != null) || !(adventureBulletFinishEvent.owner is PlayerAdventureActor))
		{
			return;
		}
		if (adventureBulletFinishEvent.tag.Equals(bulletTag_NoTrace))
		{
			if (adventureBulletFinishEvent.finishReason != BulletFinishReason.Kill)
			{
				TSVector2 bulletPosition = adventureBulletFinishEvent.bulletPosition;
				if (monsterIds.Count < maxCount)
				{
					ILRuntimeAPI.SummonMonster(_actor, 0, summonId, bulletPosition, _actor.tsTransform.Forward, summonCfg);
				}
			}
		}
		else if (adventureBulletFinishEvent.tag.Equals(bulletTag_Trace))
		{
			AdventureBulletBase adventureBulletBase = adventureBulletFinishEvent.sender as AdventureBulletBase;
			if (adventureBulletBase != null && adventureBulletBase.target is MonsterAdventureActor monsterAdventureActor)
			{
				monsterAdventureActor.buffComponent.AddBuff(buff_3, monsterAdventureActor);
				monsterAdventureActor.monsterSummonInfo.ResetLeftTime();
				playFx.Play(monsterAdventureActor, summonEffect_Trace, 1f, 0, monsterAdventureActor.tsTransform.Position, monsterAdventureActor.transform.rotation, null, 1.5f);
			}
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (evt.eventHashCode == killEvt && GetPerkLv(513502, out var _))
		{
			shape.position = _actor.tsTransform.Position;
			shape.rotation = _actor.tsTransform.Rotation;
			int num = Math.Min(tempSummonCount, maxCount - monsterIds.Count);
			for (int i = 0; i < num; i++)
			{
				TSVector2 pos = _actor.RandomActorReachablePointInsideShape(shape);
				ILRuntimeAPI.SummonMonster(_actor, 0, summonId, pos, _actor.tsTransform.Forward, summonCfg);
			}
		}
	}

	private IEnumerator SummonLogic()
	{
		FP curTime = interval_summon;
		bool beginSummon = false;
		while (true)
		{
			if (_actor.buffComponent.CheckBuffByBuffID(buff_summon))
			{
				if (!beginSummon)
				{
					beginSummon = true;
					DoSummon();
				}
				if ((curTime <= 0) & beginSummon)
				{
					curTime = interval_summon;
					DoSummon();
				}
				curTime -= _actor.LogicDeltaTime;
			}
			else
			{
				curTime = interval_summon;
				beginSummon = false;
			}
			yield return null;
		}
	}

	private void DoSummon()
	{
		if (singleSummonCount + monsterIds.Count > maxCount)
		{
			if (GetPerkLv(perkId_3, out var _))
			{
				for (int i = 0; i < monsterIds.Count; i++)
				{
					long num = monsterIds.get_Item(i);
					if (num == 0L)
					{
						continue;
					}
					LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(num);
					if (logicEntity != null && logicEntity is MonsterAdventureActor monsterAdventureActor)
					{
						string bulletAlias = bullet_summon;
						AdventureActor actor = _actor;
						LogicEntity target = monsterAdventureActor;
						AdventureBezierBullet adventureBezierBullet = ILRuntimeAPI.Shoot(bulletAlias, actor, default, default, default, default, target, AimType.Target) as AdventureBezierBullet;
						if (adventureBezierBullet != null)
						{
							adventureBezierBullet.isTraceable = true;
							adventureBezierBullet.bulletTag = bulletTag_Trace;
						}
					}
				}
				return;
			}
			int num2 = singleSummonCount + monsterIds.Count - maxCount;
			for (int j = 0; j < num2; j++)
			{
				long num3 = monsterIds.get_Item(0);
				if (num3 == 0L)
				{
					continue;
				}
				LogicEntity logicEntity2 = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(num3);
				if (logicEntity2 != null && logicEntity2 is MonsterAdventureActor monsterAdventureActor2)
				{
					if (monsterAdventureActor2.state != ActorState.Spawn)
					{
						monsterIds.RemoveAt(0);
					}
					if (!monsterAdventureActor2.inDying && monsterAdventureActor2.state != ActorState.Spawn)
					{
						monsterAdventureActor2.DestroySelf();
					}
				}
			}
		}
		if (singleSummonCount + monsterIds.Count <= maxCount)
		{
			shape.position = _actor.tsTransform.Position;
			shape.rotation = _actor.tsTransform.Rotation;
			for (int k = 0; k < singleSummonCount; k++)
			{
				TSVector2 tSVector = _actor.RandomActorReachablePointInsideShape(shape);
				string bulletAlias2 = bullet_summon;
				AdventureActor actor2 = _actor;
				TSVector2 targetPosition = tSVector;
				AdventureBezierBullet obj = ILRuntimeAPI.Shoot(bulletAlias2, actor2, default, default, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget) as AdventureBezierBullet;
				obj.isTraceable = false;
				obj.bulletTag = bulletTag_NoTrace;
			}
		}
	}

	public override void OnSummonSpawned(AdventureMonsterSummonerSpawnedEvent evt)
	{
		base.OnSummonSpawned(evt);
		if (evt.summonerId == _actor.Id && evt.dataId == summonId)
		{
			monsterIds.Add(evt.id);
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(evt.id);
			if (logicEntity != null && logicEntity is MonsterAdventureActor monsterAdventureActor && GetPerkLv(513507, out var _))
			{
				int buffNumByID = _actor.buffComponent.GetBuffNumByID(13550711);
				monsterAdventureActor.buffComponent.AddBuffNum(13550711, buffNumByID, _actor);
			}
		}
	}

	public override void OnMonsterDied(AdventureMonsterDiedEvent evt)
	{
		base.OnMonsterDied(evt);
		if (evt.monsterID == summonId)
		{
			if (monsterIds.Contains(evt.id))
			{
				monsterIds.Remove(evt.id);
			}
			if (GetPerkLv(513506, out var lv))
			{
				mainCtrActor.actorShield.AddShield(13550601, _actor);
			}
			if (GetPerkLv(513507, out lv))
			{
				mainCtrActor.buffComponent.AddBuff(13550711, _actor);
			}
		}
	}

	private IEnumerator DoSetCD()
	{
		yield return null;
		SkillInfo skillCD = skillMgr.GetSkillCD(ActionKey.B);
		skillMgr.ModifyOriginalSectionResumeTime(ActionKey.B, skillCD.originalSectionResumeTime - reduceCd_1);
	}

	private void GetSummonsByFilter(LogicEntity actor, List<LogicEntity> list, Func<LogicEntity, LogicEntity, bool> filter)
	{
		list.Clear();
		for (int i = 0; i < monsterIds.Count; i++)
		{
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterIds.get_Item(i));
			if (logicEntity != null && filter(actor, logicEntity))
			{
				list.Add(logicEntity);
			}
		}
	}
}
