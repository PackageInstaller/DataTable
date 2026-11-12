using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._139;

public class SupportSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Support";

	public const int loopTimes_Skill = 3;

	private readonly string eventName_AreaEffect = "139_Sup_Area";

	private readonly string areaEffectKey = "AreaEffect_Soldier_139_Sup";

	private static readonly TSVector2 offset_AreaEffect = new TSVector2(0, 3);

	private int _totalLoopTimes;

	private int _loopTimes;

	private Dash _dash;

	private bool _inUltra;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_loopTimes = 0;
		_totalLoopTimes = 3;
		_inUltra = false;
	}

	public void OnStart()
	{
		if (_actor.attackTarget == null)
		{
			_actor.attackTarget = ((SoldierActor)_actor).soldierAI?.FindNearestConfrontTarget();
		}
		if (UltraSkillHelper.ShouldTrigger(_actor))
		{
			UltraSkillHelper.TriggerPerformance(_actor);
			BeginUltra();
			return;
		}
		_actor.buffComponent?.AddBuff(250105102, _actor);
		string actionTag = comboTag;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onComboLoop = OnComboLoop;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventName_AreaEffect))
		{
			TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * offset_AreaEffect.x + _actor.tsTransform.Forward * offset_AreaEffect.y;
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectKey, position, _actor.tsTransform.Rotation);
		}
	}

	private void OnAnticipationEnd()
	{
		_loopTimes = 0;
	}

	private void OnComboLoop()
	{
		_loopTimes++;
		if (_loopTimes >= _totalLoopTimes)
		{
			comboAttack?.CancelAttack();
		}
	}

	private void BeginUltra()
	{
		_inUltra = true;
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
		Action<string> onCustomEvent = OnUltraCustomEvent;
		Action onActivationEnd = OnUltraActivationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Ultra_First", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd);
	}

	private void OnUltraCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "Event_139_Ultra1_Area"))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_Soldier_139_Ultra_PreExplosion", _actor.tsTransform.Position, _actor.tsTransform.Rotation);
		}
		if (string.Equals(eventName, "139_Ultra_Move"))
		{
			UltraDashToTarget();
		}
	}

	private void UltraDashToTarget()
	{
		if (_actor.attackTarget == null)
		{
			return;
		}
		TSVector2 linecastHitPoint = _actor.attackTarget.tsTransform.Position;
		if (!_actor.QueryPositionReachable(linecastHitPoint))
		{
			_actor.LinecastNavmeshGraph(_actor.tsTransform.Position, linecastHitPoint, out linecastHitPoint, offset: false, _actor.tsTransform.PositionY, _actor.tsTransform.PositionY);
		}
		FP fP = TSVector2.Distance(linecastHitPoint, _actor.tsTransform.Position);
		if (!(fP <= 0))
		{
			TSVector2 normalized = (linecastHitPoint - _actor.tsTransform.Position).normalized;
			FP speed = fP / MainSkill.duration_UltraMove;
			if (_dash == null)
			{
				_dash = new Dash();
			}
			_dash.BeginDash(_actor, normalized, speed, fP, default, null, null, null, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		}
	}

	private void OnUltraActivationEnd()
	{
		_dash?.Interrupte();
		Action<string> onCustomEvent = OnUltraCustomEvent;
		Action onActivationEnd = OnUltraSecondP1ActivationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Ultra_Second_P1", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd);
	}

	private void OnUltraSecondP1ActivationEnd()
	{
		_dash?.Interrupte();
		Action onComboFinish = OnUltraFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Ultra_Second_P2", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private void OnUltraFinish()
	{
		if (((SoldierActor)_actor).GetPotentialLv() >= 3)
		{
			_actor.buffComponent?.AddBuff(250105101, _actor);
		}
		OnFinish();
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (_inUltra)
		{
			_dash?.Interrupte();
			_dash?.Clear();
			_actor.DisableInvincible();
			_actor.DisableSuperArmor();
			_actor.DisableImmuneControl();
			_inUltra = false;
		}
		_loopTimes = 0;
	}
}
