using System.Collections;
using TrueSync;

namespace AIScript.Monster._Boss._Wind._50251ShanDianLieQuan;

public class MiniBoss_Wind_Hurricane : SkillSimpleBase
{
	private readonly string Hurricane = "Hurricane";

	private readonly FP FireTime_Max = 8;

	private readonly FP FireGap_H = 0.8;

	private readonly FP FireGap_L = 1;

	private FP FireTime;

	private long BigHurricane;

	protected override void OnSkillEnable()
	{
		FireTime = 0;
	}

	protected override IEnumerator DoMainLogic()
	{
		AddBuffToTarget(_actor, 990020140);
		BeginAttack(1, Hurricane, flushInputedKeys: true, forceInterruptAttack: true);
		SetSuperArmorEnable();
		SetLockToughnessEnable();
		yield return WaitCustomEvent("HurricaneStart");
		BigHurricane = PlayAreaEffect("Area_50251_MiniBoss_Wind_Hurricane", GetPosition());
		yield return WaitCustomEvent("Fire");
		while (FireTime < FireTime_Max)
		{
			if (GetMonsterTagValue(_actor, 1) == "Hard")
			{
				FP randomValue = GetRandomValue(0, 360);
				SmallHurricane(randomValue);
				SmallHurricane(randomValue + 180);
				yield return WaitTime(FireGap_H);
				FireTime += FireGap_H;
			}
			else
			{
				FP randomValue2 = GetRandomValue(0, 360);
				SmallHurricane(randomValue2);
				yield return WaitTime(FireGap_L);
				FireTime += FireGap_L;
			}
		}
		CancelAttack();
		StopAreaEffect(BigHurricane);
		AddBuffToTarget(_actor, 502510015);
		SetSuperArmorDisable();
		SetLockToughnessDisable();
		RemoveBuffFromTarget(_actor, 990020140);
		BeginLookAt_NotWait(GetCurrentPlayer(), 3, 150);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopLookAt();
	}

	private void SmallHurricane(FP angle)
	{
		Shoot("Bullet_50251_MiniBoss_Wind_SmallHurricane", GetPosition(), 0, 0, RotateTo(TSVector2.up, angle), AimType.Position);
	}
}
