using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._15901;

public class ParallelScript_MainControl : ParallelScript
{
	private int hitTag_P4 = CommonHelper.StringToHash("159_P04");

	private int hitTag_P4_Bomb = CommonHelper.StringToHash("159_GroundHit");

	private FP angleRange = 180;

	private FP angleOffset = 0;

	private FP innerRange_trace = 6;

	private FP outerRange_trace = 8;

	private int summonId = 15900011;

	private int summonInherit = 100;

	private FP summonLeftTime = 8;

	private int summonCount = 1;

	private int summonEvt = CommonHelper.StringToHash("summonEvt");

	private string laserPath = "Crystal_Ray1";

	private int castLaser = CommonHelper.StringToHash("castLaser");

	private int buff_Crystal = 15900001;

	private FP crystalTime = 8;

	private int bulletTag = CommonHelper.StringToHash("159_NormalBullet");

	private const string weaponTag = "p5_bullet";

	private List<TSVector2> offsets = new List<TSVector2>
	{
		new TSVector2(5, 3),
		new TSVector2(-5, 3),
		new TSVector2(0, 9)
	};

	public FP searchRange = 20;

	private const int perkId_1 = 515901;

	private string laserPath_1 = "Crystal_Ray2";

	private FP damageImmuneDurationPer_1 = 0.25;

	private FP damageImmuneDurationPer_1_2 = 0.5;

	private int perkId_2 = 515902;

	private string laserPath_1_2 = "Crystal_Ray3";

	private string laserPath_2 = "Crystal_Ray1_Self";

	private string laserPath_2_1 = "Crystal_Ray3_Self";

	private int count_2 = 1;

	private FP delayLink = 0.2;

	private int perkId_3 = 515903;

	private int ammoMaxCount_3 = 30;

	private int perkId_4 = 515904;

	private string areaEffect_4_A = "AreaEffect_15901_SkillMain_Impluse_Perk04";

	private string areaEffect_4_B = "AreaEffect_15901_SkillMain_Ground_Perk04";

	private string areaEffect_4_B_Hit = "AreaEffect_15901_SkillMain_GroundHit_Perk04";

	private string areaTag_4_B = "159_Ground_P4";

	private int count_4 = 4;

	private int countOnce_4 = 1;

	private FP delay_4 = 0.3f;

	private int once_4 = 15904011;

	private int areaTag_4_B_Hit = CommonHelper.StringToHash("areaTag_4_B_Hit");

	private int perkId_5 = 515905;

	private int once_5 = 15905001;

	private int once_5_2 = 15905002;

	private int perkId_6 = 515906;

	private int buff_6 = 15906011;

	private int once_6 = 15906001;

	private int perkId_7 = 515907;

	private FP addTime_7 = 0.5;

	private int paramId_7_maxTime = 15907001;

	private int perkId_8 = 515908;

	private int buff_8;

	private FP distance_8 = 6f;

	private int once_8 = 15908001;

	private int perkId_9 = 515909;

	private int buff_9 = 15909011;

	private int perkId_10 = 515910;

	private FP extendTime_10 = 0.6f;

	private FP maxExtend_10 = 3;

	private int perkId_11 = 515911;

	private int buff_11 = 15911011;

	private int perkId_12 = 515912;

	private int buff_12 = 15912011;

	private int perkId_13 = 515913;

	private int once_13 = 15913001;

	private string bullet_13_1 = "Bullet_15901_NormalAttack_Perk05_Grade1";

	private string bullet_13_2 = "Bullet_15901_NormalAttack_Perk05_Grade2";

	private string bullet_13_3 = "Bullet_15901_NormalAttack_Perk05_Grade3";

	private string bullet_13_P3_1 = "Bullet_15901_NormalAttack_Perk05Perk03_Grade1";

	private string bullet_13_P3_2 = "Bullet_15901_NormalAttack_Perk05Perk03_Grade2";

	private string bullet_5_P3_3 = "Bullet_15901_NormalAttack_Perk05Perk03_Grade3";

	private FP offsetY = 1.975;

	private SummonCfg summonCfg = new SummonCfg();

