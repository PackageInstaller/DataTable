using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13401;

public class ParallelScript_Support : ParallelScript
{
	private CoroutineNode _perkLogicCor_P27;

	public override void OnEnable()
	{
		base.OnEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513433, out var _))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				if (actorL.actorElementInfo.elementType == HotfixEnum.elementType.FE)
				{
					actorL.buffComponent.AddBuff(13433011, _actor);
				}
			}
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_ENTER", OnActorEnter);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_LEAVE", OnActorLeave);
	}

	private void OnActorEnter(IEvent evt)
	{
		if (evt is AdventurePlayerEnterEvent adventurePlayerEnterEvent && adventurePlayerEnterEvent.player == _actor && CommonUtils.HavePersonalPerk(_actor.dataID, 513427, out var _))
		{
			if (_perkLogicCor_P27 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P27);
			}
			_perkLogicCor_P27 = null;
		}
	}

	private void OnActorLeave(IEvent evt)
	{
		if (evt is AdventurePlayerLeaveEvent adventurePlayerLeaveEvent && adventurePlayerLeaveEvent.player == _actor && CommonUtils.HavePersonalPerk(_actor.dataID, 513427, out var _))
		{
			if (_perkLogicCor_P27 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P27);
			}
			_perkLogicCor_P27 = _actor.StartLogicCoroutine(PerkLogic_27());
		}
	}

	private IEnumerator PerkLogic_27()
	{
		FP interval = Config_Support.addBuffInterval_P27;
		while (true)
		{
			if (interval > 0)
			{
				interval -= _actor.LogicDeltaTime;
			}
			else
			{
				_actor.buffComponent.AddBuff(13427011, _actor);
				interval = Config_Support.addBuffInterval_P27;
			}
			yield return null;
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513431, out var _) && (monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monsterAdventureActor.IsBossMonster()))
		{
			AdventureActor.AddFromAttr(13431001, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor target = damageEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513428, out var perkLevel) && !damageEvent.isKill && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P28))
		{
			ILRuntimeAPI.HitActor(_actor, target, 134528001, "fx_13401_hit_Normal", null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, -1);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513432, out perkLevel) && damageEvent.isKill && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Skill))
		{
			_actor.buffComponent.AddBuff(13432011, _actor);
		}
	}

	private void Clear()
	{
		if (_perkLogicCor_P27 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P27);
		}
		_perkLogicCor_P27 = null;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_ENTER", OnActorEnter);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_LEAVE", OnActorLeave);
		Clear();
	}
}
