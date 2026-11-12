using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._13501;

public class ParallelScript_Support : ParallelScript
{
	private int buffId_DarkMark = 5011;

	private int hitTag_area = CommonHelper.StringToHash("135GhostDoorAtk");

	private int hitTag_boom = CommonHelper.StringToHash("BoomGhostAtk");

	private int summonId = 13500020;

	private int summonInherit = 100;

	private FP summonLeftTime = 8;

	private FP summonInnerRadius = 0;

	private FP summonOuterRadius = 3;

	private string areaEffect_base = "AreaEffect_135_GhostDoor";

	private string areaEffect_P23 = "AreaEffect_135_GhostDoor_T23";

	private FP offset = 3.72f;

	private FP interval_base = 0.5f;

	private int summonEvt = CommonHelper.StringToHash("summonEvt");

	private const int perkId_21 = 513521;

	private const int addTime_21 = 3;

	private const int perkId_22 = 513522;

	private const int interval_22 = 1;

	private FP scale_22 = 0.1;

	private int buff_22 = 13552211;

	private FP maxScale_22 = 1;

	private int maxBuffCount = 10;

	private const int perkId_23 = 513523;

	private int once_23 = 13523011;

	private FP pullWeight_23 = 4;

	private const int perkId_24 = 513524;

	private int once_24 = 13524011;

	private const int perkId_25 = 513525;

	private const int parameterId_25 = 13552501;

	private const int perkId_26 = 513526;

	private const int buff_26 = 13552611;

	private const int perkId_27 = 513527;

	private const int parameterId_27 = 13552701;

	private const int perkId_28 = 513528;

	private const int perkId_29 = 513529;

	private const int buff_29 = 13552911;

	private const int perkId_30 = 513530;

	private const int buff_30 = 13553011;

	private const int perkId_31 = 513531;

	private const int shield_31 = 13553101;

	private const int perkId_32 = 513532;

	private const int once_32 = 13532001;

	private const int perkId_33 = 513533;

	private const int buff_33 = 13553311;

	private AreaEffectEntity areaEntity;

	private FP leftTime;

	private CoroutineNode corSummon;

	private SummonCfg summonCfg = new SummonCfg();

	private List<long> monsterIds = new List<long>();

	private List<long> removeIds = new List<long>();

