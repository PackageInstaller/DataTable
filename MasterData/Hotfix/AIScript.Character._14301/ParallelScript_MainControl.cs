using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._14301;

public class ParallelScript_MainControl : ParallelScript
{
	private int _skillSectionCount;

	private FP _lastTriggerTime_P9;

	public override void OnEnable()
	{
		base.OnEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514304, out var perkLevel))
		{
			_damageTag_TriggerWindMark?.Add(Config_MainControl.damageTag_AddTriggerMark_P4);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514312, out perkLevel))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				if (actorL.actorElementInfo.elementType == HotfixEnum.elementType.AE)
				{
					_actor.buffComponent.AddBuff(14312011, _actor);
				}
			}
		}
		_actor.buffComponent.AddBuff(14300011, _actor);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("PLAYER_SPAWN_COMPLETE", OnPlayerSpawnComplete);
	}

	private void OnPlayerSpawnComplete(IEvent evt)
	{
		_skillSectionCount = ((PlayerAdventureActor)_actor).playerSkillCd.GetSkillCD(ActionKey.B)?.currentSectionAmount ?? 0;
		if (_skillSectionCount > 0)
		{
			_actor.buffComponent.AddBuffNum(14300013, _skillSectionCount, _actor);
		}
		else
		{
			_actor.buffComponent.AddBuff(14300012, _actor);
		}
	}

	public void OnUpdate()
	{
		UpdateSkillSection();
	}

	private void UpdateSkillSection()
	{
		int num = ((PlayerAdventureActor)_actor).playerSkillCd.GetSkillCD(ActionKey.B)?.currentSectionAmount ?? 0;
		if (_skillSectionCount == num)
		{
			return;
		}
		_skillSectionCount = num;
		if (_skillSectionCount > 0)
		{
			_actor.buffComponent.RemoveBuffByBuffId(14300012);
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(14300013);
			if (_skillSectionCount > buffNumByID)
			{
				_actor.buffComponent.AddBuffNum(14300013, _skillSectionCount - buffNumByID, _actor);
			}
			else if (_skillSectionCount < buffNumByID)
			{
				_actor.buffComponent.RemoveBuffByBuffId(14300013, buffNumByID - _skillSectionCount);
			}
		}
		else
		{
			_actor.buffComponent.RemoveBuffByBuffId(14300013);
			_actor.buffComponent.AddBuff(14300012, _actor);
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor bEntity = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514303, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P3))
		{
			AdventureActor.AddFromAttr(14303011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514304, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P4))
		{
			AdventureActor.AddFromAttr(14304011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514305, out perkLevel) && _actor.DistanceWithRadius(bEntity) <= Config_MainControl.triggerDistance_AddDamage_P5)
		{
			AdventureActor.AddFromAttr(14305001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514306, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P6))
		{
			AdventureActor.AddFromAttr(14306001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514308, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P8))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(14308011);
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(14308001, _actor, buffNumByID);
			}
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514307, out var perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P7))
		{
			_actor.buffComponent.AddBuff(14307011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514309, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P9))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 14309011);
			if (_lastTriggerTime_P9 <= 0 || _actor.LogicTime - _lastTriggerTime_P9 > scriptValue)
			{
				_actor.buffComponent.AddBuff(14309011, _actor);
				_lastTriggerTime_P9 = _actor.LogicTime;
			}
		}
	}

	protected override void OnTriggerWindMark(IList<int> hitDamageTag)
	{
		base.OnTriggerWindMark(hitDamageTag);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514313, out var _))
		{
			_actor.buffComponent.AddBuff(14313011, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("PLAYER_SPAWN_COMPLETE", OnPlayerSpawnComplete);
		_actor.buffComponent.RemoveBuffByBuffId(14300011);
		_lastTriggerTime_P9 = 0;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514312, out var _))
		{
			_actor.buffComponent.RemoveBuffByBuffId(14312011);
		}
	}
}
