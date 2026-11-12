using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13901;

public class SkillScript_Skill_MainControl : SkillAdvancedBase
{
	private bool _isHide;

	private bool _isInvincible;

	private TSVector2 _startTeleportPosition;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_isHide = false;
		_isInvincible = false;
		_startTeleportPosition = _actor.tsTransform.Position;
		_actor.logicVariable.ToggleLogicTag("SkillHasGetSoul", value: false);
		_actor.EnableCloseBlock();
		DefaultLookAt();
	}

	public void OnStart()
	{
		Action onActivationEnd = OnStartActivation;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("139_Skill_Main_1", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "139_Move"))
		{
			if (_actor.isJump)
			{
				_actor.StandBy();
			}
			DefaultLookAt();
			TSVector2 linecastHitPoint = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : (_actor.tsTransform.Position + _actor.tsTransform.Forward * Config_MainControl.distance_Move_NoTarget_Skill));
			if (!_actor.QueryPositionReachable(linecastHitPoint))
			{
				_actor.LinecastNavmeshGraph(_actor.tsTransform.Position, linecastHitPoint, out linecastHitPoint, offset: false, _actor.tsTransform.PositionY, _actor.tsTransform.PositionY);
			}
			FP speed = TSVector2.Distance(_actor.tsTransform.Position, linecastHitPoint) / Config_MainControl.duration_Move_Skill;
			_actor.ToJump(linecastHitPoint, speed, Config_MainControl.duration_Move_Skill, null, comboWithAttack: true, forbiddenHeight: true);
			if (!SceneSingleton<DeterministicCollisionManager>.Instance.CheckLineOverlap(_actor.tsTransform.Position, linecastHitPoint, null, 69632))
			{
				_actor.dtCollider.ActiveSelf = true;
			}
		}
		else if (string.Equals(eventName, "139_Hide"))
		{
			HideModel();
		}
		else if (string.Equals(eventName, "139_Show"))
		{
			ShowModel();
		}
		else if (string.Equals(eventName, "139_EnableInvincible"))
		{
			EnableInvincible();
		}
		else if (string.Equals(eventName, "139_CloseInvincible"))
		{
			DisableInvincible();
		}
		else
		{
			if (!string.Equals(eventName, "Event_P02") || !CommonUtils.HavePersonalPerk(_actor.dataID, 513902, out var perkLevel) || !_actor.buffComponent.CheckBuffByBuffTag(Config_MainControl.buffTag_Soul))
			{
				return;
			}
			FP logicTagValue = _actor.logicVariable.GetLogicTagValue("LastTriggerTime_P2");
			int parameterId = 13902011;
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513907, out perkLevel) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.WE) && _actor.buffComponent.CheckBuffByBuffID(13907001))
			{
				parameterId = 13907002;
			}
			if (logicTagValue <= 0 || _actor.LogicTime - logicTagValue > CommonUtils.GetScriptValue(_actor, parameterId))
			{
				GetSoul(1);
				List<string> list = Config_MainControl.areaEffectKeyList_P2;
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 513905, out perkLevel))
				{
					list = Config_MainControl.areaEffectKeyList_P2_P5;
				}
				string fxAlias = list.get_Item(TSRandom.Range(0, list.Count));
				TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
				{
					shapeType = DeterministicShape.ShapeType.Circle,
					innerRadius = 0,
					radius = Config_MainControl.randomRadius_AreaEffect_P2,
					position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position)
				}, isReachable: false);
				ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, randomPointInShape, _actor.tsTransform.Rotation);
				_actor.logicVariable.SetLogicTagValue("LastTriggerTime_P2", _actor.LogicTime);
			}
		}
	}

	private void GetSoul(int count)
	{
		if (count > 0 && (!CommonUtils.HavePersonalPerk(_actor.dataID, 513903, out var _) || !_actor.buffComponent.CheckBuffByBuffTag(Config.buffTag_FirstStage_UltraSkill)))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = Config_MainControl.eventHashCode_AddSoul;
			adventureActorCustomEvent.intParam = count;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private void OnStartActivation()
	{
		if (_actor.isJump)
		{
			_actor.StandBy();
		}
		Action<string> onCustomEvent = OnCustomEvent;
		Action onActivationEnd = OnAttackActivationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("139_Skill_Main_2", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd);
	}

	private void OnAttackActivationEnd()
	{
		TSVector2 position = _actor.tsTransform.Position;
		TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (tSVector == TSVector2.zero)
		{
			tSVector = (_startTeleportPosition - position).normalized;
		}
		_actor.LookAtDir(tSVector, 0);
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("139_Skill_Main_3", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void HideModel()
	{
		if (!_isHide)
		{
			_isHide = true;
			SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: false);
		}
	}

	private void ShowModel()
	{
		if (_isHide)
		{
			_isHide = false;
			SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: true);
		}
	}

	private void EnableInvincible()
	{
		if (!_isInvincible)
		{
			_isInvincible = true;
			_actor.EnableInvincible();
		}
	}

	private void DisableInvincible()
	{
		if (_isInvincible)
		{
			_isInvincible = false;
			_actor.DisableInvincible();
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
		if (_actor.isJump)
		{
			_actor.StandBy();
		}
		_actor.DisableCloseBlock();
		ShowModel();
		DisableInvincible();
		_isHide = false;
	}
}