	public override void OnEnable()
	{
		base.OnEnable();
		leftTime = summonLeftTime;
		if (!GetPerkLv(513533, out var _))
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.DE)
			{
				playerAdventureActor.buffComponent.AddBuff(13553311, _actor);
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		StopCoroutine(ref corSummon);
		monsterIds.Clear();
		removeIds.Clear();
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnBeforeHit(evt, monster, isSelf);
		int lv;
		if (isSelf)
		{
			if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra) && GetPerkLv(513532, out lv))
			{
				AdventureActor.AddFromAttr(13532001, _actor);
			}
		}
		else if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_boom))
		{
			if (GetPerkLv(513523, out lv) && areaEntity != null && TSVector2.Distance(monster.tsTransform.Position, areaEntity.tsTransform.Position) < areaEntity.GetAreaRadius())
			{
				AdventureActor.AddFromAttr(once_23, _actor);
			}
			if (GetPerkLv(513524, out lv) && areaEntity != null && TSVector2.Distance(monster.tsTransform.Position, areaEntity.tsTransform.Position) < areaEntity.GetAreaRadius())
			{
				AdventureActor.AddFromAttr(once_24, _actor);
			}
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (isSelf)
		{
			if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_area) && GetPerkLv(513528, out var _))
			{
				monster.buffComponent.AddBuff(buffId_DarkMark, _actor);
			}
			if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra) && GetPerkLv(513532, out var _))
			{
				monster.buffComponent.AddBuff(buffId_DarkMark, _actor);
			}
		}
	}

	public override void OnBattleReady(AdventureBattleReadyEvent evt)
	{
		if (areaEntity != null)
		{
			ILRuntimeAPI.StopAreaEffect(areaEntity.Id);
			areaEntity = null;
			StopCoroutine(ref corSummon);
		}
		for (int i = 0; i < monsterIds.Count; i++)
		{
			if (!removeIds.Contains(monsterIds.get_Item(i)))
			{
				LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterIds.get_Item(i));
				if (logicEntity != null)
				{
					(logicEntity as MonsterAdventureActor).DestroySelf();
				}
			}
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (evt.eventHashCode != summonEvt)
		{
			return;
		}
		if (areaEntity != null)
		{
			areaEntity.OnBeforeEnd = null;
			ILRuntimeAPI.StopAreaEffect(areaEntity.Id);
			areaEntity = null;
			StopCoroutine(ref corSummon);
		}
		string fxAlias = (GetPerkLv(513523, out var lv) ? areaEffect_P23 : areaEffect_base);
		TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Forward * offset;
		long id = ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position, default, (AreaEffectEntity entity) =>
		{
			HandlePerkLogic(entity);
		});
		areaEntity = ILRuntimeAPI.GetAreaEffect(id);
		if (areaEntity != null)
		{
			if (GetPerkLv(513521, out lv))
			{
				areaEntity.AddLeftTime(3);
			}
			areaEntity.OnBeforeEnd = () =>
			{
				StopCoroutine(ref corSummon);
			};
			StartCoroutine(ref corSummon, IntervalSummon());
		}
	}

	private void HandlePerkLogic(AreaEffectEntity entity)
	{
		if (GetPerkLv(513531, out var lv))
		{
			mainCtrActor.actorShield.AddShield(13553101, _actor);
		}
		AreaEffect_AttackComponent logicComponent = entity.GetLogicComponent<AreaEffect_AttackComponent>();
		AreaEffect_PullComponent logicComponent2 = entity.GetLogicComponent<AreaEffect_PullComponent>();
		AreaEffect_BuffComponent[] components = entity.GetComponents<AreaEffect_BuffComponent>();
		AreaEffect_FollowComponent logicComponent3 = entity.GetLogicComponent<AreaEffect_FollowComponent>();
		logicComponent.enabled = false;
		logicComponent.hitImmediately = false;
		logicComponent2.enabled = false;
		logicComponent3.enabled = false;
		for (int i = 0; i < components.Length; i++)
		{
			components[i].executeImmediately = false;
			components[i].enabled = false;
			components[i].addBuffIdList.Clear();
			components[i].removeBuffIdList.Clear();
			components[i].addInterval = 0;
			components[i].removeInterval = 0;
			components[i].triggerEnter = false;
			components[i].triggerEnterCriteriaInfo = new TargetFilterCriteriaInfo
			{
				filterCriteriaList = new List<TargetFilterCriteriaInfo.TargetFilterCriteria>
				{
					new TargetFilterCriteriaInfo.TargetFilterCriteria
					{
						targetType = TargetFilterCriteriaInfo.TargetTypeMapping.Enemy
					}
				}
			};
			components[i].triggerExit = false;
			components[i].triggerExitCriteriaInfo = new TargetFilterCriteriaInfo
			{
				filterCriteriaList = new List<TargetFilterCriteriaInfo.TargetFilterCriteria>
				{
					new TargetFilterCriteriaInfo.TargetFilterCriteria
					{
						targetType = TargetFilterCriteriaInfo.TargetTypeMapping.Enemy
					}
				}
			};
		}
		if (GetPerkLv(513523, out lv))
		{
			logicComponent2.enabled = true;
			logicComponent2.pullInterval = 0.1f;
			logicComponent2.pullSpeed = 3f;
			logicComponent2.pullLevel = 99;
			logicComponent2.strength = pullWeight_23;
			logicComponent2.pullWithRadius = false;
			logicComponent2.changeTargetDirection = false;
		}
		if (GetPerkLv(513524, out lv))
		{
			logicComponent3.enabled = true;
			logicComponent3.targetType = AreaEffect_FollowComponent.FollowTargetType.Target;
			logicComponent3.lockMainActorTarget = true;
			logicComponent3.isSlowMove = true;
		}
		if (GetPerkLv(513528, out lv))
		{
			logicComponent.enabled = true;
		}
		if (GetPerkLv(513530, out lv))
		{
			AreaEffect_BuffComponent obj = components[4];
			obj.enabled = true;
			obj.addBuffIdList = new List<int> { 13553011 };
			obj.addCriteriaInfo = new TargetFilterCriteriaInfo
			{
				filterCriteriaList = new List<TargetFilterCriteriaInfo.TargetFilterCriteria>
				{
					new TargetFilterCriteriaInfo.TargetFilterCriteria
					{
						targetType = TargetFilterCriteriaInfo.TargetTypeMapping.Enemy
					}
				}
			};
			obj.triggerEnter = true;
			obj.triggerEnterCriteriaInfo = new TargetFilterCriteriaInfo
			{
				filterCriteriaList = new List<TargetFilterCriteriaInfo.TargetFilterCriteria>
				{
					new TargetFilterCriteriaInfo.TargetFilterCriteria
					{
						targetType = TargetFilterCriteriaInfo.TargetTypeMapping.Enemy
					}
				}
			};
			AreaEffect_BuffComponent obj2 = components[5];
			obj2.enabled = true;
			obj2.removeBuffIdList = new List<int> { 13553011 };
			obj2.removeCriteriaInfo = new TargetFilterCriteriaInfo
			{
				filterCriteriaList = new List<TargetFilterCriteriaInfo.TargetFilterCriteria>
				{
					new TargetFilterCriteriaInfo.TargetFilterCriteria
					{
						targetType = TargetFilterCriteriaInfo.TargetTypeMapping.Enemy
					}
				}
			};
			obj2.triggerExit = true;
			obj2.triggerExitCriteriaInfo = new TargetFilterCriteriaInfo
			{
				filterCriteriaList = new List<TargetFilterCriteriaInfo.TargetFilterCriteria>
				{
					new TargetFilterCriteriaInfo.TargetFilterCriteria
					{
						targetType = TargetFilterCriteriaInfo.TargetTypeMapping.Enemy
					}
				}
			};
		}
	}

	private IEnumerator IntervalSummon()
	{
		FP interval = interval_base;
		if (GetPerkLv(513525, out var lv))
		{
			interval = interval_base * (1 - CommonUtils.GetScriptValue(_actor, 13552501) / 100f);
		}
		int count = 0;
		bool p22 = GetPerkLv(513522, out var _);
		FP curTime_summon = 0;
		FP curTime_scale = 0;
		while (true)
		{
			if (p22 && curTime_scale >= 1)
			{
				count++;
				curTime_scale = 0;
			}
			if (curTime_summon >= interval)
			{
				SummonActor(count);
				if (GetPerkLv(513527, out lv) && TSRandom.Range(0, 100) < CommonUtils.GetScriptValue(_actor, 13552701))
				{
					SummonActor(count);
				}
				curTime_summon = 0;
			}
			yield return null;
			curTime_summon += _actor.LogicDeltaTime;
			curTime_scale += _actor.LogicDeltaTime;
		}
	}

	private void SummonActor(int count)
	{
		summonCfg.summonFollowType = SummonFollowType.NotFollow;
		summonCfg.summonAttrType = SummonAttrType.InheritByInitialSnapshot;
		summonCfg.summonRelation = SummonRelation.Independent;
		summonCfg.attrPercent = summonInherit;
		summonCfg.leftTime = leftTime;
		FP hitBoxRadius = areaEntity.hitBoxRadius;
		TSVector2 pos = _actor.RandomActorReachablePointInsideRing(areaEntity.tsTransform.Position, hitBoxRadius, hitBoxRadius);
		ILRuntimeAPI.SummonMonster(_actor, 0, summonId, pos, _actor.tsTransform.Forward, summonCfg, null, (MonsterAdventureActor monster) =>
		{
			monsterIds.Add(monster.Id);
			if (GetPerkLv(513529, out var lv))
			{
				_actor.buffComponent.AddBuff(13552911, _actor);
				int buffNumByID = _actor.buffComponent.GetBuffNumByID(13552911);
				monster.buffComponent.AddBuffNum(13552911, buffNumByID, _actor);
			}
			if (GetPerkLv(513526, out lv))
			{
				monster.buffComponent.AddBuff(13552611, _actor);
			}
			if (GetPerkLv(513522, out lv))
			{
				monster.buffComponent.AddBuffNum(buff_22, Mathf.Min(count, maxBuffCount), _actor);
				FP modelScale = monster.actorScaleInfo.modelScale;
				monster.actorScaleInfo.modelScale = modelScale + TSMath.Min(count * scale_22, maxScale_22);
			}
		});
	}

	public override void OnMonsterDied(AdventureMonsterDiedEvent evt)
	{
		base.OnMonsterDied(evt);
		if (evt.monsterID == summonId && monsterIds.Contains(evt.id))
		{
			removeIds.Add(evt.id);
		}
	}
}
