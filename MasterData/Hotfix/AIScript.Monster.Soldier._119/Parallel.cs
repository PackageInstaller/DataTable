#define LOG_WARNING
using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._119;

public class Parallel : AIBase
{
	private const int boomerangRoundCount = 4;

	private readonly int damageTag_Boomerang = CommonHelper.StringToHash("Skill_Soldier_119_Main");

	private readonly int onceDamageId_Potential2;

	private readonly FP distancePerStack = 1;

	private const int maxStackCount = 10;

	private readonly int damageTag_skill = CommonHelper.StringToHash("Skill_Soldier_119");

	private const HotfixEnum.ChessPartnerType partnerType = HotfixEnum.ChessPartnerType.RenDaoChuanCheng;

	private const string areaEffectKey = "AreaEffect_119_Partner";

	public Dictionary<int, string> areaEffectKeys = new Dictionary<int, string>
	{
		[0] = "AreaEffect_119_Partner_1",
		[1] = "AreaEffect_119_Partner_2",
		[2] = "AreaEffect_119_Partner_3",
		[3] = "AreaEffect_119_Partner_4"
	};

	private int areaEffectCount;

	private const int triggerPercent = 5;

	private const int burstEveryTriggerCount = 3;

	private const int burstTargetCount = 3;

	private readonly FP burstSearchRange = 8;

	private int _potentialLv = 1;

	private const string logicTag_TriggerCount = "119_PartnerBond_Count";

	private bool _aborted;

	private static readonly FP dirEpsilonSqr = (FP)1 / (FP)100;

