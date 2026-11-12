#define LOG_ERROR
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12501;

public class ParallelScript_Support : ParallelScript
{
	private FP _lastTriggerTime_P24;

	private FP _lastTriggerTime_P28;

	private Queue<IceFlower> _iceFlowerPool;

	public override void OnEnable()
	{
		base.OnEnable();
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512531, out var _))
		{
			bool flag = true;
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				if (SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).actorElementInfo.elementType != HotfixEnum.elementType.WE)
				{
					flag = false;
					break;
				}
			}
			if (flag)
			{
				for (int j = 0; j < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; j++)
				{
					SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(j).buffComponent?.AddBuff(12531011, _actor);
				}
			}
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("PLAYER_SPAWN_COMPLETE", OnPlayerSpawnComplete);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	private void OnPlayerSpawnComplete(IEvent _)
	{
		if (((PlayerAdventureActor)_actor).status == ActorStatus.Special && ((PlayerAdventureActor)_actor).specialStatusTime > 0)
		{
			SceneSingleton<AdventurePlayerController>.Instance.ActiveActor(_actor as PlayerAdventureActor);
		}
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = evt as AdventureActorCustomEvent;
		if (!(adventureActorCustomEvent.actor != _actor) && adventureActorCustomEvent.eventHashCode == Config_Support.eventHashCode_BeginGenIceFlower)
		{
			_actor.StartLogicCoroutine(SkillLogic(), runImmediately: true);
		}
	}

	private IEnumerator SkillLogic()
	{
		string fxAlias = "fx_12501_base_B1_Skill_IceFlower_Trail_Rage";
		int totalFlowerCount_OnceLine = 6;
		FP distance_BetweenTwoFlower = Config_Support.distance_BetweenTwoFlower;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512522, out var _))
		{
			fxAlias = "fx_12501_base_B1_Skill_IceFlower_Trail_Rage";
			totalFlowerCount_OnceLine = 8;
			distance_BetweenTwoFlower = Config_Support.distance_BetweenTwoFlower_P22;
		}
		TSVector2 startPosition = _actor.tsTransform.Position + _actor.tsTransform.Forward * Config_Support.offset_FirstIceFlower;
		List<TSVector2> iceFlowerLineDirList = new List<TSVector2>(4);
		TSVector2 forward = _actor.tsTransform.Forward;
		int num = 3;
		if (num > 1)
		{
			Config_Support.includedAngleDic_IceFlowerLine.TryGetValue(num, out var value);
			if (value <= 0)
			{
				NovaLogger.Error($"冰花夹角配置有误,条数:{num}");
			}
			FP fP = value * (num - 1) * 0.5f;
			for (int i = 0; i < num; i++)
			{
				iceFlowerLineDirList.Add(TSVector2.Rotate(forward, -fP + value * i).normalized);
			}
		}
		else
		{
			iceFlowerLineDirList.Add(forward);
		}
		for (int j = 0; j < iceFlowerLineDirList.Count; j++)
		{
			PlayFX playFX = new PlayFX();
			playFX.Play(_actor, null, fxAlias, default, startPosition, iceFlowerLineDirList.get_Item(j));
			playFX.Clear();
		}
		int uniqueAttackId_Blossom = SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
		int uniqueAttackId_Explosion = SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
		int delayExplosionFrame = totalFlowerCount_OnceLine * 3 + 15;
		GenerateIceFlower(startPosition, 125320001, 125320002, delayExplosionFrame, uniqueAttackId_Blossom, uniqueAttackId_Explosion);
		for (int flowerIndex_Line = 1; flowerIndex_Line < totalFlowerCount_OnceLine; flowerIndex_Line++)
		{
			yield return 3;
			delayExplosionFrame -= 3;
			for (int k = 0; k < iceFlowerLineDirList.Count; k++)
			{
				TSVector2 position = startPosition + distance_BetweenTwoFlower * iceFlowerLineDirList.get_Item(k) * flowerIndex_Line;
				GenerateIceFlower(position, 125320001, 125320002, delayExplosionFrame, uniqueAttackId_Blossom, uniqueAttackId_Explosion);
			}
		}
	}

	protected override void OnSelfAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
		base.OnSelfAttacked(attackEvent);
		MonsterAdventureActor monsterAdventureActor = attackEvent.to as MonsterAdventureActor;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512523, out var perkLevel) && _actor.buffComponent.CheckBuffByBuffID(12523011) && CommonUtils.CheckHitByTag(attackEvent.hitDamageTag, Config_Support.damageTag_Trigger_P23) && TSRandom.Range(FP.Zero, 100) <= Config_Support.triggerRate_P23)
		{
			_actor.StartLogicCoroutine(PerkLogic_P23(monsterAdventureActor));
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512524, out perkLevel) && (_lastTriggerTime_P24 <= 0 || _actor.LogicTime - _lastTriggerTime_P24 > Config_Support.triggerCD_P24) && CommonUtils.CheckHitByTag(attackEvent.hitDamageTag, Config_Support.damageTag_Trigger_P24) && (monsterAdventureActor.CheckTag(Config.tag_Cold) || monsterAdventureActor.isFrozen))
		{
			_actor.StartLogicCoroutine(PerkLogic_P24(monsterAdventureActor.tsTransform.Position));
			_lastTriggerTime_P24 = _actor.LogicTime;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512525, out perkLevel) && CommonUtils.CheckHitByTag(attackEvent.hitDamageTag, Config_Support.damageTag_Trigger_P25))
		{
			monsterAdventureActor.buffComponent?.AddBuff(12525001, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512528, out perkLevel) && (_lastTriggerTime_P28 <= 0 || _actor.LogicTime - _lastTriggerTime_P28 > Config_Support.triggerCD_P28) && (monsterAdventureActor.CheckTag(Config.tag_Cold) || monsterAdventureActor.isFrozen) && CommonUtils.CheckHitByTag(attackEvent.hitDamageTag, Config_Support.damageTag_Trigger_P28))
		{
			_actor.buffComponent?.AddBuff(12528011, _actor);
			_lastTriggerTime_P28 = _actor.LogicTime;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512532, out perkLevel) && CommonUtils.CheckHitByTag(attackEvent.hitDamageTag, Config_Support.damageTag_Trigger_P32))
		{
			monsterAdventureActor.buffComponent?.AddBuff(4011, _actor);
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512521, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_P21))
		{
			AdventureActor.AddFromAttr(12521011, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512522, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_P22))
		{
			AdventureActor.AddFromAttr(12522011, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512526, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_P26))
		{
			int buffNumByID = monsterAdventureActor.buffComponent.GetBuffNumByID(12526011);
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(12526001, _actor, buffNumByID);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512532, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P32))
		{
			AdventureActor.AddFromAttr(12532001, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512526, out var _) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P26))
		{
			monsterAdventureActor.buffComponent?.AddBuff(12526011, _actor);
		}
	}

	private IEnumerator PerkLogic_P23(MonsterAdventureActor target)
	{
		FP delayTime = Config_Support.delayGenerateTime_IceFlower_P23;
		TSVector2 position = target.tsTransform.Position;
		long targetId = target.Id;
		while (delayTime > 0)
		{
			if (CommonUtils.CheckTargetIsValid(target, targetId))
			{
				position = target.tsTransform.Position;
			}
			delayTime -= _actor.LogicDeltaTime;
			yield return null;
		}
		GenerateIceFlower(position, 125322301, 125322302, 30);
	}

	private IEnumerator PerkLogic_P24(TSVector2 position)
	{
		yield return null;
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_125_Main_P24_IceAOE", position);
	}

	private void GenerateIceFlower(TSVector2 position, int blossomHitDamageId, int explosionHitDamageId, int delayExplosionFrame = 0, int blossomUniqueAttackId = 0, int explosionUniqueAttackId = 0)
	{
		GetIceFlower().Blossom(position, blossomHitDamageId, explosionHitDamageId, delayExplosionFrame, blossomUniqueAttackId, explosionUniqueAttackId);
	}

	private void OnIceFlowerFinish(IceFlower iceFlower)
	{
		if (iceFlower != null)
		{
			RecycleIceFlower(iceFlower);
		}
	}

	private void Clear()
	{
		_iceFlowerPool?.Clear();
		_lastTriggerTime_P24 = 0;
		_lastTriggerTime_P28 = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("PLAYER_SPAWN_COMPLETE", OnPlayerSpawnComplete);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		Clear();
	}

	private IceFlower GetIceFlower()
	{
		IceFlower iceFlower = ((_iceFlowerPool == null || _iceFlowerPool.Count <= 0) ? new IceFlower() : _iceFlowerPool.Dequeue());
		iceFlower.Steup(_actor, OnIceFlowerFinish);
		return iceFlower;
	}

	private void RecycleIceFlower(IceFlower iceFlower)
	{
		if (iceFlower != null)
		{
			iceFlower.Clear();
			if (_iceFlowerPool == null)
			{
				_iceFlowerPool = new Queue<IceFlower>();
			}
			_iceFlowerPool.Enqueue(iceFlower);
		}
	}
}
