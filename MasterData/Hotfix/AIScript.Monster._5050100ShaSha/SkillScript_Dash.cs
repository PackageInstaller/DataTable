using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_Dash : SkillScript_SkillBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKey_Water = new ComboInputBuffer.ActionKey[1];

	protected readonly ComboInputBuffer.ActionKey[] actionKey_Dark = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.N };

	protected readonly string eventStartTurn = "StartTurn";

	protected readonly FP RotateSpeed = 80;

	protected readonly int maxTurnCount = 1;

	protected readonly string eventChargeStart = "ChargeStart";

	protected readonly string eventAim = "Aim";

	protected readonly string eventStopAim = "StopAim";

	protected readonly FP aimRotateSpeed = 300;

	protected readonly string fxAim = "fx_50501_loop_skill1_start";

	protected readonly FP dashDistance = 0;

	protected readonly FP dashSpeed = 0;

	protected readonly FP dashAngleLimit = 0;

	protected readonly bool triObstcleStop;

	protected readonly bool triEnemyStop;

	protected readonly bool triFriendStop;

	protected Dash _dash;

	protected FP _currentSkillRotateSpeed;

	protected int _turnCount;

	protected bool _startTurn;

	protected PlayFX _playFX;

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_turnCount = 0;
		_startTurn = false;
		if (_dash == null)
		{
			_dash = new Dash();
		}
		UpdateData();
	}

	protected void UpdateData()
	{
		if (_actor.buffComponent.CheckBuffByBuffID(_violentBuffId))
		{
			_actionKey = actionKey_Dark;
		}
		else
		{
			_actionKey = actionKey_Water;
		}
	}

	public override void OnStart()
	{
		BeginSkill();
	}

	protected override void BeginSkill()
	{
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		ComboInputBuffer.ActionKey[] actionKey = _actionKey;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onInterrupt = OnInterrupt;
		System.Action onComboFinish = OnFinish;
		comboAttack.BeginAttack(actor, skill, actionKey, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventStartTurn, eventName))
		{
			if (!_startTurn)
			{
				_startTurn = true;
				_currentSkillRotateSpeed = RotateSpeed;
				BeginLookAtRotate();
			}
			if (_turnCount < maxTurnCount)
			{
				_turnCount++;
				return;
			}
			_comboAttack.CancelAttack();
			_lookAtTarget?.StopLookAt();
		}
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_turnCount = 0;
		_startTurn = false;
		_dash?.Interrupte();
		_dash.Clear();
		if (_playFX != null)
		{
			_playFX.Stop(dontPlaySubFX: true);
			_playFX.Clear();
		}
	}

	public void BeginLookAtRotate()
	{
		_ = FP.Zero;
		LogicEntity logicEntity = _actor.actorSearchTargetInfo?.GetMonsterAttackTarget();
		if (CommonUtils.CheckTargetIsValid(logicEntity, 0L))
		{
			TSVector2 forward = _actor.tsTransform.Forward;
			TSVector2 b = logicEntity.tsTransform.Position - _actor.tsTransform.Position;
			TSVector2.Angle(forward, b);
		}
		FP currentSkillRotateSpeed = _currentSkillRotateSpeed;
		_lookAtTarget.BeginLookAt(_actor, logicEntity, 999, currentSkillRotateSpeed, null);
	}
}
