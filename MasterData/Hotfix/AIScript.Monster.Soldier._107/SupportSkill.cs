using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._107;

public class SupportSkill : SkillAdvancedBase
{
	private string actionKey = "Support";

	private const string fireEvent = "Fire";

	private const string bulletPath_normal = "Bullet";

	private const string bulletPath = "StunBullet";

	private static readonly FP bulletRange = 10;

	private static readonly FP bulletHeight = 1;

	private const string shieldEvent = "Dun";

	private const string shieldKey = "Dun";

	private int PotentialLv = 1;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
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
	}

	private void DoMainLogic()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		string actionTag = actionKey;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		if (PotentialLv >= 3)
		{
			if (evt.Equals("Dun"))
			{
				if (_actor.attackTarget != null && !_actor.attackTarget.IsDead())
				{
					_actor.AimAtTarget(_actor.attackTarget);
					AdventureActor actor = _actor;
					TSVector2 position = _actor.tsTransform.Position;
					LogicEntity attackTarget = _actor.attackTarget;
					ILRuntimeAPI.Shoot("Dun", actor, position, default, default, attackTarget);
				}
				else
				{
					AdventureActor actor2 = _actor;
					TSVector2 position2 = _actor.tsTransform.Position;
					TSVector2 forward = _actor.tsTransform.Forward;
					LogicEntity attackTarget = _actor.attackTarget;
					ILRuntimeAPI.Shoot("Dun", actor2, position2, forward, default, attackTarget);
				}
			}
		}
		else if (evt.Equals("Fire"))
		{
			string text = "Bullet";
			if (PotentialLv >= 2)
			{
				text = "StunBullet";
			}
			if (_actor.attackTarget != null && !_actor.attackTarget.IsDead())
			{
				_actor.AimAtTarget(_actor.attackTarget);
				string bulletAlias = text;
				AdventureActor actor3 = _actor;
				FP range = 0;
				TSVector2 position3 = _actor.tsTransform.Position;
				FP positionY = bulletHeight;
				LogicEntity attackTarget = _actor.attackTarget;
				ILRuntimeAPI.Shoot(bulletAlias, actor3, range, position3, positionY, default, attackTarget, AimType.Target, BulletDirectionType.BulletToTarget);
			}
			else
			{
				ILRuntimeAPI.ShootByDirection(text, _actor, bulletRange, _actor.tsTransform.Forward, _actor.tsTransform.Position, bulletHeight);
			}
		}
	}
}