	public void OnEnable()
	{
		_potentialLv = ((!(_actor is SoldierActor soldierActor)) ? 1 : soldierActor.GetPotentialLv());
		_aborted = false;
		areaEffectCount = 0;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BOOMERANG_FINISH", OnBoomerangFinish);
		if (_potentialLv >= 2)
		{
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnBeforeSettlement);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	public void OnDisable()
	{
		_aborted = true;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BOOMERANG_FINISH", OnBoomerangFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnBeforeSettlement);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	private void OnBoomerangFinish(IEvent evt)
	{
		if (!_aborted && evt is BoomerangFinishEvent boomerangFinishEvent && !(boomerangFinishEvent.owner != _actor) && boomerangFinishEvent.catchSucess)
		{
			int num = ParseRound(boomerangFinishEvent.tag);
			if (num > 0 && num < 4)
			{
				ReShoot(num + 1);
			}
		}
	}

	private static int ParseRound(string tag)
	{
		if (string.IsNullOrEmpty(tag))
		{
			return 0;
		}
		if (!tag.StartsWith("119_MainBoomerang_", StringComparison.Ordinal))
		{
			return 0;
		}
		int length = "119_MainBoomerang_".Length;
		if (!StringParamHelper.TryParseStringParamToInt(tag.Substring(length, tag.Length - length), out var intValue))
		{
			return 0;
		}
		return intValue;
	}

	private void ReShoot(int round)
	{
		if (_actor == null || _actor.IsDead())
		{
			return;
		}
		TSVector2 normalized = _actor.tsTransform.Forward.normalized;
		LogicEntity attackTarget = _actor.attackTarget;
		if (attackTarget != null && !attackTarget.IsDead())
		{
			TSVector2 tSVector = attackTarget.tsTransform.Position - _actor.tsTransform.Position;
			if (tSVector.LengthSquared() > dirEpsilonSqr)
			{
				normalized = tSVector.normalized;
			}
		}
		AdventureBoomerang adventureBoomerang = ILRuntimeAPI.Shoot("Bullet_Soldier_119_MainSkill", _actor, _actor.tsTransform.Position, normalized) as AdventureBoomerang;
		if (adventureBoomerang == null)
		{
			NovaLogger.Warning(string.Format("[119] 回旋镖第 {0} 轮重发失败，检查别名 {1} ", round, "Bullet_Soldier_119_MainSkill") + "是否配在 RelateResource 里、且预制体上挂了 AdventureBoomerang 组件");
		}
		else
		{
			adventureBoomerang.customTag = "119_MainBoomerang_" + round;
		}
	}

	private void OnBeforeSettlement(IEvent evt)
	{
		if (_aborted || onceDamageId_Potential2 <= 0)
		{
			return;
		}
		if (distancePerStack <= 0)
		{
			NovaLogger.Warning("[119] distancePerStack 配成了 0，2星潜能的距离增伤已跳过");
		}
		else
		{
			if (!(evt is AdventureActorReceiveDamageBeforeSettlementEvent adventureActorReceiveDamageBeforeSettlementEvent) || adventureActorReceiveDamageBeforeSettlementEvent.from != _actor || !CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeSettlementEvent.hitDamageTag, damageTag_Boomerang) || !(adventureActorReceiveDamageBeforeSettlementEvent.to is AdventureActor adventureActor))
			{
				return;
			}
			int num = TSMath.CeilToInt(TSVector2.Distance(adventureActor.tsTransform.Position, _actor.tsTransform.Position) / distancePerStack);
			if (num > 0)
			{
				if (num > 10)
				{
					num = 10;
				}
				AdventureActor.AddFromAttr(onceDamageId_Potential2, _actor, num);
			}
		}
	}

	private void OnDamage(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent) || adventureActorReceiveDamageEvent.from != _actor || !CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, damageTag_skill) || !(adventureActorReceiveDamageEvent.to is AdventureActor adventureActor) || !(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController) || soldierLevelController.GetPartnerLv(HotfixEnum.ChessPartnerType.RenDaoChuanCheng) < 1 || TSRandom.Range(0, 100) >= 5)
		{
			return;
		}
		int num = _actor.logicVariable.GetLogicTagValue("119_PartnerBond_Count").AsInt() + 1;
		bool flag = num >= 3;
		_actor.logicVariable.SetLogicTagValue("119_PartnerBond_Count", (!flag) ? num : 0);
		TSVector2 position = adventureActor.tsTransform.Position;
		List<TSVector2> list = (flag ? CollectBurstExtraPositions(_actor, adventureActor) : null);
		areaEffectCount = ((areaEffectCount < 3) ? (areaEffectCount + 1) : 0);
		string fxAlias = areaEffectKeys.get_Item(areaEffectCount);
		ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position, GetFacingAngle(_actor, position));
		if (list != null)
		{
			for (int i = 0; i < list.Count; i++)
			{
				areaEffectCount = ((areaEffectCount < 3) ? areaEffectCount++ : 0);
				fxAlias = areaEffectKeys.get_Item(areaEffectCount);
				ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, list.get_Item(i), GetFacingAngle(_actor, list.get_Item(i)));
			}
		}
	}

	private FP GetFacingAngle(AdventureActor caster, TSVector2 position)
	{
		TSVector2 tSVector = position - caster.tsTransform.Position;
		if (!(tSVector.LengthSquared() > dirEpsilonSqr))
		{
			return caster.tsTransform.Rotation;
		}
		return tSVector.GetAngle();
	}

	private List<TSVector2> CollectBurstExtraPositions(AdventureActor caster, AdventureActor mainTarget)
	{
		int num = 2;
		if (num <= 0)
		{
			return null;
		}
		List<LogicEntity> list = new List<LogicEntity>();
		CommonUtils.SearchNearTargetsByCircle(caster, mainTarget.tsTransform.Position, burstSearchRange, isConfront: true, includeSelf: false, list);
		mainTarget.SearchEntitySortByDistance(list);
		List<TSVector2> list2 = null;
		for (int i = 0; i < list.Count; i++)
		{
			if (num <= 0)
			{
				break;
			}
			if (!(list.get_Item(i) is AdventureActor adventureActor) || (object)adventureActor == mainTarget)
			{
				continue;
			}
			ActorHealthInfo actorHealthInfo = adventureActor.actorHealthInfo;
			if (actorHealthInfo != null && actorHealthInfo.isAlive && !adventureActor.IsSearchedImmunity() && !(adventureActor is SoldierActor { isSupport: not false }))
			{
				if (list2 == null)
				{
					list2 = new List<TSVector2>(num);
				}
				list2.Add(adventureActor.tsTransform.Position);
				num--;
			}
		}
		return list2;
	}
}
