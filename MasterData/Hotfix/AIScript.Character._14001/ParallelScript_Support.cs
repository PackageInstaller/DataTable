using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14001;

public class ParallelScript_Support : ParallelScript
{
	public override void OnEnable()
	{
		base.OnEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514031, out var perkLevel))
		{
			_actor.buffComponent.AddBuff(14031011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514032, out perkLevel))
		{
			_actor.buffComponent.AddBuff(14032011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514033, out perkLevel))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				if (actorL.actorElementInfo.elementType == HotfixEnum.elementType.SE)
				{
					actorL.buffComponent.AddBuff(14033011, _actor);
				}
			}
		}
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveSelfCustomEvent);
	}

	private void OnReceiveSelfCustomEvent(IEvent evt)
	{
		if (!(evt is AdventureActorCustomEvent adventureActorCustomEvent))
		{
			return;
		}
		if (adventureActorCustomEvent.eventHashCode == Config_Support.eventHashCode_SkillTriggerLaunchMissile)
		{
			List<TSVector2> tsVector2ParamList = adventureActorCustomEvent.tsVector2ParamList;
			if (tsVector2ParamList != null && tsVector2ParamList.Count > 0)
			{
				_actor.StartLogicCoroutine(SkillLaunchMissileLogic(adventureActorCustomEvent.tsVector2ParamList.get_Item(0)), runImmediately: true);
			}
		}
		else if (adventureActorCustomEvent.eventHashCode == Config_Support.eventHashCode_TriggerPerkLogic_P25)
		{
			_actor.StartLogicCoroutine(PerkLogic_P25(), runImmediately: true);
		}
	}

	private IEnumerator SkillLaunchMissileLogic(TSVector2 targetPosition)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_Support.delay_MissileBeginDescent_Skill));
		DeterministicShape shape = new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Circle,
			innerRadius = 0,
			radius = Config_Support.randomRadius_Missile_Skill,
			position = targetPosition
		};
		int totalMissileCount = 2;
		FP missileDescentInterval = Config_Support.interval_MissileDescent_Skill;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514021, out var _) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.SE))
		{
			totalMissileCount = 3;
			missileDescentInterval = Config_Support.interval_MissileDescent_Skill_P21;
		}
		for (int i = 0; i < totalMissileCount; i++)
		{
			targetPosition = ILRuntimeAPI.GetRandomPointInShape(_actor, shape);
			ILRuntimeAPI.Shoot("Bullet_140_Support_Skill_Boom", _actor, 0, _actor.tsTransform.Position, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(missileDescentInterval));
		}
	}

	private IEnumerator PerkLogic_P25()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_Support.delay_bulletBeginDescent_P25));
		int totalBulletCount = 4;
		int maxShootRound = 2;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514021, out var _) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.SE))
		{
			totalBulletCount = 8;
			maxShootRound = 4;
		}
		DeterministicShape shape = new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Circle,
			innerRadius = 0,
			radius = Config_Support.randomRadius_Missile_Skill,
			position = _actor.tsTransform.Position
		};
		List<LogicEntity> list = ILRuntimeAPI.SearchByRange(_actor, Config_Support.triggerRadius_P25, null, isConfront: true);
		if (list != null && list.Count > 0)
		{
			List<TSVector2> targetPositionList = new List<TSVector2>();
			for (int i = 0; i < list.Count; i++)
			{
				targetPositionList.Add(list.get_Item(i).tsTransform.Position);
			}
			int num = totalBulletCount - targetPositionList.Count * maxShootRound;
			int extraBulletCount_EveryRound = 0;
			int extraBulletCount_FirstRound = 0;
			if (num > 0)
			{
				extraBulletCount_EveryRound = num / maxShootRound;
				extraBulletCount_FirstRound = num % maxShootRound;
			}
			for (int round = 0; round < maxShootRound; round++)
			{
				if (totalBulletCount <= 0)
				{
					break;
				}
				for (int j = 0; j < targetPositionList.Count; j++)
				{
					if (totalBulletCount <= 0)
					{
						break;
					}
					Shoot(targetPositionList.get_Item(j));
				}
				if (round == 0 && extraBulletCount_FirstRound > 0 && totalBulletCount > 0)
				{
					for (int k = 0; k < extraBulletCount_FirstRound; k++)
					{
						if (totalBulletCount <= 0)
						{
							break;
						}
						Shoot(ILRuntimeAPI.GetRandomPointInShape(_actor, shape));
					}
				}
				if (extraBulletCount_EveryRound > 0 && totalBulletCount > 0)
				{
					for (int l = 0; l < extraBulletCount_EveryRound; l++)
					{
						if (totalBulletCount <= 0)
						{
							break;
						}
						Shoot(ILRuntimeAPI.GetRandomPointInShape(_actor, shape));
					}
				}
				yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_Support.interval_EveryRound_P25));
			}
		}
		else
		{
			for (int m = 0; m < totalBulletCount; m++)
			{
				Shoot(ILRuntimeAPI.GetRandomPointInShape(_actor, shape));
			}
		}
		void Shoot(TSVector2 targetPosition)
		{
			ILRuntimeAPI.Shoot("Bullet_140_Support_Skill_P25_Boom", _actor, 0, _actor.tsTransform.Position, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
			totalBulletCount--;
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514021, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P21))
		{
			AdventureActor.AddFromAttr(14021011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514023, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P23))
		{
			AdventureActor.AddFromAttr(14023011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514024, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P24))
		{
			int playerActorCountByElement = CommonUtils.GetPlayerActorCountByElement(HotfixEnum.elementType.SE);
			if (playerActorCountByElement > 0)
			{
				AdventureActor.AddFromAttr(14024011, _actor, playerActorCountByElement);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514028, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P28))
		{
			AdventureActor.AddFromAttr(14028001, _actor);
		}
	}

	protected override void OnTriggerLandMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		base.OnTriggerLandMark(monster, hitDamageTag);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514027, out var _) && CommonUtils.CheckHitByTag(hitDamageTag, Config_Support.damageTag_Trigger_P27))
		{
			_actor.buffComponent.AddBuff(14027011, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveSelfCustomEvent);
	}
}
