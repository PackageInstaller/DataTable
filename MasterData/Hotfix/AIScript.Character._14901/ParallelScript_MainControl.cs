using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._14901;

public class ParallelScript_MainControl : ParallelScript
{
	public static DeterministicShape rightShape;

	public static DeterministicShape leftShape;

	public static FP delayTime;

	public static TSVector2 acPos;

	public static FP _rotation;

	public static Vector3 _scale;

	public static TSVector2 _target;

	public override void OnEnable()
	{
		base.OnEnable();
		Config_MainControl.linkNum = 2;
		if (GetPerk(514903))
		{
			Config_MainControl.linkNum = 4;
		}
		Config_MainControl.linkRange = Config_MainControl.link_range;
		if (GetPerk(514912))
		{
			Config_MainControl.linkRange = Config_MainControl.range_12;
		}
		if (GetPerk(514911))
		{
			PlayerSkillCd playerSkillCd = (_actor as PlayerAdventureActor).playerSkillCd;
			SkillInfo skillCD = playerSkillCd.GetSkillCD(ActionKey.A);
			playerSkillCd.SetSkillTotalSection(ActionKey.A, skillCD.totalSectionAmount + 1, forceMaxSection: true);
		}
		if (!GetPerk(514913))
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			if (SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).actorElementInfo.elementType == HotfixEnum.elementType.SE)
			{
				_actor.buffComponent.AddBuff(14913011, _actor);
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		delayTime = 0;
	}

	protected override void OnCastSkill(PlayerAdventureActor actor, AdventureActorCastSkillEvent skiillEvet)
	{
		if (skiillEvet != null)
		{
			base.OnCastSkill(actor, skiillEvet);
			if (skiillEvet.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && actor.isAssist && GetPerk(514909))
			{
				_actor.buffComponent.AddBuff(14909011, _actor);
			}
		}
	}

	protected override void OnBeforeHitEvent(AdventureActorReceiveDamageBeforeHitEvent evt)
	{
		base.OnBeforeHitEvent(evt);
		if (evt.from == _actor && evt.to is MonsterAdventureActor monsterAdventureActor)
		{
			if (GetPerk(514906) && monsterAdventureActor.monsterToughnessInfo.isToughnessBroken && CommonUtils.CheckHitByTag(evt.hitDamageTag, Config.damageTag_NormalAtk))
			{
				AdventureActor.AddFromAttr(14906001, _actor);
			}
			if (GetPerk(514908) && monsterAdventureActor.buffComponent.CheckBuffByBuffTag(Config_MainControl.slowBuff_tag))
			{
				AdventureActor.AddFromAttr(14908001, _actor);
			}
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		if (GetPerk(514905) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config.damageTag_NormalAtk))
		{
			_actor.buffComponent.AddBuff(14905011, _actor);
		}
	}

	public TSVector2 TransformPoint(Vector2 localPoint)
	{
		return TSVector2.Rotate(new TSVector2(localPoint.x * _scale.x, localPoint.y * _scale.z), _rotation) + acPos;
	}

	protected override void LogicUpdate()
	{
		base.LogicUpdate();
		Config_MainControl.mainConcTime -= _actor.LogicDeltaTime;
		if (Config_MainControl.mainConcTime > 0 && !_actor.buffComponent.CheckBuffByBuffID(14900001))
		{
			_actor.buffComponent.AddBuff(14900001, _actor);
		}
		else if (Config_MainControl.mainConcTime <= 0 && _actor.buffComponent.CheckBuffByBuffID(14900001))
		{
			_actor.buffComponent.RemoveBuffByBuffId(14900001);
		}
		if (GetPerk(514901))
		{
			if (Config_MainControl.mainConcTime > 0 && !_actor.buffComponent.CheckBuffByBuffID(14901011))
			{
				_actor.buffComponent.AddBuff(14901011, _actor);
			}
			else if (Config_MainControl.mainConcTime <= 0 && _actor.buffComponent.CheckBuffByBuffID(14901011))
			{
				_actor.buffComponent.RemoveBuffByBuffId(14901011);
			}
		}
		if (!(delayTime > 0))
		{
			return;
		}
		delayTime -= _actor.LogicDeltaTime;
		if (!(delayTime <= 0))
		{
			return;
		}
		int count = ILRuntimeAPI.GetMonstersFromShape(_actor, rightShape).Count;
		int count2 = ILRuntimeAPI.GetMonstersFromShape(_actor, leftShape).Count;
		Vector2 localPoint = Config_MainControl.L_pos;
		if (count > count2)
		{
			localPoint = Config_MainControl.R_pos;
		}
		else if (count == count2 && count2 + count - 1 < 2)
		{
			localPoint = Config_MainControl.Single_pos;
		}
		else if (count == count2 && count2 + count - 1 >= 2)
		{
			localPoint = Config_MainControl.M_pos;
		}
		long num = (long)_actor.logicVariable.GetLogicTagValue("summonId");
		if (num != 0L)
		{
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(num);
			if (logicEntity != null)
			{
				(logicEntity as AdventureActor).DestroySelf();
			}
		}
		FP leftTime = Config_MainControl.lifeTime;
		if (GetPerk(514910))
		{
			leftTime = Config_MainControl.time_10;
		}
		SummonCfg cfg = new SummonCfg
		{
			summonFollowType = SummonFollowType.NotFollow,
			summonAttrType = SummonAttrType.InheritByInitialSnapshot,
			summonRelation = SummonRelation.Coexisted,
			attrPercent = 100,
			leftTime = leftTime,
			retainWhenCrossLevel = false,
			useSummonHit = true,
			summonType = SummonType.None
		};
		TSVector2 dir = _target - acPos;
		TSVector2 position = TransformPoint(localPoint);
		_actor.QueryClosestPositionWalkable(position, out var result);
		ILRuntimeAPI.SummonMonster(_actor, 0, 14900011, result, dir, cfg, null, (MonsterAdventureActor monster) =>
		{
			_actor.logicVariable.SetLogicTagValue("summonId", monster.Id);
		});
	}
}
