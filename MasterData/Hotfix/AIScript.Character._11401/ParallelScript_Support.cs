using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._11401;

public class ParallelScript_Support : ParallelScript
{
	public int bulletTag_1 = CommonHelper.StringToHash("114_B2_Bullet");

	private const int perkId_1 = 511421;

	private int buffTag_1 = CommonHelper.StringToHash("114_B2_Tag_1");

	private int buff_1 = 11421011;

	private int buff_1_2 = 11421012;

	private int buff_1_3 = 11421013;

	private string areaeffect_1 = "AreaEffect_114_Support_Skill_P21_Boom_Lv1";

	private string areaeffect_1_1 = "AreaEffect_114_Support_Skill_P21_Boom_Lv2";

	private string areaeffect_1_2 = "AreaEffect_114_Support_Skill_P21_Boom_Lv3";

	private int once_1 = 11421011;

	private const int perkId_22 = 511422;

	private int paramId_22_maxCount = 11422011;

	private int once_22 = 11422011;

	private const int perkId_23 = 511423;

	private int once_23 = 11423011;

	private const int perkId_24 = 511424;

	private int once_24 = 11424011;

	private string bullet_24 = "Bullet_114_Support_Skill_P24";

	private int split_24 = 12;

	private int paramId_24_maxCount = 11424011;

	private FP startAngle_24 = 0;

	private FP shootPosY_24 = 1;

	private const int perkId_25 = 511425;

	private string areaEffect_25 = "AreaEffect_114_Support_Skill_P25_CatEye";

	private int once_25 = 11425001;

	private const int perkId_26 = 511426;

	private int once_26 = 11426001;

	private const int perkId_27 = 511427;

	private int buff_27 = 11427011;

	private FP interval_27 = 1;

	private int once_27 = 11427001;

	private const int perkId_28 = 511428;

	private int shootCount_28 = 2;

	private FP startAngle_28 = -15;

	private FP invtervalAngle_28 = 30;

	private int reflectCount_28 = 3;

	private List<FP> distanceList_28 = new List<FP> { 3, 3, 5 };

	private List<string> bulletList_28 = new List<string> { "Bullet_114_Support_Skill_P28_Ball_Small", "Bullet_114_Support_Skill_P28_Ball_Small", "Bullet_114_Support_Skill_P28_Ball_Big" };

	private int buff_28 = 11428011;

	private const int perkId_29 = 511429;

	private int buff_29 = 11429011;

	private int once_29 = 11429001;

	private const int perkId_30 = 511430;

	private int paramId_30_hpPecent_Normal = 11430011;

	private int paramId_30_hpPecent_Elite = 11430012;

	private int once_30 = 11430001;

	private const int perkId_31 = 511431;

	private int buff_31 = 11431011;

	private const int perkId_32 = 511432;

	private int buff_32 = 11432011;

	private const int perkId_33 = 511433;

	private int buff_33 = 11433011;

	private Dictionary<long, int> hitMonsterDic = new Dictionary<long, int>();

	private Dictionary<long, MonsterAdventureActor> monsterDic_P22 = new Dictionary<long, MonsterAdventureActor>();

	private Dictionary<long, FP> dicMonsterCd = new Dictionary<long, FP>();

	private List<LogicEntity> entities = new List<LogicEntity>();

	private CoroutineNode corAddBuff;

	private List<CoroutineNode> corList = new List<CoroutineNode>();

	private int shootEvt_P28 = CommonHelper.StringToHash("shootEvt_P28");

	private int evt_Counter = CommonHelper.StringToHash("evt_Counter");

	private int counter_24;

