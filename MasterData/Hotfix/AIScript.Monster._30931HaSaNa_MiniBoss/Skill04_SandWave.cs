using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa_MiniBoss;

public class Skill04_SandWave : SkillSimpleBase
{
	private static readonly string QuickCasting = "QuickCasting";

	private static readonly string Bullet = "Bullet_SandWave";

	private static readonly TSVector2 Left_1 = new TSVector2(-12, 5);

	private static readonly TSVector2 Left_2 = new TSVector2(-12, 0);

	private static readonly TSVector2 Left_3 = new TSVector2(-12, -5);

	private static readonly TSVector2 Right_1 = new TSVector2(12, 5);

	private static readonly TSVector2 Right_2 = new TSVector2(12, 0);

	private static readonly TSVector2 Right_3 = new TSVector2(12, -5);

	private static readonly TSVector2 LeftToRight = new TSVector2(1, 0);

	private static readonly TSVector2 RightToLeft = new TSVector2(-1, 0);

	private List<TSVector2> FirePos = new List<TSVector2>();

	protected override void OnSkillEnable()
	{
		FirePos.Add(Left_1);
		FirePos.Add(Left_2);
		FirePos.Add(Left_3);
		FirePos.Add(Right_1);
		FirePos.Add(Right_2);
		FirePos.Add(Right_3);
	}

