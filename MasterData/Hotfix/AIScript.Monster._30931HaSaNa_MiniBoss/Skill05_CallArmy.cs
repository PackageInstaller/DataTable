using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa_MiniBoss;

public class Skill05_CallArmy : SkillSimpleBase
{
	private static readonly string Drilling_Start = "Drilling_Start";

	private static readonly string Drilling_Out = "Drilling_Out";

	private static readonly string ContinuousCasting = "ContinuousCasting";

	private static readonly string Bullet = "Bullet_SandWave";

	private static readonly TSVector2 TeleportPos = new TSVector2(0, 7);

	private static readonly TSVector2 Left_1 = new TSVector2(-12, 5);

	private static readonly TSVector2 Left_2 = new TSVector2(-12, 0);

	private static readonly TSVector2 Left_3 = new TSVector2(-12, -5);

	private static readonly TSVector2 Right_1 = new TSVector2(12, 5);

	private static readonly TSVector2 Right_2 = new TSVector2(12, 0);

	private static readonly TSVector2 Right_3 = new TSVector2(12, -5);

	private LogicEntity Targetenemy;

	private FP SignX;

	private TSVector2 SpawnDir;

	private List<TSVector2> FirePos = new List<TSVector2>();

	protected override void OnSkillEnable()
	{
		switch (randomWeight(new int[2] { 1, 1 }))
		{
		case 0:
			SignX = -1;
			SpawnDir = new TSVector2(1, 0);
			break;
		case 1:
			SignX = 1;
			SpawnDir = new TSVector2(-1, 0);
			break;
		}
		FirePos.Add(Left_1);
		FirePos.Add(Left_2);
		FirePos.Add(Left_3);
		FirePos.Add(Right_1);
		FirePos.Add(Right_2);
		FirePos.Add(Right_3);
		SetLogicTagToggleValue(_actor, "CallArmy", value: true);
		SetImmuneControlEnable();
	}

