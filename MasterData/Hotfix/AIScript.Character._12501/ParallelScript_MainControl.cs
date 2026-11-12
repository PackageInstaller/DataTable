using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._12501;

public class ParallelScript_MainControl : ParallelScript
{
	public override void OnEnable()
	{
		base.OnEnable();
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512512, out var _))
		{
			_damageTag_TriggerWaterCorrosion?.Add(Config_MainControl.damageTag_TriggerWaterCorrosion_P12);
		}
	}

	protected override void OnSelfAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
		base.OnSelfAttacked(attackEvent);
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512506, out var perkLevel))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(12506011);
			if (buffNumByID > 0)
			{
				if (CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_A_P6))
				{
					AdventureActor.AddFromAttr(12506001, _actor, buffNumByID);
				}
				if (CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_B_P6))
				{
					AdventureActor.AddFromAttr(12506002, _actor, buffNumByID);
				}
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512508, out perkLevel) && (monsterAdventureActor.IsBossMonster() || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE) && (monsterAdventureActor.CheckTag(Config.tag_Cold) || monsterAdventureActor.isFrozen) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P8))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 12508011);
			if (TSRandom.Range(FP.Zero, 100) <= scriptValue)
			{
				AdventureActor.AddFromAttr(12508001, _actor);
			}
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512508, out var _) && monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.NORMAL && monsterAdventureActor.isFrozen && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P8))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 12508011);
			if (TSRandom.Range(FP.Zero, 100) <= scriptValue)
			{
				monsterAdventureActor.buffComponent?.RemoveBuffByTag(Config.buffTag_Frozen);
				monsterAdventureActor.Kill(_actor);
			}
		}
	}

	protected override void OnTriggerWaterCorrosion()
	{
		base.OnTriggerWaterCorrosion();
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512512, out var _))
		{
			_actor.buffComponent.AddBuff(12512011, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
	}
}
