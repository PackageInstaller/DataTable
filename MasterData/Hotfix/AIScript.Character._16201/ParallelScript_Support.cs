using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16201;

public class ParallelScript_Support : ParallelScript
{
	public override void OnEnable()
	{
		base.OnEnable();
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 516231, out var _))
		{
			return;
		}
		int playerActorCountByElement = CommonUtils.GetPlayerActorCountByElement(HotfixEnum.elementType.LE);
		foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
		{
			if (allPlayerActor.actorElementInfo.elementType == HotfixEnum.elementType.LE)
			{
				allPlayerActor.buffComponent.AddBuffNum(16231011, playerActorCountByElement, _actor);
			}
		}
	}

	protected override bool UseHugeSwordAura()
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516228, out var _))
		{
			return TSRandom.Range(0, 100) < CommonUtils.GetScriptValue(_actor, 16228011);
		}
		return base.UseHugeSwordAura();
	}

	protected override void OnPlayerCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnPlayerCastSkill(castSkillEvent);
		PlayerAdventureActor playerAdventureActor = castSkillEvent.sender as PlayerAdventureActor;
		if (castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.LE)
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516232, out var perkLevel) && !playerAdventureActor.isAssist)
			{
				_actor.buffComponent.AddBuff(16232011, _actor);
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516233, out perkLevel))
			{
				_actor.buffComponent.AddBuff(16233011, _actor);
			}
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516227, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P27))
		{
			AdventureActor.AddFromAttr(16227001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516228, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P28))
		{
			AdventureActor.AddFromAttr(16228001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516230, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P30))
		{
			AdventureActor.AddFromAttr(16230001, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516226, out var perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P26))
		{
			_actor.buffComponent.AddBuff(16226011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516229, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P29))
		{
			_actor.buffComponent.AddBuff(16229011, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
	}
}
