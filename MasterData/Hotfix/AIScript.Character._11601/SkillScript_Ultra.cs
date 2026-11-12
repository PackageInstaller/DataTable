using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11601;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private PlayTimeline _playTimeline;

	private long _areaEffectId;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
		_actor.EnableCloseBlock();
		_areaEffectId = 0L;
		_actor.logicVariable.SetLogicTagValue("UltraSkillHitTimes", 0);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511643, out var _))
		{
			_actor.buffComponent.AddBuff(11643011, _actor);
		}
		_actor.attackTarget = GetAttackTarget();
		DefaultLookAt();
	}

	public void OnStart()
	{
		if (_playTimeline == null)
		{
			_playTimeline = new PlayTimeline();
		}
		_playTimeline.Play(_actor, OnPlayTimeLineFinish, OnNotPlayTimeLine);
	}

	private void OnPlayTimeLineFinish()
	{
		GenerateAreaEffect("AreaEffect_11601_Ultra_TL");
		_actor.Hide(performanceMode: true);
		SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: false);
		MoveToTargetPosition(isTeleport: true);
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("116_Ultra_TL", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnNotPlayTimeLine()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("116_Ultra_NoTL", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private LogicEntity GetAttackTarget()
	{
		if (((PlayerAdventureActor)_actor).isAssist)
		{
			return CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		}
		return _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "116_Ultra_Area"))
		{
			GenerateAreaEffect("AreaEffect_11601_Ultra");
		}
		else if (string.Equals(eventName, "116_UltraSkill_Movement"))
		{
			MoveToTargetPosition();
		}
		else if (string.Equals(eventName, "HideModel"))
		{
			_actor.Hide(performanceMode: true);
			SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: false);
		}
		else if (string.Equals(eventName, "ShowModel"))
		{
			_actor.Visible();
			SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: true);
		}
	}

	private void GenerateAreaEffect(string areaEffectKey)
	{
		TSVector2 result = _actor.tsTransform.Position;
		TSVector2 tSVector = _actor.tsTransform.Forward;
		if (_actor.attackTarget != null)
		{
			tSVector = (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
			FP value = _actor.DistanceWithRadius(_actor.attackTarget);
			value = TSMath.Clamp(value, 0, Config.maxMoveDistance_UltraSkill);
			result = _actor.tsTransform.Position + tSVector * value;
			if (!_actor.QueryPositionWalkable(result))
			{
				_actor.QueryClosestPositionWalkable(result, out result);
				if (!_actor.QueryPositionReachable(result))
				{
					_actor.LinecastNavmeshGraph(_actor.tsTransform.Position, result, out result, offset: false, _actor.tsTransform.PositionY, _actor.tsTransform.PositionY);
				}
				tSVector = (result - _actor.tsTransform.Position).normalized;
			}
		}
		_areaEffectId = ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectKey, result, tSVector.GetAngle());
	}

	private void MoveToTargetPosition(bool isTeleport = false)
	{
		if (_areaEffectId <= 0)
		{
			return;
		}
		AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(_areaEffectId);
		if (!(areaEffect == null) && !(_actor.tsTransform.Position == areaEffect.tsTransform.Position))
		{
			TSVector2 normalized = (areaEffect.tsTransform.Position - _actor.tsTransform.Position).normalized;
			_actor.LookAtDir(normalized, 0f);
			if (isTeleport)
			{
				_actor.Teleport(areaEffect.tsTransform.Position);
				return;
			}
			FP speed = TSVector2.Distance(areaEffect.tsTransform.Position, _actor.tsTransform.Position) / Config.moveDuration_UltraSkill;
			_actor.ToJump(areaEffect.tsTransform.Position, speed, Config.moveDuration_UltraSkill, null, comboWithAttack: true, forbiddenHeight: true);
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
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
		_actor.DisableCloseBlock();
		if (_actor.isHide)
		{
			_actor.Visible();
			SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: true);
		}
	}
}
