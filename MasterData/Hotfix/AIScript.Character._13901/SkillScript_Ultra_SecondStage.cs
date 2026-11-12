using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13901;

public class SkillScript_Ultra_SecondStage : SkillAdvancedBase
{
	private Dash _dash;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
		_actor.EnableCloseBlock();
		CommonUtils.EnableCrossObstacleMode(_actor);
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2))
		{
			_actor.buffComponent.AddBuff(13996211, _actor);
		}
		DefaultLookAt();
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onActivationEnd = OnStartActivationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("139_Ultra2_Start", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "139_Ultra2_AddBuff"))
		{
			if (_actor.logicVariable.GetLogicTagToggle("TriggerPersonalPerk_P1 ") && _skill.skillId == 13931002)
			{
				int buffNum = _actor.buffComponent.GetBuffNum(0, 0, Config_MainControl.buffTag_Soul);
				if (buffNum > 0)
				{
					AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
					adventureActorCustomEvent.sender = _actor;
					adventureActorCustomEvent.actor = _actor;
					adventureActorCustomEvent.eventHashCode = Config_MainControl.eventHashCode_RemoveSoul;
					adventureActorCustomEvent.boolParam = true;
					_actor.DispatchEvent(adventureActorCustomEvent);
					_actor.buffComponent.AddBuffNum(13900003, buffNum, _actor);
				}
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513941, out var _))
			{
				_actor.buffComponent.AddBuff(13941011, _actor);
			}
		}
		else if (string.Equals(eventName, "139_Ultra2_LookAtTarget"))
		{
			DefaultLookAt();
		}
		else if (string.Equals(eventName, "Event_139_Ultra2_Move"))
		{
			DashToPosition();
		}
	}

	private void DashToPosition()
	{
		if (_actor.attackTarget == null)
		{
			return;
		}
		TSVector2 normalized = (_actor.tsTransform.Position - _actor.attackTarget.tsTransform.Position).normalized;
		TSVector2 linecastHitPoint = _actor.attackTarget.tsTransform.Position + normalized * Config.distance_TargetOffset_SecondStage_UltraSkill;
		if (!_actor.QueryPositionReachable(linecastHitPoint))
		{
			_actor.LinecastNavmeshGraph(_actor.tsTransform.Position, linecastHitPoint, out linecastHitPoint, offset: false, _actor.tsTransform.PositionY, _actor.tsTransform.PositionY);
		}
		FP fP = TSVector2.Distance(linecastHitPoint, _actor.tsTransform.Position);
		if (!(fP <= 0))
		{
			TSVector2 normalized2 = (linecastHitPoint - _actor.tsTransform.Position).normalized;
			FP speed = fP / Config.duration_Move_SecondStage_UltraSkill;
			if (_dash == null)
			{
				_dash = new Dash();
			}
			_dash.BeginDash(_actor, normalized2, speed, fP, default, null, null, null, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		}
	}

	private void OnStartActivationEnd()
	{
		_dash?.Interrupte();
		CommonUtils.CheckAndSetCrossObstacleMode(_actor, Config.realMoveDistance_Attack_SecondStage_UltraSkill, Config.crossAdditionDistance_Attack_SecondStage_UltraSkill, Config.crossKeepAwayNavmeshEdgeDistance_Attack_SecondStage_UltraSkill, forceUseForwardDirection: true);
		string text = "139_Ultra2_Atk";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513943, out var _))
		{
			text = "139_Ultra2_Atk_P43";
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onActivationEnd = OnAttackActivationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd);
	}

	private void OnAttackActivationEnd()
	{
		BindFirstStageUltraSkill();
	}

	private void BindFirstStageUltraSkill()
	{
		if (_skill.skillId == 13940001 && ((PlayerAdventureActor)_actor).playerSkillCd.GetCurrentBindSkillId(ActionKey.D) != 13940000)
		{
			((PlayerAdventureActor)_actor).playerSkillCd.BindSkillIdToButton(ActionKey.D, 13940000);
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = Config.eventHashCode_ChangeUltraSkillStage;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_dash?.Interrupte();
		_dash?.Clear();
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
		_actor.DisableCloseBlock();
		CommonUtils.DisableCrossObstacleMode(_actor);
		CommonUtils.ClearCrossObstacleMode(_actor);
		BindFirstStageUltraSkill();
	}
}
