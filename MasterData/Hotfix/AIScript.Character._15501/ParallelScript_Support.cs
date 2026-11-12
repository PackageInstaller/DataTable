using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._15501;

public class ParallelScript_Support : ParallelScript
{
	private int summonInherit_M = 100;

	private FP summonLeftTime_MB = 4;

	private FP summonLeftTime_MW = 7.5;

	private int summonId_MW = 15532011;

	private int summonId_MB = 15532021;

	private FP radius_enter = 20;

	private string bullet_W = "Bullet_15501_Summon_Support_Skill_XiYa_Surf_White";

	private string bullet_MW_1 = "Bullet_15501_Summon_Support_Skill_White_1";

	private string bullet_MW_2 = "Bullet_15501_Summon_Support_Skill_White_2";

	private FP offset_W = 1;

	private string bullet_B = "Bullet_15501_Summon_Support_Skill_XiYa_Surf_Black";

	private string bullet_MB_1 = "Bullet_15501_Summon_Support_Skill_Black_1";

	private string bullet_MB_2 = "Bullet_15501_Summon_Support_Skill_Black_2";

	private FP offset_B_1 = 1.5;

	private FP offset_B_2 = 1;

	private FP delay = 0.4f;

	private FP interval_time = 0.15;

	private FP interval_disX = 4;

	private FP interval_disY = 1.5;

	private FP with = 2;

	private FP length = 2;

	private int bombCount = 15;

	private string areaEffect_base = "AreaEffect_15501_Summon_Support_Skill_Black";

	private int shootEvt = CommonHelper.StringToHash("shootEvt");

	private int dieEvt = CommonHelper.StringToHash("dieEvt");

	private const int perkId_21 = 515521;

	private int count_21 = 2;

	private List<TSVector2> spawnOffset_W_21 = new List<TSVector2>
	{
		new TSVector2(-1, -2),
		new TSVector2(1, -2)
	};

	private const int perkId_22 = 515522;

	private int count_22 = 2;

	private List<TSVector2> spawnOffset_B_22 = new List<TSVector2>
	{
		new TSVector2(-2, 2),
		new TSVector2(2, 2)
	};

	private const int perkId_23 = 515523;

	private int once_23 = 15523001;

	private const int perkId_24 = 515524;

	private string bullet_W_24 = "Bullet_15501_Summon_Support_Skill_XiYa_Surf_White_P24";

	private string bullet_B_24 = "Bullet_15501_Summon_Support_Skill_XiYa_Surf_Black_P24";

	private string areaEffect_24 = "AreaEffect_15501_Summon_Support_Skill_P24_Pond";

	private FP interval_24 = 4;

	private int totleLength_24 = 30;

	private const int perkId_25 = 515525;

	private int once_25 = 15525001;

	private const int perkId_26 = 515526;

	private int once_26 = 15526001;

	private int paramId_26_maxCount = 15526011;

	private const int perkId_27 = 515527;

	private int buff_27 = 15527011;

	private int once_27 = 15527001;

	private const int perkId_28 = 515528;

	private int buff_28_stun = 15528011;

	private int once_28 = 15528001;

	private const int perkId_29 = 515529;

	private int buff_29 = 15529011;

	private int once_29 = 15529001;

	private const int perkId_30 = 515530;

	private int buff_30 = 15530011;

	private FP interval_30 = 1;

	private const int perkId_31 = 515531;

	private int buff_31 = 15531011;

	private const int perkId_32 = 515532;

	private int buff_32 = 15532011;

	private const int perkId_33 = 515533;

	private int buff_33 = 15533011;

	private DeterministicShape shape = new DeterministicShape
	{
		shapeType = DeterministicShape.ShapeType.Rectangle
	};

	private List<CoroutineNode> corList = new List<CoroutineNode>();

	private SummonCfg summonCfg_MW = new SummonCfg();

	private SummonCfg summonCfg_MB = new SummonCfg();

	private int summonCount;

	private List<long> entityIds = new List<long>();

	private List<TSVector2> positions = new List<TSVector2>();

	private int curCount_26;