	private CoroutineNode corCrystal;

	private int curCount_4;

	private FP totleTime_7;

	private List<MonsterAdventureActor> monsters = new List<MonsterAdventureActor>();

	private List<LaserEntity> lasers = new List<LaserEntity>();

	private int curCount_10;

	private FP extralTime;

	private Dictionary<long, FP> dicCastTime = new Dictionary<long, FP>();

	private int shootEvent = CommonHelper.StringToHash("shootEvent");

	private int orginAmmoMaxCount;

	private Dictionary<long, bool> dicAreaB = new Dictionary<long, bool>();

	private long uuid;

	private Dictionary<long, List<MonsterAdventureActor>> dicMonsterGroup = new Dictionary<long, List<MonsterAdventureActor>>();

	private Dictionary<long, CoroutineNode> dicCor = new Dictionary<long, CoroutineNode>();

	private AreaEffectEntity areaEffect_4;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEnterOrExit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_BORN", OnBulletBorn);
		_actor.logicVariable.ToggleLogicTag("InCrystal", value: false);
		extralTime = 0;
		totleTime_7 = 0;
		uuid = 0L;
		curCount_4 = 0;
		curCount_10 = 0;
		summonCfg.summonFollowType = SummonFollowType.NotFollow;
		summonCfg.summonAttrType = SummonAttrType.InheritByInitialSnapshot;
		summonCfg.summonRelation = SummonRelation.Independent;
		summonCfg.attrPercent = summonInherit;
		summonCfg.leftTime = summonLeftTime;
		summonCfg.retainWhenCrossLevel = false;
		summonCfg.useSummonHit = true;
		summonCfg.summonType = SummonType.None;
		if (GetPerk(perkId_12))
		{
			SkillInfo skillCD = skillMgr.GetSkillCD(ActionKey.A);
			skillMgr.SetSkillTotalSection(ActionKey.A, skillCD.originalTotalSectionAmount + 1, forceMaxSection: true);
		}
		orginAmmoMaxCount = _actor.ammoInfo.ammoCountMax;
		if (GetPerk(perkId_3))
		{
			_actor.ammoInfo.SetOriginIntValue(HotfixEnum.AmmoType.Main, ammoMaxCount_3, 1);
			_actor.ammoInfo.ammoCount = _actor.ammoInfo.ammoCountMax;
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEnterOrExit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BORN", OnBulletBorn);
		dicMonsterGroup.Clear();
		foreach (CoroutineNode value in dicCor.Values)
		{
			StopCoroutine(value);
		}
		dicCor.Clear();
		StopCoroutine(ref corCrystal);
		skillMgr.ResetSkillTotalSection(ActionKey.A);
		monsters.Clear();
		lasers.Clear();
		dicCastTime.Clear();
		_actor.ammoInfo.SetOriginIntValue(HotfixEnum.AmmoType.Main, orginAmmoMaxCount, 1);
		dicAreaB.Clear();
		areaEffect_4 = null;
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		if (evt.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.B)
		{
			return;
		}
		foreach (MonsterAdventureActor monster in monsters)
		{
			monster.DestroySelf(forceDestory: true);
		}
		monsters.Clear();
		StartCoroutine(ref corCrystal, DoEnterCystal());
	}

