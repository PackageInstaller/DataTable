using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._13701;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private int _attackCount;

	private string _attackTag;

	private LogicEntity targetEntity;

	private AimTarget aimTarget = new AimTarget();

	private VisualSmooth smooth;

	private static bool IsNormalComboTag(string tag)
	{
		return Config.comboTagListNormalAttack.Contains(tag);
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		smooth = _actor.GetLogicComponent<VisualSmooth>();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		aimTarget.Cancel();
		targetEntity = null;
		_actor.logicVariable.SetLogicTagValue("137TD_LastNormalAttackTime", _actor.LogicTime);
	}

	public void OnStart()
	{
		if (_actor.attackTarget == null)
		{
			OnFinish();
			return;
		}
		int buffNumByID = _actor.buffComponent.GetBuffNumByID(801370050);
		int num = 10;
		if (buffNumByID >= num)
		{
			_attackTag = (GetPerk(1370103) ? "Atk_Sp_P1" : "Atk_Sp");
			_actor.buffComponent.RemoveBuffByBuffId(801370050, num);
			TryFireGrenade();
		}
		else
		{
			FP logicTagValue = _actor.logicVariable.GetLogicTagValue("137TD_LastNormalAttackTime");
			if (_actor.LogicTime > logicTagValue + Config.SaveComboIndexTime)
			{
				_attackCount = 0;
			}
			else
			{
				_attackCount = (int)(long)_actor.logicVariable.GetLogicTagValue("137TD_NormalAttackCount");
			}
			if (_attackCount < 0)
			{
				_attackCount = 0;
			}
			else if (_attackCount >= Config.comboTagListNormalAttack.Count)
			{
				_attackCount = Config.comboTagListNormalAttack.Count - 1;
			}
			_attackTag = Config.comboTagListNormalAttack.get_Item(_attackCount);
		}
		if (_actor.attackTarget != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
		}
		string attackTag = _attackTag;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		Action onAnticipationEnd = OnAnticipationEnd;
		BeginAttack(attackTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			if (targetEntity != _actor.attackTarget)
			{
				targetEntity = _actor.attackTarget;
				aimTarget.Cancel();
				aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
			}
		}
		else
		{
			_actor.CancelAttack();
		}
	}

	protected void OnAnticipationEnd()
	{
		if (IsNormalComboTag(_attackTag))
		{
			if (++_attackCount >= Config.comboTagListNormalAttack.Count)
			{
				_attackCount = 0;
			}
			_actor.logicVariable.SetLogicTagValue("137TD_NormalAttackCount", _attackCount);
			int num = 2;
			if (GetPerk(1370103) && Config.IsInAlert(_actor))
			{
				num += 2;
			}
			_actor.buffComponent.AddBuffNum(801370050, num, _actor);
			TryFireGrenade();
		}
	}

	private void TryFireGrenade()
	{
		if (GetPerk(1370101))
		{
			ILRuntimeAPI.Shoot(targetPosition: (!(_actor.attackTarget != null)) ? (_actor.tsTransform.Position + _actor.tsTransform.Forward * Config.grenadeNoTargetDistance) : ILRuntimeAPI.GetRandomPointInShape(_actor, CommonUtils.GetDeterministicCircleShape(Config.grenadeScatterRadius, 0, _actor.attackTarget.tsTransform.Position), isReachable: false), bulletAlias: "Bullet_137_P2_ShouLei", actor: _actor, range: default, position: _actor.tsTransform.Position, positionY: _actor.dtCollider.HeightCenter, target: null, aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget);
		}
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		if (!IsNormalComboTag(_attackTag))
		{
			_actor.buffComponent.RemoveBuffByBuffId(801370050);
		}
		OnFinish();
	}
}
