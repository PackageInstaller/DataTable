using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11501;

public class ParallelScript_Support : ParallelScript
{
	private FP _lastTriggerTime_P26;

	private FP _lastTriggerTime_P30;

	public override void OnEnable()
	{
		base.OnEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511531, out var perkLevel))
		{
			_damageTag_AddLightMark?.Add(Config_Support.damageTag_AddLightMark_P31);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511533, out perkLevel) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.LE))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				actorL.buffComponent.AddBuff(11533011, _actor);
			}
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("PLAYER_SPAWN_COMPLETE", OnPlayerSpawnComplete);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_ENTER", OnPlayerEnter);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_LEAVE", OnPlayerLeave);
	}

	private void OnPlayerSpawnComplete(IEvent _)
	{
		if (((PlayerAdventureActor)_actor).status == ActorStatus.Special && ((PlayerAdventureActor)_actor).specialStatusTime > 0)
		{
			SceneSingleton<AdventurePlayerController>.Instance.ActiveActor(_actor as PlayerAdventureActor);
		}
	}

	private void OnPlayerEnter(IEvent evt)
	{
		if (!(evt is AdventurePlayerEnterEvent adventurePlayerEnterEvent) || !(adventurePlayerEnterEvent.player == _actor) || !CommonUtils.HavePersonalPerk(_actor.dataID, 511533, out var _) || !CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.LE))
		{
			return;
		}
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			actorL.buffComponent.AddBuff(11533012, _actor);
		}
	}

	private void OnPlayerLeave(IEvent evt)
	{
		if (!(evt is AdventurePlayerLeaveEvent adventurePlayerLeaveEvent) || !(adventurePlayerLeaveEvent.player == _actor) || !CommonUtils.HavePersonalPerk(_actor.dataID, 511533, out var _))
		{
			return;
		}
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			actorL.buffComponent.RemoveBuffByBuffId(11533012);
		}
	}

	protected override void OnSelfCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnSelfCastSkill(castSkillEvent);
		if (castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D && CommonUtils.HavePersonalPerk(_actor.dataID, 511531, out var _))
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor;
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.LE)
			{
				playerAdventureActor.actorShield.AddShield(11531001, _actor);
			}
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511521, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P21))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(11521011);
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(11521011, _actor, buffNumByID);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511522, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_AddDamage_P22))
		{
			AdventureActor.AddFromAttr(11522011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511523, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P23) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.LE))
		{
			AdventureActor.AddFromAttr(11523011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511525, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P25))
		{
			int buffNumByID2 = _actor.buffComponent.GetBuffNumByID(11525013);
			if (buffNumByID2 > 0)
			{
				AdventureActor.AddFromAttr(11525001, _actor, buffNumByID2);
			}
			buffNumByID2 = _actor.buffComponent.GetBuffNumByID(11525015);
			if (buffNumByID2 > 0)
			{
				AdventureActor.AddFromAttr(11525002, _actor, buffNumByID2);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511528, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P28))
		{
			int buffNumByID3 = _actor.buffComponent.GetBuffNumByID(11528011);
			if (buffNumByID3 > 0)
			{
				AdventureActor.AddFromAttr(11528001, _actor, buffNumByID3);
			}
		}
	}

	protected override void OnPlayerDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerDamaged(damageEvent);
		PlayerAdventureActor playerAdventureActor = damageEvent.from as PlayerAdventureActor;
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (monsterAdventureActor == null || !(playerAdventureActor == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor) || playerAdventureActor.actorElementInfo.elementType != HotfixEnum.elementType.LE || !CommonUtils.HavePersonalPerk(_actor.dataID, 511526, out var perkLevel))
		{
			return;
		}
		FP scriptValue = CommonUtils.GetScriptValue(_actor, 11526011);
		if ((_lastTriggerTime_P26 <= 0 || _actor.LogicTime - _lastTriggerTime_P26 > scriptValue) && damageEvent.damageType == HotfixEnum.damageType.SKILL)
		{
			string text = "Bullet_11501_Support_Skill_P26_Boom";
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 511522, out perkLevel))
			{
				text = "Bullet_11501_Support_Skill_P26P21_Boom_Strengthen";
			}
			if (!string.IsNullOrEmpty(text))
			{
				string bulletAlias = text;
				AdventureActor actor = _actor;
				FP range = 0;
				TSVector2 position = damageEvent.from.tsTransform.Position;
				TSVector2 position2 = monsterAdventureActor.tsTransform.Position;
				ILRuntimeAPI.Shoot(bulletAlias, actor, range, position, default, position2, null, AimType.Position, BulletDirectionType.BulletToTarget);
			}
			_lastTriggerTime_P26 = _actor.LogicTime;
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511521, out var perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P21))
		{
			_actor.buffComponent.AddBuff(11521011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511522, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P22) && !string.IsNullOrEmpty("AreaEffect_11501_Support_Skill_P22_Boom"))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_11501_Support_Skill_P22_Boom", monsterAdventureActor.tsTransform.Position);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511526, out perkLevel) && monsterAdventureActor != null && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P26))
		{
			int buffNum = monsterAdventureActor.buffComponent.GetBuffNum(0, 0, Config_Support.buffTag_Check_P26);
			if (buffNum > 0)
			{
				monsterAdventureActor.buffComponent.AddBuffNum(11526011, buffNum, _actor);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511527, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P27))
		{
			_actor.buffComponent.AddBuff(11527011, _actor);
		}
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 511530, out perkLevel))
		{
			return;
		}
		FP scriptValue = CommonUtils.GetScriptValue(_actor, 11530011);
		if ((_lastTriggerTime_P30 <= 0 || _actor.LogicTime - _lastTriggerTime_P30 > scriptValue) && monsterAdventureActor != null && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P30))
		{
			if (!string.IsNullOrEmpty("AreaEffect_11501_Support_Skill_P30_Aoe"))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_11501_Support_Skill_P30_Aoe", monsterAdventureActor.tsTransform.Position);
			}
			_lastTriggerTime_P30 = _actor.LogicTime;
		}
	}

	protected override void OnLightMarkTrigger(AdventureElementMarkTriggerEvent markTriggerEvent)
	{
		base.OnLightMarkTrigger(markTriggerEvent);
		if (markTriggerEvent.triggerActor.actorElementInfo.elementType != HotfixEnum.elementType.LE || !(markTriggerEvent.triggerActor == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor))
		{
			return;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511525, out var perkLevel))
		{
			if (markTriggerEvent.markTriggerType == HotfixEnum.AdventureActorElementTriggerType.LightElementTriggerType2)
			{
				_actor.buffComponent.AddBuff(11525011, _actor);
			}
			_actor.buffComponent.AddBuff(11525014, _actor);
		}
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 511529, out perkLevel) || _actor.state != ActorState.Action || markTriggerEvent.markTriggerType != HotfixEnum.AdventureActorElementTriggerType.LightElementTriggerType1)
		{
			return;
		}
		List<LogicEntity> list = ILRuntimeAPI.SearchByRange(_actor, CommonUtils.GetScriptValue(_actor, 11529011), null, isConfront: true);
		if (list != null && list.Count > 0)
		{
			foreach (LogicEntity item in list)
			{
				if (item is MonsterAdventureActor monsterAdventureActor)
				{
					monsterAdventureActor.buffComponent.AddBuff(11529011, _actor);
				}
			}
		}
		_actor.buffComponent.AddBuff(11529012, _actor);
	}

	private void Clear()
	{
		_lastTriggerTime_P26 = 0;
		_lastTriggerTime_P30 = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("PLAYER_SPAWN_COMPLETE", OnPlayerSpawnComplete);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_ENTER", OnPlayerEnter);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_LEAVE", OnPlayerLeave);
		Clear();
	}
}
