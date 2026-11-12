using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._11031FaMuXie;

public class Skill_06 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	private string End1 = "Skill6_End1";

	private string End2 = "Skill6_End2";

	private string End3 = "Skill6_End3";

	private long Link01;

	private long Link02;

	private long ChargeEffect01;

	private long ChargeEffect02;

	private long ChargeAtk;

	private long ClawBulletId;

	private List<long> WeaponIds = new List<long>();

	private int FinalEnd;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		FinalEnd = 0;
		WeaponIds = GetLogicTagListLongValue(_actor, "FaMuXieWeaponList");
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopEffect(Link01);
		StopEffect(Link02);
		StopAreaEffect(ChargeAtk);
		FinishBullet(ClawBulletId);
		RemoveBuffFromTarget(_actor, 110310010);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
	}

	protected override IEnumerator DoMainLogic()
	{
		if (GetBuffNum(_actor, 110310010) > 0 && GetMonsterTagValue(_actor, 1) == "Lv2")
		{
			BeginAttack(1, Attack, flushInputedKeys: true, forceInterruptAttack: true);
			BeginLookAt_NotWait(GetCurrentPlayer(), 0.5, 360);
			yield return WaitCustomEvent("Shoot");
			ShootClaw();
			while (FinalEnd == 0)
			{
				yield return WaitFrame(3);
			}
			if (FinalEnd == 1)
			{
				yield return WaitDashFinish();
				FinalEnd = 0;
				StopEffect(Link02);
				StopEffect(ChargeEffect01);
				StopEffect(ChargeEffect02);
				FinishBullet(ClawBulletId);
				StopAreaEffect(ChargeAtk);
				PlayEffect("fx_m11031_hit_obstacle_atk_6_02", 1f, 1, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2)), 0, 2f);
				ReboundBullet();
				FinishWeapon(WeaponIds.get_Item(0));
				BeginAttack(2, End3, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitCustomEvent("Turn");
				BeginLookAt_NotWait(GetCurrentPlayer(), 1, 400);
				yield return WaitCustomEvent("TurnEnd");
				StopWaitLookAt();
				yield return WaitCustomEvent("Shootagain");
				ShootClaw();
				while (FinalEnd == 0)
				{
					yield return WaitFrame(3);
				}
				if (FinalEnd == 1)
				{
					yield return WaitDashFinish();
					FinalEnd = 0;
					StopEffect(Link02);
					StopEffect(ChargeEffect01);
					StopEffect(ChargeEffect02);
					FinishBullet(ClawBulletId);
					StopAreaEffect(ChargeAtk);
					PlayEffect("fx_m11031_hit_obstacle_atk_6_02", 1f, 1, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2)), 0, 2f);
					ReboundBullet();
					FinishWeapon(WeaponIds.get_Item(1));
					BeginAttack(2, End3, flushInputedKeys: true, forceInterruptAttack: true);
					yield return WaitCustomEvent("Turn");
					BeginLookAt_NotWait(GetCurrentPlayer(), 1, 400);
					yield return WaitCustomEvent("TurnEnd");
					StopWaitLookAt();
					yield return WaitCustomEvent("Shootagain");
					ShootClaw();
					while (FinalEnd == 0)
					{
						yield return WaitFrame(3);
					}
					if (FinalEnd == 1)
					{
						yield return WaitDashFinish();
						FinalEnd = 0;
						StopEffect(Link02);
						StopEffect(ChargeEffect01);
						StopEffect(ChargeEffect02);
						FinishBullet(ClawBulletId);
						StopAreaEffect(ChargeAtk);
						PlayEffect("fx_m11031_hit_obstacle_atk_6_02", 1f, 1, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2)), 0, 2f);
						ReboundBullet();
						FinishWeapon(WeaponIds.get_Item(2));
						BeginAttack(2, End1, flushInputedKeys: true, forceInterruptAttack: true);
					}
					else
					{
						yield return WaitDashFinish();
						FinalEnd = 0;
						StopEffect(Link02);
						StopEffect(ChargeEffect01);
						StopEffect(ChargeEffect02);
						FinishBullet(ClawBulletId);
						StopAreaEffect(ChargeAtk);
						BeginAttack(2, End2, flushInputedKeys: true, forceInterruptAttack: true);
					}
					yield return WaitCombo(ComboAttackType.isComboFinish);
				}
				else
				{
					yield return WaitDashFinish();
					FinalEnd = 0;
					StopEffect(Link02);
					StopEffect(ChargeEffect01);
					StopEffect(ChargeEffect02);
					FinishBullet(ClawBulletId);
					StopAreaEffect(ChargeAtk);
					BeginAttack(2, End2, flushInputedKeys: true, forceInterruptAttack: true);
				}
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
			else
			{
				yield return WaitDashFinish();
				FinalEnd = 0;
				StopEffect(Link02);
				StopEffect(ChargeEffect01);
				StopEffect(ChargeEffect02);
				FinishBullet(ClawBulletId);
				StopAreaEffect(ChargeAtk);
				BeginAttack(2, End2, flushInputedKeys: true, forceInterruptAttack: true);
			}
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield break;
		}
		BeginAttack(1, Attack, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.5, 360);
		yield return WaitCustomEvent("Shoot");
		ShootClaw();
		while (FinalEnd == 0)
		{
			yield return WaitFrame(3);
		}
		if (FinalEnd == 1)
		{
			yield return WaitDashFinish();
			StopEffect(Link02);
			StopEffect(ChargeEffect01);
			StopEffect(ChargeEffect02);
			FinishBullet(ClawBulletId);
			StopAreaEffect(ChargeAtk);
			PlayEffect("fx_m11031_hit_obstacle_atk_6_02", 1f, 1, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2)), 0, 2f);
			BeginAttack(2, End1, flushInputedKeys: true, forceInterruptAttack: true);
			if (GetBuffNum(_actor, 110310010) > 0)
			{
				ReboundBullet();
				FinishWeapon(WeaponIds.get_Item(0));
			}
		}
		else
		{
			yield return WaitDashFinish();
			StopEffect(Link02);
			StopEffect(ChargeEffect01);
			StopEffect(ChargeEffect02);
			FinishBullet(ClawBulletId);
			StopAreaEffect(ChargeAtk);
			BeginAttack(2, End2, flushInputedKeys: true, forceInterruptAttack: true);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected void ShootClaw()
	{
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2.7));
		TSVector2 targetPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 5));
		AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot("Weapon_11031FaMuXie_Skill06_FlyClaw", _actor, 0, position, 2, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
		LogicEntity target = adventureBulletBase;
		Link01 = PlayLinkEffect("fx_m11031_loop_line_atk_6_loop", useCustomSource: false, null, default, default, target);
	}

	private void OnBulletFinish(IEvent e)
	{
		if (e is AdventureBulletFinishEvent { tag: "FaMuXie_Skill06_A", bulletPosition: var bulletPosition, bulletPositionY: var bulletPositionY } adventureBulletFinishEvent)
		{
			if (adventureBulletFinishEvent.finishReason == BulletFinishReason.HitActor)
			{
				FinalEnd = 2;
				ClawBulletId = Shoot("Weapon_11031FaMuXie_Skill06_Claw", bulletPosition, bulletPositionY, 0, default, AimType.Default, BulletDirectionType.BulletToTarget);
				StopEffect(Link01);
				LogicEntity target = _actor.QueryOwnedBullet(ClawBulletId);
				Link02 = PlayLinkEffect("fx_m11031_loop_line_atk_6_loop", useCustomSource: false, null, default, default, target);
				BeginDashActorForward(1, 35, Distance(GetPosition(), bulletPosition) - 1, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: true, triggerFriendStop: false);
				ChargeEffect01 = PlayEffect("fx_m11031_loop_bady_atk_6", 1f, 0.1, GetPosition(), 0, 1f, actorScale: true);
				ChargeEffect02 = PlayEffect("fx_m11031_loop_bady_atk_6_trail", 1f, 0.1, GetPosition(), 0, 1f, actorScale: true);
				ChargeAtk = PlayAreaEffect("Area_11031FaMuXie_Skill06", GetPosition());
			}
			if (adventureBulletFinishEvent.finishReason == BulletFinishReason.HitObstacle)
			{
				FinalEnd = 1;
				ClawBulletId = Shoot("Weapon_11031FaMuXie_Skill06_Claw", bulletPosition, bulletPositionY, 0, default, AimType.Default, BulletDirectionType.BulletToTarget);
				StopEffect(Link01);
				LogicEntity target = _actor.QueryOwnedBullet(ClawBulletId);
				Link02 = PlayLinkEffect("fx_m11031_loop_line_atk_6_loop", useCustomSource: false, null, default, default, target);
				BeginDashActorForward(1, 35, Distance(GetPosition(), bulletPosition) - 1, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false, 1.5);
				ChargeEffect01 = PlayEffect("fx_m11031_loop_bady_atk_6", 1f, 0.1, GetPosition(), 0, 1f, actorScale: true);
				ChargeEffect02 = PlayEffect("fx_m11031_loop_bady_atk_6_trail", 1f, 0.1, GetPosition(), 0, 1f, actorScale: true);
				ChargeAtk = PlayAreaEffect("Area_11031FaMuXie_Skill06", GetPosition());
			}
		}
	}

	private void ReboundBullet()
	{
		if (GetLogicTagFpValue(_actor, "FaMuXieRebound") <= 8)
		{
			Shoot("Weapon_11031FaMuXie_Skill07_Rebound", GetPosition(), 0, 0, GetForward(), AimType.Default, BulletDirectionType.BulletToTarget);
			FP value = GetLogicTagFpValue(_actor, "FaMuXieRebound") + 1;
			SetLogicTagFpValue(_actor, "FaMuXieRebound", value);
		}
	}
}
