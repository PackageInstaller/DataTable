using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._13301;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private ComboInputBuffer.ActionKey[] key = new ComboInputBuffer.ActionKey[3];

	private static readonly Dictionary<string, string> bulletDic = new Dictionary<string, string>
	{
		["Bezier1"] = "Bullet_13301_Attack_3_Bezier1",
		["Bezier2"] = "Bullet_13301_Attack_3_Bezier2",
		["Bezier3"] = "Bullet_13301_Attack_3_Bezier3"
	};

	private LogicEntity targetEntity;

	private AimTarget aimTarget = new AimTarget();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		targetEntity = null;
		aimTarget.Cancel();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
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

	private void DoMainLogic()
	{
		ComboInputBuffer.ActionKey[] keys = key;
		Action<string> action = onCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		if (bulletDic.TryGetValue(evt, out var value) && _actor.aimLockedTarget != null)
		{
			TSVector2 position = _actor.tsTransform.TransformLocalPointToWorldSpace(new TSVector2(0, 1.5f));
			string bulletAlias = value;
			AdventureActor actor = _actor;
			FP range = 0;
			FP positionY = 1.8;
			LogicEntity aimLockedTarget = _actor.aimLockedTarget;
			ILRuntimeAPI.Shoot(bulletAlias, actor, range, position, positionY, default, aimLockedTarget, AimType.Target, BulletDirectionType.BulletToTarget);
		}
	}
}
