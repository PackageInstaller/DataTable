#define LOG_DEBUG
using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50011XingXing;

public class Skill_4 : SkillAdvancedBase
{
	private readonly FP _rotateLimit = 60;

	private readonly FP _timeLimit = 1.5;

	private readonly FP _speed = 40;

	private readonly FP _distance = 30;

	protected readonly string _eventName = "DashStart";

	protected ComboAttack _comboAttack;

	private readonly LookAtTarget _lookAtTarget = new LookAtTarget();

	protected Dash _dash;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_50011XingXing Skill_4 OnDisable");
		base.OnSkillDisable();
		_lookAtTarget.Clear();
		_comboAttack?.Clear();
		if (_dash != null)
		{
			_dash.Clear();
			_dash = null;
		}
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_50011XingXing Skill_4 OnEnable");
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		NovaLogger.Debug("_50011XingXing Skill_4 OnStart");
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.None, null, SkillPhaseFeatureFlag.None, null);
			if (_comboAttack == null)
			{
				_comboAttack = new ComboAttack();
			}
			ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };
			ComboAttack comboAttack = _comboAttack;
			AdventureActor actor = _actor;
			AdventureSkill skill = _skill;
			int skillId = ((_skill != null) ? _skill.skillId : 0);
			Action onAnticipationEnd = OnAnticipationEnd;
			Action onInterrupt = OnInterrupt;
			comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, null, null, onInterrupt);
		}
	}

	protected void OnAnticipationEnd()
	{
		NovaLogger.Debug("_50011XingXing Skill_4 OnAnticipationEnd");
		if (!CommonUtils.CheckTargetIsValid(_actor.monsterTarget, 0L))
		{
			OnFinish();
			return;
		}
		_lookAtTarget.BeginLookAt(_actor, _actor.monsterTarget, _timeLimit, _rotateLimit, () =>
		{
			ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[2]
			{
				ComboInputBuffer.ActionKey.C,
				ComboInputBuffer.ActionKey.A
			};
			ComboAttack comboAttack = _comboAttack;
			AdventureActor actor = _actor;
			AdventureSkill skill = _skill;
			int skillId = ((_skill != null) ? _skill.skillId : 0);
			Action<string> onCustomEvent = OnCustomEvent;
			comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, null, null, onCustomEvent);
		});
	}

	protected void OnCustomEvent(string eventName)
	{
		NovaLogger.Debug("_50011XingXing Skill_4" + eventName);
		if (_eventName.Equals(eventName))
		{
			if (_dash == null)
			{
				_dash = new Dash();
			}
			_dash.BeginDash(_actor, _actor.tsTransform.Forward, _speed, _distance, 0, DashFinishCallback, DashFinishCallback, DashFinishCallback, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false, checkStop: true);
		}
	}

	protected void DashFinishCallback()
	{
		ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[2]
		{
			ComboInputBuffer.ActionKey.C,
			ComboInputBuffer.ActionKey.B
		};
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt);
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("_50011XingXing Skill_4 onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("_50011XingXing Skill_4 onInterrupt");
		_skill.Clear();
	}
}