	private bool _shotFirstHitDone_P21;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_ENERGY_CHANGE", OnActorEnergyChange);
		hitMonsterDic.Clear();
		_shotFirstHitDone_P21 = false;
		if (GetPerk(511428))
		{
			_actor.buffComponent.AddBuff(buff_28, _actor);
		}
		if (GetPerk(511431))
		{
			FP fP = (FP)skillMgr.GetEnergy();
			int totalEnergy = skillMgr.GetTotalEnergy();
			if (fP >= totalEnergy)
			{
				_actor.buffComponent.AddBuff(buff_31, _actor);
			}
		}
		if (!GetPerk(511433))
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
			{
				playerAdventureActor.buffComponent.AddBuff(buff_33, _actor);
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_ENERGY_CHANGE", OnActorEnergyChange);
		monsterDic_P22.Clear();
		dicMonsterCd.Clear();
		_shotFirstHitDone_P21 = false;
		entities.Clear();
		StopCoroutine(ref corAddBuff);
		for (int i = 0; i < corList.Count; i++)
		{
			StopCoroutine(corList.get_Item(i));
		}
		corList.Clear();
		counter_24 = 0;
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		if (evt.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.B)
		{
			return;
		}
		if (GetPerk(511422))
		{
			_actor.logicVariable.SetLogicTagValue("skillCount", 0);
		}
		if (GetPerk(511425))
		{
			LogicEntity target = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
			if (target != null)
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_25, target.tsTransform.Position, default, (AreaEffectEntity enity) =>
				{
					AreaEffect_FollowComponent areaEffectComponent = enity.GetAreaEffectComponent<AreaEffect_FollowComponent>();
					if (areaEffectComponent != null)
					{
						areaEffectComponent.targetType = AreaEffect_FollowComponent.FollowTargetType.SpecifiedTarget;
						areaEffectComponent.FollowTarget = target;
					}
				});
			}
		}
		if (GetPerk(511427))
		{
			StartCoroutine(ref corAddBuff, DoAddBuff());
		}
		if (GetPerk(511429))
		{
			_actor.buffComponent.RemoveBuffByBuffId(buff_29);
		}
		if (GetPerk(511432))
		{
			_actor.buffComponent.AddBuff(buff_32, _actor);
		}
	}

	public override void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		base.OnCastEndSkill(evt);
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			if (GetPerk(511422))
			{
				_actor.logicVariable.SetLogicTagValue("skillCount", 0);
			}
			if (GetPerk(511427))
			{
				StopCoroutine(ref corAddBuff);
			}
			if (GetPerk(511431))
			{
				_actor.buffComponent.RemoveBuffByBuffId(buff_31);
			}
			if (GetPerk(511432))
			{
				_actor.buffComponent.RemoveBuffByBuffId(buff_32);
			}
		}
	}

	public override void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster)
	{
		base.OnHitPre(evt, monster);
		if (GetPerk(511430) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS) && monster.monsterInfo.epicType == HotfixEnum.monsterEpicType.NORMAL && (FP)monster.actorHealthInfo.hpPercentage <= CommonUtils.GetScriptValue(_actor, paramId_30_hpPecent_Normal))
		{
			monster.Kill(_actor);
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
		if (GetPerk(511421) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill) && monster.buffComponent.CheckBuffByBuffTag(buffTag_1))
		{
			AdventureActor.AddFromAttr(once_1, _actor);
		}
		if (GetPerk(511422) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill))
		{
			AdventureActor.AddFromAttr(once_22, _actor);
		}
		if (GetPerk(511423) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill))
		{
			AdventureActor.AddFromAttr(once_23, _actor);
		}
		if (GetPerk(511424) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill))
		{
			AdventureActor.AddFromAttr(once_24, _actor);
		}
		if (GetPerk(511425) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill))
		{
			AdventureActor.AddFromAttr(once_25, _actor);
		}
		if (GetPerk(511426))
		{
			if (monster.buffComponent.CheckBuffByBuffID(buff_1))
			{
				AdventureActor.AddFromAttr(once_26, _actor);
			}
			else if (monster.buffComponent.CheckBuffByBuffID(buff_1_2))
			{
				AdventureActor.AddFromAttr(once_26, _actor, 2);
			}
			else if (monster.buffComponent.CheckBuffByBuffID(buff_1_3))
			{
				AdventureActor.AddFromAttr(once_26, _actor, 3);
			}
		}
		if (GetPerk(511427) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS))
		{
			int buffNumByID = monster.buffComponent.GetBuffNumByID(buff_27);
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(once_27, _actor, buffNumByID);
			}
		}
		if (GetPerk(511429) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS))
		{
			int buffNumByID2 = _actor.buffComponent.GetBuffNumByID(buff_29);
			if (buffNumByID2 > 0)
			{
				AdventureActor.AddFromAttr(once_29, _actor, buffNumByID2);
			}
		}
		if (GetPerk(511430) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS) && monster.monsterInfo.epicType != HotfixEnum.monsterEpicType.NORMAL && (FP)monster.actorHealthInfo.hpPercentage < CommonUtils.GetScriptValue(_actor, paramId_30_hpPecent_Elite))
		{
			AdventureActor.AddFromAttr(once_30, _actor);
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		base.OnHitPost(evt, monster);
		if (GetPerk(511421) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS) && evt.weapon is AdventureBulletBase adventureBulletBase && adventureBulletBase.BulletHashCode == bulletTag_1 && !_shotFirstHitDone_P21)
		{
			_shotFirstHitDone_P21 = true;
			if (monster.buffComponent.CheckBuffByBuffTag(buffTag_1))
			{
				if (monster.buffComponent.CheckBuffByBuffID(buff_1))
				{
					monster.buffComponent.RemoveBuffByTag(buffTag_1);
					monster.buffComponent.AddBuff(buff_1_2, _actor);
					ILRuntimeAPI.PlayAreaEffect(_actor, areaeffect_1_1, monster.tsTransform.Position);
				}
				else if (monster.buffComponent.CheckBuffByBuffID(buff_1_2))
				{
					monster.buffComponent.RemoveBuffByTag(buffTag_1);
					monster.buffComponent.AddBuff(buff_1_3, _actor);
					ILRuntimeAPI.PlayAreaEffect(_actor, areaeffect_1_2, monster.tsTransform.Position);
				}
				else if (monster.buffComponent.CheckBuffByBuffID(buff_1_3))
				{
					monster.buffComponent.AddBuff(buff_1_3, _actor);
					ILRuntimeAPI.PlayAreaEffect(_actor, areaeffect_1_2, monster.tsTransform.Position);
				}
			}
			else
			{
				monster.buffComponent.AddBuff(buff_1, _actor);
				ILRuntimeAPI.PlayAreaEffect(_actor, areaeffect_1, monster.tsTransform.Position);
			}
		}
		if (GetPerk(511422) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS) && evt.isCrit)
		{
			int num = (int)(long)_actor.logicVariable.GetLogicTagValue("skillCount");
			_actor.logicVariable.SetLogicTagValue("skillCount", Mathf.Min(++num, CommonUtils.GetScriptValue(_actor, paramId_22_maxCount).AsInt()));
		}
		if (GetPerk(511424) && evt.weapon != null && evt.weapon is AdventureBulletBase adventureBulletBase2 && adventureBulletBase2.BulletHashCode == bulletTag_1 && counter_24 < CommonUtils.GetScriptValue(_actor, paramId_24_maxCount).AsInt())
		{
			counter_24++;
			float num2 = 360f / (float)split_24;
			for (int i = 0; i < split_24; i++)
			{
				FP degrees = (float)i * num2 + startAngle_24;
				TSVector2 shootDir = TSVector2.Rotate(TSVector2.up, degrees);
				TSVector2 position = monster.tsTransform.Position;
				FP positionY = shootPosY_24;
				ILRuntimeAPI.ShootByDirection(bullet_24, _actor, default, shootDir, position, positionY);
			}
		}
		if (GetPerk(511429) && evt.isCrit && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS))
		{
			_actor.buffComponent.AddBuff(buff_29, _actor);
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		base.OnCustomEvent(evt);
		if (evt.eventHashCode == evt_Counter)
		{
			if (GetPerk(511421))
			{
				_shotFirstHitDone_P21 = false;
			}
			if (GetPerk(511424))
			{
				counter_24 = 0;
			}
		}
		if (GetPerk(511428) && evt.eventHashCode == shootEvt_P28)
		{
			for (int i = 0; i < shootCount_28; i++)
			{
				FP degrees = i * invtervalAngle_28 + startAngle_28;
				TSVector2 shootDir = TSVector2.Rotate(_actor.tsTransform.Forward, degrees);
				CoroutineNode item = StartCoroutine(DoShootParabolaBombs(_actor.tsTransform.Position, shootDir));
				corList.Add(item);
			}
		}
	}

	private void OnActorEnergyChange(IEvent evt)
	{
		if (evt is AdventureActorEnergyChangeEvent adventureActorEnergyChangeEvent && !(adventureActorEnergyChangeEvent.actor != _actor) && GetPerk(511431) && adventureActorEnergyChangeEvent.currentEnergy >= adventureActorEnergyChangeEvent.totalEnergy)
		{
			_actor.buffComponent.AddBuff(buff_31, _actor);
		}
	}

	private IEnumerator DoAddBuff()
	{
		while (true)
		{
			MonsterAdventureActor monsterAdventureActor = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true) as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				monsterAdventureActor.buffComponent.AddBuff(buff_27, _actor);
			}
			yield return _actor.WaitTime(interval_27);
		}
	}

	private IEnumerator DoShootParabolaBombs(TSVector2 startPos, TSVector2 shootDir)
	{
		TSVector2 lastPos = startPos;
		for (int i = 0; i < reflectCount_28; i++)
		{
			TSVector2 tSVector = lastPos + distanceList_28.get_Item(i) * shootDir;
			string bulletAlias = bulletList_28.get_Item(i);
			AdventureActor actor = _actor;
			TSVector2 position = lastPos;
			TSVector2 targetPosition = tSVector;
			AdventureBulletBase bullet = ILRuntimeAPI.Shoot(bulletAlias, actor, default, position, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
			if (bullet == null)
			{
				break;
			}
			while (!bullet.isFinished)
			{
				lastPos = bullet.tsTransform.Position;
				yield return null;
			}
			yield return null;
		}
	}
}
