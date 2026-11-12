using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._133;

public class MainSkill : SkillAdvancedBase
{
	private string actionKey = "Skill";

	private const string fireEvent1 = "Fire1";

	private const string fireEvent2 = "Fire2";

	private const string fireEvent3 = "Fire3";

	private const string fireEvent4 = "Fire4";

	private const string fireEvent5 = "Fire5";

	private const string bulletPath1 = "Bullet1";

	private const string bulletPath2 = "Bullet2";

	private const string bulletPath3 = "Bullet3";

	private const string bulletPath4 = "Bullet4";

	private const string bulletPath5 = "Bullet5";

	private const string event_end = "End";

	private List<string> bulletsFire1 = new List<string> { "Bullet1", "Bullet2" };

	private List<string> bulletsFire2 = new List<string> { "Bullet3", "Bullet4" };

	private List<string> bulletsFire3 = new List<string> { "Bullet5", "Bullet1" };

	private List<string> bulletsFire4 = new List<string> { "Bullet2", "Bullet3" };

	private List<string> bulletsFire5 = new List<string> { "Bullet1", "Bullet5" };

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
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private void DoMainLogic()
	{
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals("End"))
		{
			comboAttack?.CancelAttack();
		}
		else if (evt.Equals("Fire1"))
		{
			if (PotentialLv >= 3)
			{
				for (int i = 0; i < bulletsFire1.Count; i++)
				{
					ShootBullet(bulletsFire1.get_Item(i));
				}
			}
			else
			{
				ShootBullet("Bullet1");
			}
		}
		else if (evt.Equals("Fire2"))
		{
			if (PotentialLv >= 3)
			{
				for (int j = 0; j < bulletsFire2.Count; j++)
				{
					ShootBullet(bulletsFire2.get_Item(j));
				}
			}
			else
			{
				ShootBullet("Bullet2");
			}
		}
		else if (evt.Equals("Fire3"))
		{
			if (PotentialLv >= 3)
			{
				for (int k = 0; k < bulletsFire3.Count; k++)
				{
					ShootBullet(bulletsFire3.get_Item(k));
				}
			}
			else
			{
				ShootBullet("Bullet3");
			}
		}
		else if (evt.Equals("Fire4"))
		{
			if (PotentialLv >= 3)
			{
				for (int l = 0; l < bulletsFire4.Count; l++)
				{
					ShootBullet(bulletsFire4.get_Item(l));
				}
			}
			else
			{
				ShootBullet("Bullet4");
			}
		}
		else
		{
			if (!evt.Equals("Fire5"))
			{
				return;
			}
			if (PotentialLv >= 3)
			{
				for (int m = 0; m < bulletsFire5.Count; m++)
				{
					ShootBullet(bulletsFire5.get_Item(m));
				}
			}
			else
			{
				ShootBullet("Bullet5");
			}
		}
	}

	private void ShootBullet(string bulletPath)
	{
		if (_actor.attackTarget != null && !_actor.attackTarget.IsDead())
		{
			TSVector2 position = _actor.tsTransform.TransformLocalPointToWorldSpace(new TSVector2(0, 1.5f));
			AdventureActor actor = _actor;
			FP range = 0;
			FP positionY = 1.8;
			LogicEntity attackTarget = _actor.attackTarget;
			ILRuntimeAPI.Shoot(bulletPath, actor, range, position, positionY, default, attackTarget, AimType.Target, BulletDirectionType.BulletToTarget);
		}
		else
		{
			ILRuntimeAPI.ShootByDirection(bulletPath, _actor, default, _actor.tsTransform.Forward, _actor.tsTransform.Position);
		}
	}
}
