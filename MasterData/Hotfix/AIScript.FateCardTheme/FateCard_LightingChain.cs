#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.FateCardTheme;

public class FateCard_LightingChain : BaseFateCardTheme
{
	private readonly int damageId = 986281;

	private readonly FP cd = 2;

	private const string triggerFxPath = "light_trigger_s";

	private readonly FP targetSearchRange = 15;

	private readonly string hitFxPath = "light_lightning_01";

	private const int baseBounceTime = 2;

	private readonly FP linkCheckRange = 8;

	private readonly FP linkHitInterval = 0.2;

	private static readonly int attackTag = CommonHelper.StringToHash("lightingChain");

	private FP pro_14 = 80;

	private int dmg_14 = 986282;

	private FP radius_14 = 10;

	private FP interval_14 = 0.5;

	private FP time_14 = 3;

	private readonly string hitFx_14 = "light_lightning_01";

	private string hitFxPath_strong = "light_lightning_15";

	private int buff_15 = 986281;

	private int count_15 = 1;

	private string tagCastCount = "CastCount_Chain";

	private List<CoroutineNode> corList = new List<CoroutineNode>();

	private Dictionary<int, int> dicCount = new Dictionary<int, int>();

	private bool canLinkOnSelf;

	public override void OnEnable()
	{
		NovaLogger.Debug("FateCard_LightingChain OnEnable");
		base.OnEnable();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		foreach (CoroutineNode cor in corList)
		{
			_actor.StopLogicCoroutine(cor);
		}
		corList.Clear();
		ClearKey(tagCastCount);
	}

	protected override void OnTrigger()
	{
		NovaLogger.Debug("FateCard_LightingChain OnTrigger");
		if (CheckTimeout(cd))
		{
			Shoot(damageId, 1);
			TriggerTheme();
		}
	}

	private void Shoot(int hitDamageId, int perkSlotIndex, LogicEntity target = null)
	{
		if (target == null)
		{
			target = GetShootTarget();
		}
		if (!(target == null))
		{
			CommonUtils.PlayOneOffFx(_actor, "light_trigger_s");
			internalShoot(target, hitDamageId, perkSlotIndex);
		}
	}

	private LogicEntity GetShootTarget()
	{
		if (_actor.attackTarget != null)
		{
			return _actor.attackTarget;
		}
		LogicEntity target = null;
		ILRuntimeAPI.SearchByRange(_actor, targetSearchRange, (List<LogicEntity> result) =>
		{
			if (result.Count > 0)
			{
				_actor.SearchEntitySortByDistance(result);
				target = result.get_Item(0);
			}
		}, isConfront: true);
		return target;
	}

	private void internalShoot(LogicEntity target, int damageId, int perkSlotIndex)
	{
		AddKey(tagCastCount);
		string hitFx = hitFxPath;
		if (CanExcuteB)
		{
			hitFx = hitFxPath_strong;
		}
		CoroutineNode item = StartLogicCoroutine(LoopLinkHit(target, damageId, hitFx));
		corList.Add(item);
	}

	private IEnumerator LoopLinkHit(LogicEntity firstTarget, int damageId, string hitFx)
	{
		int linkCount = GetMaxBounceTime();
		int curLink = 0;
		List<LogicEntity> temHitList = new List<LogicEntity>();
		LogicEntity lastTaget = null;
		while (curLink < linkCount)
		{
			if (curLink == 0)
			{
				int uniqueAttackId = SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
				dicCount.Add(uniqueAttackId, curLink);
				internalHit(_actor, firstTarget, damageId, hitFx, uniqueAttackId);
				dicCount.Remove(uniqueAttackId);
				curLink++;
				temHitList.Add(firstTarget);
				lastTaget = firstTarget;
			}
			else
			{
				ILRuntimeAPI.SearchByRange(lastTaget as AdventureActor, linkCheckRange, (List<LogicEntity> result) =>
				{
					if (result.Count > 0)
					{
						if (!canLinkOnSelf && result.Contains(_actor))
						{
							result.Remove(_actor);
						}
						for (int i = 0; i < temHitList.Count; i++)
						{
							if (result.Contains(temHitList.get_Item(i)))
							{
								result.Remove(temHitList.get_Item(i));
							}
						}
					}
					if (result.Count == 0)
					{
						curLink = linkCount;
					}
					else
					{
						lastTaget.SearchEntitySortByDistance(result);
						LogicEntity logicEntity = result.get_Item(0);
						int uniqueAttackId2 = SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
						dicCount.Add(uniqueAttackId2, curLink);
						internalHit(lastTaget, logicEntity, damageId, hitFx, uniqueAttackId2);
						dicCount.Remove(uniqueAttackId2);
						temHitList.Add(logicEntity);
						lastTaget = logicEntity;
						curLink++;
					}
				});
			}
			yield return linkHitInterval;
		}
	}

	private void internalHit(LogicEntity from, LogicEntity target, int damageId, string hitFxPath, int uniqueAtkId = 0)
	{
		AdventureActor actor = _actor;
		AdventureActor target2 = target as AdventureActor;
		GameObject gameObject = from.gameObject;
		ILRuntimeAPI.HitActor(actor, target2, damageId, null, hitFxPath, attackFxPlayOnTarget: true, HitBox.FeatureFlag.None, null, default, HitBox.HurtAnimType.Small, uniqueAtkId, gameObject);
	}

	private int GetMaxBounceTime()
	{
		int num = 3;
		if (CanExcuteB)
		{
			num += count_15;
		}
		return num;
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt)
	{
		base.OnBeforeHit(evt);
		CommonUtils.CheckHitByTag(evt.hitDamageTag, attackTag);
	}

	protected override void OnHitPre(AdventureActorReceiveDamageBeforeSettlementEvent evt)
	{
		base.OnHitPre(evt);
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, attackTag))
		{
			if (CanExcuteB)
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(buff_15, _actor);
			}
			if (CanExcuteA && monsterAdventureActor != null && TSRandom.Range(0, 100) < pro_14)
			{
				CoroutineNode item = StartLogicCoroutine(SpecialHit(monsterAdventureActor, hitFx_14, time_14, dmg_14, radius_14, interval_14));
				corList.Add(item);
			}
		}
	}

	private IEnumerator SpecialHit(AdventureActor to, string hitFx, FP time, int damageId, FP radius, FP interval)
	{
		FP curTime = 0;
		List<LogicEntity> targets = new List<LogicEntity>();
		while (curTime < time)
		{
			CommonUtils.SearchNearTargetsByCircle(to, radius, isConfront: false, includeSelf: false, targets);
			for (int i = 0; i < targets.Count; i++)
			{
				internalHit(to, targets.get_Item(i), damageId, hitFx);
			}
			curTime += interval;
			yield return interval;
		}
	}
}
