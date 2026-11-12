using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Monster.Soldier._157;

public class Parallel : AIBase
{
	private static readonly int damageTag_MainSkill = CommonHelper.StringToHash("157_MainSkill");

	private static readonly int damageTag_NormalAttack = CommonHelper.StringToHash("157_NormalAttack");

	private const int buffId_P2 = 250104901;

	private const int buffId_P3 = 250104902;

	private const int onceAttrId_HuntBoost = 250104901;

	private const string linkFxKey = "157_SuoLian";

	private int _potentialLv = 1;

	private bool _aborted;

	private readonly HashSet<AdventureActor> _buffedTargetsThisCast = new HashSet<AdventureActor>();

	private readonly Dictionary<AdventureActor, PlayFX> _linkFxByTarget = new Dictionary<AdventureActor, PlayFX>();

	public void OnEnable()
	{
		_potentialLv = (_actor as SoldierActor).GetPotentialLv();
		_aborted = false;
		_buffedTargetsThisCast.Clear();
		if (_potentialLv >= 2)
		{
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		}
	}

	public void OnDisable()
	{
		_aborted = true;
		if (_potentialLv >= 2)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		}
		_buffedTargetsThisCast.Clear();
		StopAllLinkFx();
	}

	private void OnCastSkill(IEvent evt)
	{
		if (!_aborted && evt is AdventureActorCastSkillEvent adventureActorCastSkillEvent && adventureActorCastSkillEvent.sender == _actor && adventureActorCastSkillEvent.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.NORMAL)
		{
			_buffedTargetsThisCast.Clear();
			StopAllLinkFx();
		}
	}

	private void OnDamage(IEvent evt)
	{
		if (!_aborted && evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && !(adventureActorReceiveDamageEvent.from != _actor) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, damageTag_MainSkill) && adventureActorReceiveDamageEvent.to is AdventureActor adventureActor && !adventureActor.IsDead())
		{
			int buffId = ((_potentialLv >= 3) ? 250104902 : 250104901);
			TryBuffAndLink(adventureActor, buffId);
		}
	}

	private void OnBeforeHit(IEvent evt)
	{
		if (!_aborted && evt is AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent && !(adventureActorReceiveDamageBeforeHitEvent.from != _actor) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, damageTag_NormalAttack) && adventureActorReceiveDamageBeforeHitEvent.to is AdventureActor adventureActor && !(adventureActor.buffComponent == null) && (adventureActor.buffComponent.CheckBuffByBuffID(250104901) || adventureActor.buffComponent.CheckBuffByBuffID(250104902)))
		{
			AdventureActor.AddFromAttr(250104901, _actor);
		}
	}

	private void TryBuffAndLink(AdventureActor target, int buffId)
	{
		if (!(target == null) && !target.IsDead() && !(target.buffComponent == null) && !_buffedTargetsThisCast.Contains(target))
		{
			target.buffComponent.AddBuff(buffId, _actor);
			_buffedTargetsThisCast.Add(target);
			PlayLinkFx(target);
		}
	}

	private void PlayLinkFx(AdventureActor target)
	{
		if (!(target == null) && !(target.gameObject == null) && !(_actor.gameObject == null))
		{
			if (_linkFxByTarget.TryGetValue(target, out var value))
			{
				value?.Stop();
				value?.Clear();
			}
			PlayFX playFX = new PlayFX();
			playFX.PlayLinFx(_actor, "157_SuoLian", 1f, useCustSource: true, _actor.gameObject, default, default, target.gameObject, default, default);
			_linkFxByTarget.set_Item(target, playFX);
		}
	}

	private void OnActorDied(IEvent evt)
	{
		if (!_aborted && evt is AdventureActorDiedEvent { actor: { } actor })
		{
			StopLinkFxForTarget(actor);
		}
	}

	private void StopLinkFxForTarget(AdventureActor target)
	{
		if (!(target == null) && _linkFxByTarget.TryGetValue(target, out var value))
		{
			value?.Stop();
			value?.Clear();
			_linkFxByTarget.Remove(target);
		}
	}

	private void StopAllLinkFx()
	{
		if (_linkFxByTarget.Count == 0)
		{
			return;
		}
		foreach (PlayFX value in _linkFxByTarget.Values)
		{
			value?.Stop();
			value?.Clear();
		}
		_linkFxByTarget.Clear();
	}
}
