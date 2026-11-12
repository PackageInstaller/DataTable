using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16001;

public class SkillScript_Skill_Strength_MainControl : SkillScript_Skill_Base_MainControl
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("160_Main_Skill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "160_Summon"))
		{
			TSVector2 result = _actor.tsTransform.Position + _actor.tsTransform.Forward * Config_MainControl.offset_Summon_Skill_Strength;
			if (!_actor.QueryPositionReachable(result))
			{
				_actor.QueryClosestPositionWalkable(result, out result);
			}
			ILRuntimeAPI.SummonMonster(_actor, 0, 16000011, result, _actor.tsTransform.Forward, Config_MainControl.summonCfg_Summoned);
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = Config.eventHashCode_RemoveDecibel;
			adventureActorCustomEvent.boolParam = true;
			_actor.DispatchEvent(adventureActorCustomEvent);
			if (((PlayerAdventureActor)_actor).status == ActorStatus.Default)
			{
				_playerSkillCd.BindSkillIdToButton(ActionKey.B, 16031000);
			}
			else
			{
				_playerSkillCd.BindSkillIdToButton(ActionKey.B, 16031001);
			}
			_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
			((PlayerAdventureActor)_actor).SetActionCondition(ActionKey.B, canCast: false);
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
