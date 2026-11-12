using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15601;

public class ParallelScript_MainControl : ParallelScript
{
	private int _summonedCount;

	private bool _isSkillInCD;

	private FP _lastTriggerTime_P8;

	public override void OnEnable()
	{
		base.OnEnable();
		_summonedCount = 0;
		_isSkillInCD = false;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515612, out var _))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				if (actorL.actorElementInfo.elementType == HotfixEnum.elementType.SE)
				{
					actorL.buffComponent.AddBuff(15612011, _actor);
				}
			}
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_NODAMAGE", OnReceiveNoDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_BEGIN_RELOAD", OnBeginReload);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_END_RELOAD", OnEndReload);
	}

	public override void OnUpdate()
	{
		UpdateSummonedCount(_actor.logicVariable.GetLogicTagValue("SummonedCount").AsInt());
		UpdateSkillCDState(((PlayerAdventureActor)_actor).playerSkillCd.GetSkillCD(ActionKey.B).currentResumeTime > 0);
	}

	private void UpdateSummonedCount(int summonedCount)
	{
		if (_summonedCount == summonedCount)
		{
			return;
		}
		_summonedCount = summonedCount;
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 515606, out var _))
		{
			return;
		}
		if (_summonedCount > 0)
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				if (!actorL.buffComponent.CheckBuffByBuffID(15606011))
				{
					actorL.buffComponent.AddBuff(15606011, _actor);
				}
			}
			return;
		}
		foreach (PlayerAdventureActor actorL2 in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			actorL2.buffComponent.RemoveBuffByBuffId(15606011);
		}
	}

	private void UpdateSkillCDState(bool isSkillInCD)
	{
		if (_isSkillInCD == isSkillInCD)
		{
			return;
		}
		_isSkillInCD = isSkillInCD;
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 515610, out var _))
		{
			return;
		}
		if (_isSkillInCD)
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				actorL.buffComponent.AddBuff(15610011, _actor);
			}
			return;
		}
		foreach (PlayerAdventureActor actorL2 in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			actorL2.buffComponent.RemoveBuffByBuffId(15610011);
		}
	}

	private void OnReceiveNoDamage(IEvent evt)
	{
		AdventureActorNoDamageEvent adventureActorNoDamageEvent = evt as AdventureActorNoDamageEvent;
		if (adventureActorNoDamageEvent.from.IsPlayerSummoned(out var summoner, out var _) && summoner == _actor && Config_MainControl.hitDamageIdMapping.TryGetValue(adventureActorNoDamageEvent.hitDamageConfigId, out var value))
		{
			AdventureActor adventureActor = adventureActorNoDamageEvent.to as AdventureActor;
			if (adventureActor != null)
			{
				ILRuntimeAPI.HitActor(_actor, adventureActor, value, null, null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, uniqueAttackId: adventureActorNoDamageEvent.uniqueAttackId, damageImmuneDuration: -1, hurtAnimType: HitBox.HurtAnimType.None);
			}
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515605, out var _) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P5))
		{
			AdventureActor.AddFromAttr(15605001, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515601, out var perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P1))
		{
			monsterAdventureActor.buffComponent.AddBuff(15601011, _actor);
		}
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 515608, out perkLevel))
		{
			return;
		}
		FP scriptValue = CommonUtils.GetScriptValue(_actor, 15608012);
		if ((_lastTriggerTime_P8 <= 0 || _actor.LogicTime - _lastTriggerTime_P8 > scriptValue) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P8))
		{
			FP scriptValue2 = CommonUtils.GetScriptValue(_actor, 15608011);
			if (TSRandom.Range(FP.Zero, 100) <= scriptValue2)
			{
				TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Forward * Config_MainControl.shootOffset_P8;
				ILRuntimeAPI.ShootByDirection("Bullet_156_P8_Egg", _actor, default, _actor.tsTransform.Forward, position, Config_MainControl.shootPositionY_P8);
				_lastTriggerTime_P8 = _actor.LogicTime;
			}
		}
	}

	private void OnBeginReload(IEvent evt)
	{
		if (!(evt is AdventureActorBeginReload adventureActorBeginReload) || !(adventureActorBeginReload.sender as AdventureActor == _actor))
		{
			return;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515607, out var perkLevel))
		{
			_actor.buffComponent.AddBuff(15607011, _actor);
		}
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 515609, out perkLevel))
		{
			return;
		}
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (actorL.isAssist)
			{
				actorL.buffComponent.AddBuff(15609011, _actor);
			}
		}
	}

	private void OnEndReload(IEvent evt)
	{
		if (evt is AdventureActorEndReload adventureActorEndReload && adventureActorEndReload.sender as AdventureActor == _actor && CommonUtils.HavePersonalPerk(_actor.dataID, 515604, out var _))
		{
			ILRuntimeAPI.CreateSkill(15631004, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_NODAMAGE", OnReceiveNoDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_BEGIN_RELOAD", OnBeginReload);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_END_RELOAD", OnEndReload);
		_summonedCount = 0;
		_isSkillInCD = false;
		_lastTriggerTime_P8 = 0;
	}
}
