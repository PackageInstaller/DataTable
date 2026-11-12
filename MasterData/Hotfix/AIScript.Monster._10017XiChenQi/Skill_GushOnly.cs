using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._10017XiChenQi;

public class Skill_GushOnly : SkillAdvancedBase
{
	protected FP rotateSpeed = 60;

	protected const string shootEvt = "Shoot";

	protected const string checkEvt = "Listen";

	protected FP interruptDistance = 3;

	protected FP minDistance = 3.5;

	protected FP maxDistance = 15;

	protected FP maxAngle = 130;

	protected FP radius = 2;

	protected readonly string[] bullutPaths = new string[8] { "Weapon_Rubbish_S_1", "Weapon_Rubbish_S_2", "Weapon_Rubbish_S_3", "Weapon_Rubbish_S_4", "Weapon_Rubbish_S_5", "Weapon_Rubbish_L_1", "Weapon_Rubbish_L_2", "Weapon_Rubbish_C_1" };

	protected const int minShootTime = 3;

	protected const int maxShootTime = 6;

	protected int _maxShootTime;

	protected ComboAttack _comboAttack;

	protected int _loopTime;

	protected LookAtTarget _lookAtTarget;

	protected bool _lookAt;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		InitData();
	}

	protected void InitData()
	{
		_maxShootTime = TSRandom.Range(3, 6);
	}

	public void OnStart()
	{
		ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };
		if (_comboAttack == null)
		{
			_comboAttack = new ComboAttack();
		}
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboLoop = OnComboLoop;
		Action onRecoveryBegin = OnRecoveryBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, onRecoveryBegin, onComboLoop, onComboFinish, onInterrupt, onCustomEvent);
	}

	public void OnUpdate()
	{
		if (!_lookAt)
		{
			return;
		}
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (activedPlayerActor != null)
		{
			if (_lookAtTarget == null)
			{
				_lookAtTarget = new LookAtTarget();
			}
			_lookAtTarget.BeginLookAt(_actor, activedPlayerActor, 0, rotateSpeed, null);
		}
	}

	protected void OnAnticipationEnd()
	{
		_loopTime = 0;
		_lookAt = true;
	}

	protected void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "Shoot"))
		{
			Shoot();
		}
		else if (string.Equals(eventName, "Listen"))
		{
			LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			if (activedPlayerActor != null && TSVector2.Distance(_actor.tsTransform.Position, activedPlayerActor.tsTransform.Position) <= interruptDistance)
			{
				_comboAttack.InterruptAttack();
			}
		}
	}

	protected void Shoot()
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		FP angle = _actor.tsTransform.Forward.GetAngle();
		TSVector2 center;
		if (activedPlayerActor == null)
		{
			center = TrueSyncExtensions.RandomPointInsideFan(_actor.tsTransform.Position, minDistance, maxDistance, angle, maxAngle);
		}
		else
		{
			FP fP = TSVector2.Angle(activedPlayerActor.tsTransform.Position - _actor.tsTransform.Position, _actor.tsTransform.Forward);
			FP fP2 = TSVector2.Distance(activedPlayerActor.tsTransform.Position, _actor.tsTransform.Position);
			center = ((!(fP2 >= minDistance) || !(fP2 <= maxDistance) || !(fP <= maxAngle / 2)) ? TrueSyncExtensions.RandomPointInsideFan(_actor.tsTransform.Position, minDistance, maxDistance, angle, maxAngle) : activedPlayerActor.tsTransform.Position);
		}
		TSVector2 tSVector = TrueSyncExtensions.RandomPointInsideRing(center, 0, radius);
		int num = TSRandom.Range(0, bullutPaths.Length - 1);
		string bulletAlias = bullutPaths[num];
		AdventureActor actor = _actor;
		TSVector2 position = _actor.tsTransform.Position;
		TSVector2 targetPosition = tSVector;
		ILRuntimeAPI.Shoot(bulletAlias, actor, default, position, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
	}

	protected void OnComboLoop()
	{
		_loopTime++;
		if (_loopTime >= _maxShootTime)
		{
			_comboAttack.CancelAttack();
		}
	}

	protected void OnRecoveryBegin()
	{
		_lookAt = false;
		_lookAtTarget?.StopLookAt();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_lookAt = false;
		_lookAtTarget?.StopLookAt();
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_loopTime = 0;
		_lookAt = false;
		_comboAttack?.Clear();
		_comboAttack = null;
		_lookAtTarget?.Clear();
		_lookAtTarget = null;
	}
}