	protected override void OnSkillDisable()
	{
		SetLogicTagToggleValue(_actor, "CallArmy", value: false);
		SetLogicTagToggleValue(GetTargetByTeammateIndex(1).get_Item(0), "Locked", value: false);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Drilling_Start, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Hide");
		SetHideModelEnable();
		Teleport(TeleportPos);
		yield return WaitTime(0.5);
		Skill05_CallArmy skill05_CallArmy = this;
		TSVector2 teleportPos = TeleportPos;
		skill05_CallArmy.PlayEffect("fx_m30391_base_Other_2", 1f, default, teleportPos, default, 1f, actorScale: true);
		yield return WaitFrame(4);
		BeginAttack(2, Drilling_Out, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAtByDir_NotWait(TSVector2.down, 0.1, 3600);
		SetHideModelDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (GetLogicTagToggleValue(GetTargetByTeammateIndex(1).get_Item(0), "IsActive"))
		{
			SetLogicTagToggleValue(GetTargetByTeammateIndex(1).get_Item(0), "Locked", value: true);
			PlayLinkFX("fx_30931JiGuanZhuangZhi_loop_charge_link", useCustomSource: true, GetTargetByTeammateIndex(1).get_Item(0).gameObject, TSVector.zero, 0, _actor.slotConfig.bodySlot.gameObject, TSVector.zero, 0);
		}
		BeginAttack(3, ContinuousCasting, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Begin");
		SandWave();
		SoldierBornEffect_1();
		yield return WaitTime(0.5);
		CallSoldier_1();
		yield return WaitTime(8);
		SandWave();
		SoldierBornEffect_2();
		yield return WaitTime(0.5);
		CallSoldier_2();
		yield return WaitTime(8);
		SandWave();
		SoldierBornEffect_1();
		yield return WaitTime(0.5);
		CallSoldier_1();
		yield return WaitTime(11);
		CancelAttack();
		yield return WaitCustomEvent("Boom");
		DispatchCustomEvent("SandSoldier_Boom", isSelfEvent: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(1);
	}

	private void CallSoldier_1()
	{
		SummonTeammate(2, new TSVector2(SignX * 12, 6.25), SpawnDir);
		SummonTeammate(2, new TSVector2(SignX * 12, 1.25), SpawnDir);
		SummonTeammate(2, new TSVector2(SignX * 12, -3.75), SpawnDir);
		SignX = -SignX;
		SpawnDir = -SpawnDir;
	}

	private void CallSoldier_2()
	{
		SummonTeammate(2, new TSVector2(SignX * 12, 3.75), SpawnDir);
		SummonTeammate(2, new TSVector2(SignX * 12, -1.25), SpawnDir);
		SummonTeammate(2, new TSVector2(SignX * 12, -6.25), SpawnDir);
		SignX = -SignX;
		SpawnDir = -SpawnDir;
	}

	private void SoldierBornEffect_1()
	{
		PlayEarlyWarningEffect("fx_warning_circular_2", 0.5f, 0, new TSVector2(SignX * 12, 6.25));
		PlayEarlyWarningEffect("fx_warning_circular_2", 0.5f, 0, new TSVector2(SignX * 12, 1.25));
		PlayEarlyWarningEffect("fx_warning_circular_2", 0.5f, 0, new TSVector2(SignX * 12, -3.75));
	}

	private void SoldierBornEffect_2()
	{
		PlayEarlyWarningEffect("fx_warning_circular_2", 0.5f, 0, new TSVector2(SignX * 12, 3.75));
		PlayEarlyWarningEffect("fx_warning_circular_2", 0.5f, 0, new TSVector2(SignX * 12, -1.25));
		PlayEarlyWarningEffect("fx_warning_circular_2", 0.5f, 0, new TSVector2(SignX * 12, -6.25));
	}

	private void SandWave()
	{
		List<int> list = new List<int>();
		if (SignX < 0)
		{
			FP randomValue = GetRandomValue(0, 2.99, isInt: true);
			FP randomValue2 = GetRandomValue(0, 2.99, isInt: true);
			while (randomValue2 == randomValue)
			{
				randomValue2 = GetRandomValue(0, 2.99, isInt: true);
			}
			FP randomValue3 = GetRandomValue(3, 5.99, isInt: true);
			while (randomValue3 == randomValue + 3 || randomValue3 == randomValue2 + 3)
			{
				randomValue3 = GetRandomValue(3, 5.99, isInt: true);
			}
			list.Add((int)(long)randomValue);
			list.Add((int)(long)randomValue2);
			list.Add((int)(long)randomValue3);
		}
		else
		{
			FP randomValue4 = GetRandomValue(3, 5.99, isInt: true);
			FP randomValue5 = GetRandomValue(3, 5.99, isInt: true);
			while (randomValue5 == randomValue4)
			{
				randomValue5 = GetRandomValue(3, 5.99, isInt: true);
			}
			FP randomValue6 = GetRandomValue(0, 2.99, isInt: true);
			while (randomValue6 == randomValue4 - 3 || randomValue6 == randomValue5 - 3)
			{
				randomValue6 = GetRandomValue(0, 2.99, isInt: true);
			}
			list.Add((int)(long)randomValue4);
			list.Add((int)(long)randomValue5);
			list.Add((int)(long)randomValue6);
		}
		for (int i = 0; i < 3; i++)
		{
			if (list.get_Item(i) < 3)
			{
				PlayEarlyWarningEffect("fx_warning_dash_5x4", 1f, 0, FirePos.get_Item(list.get_Item(i)), GetTSVectToAngle(new TSVector2(1, 0), 0));
				SandWaveFire(FirePos.get_Item(list.get_Item(i)), new TSVector2(1, 0));
			}
			else
			{
				PlayEarlyWarningEffect("fx_warning_dash_5x4", 1f, 0, FirePos.get_Item(list.get_Item(i)), GetTSVectToAngle(new TSVector2(-1, 0), 0));
				SandWaveFire(FirePos.get_Item(list.get_Item(i)), new TSVector2(-1, 0));
			}
		}
	}

	private void SandWaveFire(TSVector2 Pos, TSVector2 Dir)
	{
		string bullet = Bullet;
		FP positionY = 0;
		FP range = 0;
		TSVector2 targetPosition = Pos + 25 * Dir;
		Shoot(bullet, Pos, positionY, range, default, AimType.Position, BulletDirectionType.BulletToTarget, targetPosition);
	}
}
