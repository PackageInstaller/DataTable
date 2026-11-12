using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13901;

public class ParallelScript_Support : ParallelScript
{
	private CoroutineNode _perkLogicCor_P27;

	public override void OnEnable()
	{
		base.OnEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513933, out var _) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.WE))
		{
			foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
			{
				allPlayerActor.buffComponent.AddBuff(13933011, _actor);
			}
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_ENTER", OnPlayerEnterBattle);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_LEAVE", OnPlayerLeaveBattle);
	}

	private void OnPlayerEnterBattle(IEvent evt)
	{
		if (evt is AdventurePlayerEnterEvent adventurePlayerEnterEvent && adventurePlayerEnterEvent.player == _actor && CommonUtils.HavePersonalPerk(_actor.dataID, 513927, out var _))
		{
			if (_perkLogicCor_P27 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P27);
			}
			_perkLogicCor_P27 = _actor.StartLogicCoroutine(PerkLogic_P27(), runImmediately: true);
		}
	}

	private IEnumerator PerkLogic_P27()
	{
		while (true)
		{
			yield return _actor.WaitTime(CommonUtils.GetScriptValue(_actor, 13927011));
			_actor.buffComponent.AddBuff(13927011, _actor);
		}
	}

	private void OnPlayerLeaveBattle(IEvent evt)
	{
		if (evt is AdventurePlayerLeaveEvent adventurePlayerLeaveEvent && adventurePlayerLeaveEvent.player == _actor && CommonUtils.HavePersonalPerk(_actor.dataID, 513927, out var _))
		{
			if (_perkLogicCor_P27 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P27);
			}
			_perkLogicCor_P27 = null;
			_actor.buffComponent.RemoveBuffByBuffId(13927011);
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513922, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P22))
		{
			AdventureActor.AddFromAttr(13922011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513923, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P23))
		{
			AdventureActor.AddFromAttr(13923011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513925, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P25))
		{
			AdventureActor.AddFromAttr(13925001, _actor);
			if (monsterAdventureActor.monsterToughnessInfo.isToughnessBroken)
			{
				AdventureActor.AddFromAttr(13925002, _actor);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513926, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P26) && beforeHitEvent.onceAttackTargetCount > CommonUtils.GetScriptValue(_actor, 13926011).AsInt())
		{
			AdventureActor.AddFromAttr(13926001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513928, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P28))
		{
			AdventureActor.AddFromAttr(13928001, _actor);
			if (monsterAdventureActor.IsEliteOrBossMonster())
			{
				AdventureActor.AddFromAttr(13928002, _actor);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513929, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P29) && beforeHitEvent.onceAttackTargetCount < CommonUtils.GetScriptValue(_actor, 13929011).AsInt())
		{
			AdventureActor.AddFromAttr(13929001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513930, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P30))
		{
			AdventureActor.AddFromAttr(13930001, _actor);
		}
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 513931, out perkLevel) || !CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P31))
		{
			return;
		}
		bool flag = false;
		foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
		{
			if (allPlayerActor is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Support && playerAdventureActor.actived)
			{
				flag = true;
				break;
			}
		}
		if (flag)
		{
			AdventureActor.AddFromAttr(13931001, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_ENTER", OnPlayerEnterBattle);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_LEAVE", OnPlayerLeaveBattle);
		if (_perkLogicCor_P27 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P27);
		}
		_perkLogicCor_P27 = null;
	}
}