	public override void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		base.OnCastEndSkill(evt);
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.A && GetPerk(perkId_12))
		{
			_actor.buffComponent.AddBuff(buff_12, _actor);
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnBeforeHit(evt, monster, isSelf);
		AdventureActor fromActor = evt.from as AdventureActor;
		if (!isSelf)
		{
			return;
		}
		if (GetPerk(perkId_5) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS))
		{
			AdventureActor.AddFromAttr(GetPerk(perkId_2) ? once_5_2 : once_5, fromActor);
		}
		if (GetPerk(perkId_4) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_P4_Bomb) && evt.areaEffectId != 0L)
		{
			AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(evt.areaEffectId);
			if (areaEffect != null && areaEffect.CheckChildTag(areaTag_4_B_Hit))
			{
				AdventureActor.AddFromAttr(once_4, _actor);
			}
		}
		if (GetPerk(perkId_6) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(buff_6);
			AdventureActor.AddFromAttr(once_6, _actor, buffNumByID);
		}
		if (GetPerk(perkId_8) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Normal) && TSVector2.Distance(_actor.tsTransform.Position, monster.tsTransform.Position) >= distance_8)
		{
			AdventureActor.AddFromAttr(once_8, _actor);
		}
	}

	public override void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPre(evt, monster, isSelf);
		_ = evt.from;
		if (isSelf && GetPerk(perkId_4) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_P4) && curCount_4 < count_4)
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_4_B, monster.tsTransform.Position, default, (AreaEffectEntity entity) =>
			{
				dicCastTime.Add(entity.Id, _actor.LogicTime);
				dicAreaB.Add(entity.Id, value: false);
			});
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		AdventureActor adventureActor = evt.from as AdventureActor;
		if (!isSelf)
		{
			return;
		}
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Normal);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS);
		bool flag3 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra);
		if (flag)
		{
			if (GetPerk(perkId_6))
			{
				_actor.buffComponent.AddBuff(buff_6, _actor);
			}
			if (GetPerk(perkId_9))
			{
				monster.buffComponent.AddBuff(buff_9, _actor);
			}
		}
		else if (!flag2 && flag3 && GetPerk(perkId_11))
		{
			TriggerMask(adventureActor, monster);
		}
	}

	public override void OnTriggerMasked(AdventureActor actor)
	{
		if (GetPerk(perkId_11))
		{
			actor.buffComponent.AddBuff(buff_11, _actor);
		}
		if (GetPerk(perkId_10) && _actor.logicVariable.GetLogicTagToggle("InCrystal") && extralTime < maxExtend_10)
		{
			extralTime += extendTime_10;
			if (areaEffect_4 != null)
			{
				areaEffect_4.AddLeftTime(extendTime_10);
			}
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (evt.eventHashCode == summonEvt)
		{
			long num = ++uuid;
			CoroutineNode value = StartCoroutine(DoSummonLogic(num));
			dicCor.Add(num, value);
		}
		else if (evt.eventHashCode == castLaser)
		{
			MonsterAdventureActor form = evt.target as MonsterAdventureActor;
			bool perk = GetPerk(515901);
			bool perk2 = GetPerk(perkId_2);
			GetPerk(perkId_3);
			string text = (perk ? laserPath_1 : laserPath);
			if (perk & perk2)
			{
				text = laserPath_1_2;
			}
			CastLaser(form, text);
		}
		else
		{
			_ = evt.eventHashCode;
			_ = shootEvent;
		}
	}

	public override void OnAreaEffectBegin(AdventureAreaEffectBeginEvent evt)
	{
		base.OnAreaEffectBegin(evt);
		if (evt.sender as LogicEntity is AreaEffectEntity areaEffectEntity && areaEffectEntity.areaTag.Equals(areaTag_4_B))
		{
			curCount_4++;
		}
	}

	public override void OnAreaEffectFinish(AdventureAreaEffectFinishEvent evt)
	{
		base.OnAreaEffectFinish(evt);
		LogicEntity logicEntity = evt.sender as LogicEntity;
		if (logicEntity is AreaEffectEntity areaEffectEntity && areaEffectEntity.areaTag.Equals(areaTag_4_B))
		{
			curCount_4--;
		}
		if (dicAreaB.TryGetValue(evt.entityID, out var triggerBom))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_4_B_Hit, logicEntity.tsTransform.Position, default, (AreaEffectEntity entity) =>
			{
				entity.RemoveChildTag(areaTag_4_B_Hit);
				if (triggerBom)
				{
					entity.AddChildTag(areaTag_4_B_Hit);
				}
			});
			dicAreaB.Remove(evt.entityID);
		}
		if (logicEntity == areaEffect_4)
		{
			areaEffect_4 = null;
		}
	}

	private IEnumerator DoSummonLogic(long uid)
	{
		totleTime_7 = 0;
		dicMonsterGroup.Add(uid, new List<MonsterAdventureActor>());
		FP angle = _actor.tsTransform.Forward.GetAngle();
		int count = (GetPerk(perkId_2) ? (summonCount + count_2) : summonCount);
		bool finish = false;
		int curCount = 0;
		for (int i = 0; i < count; i++)
		{
			TSVector2 tSVector;
			if (count <= 1)
			{
				int index = TSRandom.Range(0, 2);
				tSVector = _actor.tsTransform.TransformLocalPointToWorldSpace(offsets.get_Item(index));
			}
			else
			{
				tSVector = _actor.tsTransform.TransformLocalPointToWorldSpace(offsets.get_Item(i));
			}
			if (!_actor.QueryPositionReachable(tSVector))
			{
				tSVector = ((!_actor.LinecastNavmeshGraph(_actor.tsTransform.Position, tSVector, out var linecastHitPoint)) ? CommonUtils.RandomReachablePointInsideFan(_actor, _actor.tsTransform.Position, innerRange_trace, outerRange_trace, angle, angleRange) : linecastHitPoint);
			}
			TSVector2 dir = _actor.tsTransform.Forward;
			AdventureActor crystalAttackTarget = GetCrystalAttackTarget(tSVector);
			if (crystalAttackTarget != null && crystalAttackTarget.actorHealthInfo.isAlive)
			{
				dir = (crystalAttackTarget.tsTransform.Position - tSVector).normalized;
			}
			ILRuntimeAPI.SummonMonster(_actor, 0, summonId, tSVector, dir, summonCfg, null, (MonsterAdventureActor entity) =>
			{
				dicMonsterGroup.get_Item(uid).Add(entity);
				curCount++;
				finish = curCount >= count;
			});
		}
		while (!finish)
		{
			yield return null;
		}
		if (!GetPerk(perkId_2) || !dicMonsterGroup.TryGetValue(uid, out var monsters) || monsters.Count <= 1)
		{
			yield break;
		}
		yield return _actor.WaitTime(delayLink);
		string text = (GetPerk(515901) ? laserPath_2_1 : laserPath_2);
		int num = ((monsters.Count <= 2) ? 1 : monsters.Count);
		for (int num2 = 0; num2 < num; num2++)
		{
			MonsterAdventureActor form = monsters.get_Item(num2);
			MonsterAdventureActor atkTarget = monsters.get_Item((num2 + 1) % monsters.Count);
			LaserEntity laserEntity = CastLaser(form, text);
			if (laserEntity != null)
			{
				laserEntity.atkTarget = atkTarget;
			}
		}
	}

	private LaserEntity CastLaser(MonsterAdventureActor form, string laserPath)
	{
		GameObject fXByAlias = _actor.comboGroup.relatedResourceConfig.GetFXByAlias(laserPath);
		LaserEntity laserEntity = SceneSingleton<SpecialEntityManager>.Instance.PlaySpecialProcess(form, fXByAlias, form.transform.position, Quaternion.identity) as LaserEntity;
		if (laserEntity == null)
		{
			return null;
		}
		laserEntity.LeftTime = summonLeftTime;
		if (GetPerk(515901))
		{
			FP fP = (GetPerk(perkId_2) ? damageImmuneDurationPer_1_2 : damageImmuneDurationPer_1);
			laserEntity.DamageImmuneDuration *= 1 - fP;
		}
		if (!monsters.Contains(form))
		{
			monsters.Add(form);
		}
		lasers.Add(laserEntity);
		bool p1 = GetPerk(515901);
		bool p2 = GetPerk(perkId_2);
		bool p3 = GetPerk(perkId_3);
		bool p13 = GetPerk(perkId_13);
		bool p14 = GetPerk(perkId_7);
		if (p13 | p14)
		{
			laserEntity.SetColliderState(enable: true);
			laserEntity.OnCollisionEnter = (LogicEntity other) =>
			{
				if (other is AdventureBullet adventureBullet && adventureBullet.BulletHashCode == bulletTag && !adventureBullet.weaponTag.Equals("p5_bullet"))
				{
					if (p13)
					{
						string empty = string.Empty;
						if (p3)
						{
							empty = bullet_13_P3_1;
							empty = ((!p1) ? bullet_13_P3_1 : bullet_13_P3_2);
						}
						else
						{
							empty = bullet_13_1;
							empty = ((p1 & p2) ? bullet_13_3 : ((!p1) ? bullet_13_1 : bullet_13_2));
						}
						FP leftTime = adventureBullet.GetLeftTime();
						AdventureBullet obj = ILRuntimeAPI.ShootByDirection(empty, _actor, default, adventureBullet.tsTransform.Forward, adventureBullet.tsTransform.Position, offsetY) as AdventureBullet;
						obj.weaponTag = "p5_bullet";
						obj.AddAdditionalAttr(once_13);
						obj.LiftTime = leftTime;
						if (!adventureBullet.isFinished)
						{
							adventureBullet.Finish();
						}
					}
					if (p14)
					{
						FP fP2 = TSMath.Min(CommonUtils.GetScriptValue(_actor, paramId_7_maxTime) - totleTime_7, addTime_7);
						totleTime_7 += fP2;
						foreach (LaserEntity laser in lasers)
						{
							laser.AddLeftTime(fP2);
						}
						foreach (MonsterAdventureActor monster in monsters)
						{
							monster.monsterSummonInfo.AddLeftTime(fP2);
						}
					}
				}
			};
		}
		return laserEntity;
	}

	private void OnAreaEnterOrExit(IEvent evt)
	{
		AdventureAreaEnterExitEvent adventureAreaEnterExitEvent = evt as AdventureAreaEnterExitEvent;
		if (_actor != null && _actor == adventureAreaEnterExitEvent.owner && adventureAreaEnterExitEvent.triggerCollider?.Entity != null && adventureAreaEnterExitEvent.sender is AreaEffectEntity areaEffectEntity && areaEffectEntity.areaTag == areaTag_4_B && adventureAreaEnterExitEvent.iEnter && adventureAreaEnterExitEvent.triggerCollider.Entity is AdventureBulletBase adventureBulletBase && adventureBulletBase.BulletHashCode == bulletTag && dicCastTime.TryGetValue(areaEffectEntity.Id, out var value) && _actor.LogicTime - value > delay_4)
		{
			if (dicAreaB.ContainsKey(areaEffectEntity.Id))
			{
				dicAreaB.set_Item(areaEffectEntity.Id, true);
			}
			ILRuntimeAPI.StopAreaEffect(areaEffectEntity.Id);
		}
	}

	private void OnBulletBorn(IEvent evt)
	{
		AdventureBulletBornEvent adventureBulletBornEvent = evt as AdventureBulletBornEvent;
		if (adventureBulletBornEvent.owner != null)
		{
			_ = adventureBulletBornEvent.owner.Id;
			_ = _actor.Id;
		}
	}

	private IEnumerator DoEnterCystal()
	{
		_actor.logicVariable.ToggleLogicTag("InCrystal", value: true);
		_actor.buffComponent.AddBuff(buff_Crystal, _actor);
		if (GetPerk(perkId_4))
		{
			ILRuntimeAPI.StopAreaEffect(areaEffect_4?.Id ?? 0);
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_4_A, _actor.tsTransform.Position, default, (AreaEffectEntity areaEffect) =>
			{
				areaEffect_4 = areaEffect;
			});
		}
		FP curTime = 0;
		curCount_10 = 0;
		for (extralTime = 0; curTime <= crystalTime + extralTime; curTime += _actor.LogicDeltaTime)
		{
			yield return null;
		}
		_actor.logicVariable.ToggleLogicTag("InCrystal", value: false);
		_actor.buffComponent.RemoveBuffByBuffId(buff_Crystal);
	}

	public AdventureActor GetCrystalAttackTarget(TSVector2 center)
	{
		List<LogicEntity> list = ILRuntimeAPI.SearchByRangeAndPosition(_actor, center, searchRange, null, isConfront: true);
		if (list.Count > 0)
		{
			_actor.SearchEntitySortByDistance(list);
			return list.get_Item(0) as AdventureActor;
		}
		return null;
	}
}
