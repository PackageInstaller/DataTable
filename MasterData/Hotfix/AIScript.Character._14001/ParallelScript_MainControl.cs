using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14001;

public class ParallelScript_MainControl : ParallelScript
{
	private FP _lastTriggerTime_P9;

	public override void OnEnable()
	{
		base.OnEnable();
		_lastTriggerTime_P9 = 0;
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveSelfCustomEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
	}

	private void OnReceiveSelfCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && CommonUtils.HavePersonalPerk(_actor.dataID, 514011, out var _) && adventureActorCustomEvent.eventHashCode == Config_MainControl.eventHashCode_TriggerLogic_P11)
		{
			_actor.StartLogicCoroutine(PerkLogic_P11(), runImmediately: true);
		}
	}

	private IEnumerator PerkLogic_P11()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_MainControl.shootDelayTime_P11));
		int num = 6;
		List<LogicEntity> list = ILRuntimeAPI.SearchByRange(_actor, Config_MainControl.triggerRadius_P11, null, isConfront: true);
		if (list != null && list.Count > 0)
		{
			for (int i = 0; i < list.Count; i++)
			{
				if (num <= 0)
				{
					break;
				}
				TSVector2 position = list.get_Item(i).tsTransform.Position;
				AdventureActor actor = _actor;
				FP range = 0;
				TSVector2 position2 = _actor.tsTransform.Position;
				TSVector2 targetPosition = position;
				ILRuntimeAPI.Shoot("Bullet_140_P11_Boom", actor, range, position2, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
				num--;
			}
		}
		if (num > 0)
		{
			DeterministicShape shape = new DeterministicShape
			{
				shapeType = DeterministicShape.ShapeType.Circle,
				innerRadius = 0,
				radius = Config_MainControl.triggerRadius_P11,
				position = _actor.tsTransform.Position
			};
			for (int j = 0; j < num; j++)
			{
				TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, shape);
				AdventureActor actor2 = _actor;
				FP range2 = 0;
				TSVector2 position3 = shape.position;
				TSVector2 targetPosition = randomPointInShape;
				ILRuntimeAPI.Shoot("Bullet_140_P11_Boom", actor2, range2, position3, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
			}
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (!(evt is AdventureBulletFinishEvent adventureBulletFinishEvent))
		{
			return;
		}
		AdventureBulletBase adventureBulletBase = adventureBulletFinishEvent.sender as AdventureBulletBase;
		if (!(adventureBulletFinishEvent.owner == _actor) || !CommonUtils.HavePersonalPerk(_actor.dataID, 514009, out var perkLevel))
		{
			return;
		}
		if (adventureBulletBase.CheckBulletTag(Config_MainControl.bulletTag_Trigger_P9))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 14009011);
			if (_lastTriggerTime_P9 <= 0 || _actor.LogicTime - _lastTriggerTime_P9 > scriptValue)
			{
				DeterministicShape shape = new DeterministicShape
				{
					shapeType = DeterministicShape.ShapeType.Circle,
					innerRadius = 0,
					radius = Config_MainControl.randomRadius_P9,
					position = adventureBulletBase.tsTransform.Position
				};
				for (int i = 0; i < 5; i++)
				{
					TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, shape);
					AdventureActor actor = _actor;
					FP range = 0;
					TSVector2 position = shape.position;
					TSVector2 targetPosition = randomPointInShape;
					ILRuntimeAPI.Shoot("Bullet_140_Tank_P09", actor, range, position, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
				}
				_lastTriggerTime_P9 = _actor.LogicTime;
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514003, out perkLevel) && adventureBulletBase.CheckBulletTag(Config_MainControl.bulletTag_Trigger_P3_P9))
		{
			DeterministicShape shape2 = new DeterministicShape
			{
				shapeType = DeterministicShape.ShapeType.Circle,
				innerRadius = 0,
				radius = Config_MainControl.randomRadius_P3_P9,
				position = adventureBulletBase.tsTransform.Position
			};
			for (int j = 0; j < 10; j++)
			{
				TSVector2 randomPointInShape2 = ILRuntimeAPI.GetRandomPointInShape(_actor, shape2);
				AdventureActor actor2 = _actor;
				FP range2 = 0;
				TSVector2 position2 = shape2.position;
				TSVector2 targetPosition = randomPointInShape2;
				ILRuntimeAPI.Shoot("Bullet_140_Tank_P09", actor2, range2, position2, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
			}
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor bEntity = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514001, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_AddDamage_P1) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.SE))
		{
			AdventureActor.AddFromAttr(14001011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514002, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_AddDamage_P2))
		{
			AdventureActor.AddFromAttr(14002011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514003, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_AddDamage_P3) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.SE))
		{
			AdventureActor.AddFromAttr(14003011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514004, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P4))
		{
			AdventureActor.AddFromAttr(14004011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514009, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_AddDamage_P9))
		{
			AdventureActor.AddFromAttr(14009001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514013, out perkLevel) && _actor.DistanceWithRadius(bEntity) > CommonUtils.GetScriptValue(_actor, 14013011))
		{
			AdventureActor.AddFromAttr(14013001, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 514002, out var _) || !CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P2))
		{
			return;
		}
		if (monsterAdventureActor.buffComponent.CheckBuffByBuffID(14002012))
		{
			ILRuntimeAPI.HitActor(_actor, monsterAdventureActor, 140502001, null, null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, -1);
			return;
		}
		monsterAdventureActor.buffComponent.AddBuff(14002011, _actor);
		if (monsterAdventureActor.buffComponent.GetBuffNumByID(14002011) >= 20)
		{
			monsterAdventureActor.buffComponent.RemoveBuffByBuffId(14002011);
			monsterAdventureActor.buffComponent.AddBuff(14002012, _actor);
			monsterAdventureActor.buffComponent.AddBuff(14002013, _actor);
		}
	}

	protected override void OnTriggerLandMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		base.OnTriggerLandMark(monster, hitDamageTag);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514005, out var _) && CommonUtils.CheckHitByTag(hitDamageTag, Config_MainControl.damageTag_Trigger_P5))
		{
			_actor.buffComponent.AddBuff(14005011, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveSelfCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		_lastTriggerTime_P9 = 0;
	}
}
