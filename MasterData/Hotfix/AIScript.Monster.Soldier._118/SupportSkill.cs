using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._118;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "Support";

	private const string fireEvent = "Fire";

	private const string bulletPath = "Bullet_Soldier_118_Support";

	private readonly int targetCount = 3;

	private static readonly FP bulletHeight = 1.5;

	private static readonly FP fanAngle = 33;

	private static readonly FP fanInnerRadius = 0.5;

	public static readonly int hitTag_bullet = CommonHelper.StringToHash("Bullet_Soldier_118_Support");

	public const string areaEffectAlias_p3 = "AreaEffect_Soldier_118_Support_Dot";

	public const string logicTag_areaEffectCount = "areaEffectCount_p3";

	private readonly List<SoldierActor> _extraTargetBuffer = new List<SoldierActor>();

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
	}

	public void OnStart()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Support", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
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
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("Fire"))
		{
			ShootBullets();
		}
	}

	private void ShootBullets()
	{
		_actor.logicVariable.SetLogicTagValue("areaEffectCount_p3", 0);
		TSVector2 position = _actor.tsTransform.Position;
		if (_actor.attackTarget != null && !_actor.attackTarget.IsDead())
		{
			AdventureActor actor = _actor;
			FP range = 0;
			FP positionY = bulletHeight;
			LogicEntity attackTarget = _actor.attackTarget;
			ILRuntimeAPI.Shoot("Bullet_Soldier_118_Support", actor, range, position, positionY, default, attackTarget, AimType.Target, BulletDirectionType.BulletToTarget);
			int num = targetCount - 1;
			if (num <= 0 || !(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
			{
				return;
			}
			_extraTargetBuffer.Clear();
			soldierLevelController.GetBattleActors(_actor.attackTarget as AdventureActor, _extraTargetBuffer);
			if (_actor.attackTarget is SoldierActor item)
			{
				_extraTargetBuffer.Remove(item);
			}
			int num2 = 0;
			while (num2 < _extraTargetBuffer.Count && num > 0)
			{
				SoldierActor soldierActor = _extraTargetBuffer.get_Item(num2);
				if (soldierActor != null && !soldierActor.IsDead())
				{
					AdventureActor actor2 = _actor;
					FP range2 = 0;
					FP positionY2 = bulletHeight;
					attackTarget = soldierActor;
					ILRuntimeAPI.Shoot("Bullet_Soldier_118_Support", actor2, range2, position, positionY2, default, attackTarget, AimType.Target, BulletDirectionType.BulletToTarget);
				}
				num2++;
				num--;
			}
		}
		else
		{
			ILRuntimeAPI.FanMultipleShoot(_actor, "Bullet_Soldier_118_Support", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, targetCount, 0, position, bulletHeight, _actor.tsTransform.Forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, fanAngle, 0, fanInnerRadius);
		}
	}
}
