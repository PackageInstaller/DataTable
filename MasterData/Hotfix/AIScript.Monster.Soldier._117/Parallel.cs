using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.Soldier._117;

public class Parallel : AIBase
{
	private static readonly int damageTag_SupportSkill = CommonHelper.StringToHash("117_B1_Skill_Hit");

	private readonly FP linkCheckRange = 10;

	private const int maxLinkTime = 5;

	private readonly int hitDamageId_link = 1011701032;

	private readonly string fxAlias_link = "fx_11701_bullet_atk_1";

	private readonly FP linkHitInterval = 0.35;

	private static readonly int damageTag_MainSkillArea = CommonHelper.StringToHash("117_B2_Skill_Hit");

	private readonly int onceDamageId_Potential2;

	private int _potentialLv = 1;

	private bool _aborted;

	private bool _chainRunning;

	private int _linkTimes;

	private readonly List<AdventureActor> _ridList = new List<AdventureActor>();

	private readonly List<LogicEntity> _searchBuffer = new List<LogicEntity>();

	private AdventureActor _triggerTarget;

	public void OnEnable()
	{
		_potentialLv = ((!(_actor is SoldierActor soldierActor)) ? 1 : soldierActor.GetPotentialLv());
		_aborted = false;
		_chainRunning = false;
		_linkTimes = 0;
		_triggerTarget = null;
		_ridList.Clear();
		_searchBuffer.Clear();
		if (_potentialLv >= 2)
		{
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		}
		if (_potentialLv >= 3)
		{
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnBeforeSettlement);
		}
	}

	public void OnDisable()
	{
		_aborted = true;
		if (_potentialLv >= 2)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		}
		if (_potentialLv >= 3)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnBeforeSettlement);
		}
		_chainRunning = false;
		_linkTimes = 0;
		_triggerTarget = null;
		_ridList.Clear();
		_searchBuffer.Clear();
	}

	private void OnDamage(IEvent evt)
	{
		if (!_aborted && !_chainRunning && evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && !(adventureActorReceiveDamageEvent.from != _actor) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, damageTag_SupportSkill) && adventureActorReceiveDamageEvent.to is AdventureActor adventureActor)
		{
			_chainRunning = true;
			_linkTimes = 0;
			_ridList.Clear();
			_triggerTarget = adventureActor;
			ExtraHit(adventureActor, adventureActor.tsTransform.Position, firstCheck: true);
		}
	}

	private void ExtraHit(AdventureActor node, TSVector2 nodePosition, bool firstCheck)
	{
		if (_aborted || _actor == null || _actor.IsDead() || node == null)
		{
			ClearExtraHit();
			return;
		}
		if (_linkTimes >= 5)
		{
			ClearExtraHit();
			return;
		}
		_ridList.Add(node);
		bool flag = node.actorHealthInfo?.isAlive ?? false;
		TSVector2 center = (flag ? node.tsTransform.Position : nodePosition);
		AdventureActor adventureActor = FindNextLinkTarget(node, flag, center);
		if (adventureActor == null)
		{
			ClearExtraHit();
			return;
		}
		AdventureActor actor = _actor;
		int hitDamageId = hitDamageId_link;
		string attackFxPath = fxAlias_link;
		GameObject gameObject = node.gameObject;
		ILRuntimeAPI.HitActor(actor, adventureActor, hitDamageId, null, attackFxPath, attackFxPlayOnTarget: true, HitBox.FeatureFlag.None, null, default, HitBox.HurtAnimType.Small, 0, gameObject);
		_linkTimes++;
		if (StartCoroutine(WaitForLinkHit(adventureActor, adventureActor.tsTransform.Position)) == null)
		{
			ClearExtraHit();
		}
	}

	private AdventureActor FindNextLinkTarget(AdventureActor node, bool nodeAlive, TSVector2 center)
	{
		_searchBuffer.Clear();
		CommonUtils.SearchNearTargetsByCircle(_actor, center, linkCheckRange, isConfront: true, includeSelf: false, _searchBuffer);
		if (nodeAlive)
		{
			node.SearchEntitySortByDistance(_searchBuffer);
		}
		for (int i = 0; i < _searchBuffer.Count; i++)
		{
			if (_searchBuffer.get_Item(i) is AdventureActor adventureActor && !IsAlreadyHit(adventureActor))
			{
				ActorHealthInfo actorHealthInfo = adventureActor.actorHealthInfo;
				if (actorHealthInfo != null && actorHealthInfo.isAlive && !adventureActor.IsSearchedImmunity() && !(adventureActor is SoldierActor { isSupport: not false }))
				{
					return adventureActor;
				}
			}
		}
		return null;
	}

	private bool IsAlreadyHit(AdventureActor actor)
	{
		for (int i = 0; i < _ridList.Count; i++)
		{
			if ((object)_ridList.get_Item(i) == actor)
			{
				return true;
			}
		}
		return false;
	}

	private IEnumerator WaitForLinkHit(AdventureActor node, TSVector2 nodePosition)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(linkHitInterval));
		if (!_aborted)
		{
			ExtraHit(node, nodePosition, firstCheck: false);
		}
	}

	private void ClearExtraHit()
	{
		_chainRunning = false;
		_linkTimes = 0;
		_triggerTarget = null;
		_ridList.Clear();
	}

	private void OnBeforeSettlement(IEvent evt)
	{
		if (!_aborted && evt is AdventureActorReceiveDamageBeforeSettlementEvent adventureActorReceiveDamageBeforeSettlementEvent && !(adventureActorReceiveDamageBeforeSettlementEvent.from != _actor) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeSettlementEvent.hitDamageTag, damageTag_MainSkillArea))
		{
			AdventureActor.AddFromAttr(onceDamageId_Potential2, _actor);
		}
	}
}
