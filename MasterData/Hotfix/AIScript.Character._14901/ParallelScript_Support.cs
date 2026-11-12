using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14901;

public class ParallelScript_Support : ParallelScript
{
	public override void OnEnable()
	{
		base.OnEnable();
		if (GetPerk(514933))
		{
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				if (SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).actorElementInfo.elementType == HotfixEnum.elementType.SE)
				{
					_actor.buffComponent.AddBuff(14933011, _actor);
				}
			}
		}
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_REMOVE_BUFF", OnBuffRemove);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnBuffRemove);
	}

	private void OnBuffRemove(IEvent evt)
	{
		AdventureActorRemoveBuff adventureActorRemoveBuff = evt as AdventureActorRemoveBuff;
		if (GetPerk(514927) && adventureActorRemoveBuff.eventInfo.iRemoveNature && (adventureActorRemoveBuff.eventInfo.buffId == 14927011 || adventureActorRemoveBuff.eventInfo.buffId == 14927012))
		{
			ILRuntimeAPI.HitActor(_actor, adventureActorRemoveBuff.sender as AdventureActor, 149327101, null, null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, -1);
		}
	}

	protected override void OnBeforeHitEvent(AdventureActorReceiveDamageBeforeHitEvent evt)
	{
		base.OnBeforeHitEvent(evt);
		if (!(evt.from == _actor) || !(evt.to is MonsterAdventureActor monsterAdventureActor))
		{
			return;
		}
		if (GetPerk(514921) && CommonUtils.CheckHitByTag(evt.hitDamageTag, Config_Support.damageTag_Chain))
		{
			AdventureActor.AddFromAttr(14921011, _actor);
		}
		if (GetPerk(514922) && CommonUtils.CheckHitByTag(evt.hitDamageTag, Config_Support.damageTag_Chain))
		{
			AdventureActor.AddFromAttr(14922011, _actor);
		}
		if (GetPerk(514924) && CommonUtils.CheckHitByTag(evt.hitDamageTag, Config_Support.damageTag_Earthquake))
		{
			AdventureActor.AddFromAttr(14924011, _actor);
		}
		if (GetPerk(514926) && CommonUtils.CheckHitByTag(evt.hitDamageTag, Config_Support.damageTag_Chain))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 14926011);
			if (monsterAdventureActor.actorHealthInfo.hpPercentage * 100 < scriptValue)
			{
				AdventureActor.AddFromAttr(14926001, _actor);
			}
		}
		if (GetPerk(514928) && CommonUtils.CheckHitByTag(evt.hitDamageTag, Config_Support.damageTag_B2))
		{
			int num = (int)(long)(_actor.LogicTime - Config_Support.supportSkillBeginTime);
			num = ((num < 1) ? 1 : num);
			AdventureActor.AddFromAttr(14928001, _actor, num);
		}
		if (GetPerk(514929) && CommonUtils.CheckHitByTag(evt.hitDamageTag, Config_Support.damageTag_Earthquake))
		{
			AdventureActor.AddFromAttr(14929001, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		if (!(damageEvent.to is MonsterAdventureActor monsterAdventureActor) || !GetPerk(514927) || !CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Chain))
		{
			return;
		}
		if (monsterAdventureActor.buffComponent.CheckBuffByBuffID(14927011))
		{
			if (!monsterAdventureActor.buffComponent.CheckBuffByBuffID(14927012))
			{
				monsterAdventureActor.buffComponent.AddBuff(14927012, _actor);
			}
		}
		else
		{
			monsterAdventureActor.buffComponent.AddBuff(14927011, _actor);
		}
	}

	protected override void OnCastSkill(PlayerAdventureActor actor, AdventureActorCastSkillEvent skiillEvet)
	{
		base.OnCastSkill(actor, skiillEvet);
		if ((skiillEvet.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B || skiillEvet.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D) && actor.Id != _actor.Id && GetPerk(514932))
		{
			_actor.buffComponent.AddBuff(14932011, _actor);
		}
	}
}
