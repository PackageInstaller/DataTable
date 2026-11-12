using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14301;

public class ParallelScript_Support : ParallelScript
{
	private FP _lastTriggerTime_P25;

	private FP _lastTriggerTime_P32;

	public override void OnEnable()
	{
		base.OnEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514333, out var _))
		{
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
				if ((object)playerAdventureActor != null && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.AE)
				{
					_actor.buffComponent?.AddBuff(14333011, _actor);
				}
			}
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor target = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514328, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_TriggerImprove_P28))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(14328011);
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(14328001, _actor, buffNumByID);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514329, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P29))
		{
			AdventureActor.AddFromAttr(14329001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514330, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P30))
		{
			AdventureActor.AddFromAttr((beforeHitEvent.onceAttackTargetCount == 1) ? 14330002 : 14330001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514331, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P31) && CommonUtils.CheckElementMark(CommonDefine.Wind, target))
		{
			AdventureActor.AddFromAttr(14331001, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		_ = damageEvent.to;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514326, out var perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P26))
		{
			_actor.buffComponent.AddBuff(14326011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514328, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_TriggerBuff_P28))
		{
			_actor.buffComponent.AddBuff(14328011, _actor);
		}
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 514325, out perkLevel) || !CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P25))
		{
			return;
		}
		FP scriptValue = CommonUtils.GetScriptValue(_actor, 14325012);
		if ((!(_lastTriggerTime_P25 <= 0) && !(_actor.LogicTime - _lastTriggerTime_P25 > scriptValue)) || !(TSRandom.Range(FP.Zero, 100) <= CommonUtils.GetScriptValue(_actor, 14325011)))
		{
			return;
		}
		PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor;
		if (playerAdventureActor != null)
		{
			TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
			{
				shapeType = DeterministicShape.ShapeType.Circle,
				innerRadius = Config_Support.randomRadius_P25,
				radius = Config_Support.randomRadius_P25,
				position = playerAdventureActor.tsTransform.Position
			}, isReachable: false);
			TSVector2 tSVector = playerAdventureActor.tsTransform.Forward;
			if (playerAdventureActor.attackTarget != null)
			{
				tSVector = (playerAdventureActor.attackTarget.tsTransform.Position - randomPointInShape).normalized;
			}
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_143_P25_JiGuang", randomPointInShape, tSVector.GetAngle(), (AreaEffectEntity areaEffect) =>
			{
				areaEffect.tsTransform.PositionY += Config_Support.generateLaserPositionY_P25;
			});
			_lastTriggerTime_P25 = _actor.LogicTime;
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent = evt as AdventureElementMarkTriggerEvent;
		if (adventureElementMarkTriggerEvent.elementType != HotfixEnum.elementType.AE || !(adventureElementMarkTriggerEvent.triggerActor is PlayerAdventureActor playerAdventureActor) || !(playerAdventureActor != _actor) || !CommonUtils.HavePersonalPerk(_actor.dataID, 514332, out var _))
		{
			return;
		}
		FP scriptValue = CommonUtils.GetScriptValue(_actor, 14332012);
		if (_lastTriggerTime_P32 <= 0 || _actor.LogicTime - _lastTriggerTime_P32 > scriptValue)
		{
			FP scriptValue2 = CommonUtils.GetScriptValue(_actor, 14332011);
			if (TSRandom.Range(FP.Zero, 100) <= scriptValue2)
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_143_P32_LongJuanFeng", adventureElementMarkTriggerEvent.markActor.tsTransform.Position);
				_lastTriggerTime_P32 = _actor.LogicTime;
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		_lastTriggerTime_P25 = 0;
		_lastTriggerTime_P32 = 0;
	}
}