	protected override void OnSkillDisable()
	{
		SetLogicTagToggleValue(GetTargetByTeammateIndex(1).get_Item(0), "Locked", value: false);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, QuickCasting, flushInputedKeys: true, forceInterruptAttack: true);
		if (GetLogicTagToggleValue(GetTargetByTeammateIndex(1).get_Item(0), "IsActive"))
		{
			SetLogicTagToggleValue(GetTargetByTeammateIndex(1).get_Item(0), "Locked", value: true);
			PlayLinkFX("fx_30931JiGuanZhuangZhi_loop_charge_link", useCustomSource: true, GetTargetByTeammateIndex(1).get_Item(0).gameObject, TSVector.zero, 0, _actor.slotConfig.bodySlot.gameObject, TSVector.zero, 0);
		}
		yield return WaitCustomEvent("Call");
		if (GetLogicTagStringValue(_actor, "SkillLv") == "SkillLv_1")
		{
			Wave1();
		}
		else if (GetLogicTagStringValue(_actor, "SkillLv") == "SkillLv_2")
		{
			Wave2();
		}
		else
		{
			Wave3();
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void Wave1()
	{
		FP randomValue = GetRandomValue(0, 5.99, isInt: true);
		if (randomValue < 3)
		{
			PlayEarlyWarningEffect("fx_warning_dash_5x4", 1f, 0, FirePos.get_Item((int)(long)randomValue), GetTSVectToAngle(LeftToRight, 0));
			SandWaveFire(FirePos.get_Item((int)(long)randomValue), LeftToRight);
		}
		else
		{
			PlayEarlyWarningEffect("fx_warning_dash_5x4", 1f, 0, FirePos.get_Item((int)(long)randomValue), GetTSVectToAngle(RightToLeft, 0));
			SandWaveFire(FirePos.get_Item((int)(long)randomValue), RightToLeft);
		}
		if (GetLogicTagToggleValue(GetTargetByTeammateIndex(1).get_Item(0), "IsActive"))
		{
			if (randomValue < 3)
			{
				PlayEarlyWarningEffect("fx_warning_dash_5x4", 1f, 0, FirePos.get_Item((int)(long)randomValue + 3), GetTSVectToAngle(RightToLeft, 0));
				SandWaveFire(FirePos.get_Item((int)(long)randomValue + 3), RightToLeft);
			}
			else
			{
				PlayEarlyWarningEffect("fx_warning_dash_5x4", 1f, 0, FirePos.get_Item((int)(long)randomValue - 3), GetTSVectToAngle(LeftToRight, 0));
				SandWaveFire(FirePos.get_Item((int)(long)randomValue - 3), LeftToRight);
			}
		}
	}

	private void Wave2()
	{
		List<int> list = new List<int>();
		FP randomValue = GetRandomValue(0, 5.99, isInt: true);
		FP randomValue2 = GetRandomValue(0, 5.99, isInt: true);
		while (randomValue2 == randomValue || randomValue2 == randomValue + 3 || randomValue2 == randomValue - 3)
		{
			randomValue2 = GetRandomValue(0, 5.99, isInt: true);
		}
		list.Add((int)(long)randomValue);
		list.Add((int)(long)randomValue2);
		for (int i = 0; i < 2; i++)
		{
			if (list.get_Item(i) < 3)
			{
				PlayEarlyWarningEffect("fx_warning_dash_5x4", 1f, 0, FirePos.get_Item(list.get_Item(i)), GetTSVectToAngle(LeftToRight, 0));
				SandWaveFire(FirePos.get_Item(list.get_Item(i)), LeftToRight);
			}
			else
			{
				PlayEarlyWarningEffect("fx_warning_dash_5x4", 1f, 0, FirePos.get_Item(list.get_Item(i)), GetTSVectToAngle(RightToLeft, 0));
				SandWaveFire(FirePos.get_Item(list.get_Item(i)), RightToLeft);
			}
			if (GetLogicTagToggleValue(GetTargetByTeammateIndex(1).get_Item(0), "IsActive"))
			{
				if (list.get_Item(i) < 3)
				{
					PlayEarlyWarningEffect("fx_warning_dash_5x4", 1f, 0, FirePos.get_Item(list.get_Item(i) + 3), GetTSVectToAngle(RightToLeft, 0));
					SandWaveFire(FirePos.get_Item(list.get_Item(i) + 3), RightToLeft);
				}
				else
				{
					PlayEarlyWarningEffect("fx_warning_dash_5x4", 1f, 0, FirePos.get_Item(list.get_Item(i) - 3), GetTSVectToAngle(LeftToRight, 0));
					SandWaveFire(FirePos.get_Item(list.get_Item(i) - 3), LeftToRight);
				}
			}
		}
	}

	private void Wave3()
	{
		List<int> list = new List<int>();
		FP randomValue = GetRandomValue(0, 5.99, isInt: true);
		FP randomValue2 = GetRandomValue(0, 5.99, isInt: true);
		while (randomValue2 == randomValue || randomValue2 == randomValue + 3 || randomValue2 == randomValue - 3)
		{
			randomValue2 = GetRandomValue(0, 5.99, isInt: true);
		}
		FP randomValue3 = GetRandomValue(0, 5.99, isInt: true);
		while (randomValue3 == randomValue || randomValue3 == randomValue + 3 || randomValue3 == randomValue - 3 || randomValue3 == randomValue2 || randomValue3 == randomValue2 + 3 || randomValue3 == randomValue2 - 3)
		{
			randomValue3 = GetRandomValue(0, 5.99, isInt: true);
		}
		list.Add((int)(long)randomValue);
		list.Add((int)(long)randomValue2);
		list.Add((int)(long)randomValue3);
		for (int i = 0; i < 3; i++)
		{
			if (list.get_Item(i) < 3)
			{
				PlayEarlyWarningEffect("fx_warning_dash_5x4", 1f, 0, FirePos.get_Item(list.get_Item(i)), GetTSVectToAngle(LeftToRight, 0));
				SandWaveFire(FirePos.get_Item(list.get_Item(i)), LeftToRight);
			}
			else
			{
				PlayEarlyWarningEffect("fx_warning_dash_5x4", 1f, 0, FirePos.get_Item(list.get_Item(i)), GetTSVectToAngle(RightToLeft, 0));
				SandWaveFire(FirePos.get_Item(list.get_Item(i)), RightToLeft);
			}
			if (GetLogicTagToggleValue(GetTargetByTeammateIndex(1).get_Item(0), "IsActive"))
			{
				if (list.get_Item(i) < 3)
				{
					PlayEarlyWarningEffect("fx_warning_dash_5x4", 1f, 0, FirePos.get_Item(list.get_Item(i) + 3), GetTSVectToAngle(RightToLeft, 0));
					SandWaveFire(FirePos.get_Item(list.get_Item(i) + 3), RightToLeft);
				}
				else
				{
					PlayEarlyWarningEffect("fx_warning_dash_5x4", 1f, 0, FirePos.get_Item(list.get_Item(i) - 3), GetTSVectToAngle(LeftToRight, 0));
					SandWaveFire(FirePos.get_Item(list.get_Item(i) - 3), LeftToRight);
				}
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