	private CoroutineNode corAddBuff;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDie);
		shape.width = with;
		shape.length = length;
		summonCfg_MB.summonFollowType = (summonCfg_MW.summonFollowType = SummonFollowType.NotFollow);
		summonCfg_MB.summonAttrType = (summonCfg_MW.summonAttrType = SummonAttrType.InheritByInitialSnapshot);
		summonCfg_MB.summonRelation = (summonCfg_MW.summonRelation = SummonRelation.Coexisted);
		summonCfg_MB.retainWhenCrossLevel = (summonCfg_MW.retainWhenCrossLevel = false);
		summonCfg_MB.useSummonHit = (summonCfg_MW.useSummonHit = true);
		summonCfg_MB.summonType = (summonCfg_MW.summonType = SummonType.None);
		summonCount = 0;
		curCount_26 = 0;
		if (!GetPerk(515533))
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.LE)
			{
				playerAdventureActor.buffComponent.AddBuff(buff_33, _actor);
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDie);
		StopCoroutine(ref corAddBuff);
		for (int i = 0; i < corList.Count; i++)
		{
			StopCoroutine(corList.get_Item(i));
		}
		corList.Clear();
		for (int num = entityIds.Count - 1; num > 0; num--)
		{
			ILRuntimeAPI.StopAreaEffect(entityIds.get_Item(num));
		}
		entityIds?.Clear();
		positions.Clear();
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			if (GetPerk(515526))
			{
				curCount_26 = 0;
			}
			if (GetPerk(515530))
			{
				StartCoroutine(ref corAddBuff, DoAddBuff());
			}
		}
	}

	public override void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		base.OnCastEndSkill(evt);
		if (evt.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.B)
		{
			return;
		}
		if (GetPerk(515521))
		{
			summonCfg_MW.attrPercent = summonInherit_M;
			summonCfg_MW.leftTime = summonLeftTime_MW;
			for (int i = 0; i < count_21; i++)
			{
				SummonMW(i);
			}
		}
		if (GetPerk(515522))
		{
			summonCfg_MB.attrPercent = summonInherit_M;
			summonCfg_MB.leftTime = summonLeftTime_MB;
			for (int j = 0; j < count_22; j++)
			{
				TSVector2 pos = mainCtrActor.tsTransform.TransformLocalPointToWorldSpace(spawnOffset_B_22.get_Item(j));
				ILRuntimeAPI.SummonMonster(_actor, 0, summonId_MB, pos, _actor.tsTransform.Forward, summonCfg_MB, null, (MonsterAdventureActor monster) =>
				{
					summonCount++;
				});
			}
		}
		if (GetPerk(515530))
		{
			if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
			{
				StopCoroutine(ref corAddBuff);
			}
			_actor.buffComponent.RemoveBuffByBuffId(buff_30);
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnBeforeHit(evt, monster, isSelf);
		AdventureActor adventureActor = evt.from as AdventureActor;
		if (adventureActor == null)
		{
			return;
		}
		if (GetPerk(515523) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS))
		{
			AdventureActor.AddFromAttr(once_23, adventureActor);
		}
		if (GetPerk(515525))
		{
			if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MW) || CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MB))
			{
				AdventureActor.AddFromAttr(once_25, adventureActor, summonCount);
			}
			else if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS_P25))
			{
				AdventureActor.AddFromAttr(once_25, adventureActor, summonCount + 2);
			}
		}
		if (GetPerk(515526) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MW))
		{
			int b = CommonUtils.GetScriptValue(_actor, paramId_26_maxCount).AsInt();
			int count = Mathf.Min(curCount_26, b);
			AdventureActor.AddFromAttr(once_26, adventureActor, count);
		}
		if (GetPerk(515527) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MB) && _actor.buffComponent.CheckBuffByBuffID(buff_27))
		{
			AdventureActor.AddFromAttr(once_27, adventureActor);
		}
		if (GetPerk(515528) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS))
		{
			AdventureActor.AddFromAttr(once_28, adventureActor);
		}
		if (GetPerk(515529) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(buff_29);
			AdventureActor.AddFromAttr(once_29, adventureActor, buffNumByID);
		}
	}

	public override void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPre(evt, monster, isSelf);
		AdventureActor adventureActor = evt.from as AdventureActor;
		if (isSelf)
		{
			if (GetPerk(515529) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS))
			{
				adventureActor.buffComponent.AddBuff(buff_29, adventureActor);
			}
			if (GetPerk(515528) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS))
			{
				monster.buffComponent.AddBuff(buff_28_stun, adventureActor);
			}
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		AdventureActor adventureActor = evt.from as AdventureActor;
		if (isSelf)
		{
			if (GetPerk(515526) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MW))
			{
				curCount_26++;
			}
			if (GetPerk(515531) && evt.isKill && (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS) || CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MB) || CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MW) || CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS_P25)))
			{
				adventureActor.buffComponent.AddBuff(buff_31, adventureActor);
			}
		}
	}

	private void OnMonsterDie(IEvent evt)
	{
		AdventureMonsterDiedEvent adventureMonsterDiedEvent = evt as AdventureMonsterDiedEvent;
		if (adventureMonsterDiedEvent.monsterID != summonId_MB)
		{
			_ = adventureMonsterDiedEvent.monsterID;
			_ = summonId_MW;
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (evt.eventHashCode == shootEvt)
		{
			TSVector2 tSVector = TrueSyncExtensions.RandomPointInsideRing(mainCtrActor.tsTransform.Position, radius_enter, radius_enter);
			TSVector2 normalized = (mainCtrActor.tsTransform.Position - tSVector).normalized;
			FP speed = 0;
			if (mainCtrActor.attackTarget != null)
			{
				normalized = (mainCtrActor.attackTarget.tsTransform.Position - tSVector).normalized;
			}
			if (evt.intParam % 2 != 0)
			{
				speed = ILRuntimeAPI.ShootByDirection(GetPerk(515524) ? bullet_W_24 : bullet_W, _actor, default, normalized, tSVector).velocitySpeed;
				TSVector2 position = tSVector + TSVector2.Rotate(normalized, 90) * offset_W;
				ILRuntimeAPI.ShootByDirection(bullet_MW_1, _actor, default, normalized, position);
				TSVector2 position2 = tSVector + TSVector2.Rotate(normalized, -90) * offset_W;
				ILRuntimeAPI.ShootByDirection(bullet_MW_2, _actor, default, normalized, position2);
			}
			else if (evt.intParam % 2 == 0)
			{
				speed = ILRuntimeAPI.ShootByDirection(GetPerk(515524) ? bullet_B_24 : bullet_B, _actor, default, normalized, tSVector).velocitySpeed;
				TSVector2 position3 = tSVector + TSVector2.Rotate(normalized, 90) * offset_B_1;
				ILRuntimeAPI.ShootByDirection(bullet_MB_1, _actor, default, normalized, position3);
				TSVector2 position4 = tSVector + TSVector2.Rotate(normalized, -90) * offset_B_2;
				ILRuntimeAPI.ShootByDirection(bullet_MB_2, _actor, default, normalized, position4);
				CoroutineNode item = StartCoroutine(DoBomb(tSVector, normalized));
				corList.Add(item);
			}
			if (GetPerk(515524))
			{
				CoroutineNode item2 = StartCoroutine(DoAreaEffect(tSVector, normalized, speed));
				corList.Add(item2);
			}
		}
		else if (evt.eventHashCode == dieEvt)
		{
			summonCount--;
		}
	}

	private IEnumerator DoBomb(TSVector2 shootPos, TSVector2 shootDir)
	{
		yield return _actor.WaitTime(delay);
		int count = 0;
		while (count < bombCount)
		{
			string fxAlias = areaEffect_base;
			TSVector2 tSVector = TSVector2.Rotate(shootDir, 90);
			TSVector2 position = shootPos + shootDir * interval_disX / 2 + shootDir * interval_disX * count + tSVector * interval_disY;
			shape.angle = tSVector.GetAngle();
			shape.position = position;
			TSVector2 position2 = _actor.RandomActorReachablePointInsideShape(shape);
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position2);
			TSVector2 tSVector2 = TSVector2.Rotate(shootDir, -90);
			TSVector2 position3 = shootPos + shootDir * interval_disX / 2 + shootDir * interval_disX * count + tSVector2 * interval_disY;
			shape.angle = tSVector2.GetAngle();
			shape.position = position3;
			position2 = _actor.RandomActorReachablePointInsideShape(shape);
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position2);
			count++;
			yield return _actor.WaitTime(interval_time);
		}
	}

	private IEnumerator DoAreaEffect(TSVector2 startPos, TSVector2 shootDir, FP speed)
	{
		string areaEffect = areaEffect_24;
		FP interval = interval_24;
		FP curLen = 0;
		int count = 0;
		while (curLen < totleLength_24)
		{
			curLen += speed * _actor.LogicDeltaTime;
			if (curLen >= count * interval)
			{
				count++;
				long item = ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect, startPos + curLen * shootDir);
				entityIds.Add(item);
				positions.Add(startPos + curLen * shootDir);
			}
			yield return null;
		}
	}

	public override void OnTriggerMasked(AdventureActor actor)
	{
		base.OnTriggerMasked(actor);
		if (GetPerk(515527))
		{
			_actor.buffComponent.AddBuff(buff_27, actor);
		}
		if (GetPerk(515532))
		{
			_actor.buffComponent.AddBuff(buff_32, actor);
		}
	}

	private IEnumerator DoAddBuff()
	{
		while (true)
		{
			_actor.buffComponent.AddBuff(buff_30, _actor);
			yield return _actor.WaitTime(interval_30);
		}
	}

	private void SummonMW(int index)
	{
		TSVector2 pos = mainCtrActor.tsTransform.TransformLocalPointToWorldSpace(spawnOffset_W_21.get_Item(index));
		ILRuntimeAPI.SummonMonster(_actor, 0, summonId_MW, pos, _actor.tsTransform.Forward, summonCfg_MW, null, (MonsterAdventureActor monster) =>
		{
			monster.logicVariable.ToggleLogicTag("isLeft", index % 2 == 0);
			summonCount++;
		});
	}
}
