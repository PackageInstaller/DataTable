using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._11011ZhongYeJingYing;

public class Skill_MineThrower : SkillAdvancedBase
{
	protected const string beginRotateEvt = "Turn";

	protected const string shootEvt = "Shoot";

	protected FP rotateSpeed = 120;

	protected const string bulletName = "Skill2_Bullet";

	protected FP shootOffsetX = 0.75;

	protected FP shootOffsetY = 1.15;

	protected FP shootHeight = 2.6;

	protected ComboAttack _comboAttack;

	protected ComboInputBuffer.ActionKey[] _actionKeys;

	protected LookAtTarget _lookAtTarget;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		if (_comboAttack == null)
		{
			_comboAttack = new ComboAttack();
		}
		if (_actionKeys == null)
		{
			_actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };
		}
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		ComboInputBuffer.ActionKey[] actionKeys = _actionKeys;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "Turn"))
		{
			LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			if (activedPlayerActor != null)
			{
				_lookAtTarget?.BeginLookAt(_actor, activedPlayerActor, 0, rotateSpeed, null);
			}
		}
		else if (string.Equals(eventName, "Shoot"))
		{
			Shoot();
		}
	}

	protected void Shoot()
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (activedPlayerActor != null)
		{
			TSVector2 position = ILRuntimeAPI.TransLocalPosToWorldPosByPos(_actor.tsTransform.Position, _actor.tsTransform.Forward, new TSVector2(shootOffsetX, shootOffsetY));
			ILRuntimeAPI.Shoot("Skill2_Bullet", _actor, default, position, shootHeight, activedPlayerActor.tsTransform.Position, null, AimType.Position, BulletDirectionType.BulletToTarget);
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
		_comboAttack?.Clear();
		_comboAttack = null;
		_lookAtTarget?.StopLookAt();
		_lookAtTarget?.Clear();
		_lookAtTarget = null;
	}
}
