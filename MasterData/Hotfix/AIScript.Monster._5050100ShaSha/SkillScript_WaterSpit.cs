using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_WaterSpit : SkillScript_SkillBase
{
	protected readonly ComboInputBuffer.ActionKey[] _actionKey_Water = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	protected readonly ComboInputBuffer.ActionKey[] _actionKey_Dark = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.W };

	protected FP RotateSpeed = 150;

	protected readonly string eventStartTurn = "StartTurn";

	protected readonly string eventStopTurn = "StopTurn";

	protected FP ShootRotateSpeed = 100;

	protected readonly string eventShoot = "Shoot";

	protected readonly string bulletPath_Water = "Weapon_50501ShaSha_Water_Throw";

	protected readonly string bulletPath_Dark = "Weapon_50501ShaSha_Dark_Throw";

	protected FP bulletYPos = 4;

	protected TSVector2 bulletOffset = new TSVector2(0, 5);

	protected readonly int ReceiveDamageFEPre = 99;

	protected FP fanAngle = 160;

	protected FP innerRange = 6;

	protected FP fanRange = 24;

	protected TSVector2 NonePlayerOffset = new TSVector2(0, 8);

	protected FP waitCancelTime = 0.2;

	protected long _receiveDamage;

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected string _bulletPath;

	protected int _buttleCount;

	private readonly List<DeterministicCollider> _targets = new List<DeterministicCollider>();

	protected CoroutineNode _waitCancelAttack;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_buttleCount = 0;
		_receiveDamage = 0L;
		_rotateSpeed = RotateSpeed;
		UpdateData();
	}

	protected void UpdateData()
	{
		if (_actor.buffComponent.CheckBuffByBuffID(_violentBuffId))
		{
			_actionKey = _actionKey_Dark;
			_bulletPath = bulletPath_Dark;
		}
		else
		{
			_actionKey = _actionKey_Water;
			_bulletPath = bulletPath_Water;
		}
	}

	public override void OnStart()
	{
		BeginSkill();
	}

	protected override void BeginSkill()
	{
		BeginLookAtPlayer();
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
		if (!string.Equals(eventShoot, eventName))
		{
			return;
		}
		LogicEntity logicEntity = _actor.actorSearchTargetInfo?.GetMonsterAttackTarget();
		_lookAtTarget?.StopLookAt();
		_rotateSpeed = ShootRotateSpeed;
		BeginLookAtPlayer();
		if (CheckPlay())
		{
			string bulletPath = _bulletPath;
			AdventureActor actor = _actor;
			FP range = 0;
			TSVector2 position = _actor.tsTransform.Position + TSVector2.Rotate(bulletOffset, _actor.tsTransform.Rotation);
			TSVector2 position2 = logicEntity.tsTransform.Position;
			LogicEntity target = logicEntity;
			ILRuntimeAPI.Shoot(bulletPath, actor, range, position, bulletYPos, position2, target, AimType.Target, BulletDirectionType.BulletToTarget);
			_buttleCount++;
			if (_buttleCount == 3)
			{
				_comboAttack?.CancelAttack();
			}
		}
		else
		{
			ILRuntimeAPI.Shoot(_bulletPath, _actor, 0, _actor.tsTransform.Position + TSVector2.Rotate(bulletOffset, _actor.tsTransform.Rotation), targetPosition: _actor.tsTransform.Position + TSVector2.Rotate(NonePlayerOffset, _actor.tsTransform.Rotation), positionY: bulletYPos, target: null, aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget);
		}
	}

	protected IEnumerator WaitCancelAttack()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(waitCancelTime));
		_comboAttack?.CancelAttack();
	}

	private bool CheckPlay()
	{
		LogicEntity logicEntity = _actor.actorSearchTargetInfo?.GetMonsterAttackTarget();
		if (!CommonUtils.CheckTargetIsValid(logicEntity, 0L))
		{
			return false;
		}
		_targets.Clear();
		DeterministicShape shape = new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Fan,
			angle = fanAngle,
			innerRadius = innerRange,
			rotation = _actor.tsTransform.Rotation,
			radius = fanRange,
			position = _actor.tsTransform.Position
		};
		SceneSingleton<DeterministicCollisionManager>.Instance.GetTargetByShape(_targets, shape, 256);
		if (_targets == null || _targets.Count == 0)
		{
			return false;
		}
		if (_targets.Count > 0)
		{
			bool flag = false;
			foreach (DeterministicCollider target in _targets)
			{
				if (target.GetComponent<AdventureActor>() == logicEntity)
				{
					flag = true;
				}
			}
			if (!flag)
			{
				return false;
			}
		}
		return true;
	}

	protected void OnFinish()
	{
		_skill?.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnReceiveDamage(IEvent evt)
	{
		base.OnReceiveDamage(evt);
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(adventureActorReceiveDamageEvent.to != _actor))
		{
			if (adventureActorReceiveDamageEvent.elementType == HotfixEnum.elementType.FE)
			{
				_receiveDamage += adventureActorReceiveDamageEvent.damageToShieldAndHp;
			}
			if (_receiveDamage * 100 / _actor.actorHealthInfo.hpMax > ReceiveDamageFEPre)
			{
				_comboAttack.InterruptAttack();
				_actor.logicVariable.ToggleLogicTag("5050100ShaShaSpecial", value: true);
				ILRuntimeAPI.CreateSkill(_skillId_whelmed, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false);
				OnFinish();
			}
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref _waitCancelAttack);
	}

	public void BeginLookAtPlayer()
	{
		FP fP = FP.Zero;
		LogicEntity logicEntity = _actor.actorSearchTargetInfo?.GetMonsterAttackTarget();
		if (CommonUtils.CheckTargetIsValid(logicEntity, 0L))
		{
			TSVector2 forward = _actor.tsTransform.Forward;
			TSVector2 b = logicEntity.tsTransform.Position - _actor.tsTransform.Position;
			fP = TSVector2.Angle(forward, b);
		}
		FP duration = fP / _rotateSpeed;
		_lookAtTarget.BeginLookAt(_actor, logicEntity, duration, _rotateSpeed, () =>
		{
		});
	}
}
