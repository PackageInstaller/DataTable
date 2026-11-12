using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16101;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private TSVector shootOffset_Atk1 = new TSVector(0, 1.5, 0.5);

	private TSVector shootOffset_Atk2 = new TSVector(0, 1.5, 0.5);

	private TSVector shootOffset_Atk3 = new TSVector(0, 1.5, 0.5);

	private const string key_Atk1 = "161_Atk1";

	private const string key_Atk2 = "161_Atk2";

	private const string key_Atk3 = "161_Atk3";

	private const string evt_Shoot_1 = "Shoot_1";

	private const string evt_Shoot_2 = "Shoot_2";

	private const string evt_Shoot_3 = "Shoot_3";

	private const string bullet_01 = "Bullet_16101_Normal01";

	private const string bullet_02 = "Bullet_16101_Normal02";

	private const string bullet_03 = "Bullet_16101_Normal03";

	private const string bullet01_p1 = "Bullet_16101_01_p1";

	private const string bullet02_p1 = "Bullet_16101_02_p1";

	private const string bullet03_p1 = "Bullet_16101_03_p1";

	private const string bullet01_p2 = "Bullet_16101_01_p2";

	private const string bullet02_p2 = "Bullet_16101_02_p2";

	private const string bullet03_p2 = "Bullet_16101_03_p2";

	private const string bullet01_p1p2 = "Bullet_16101_01_p1p2";

	private const string bullet02_p1p2 = "Bullet_16101_02_p1p2";

	private const string bullet03_p1p2 = "Bullet_16101_03_p1p2";

	private const string bullet_NormalBezier01 = "Bullet_161_Attack_Bezier_1_P07";

	private const string bullet_NormalBezier02 = "Bullet_161_Attack_Bezier_2_P07";

	private const string bullet_NormalBezier03 = "Bullet_161_Attack_Bezier_3_P07";

	private const int perkId_1 = 516101;

	private const int perkId_2 = 516102;

	private const int perkId_7 = 516107;

	private const int paramId_7_prob = 16107001;

	private const int consume_Special_1 = 3;

	private const int consume_Special_7 = 2;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget == null)
		{
			comboAttack.InterruptAttack();
		}
	}

	private void DoMainLogic()
	{
		int num = (int)(long)_actor.logicVariable.GetLogicTagValue("curNormalPhase");
		string text = "161_Atk1";
		switch (num)
		{
		case 1:
			text = "161_Atk1";
			break;
		case 2:
			text = "161_Atk2";
			break;
		case 3:
			text = "161_Atk3";
			break;
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("Shoot_1"))
		{
			ShootBullet(1);
		}
		else if (evt.Equals("Shoot_2"))
		{
			ShootBullet(2);
		}
		else if (evt.Equals("Shoot_3"))
		{
			ShootBullet(3);
		}
	}

	private void ShootBullet(int atkIndex)
	{
		if (_actor.aimLockedTarget == null)
		{
			return;
		}
		TSVector shootOffset = GetShootOffset(atkIndex);
		TSVector2 tSVector = _actor.tsTransform.TransformLocalPointToWorldSpace(new TSVector2(shootOffset.x, shootOffset.z));
		TSVector2 position = new TSVector2(tSVector.x, tSVector.y);
		FP y = shootOffset.y;
		bool perk = GetPerk(516101);
		bool perk2 = GetPerk(516102);
		bool perk3 = GetPerk(516107);
		bool p1Active = false;
		int buffNumByID = _actor.buffComponent.GetBuffNumByID(16100011);
		if (perk)
		{
			int num = 3;
			if (perk3)
			{
				num = 2;
			}
			if (buffNumByID >= num)
			{
				p1Active = true;
				_actor.buffComponent.RemoveBuffByBuffId(16100011, num);
			}
		}
		string bullet = GetBullet(atkIndex, p1Active, perk2);
		AdventureActor actor = _actor;
		LogicEntity aimLockedTarget = _actor.aimLockedTarget;
		ILRuntimeAPI.Shoot(bullet, actor, default, position, y, default, aimLockedTarget, AimType.Target, BulletDirectionType.BulletToTarget);
		if (perk3 && TSRandom.Range(0, 100) < CommonUtils.GetScriptValue(_actor, 16107001))
		{
			string bezierBullet = GetBezierBullet(atkIndex);
			AdventureActor actor2 = _actor;
			aimLockedTarget = _actor.aimLockedTarget;
			ILRuntimeAPI.Shoot(bezierBullet, actor2, default, position, y, default, aimLockedTarget, AimType.Target, BulletDirectionType.BulletToTarget);
		}
	}

	private TSVector GetShootOffset(int atkIndex)
	{
		return atkIndex switch
		{
			2 => shootOffset_Atk2, 
			3 => shootOffset_Atk3, 
			_ => shootOffset_Atk1, 
		};
	}

	private string GetBezierBullet(int atkIndex)
	{
		return atkIndex switch
		{
			2 => "Bullet_161_Attack_Bezier_2_P07", 
			3 => "Bullet_161_Attack_Bezier_3_P07", 
			_ => "Bullet_161_Attack_Bezier_1_P07", 
		};
	}

	private string GetBullet(int atkIndex, bool p1Active, bool p2)
	{
		switch (atkIndex)
		{
		case 2:
			if (p1Active & p2)
			{
				return "Bullet_16101_02_p1p2";
			}
			if (p1Active)
			{
				return "Bullet_16101_02_p1";
			}
			if (p2)
			{
				return "Bullet_16101_02_p2";
			}
			return "Bullet_16101_Normal02";
		case 3:
			if (p1Active & p2)
			{
				return "Bullet_16101_03_p1p2";
			}
			if (p1Active)
			{
				return "Bullet_16101_03_p1";
			}
			if (p2)
			{
				return "Bullet_16101_03_p2";
			}
			return "Bullet_16101_Normal03";
		default:
			if (p1Active & p2)
			{
				return "Bullet_16101_01_p1p2";
			}
			if (p1Active)
			{
				return "Bullet_16101_01_p1";
			}
			if (p2)
			{
				return "Bullet_16101_01_p2";
			}
			return "Bullet_16101_Normal01";
		}
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		_skill?.Clear();
	}
}
