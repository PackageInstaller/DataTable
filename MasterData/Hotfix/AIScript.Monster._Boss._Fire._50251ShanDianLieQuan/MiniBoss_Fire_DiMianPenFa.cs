using System.Collections;
using TrueSync;

namespace AIScript.Monster._Boss._Fire._50251ShanDianLieQuan;

public class MiniBoss_Fire_DiMianPenFa : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.E,
		ComboInputBuffer.ActionKey._0
	};

	private TSVector2 HomePos;

	private TSVector2 FlashPos01;

	private TSVector2 FlashPos02;

	private TSVector2 FlashPos03;

	private DeterministicShape Shape01;

	private FP FlashTimes01;

	private FP FlashTimes02;

	private FP FlashTimes03;

	private FP BigFlashTimes;

	private FP GroundTimes;

	private readonly string AreaName01 = "Area_50251_MiniBoss_Fire_BigGroundFire";

	private readonly string AreaName02 = "Area_50251_MiniBoss_Fire_GroundFire";

	protected override void OnSkillEnable()
	{
		HomePos = new TSVector2(0, 0);
		TSVector2 homePos = HomePos;
		FP radius = 13;
		FP innerRadius = 0;
		FP angle = 360;
		FP rotation = 0;
		Shape01 = GetShapeData(DeterministicShape.ShapeType.Fan, homePos, default, default, radius, innerRadius, angle, rotation);
		FlashTimes01 = 0;
		FlashTimes02 = 0;
		FlashTimes03 = 0;
		BigFlashTimes = 0;
		GroundTimes = 0;
	}

	protected override IEnumerator DoMainLogic()
	{
		AddBuffToTarget(_actor, 990020140);
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		SetSuperArmorEnable();
		SetLockToughnessEnable();
		yield return WaitCustomEvent("Fire");
		yield return WaitFrame(30);
		StartCor(SpawnFlash04());
		yield return WaitTime(0.5);
		StartCor(SpawnFlash01());
		yield return WaitTime(2.5);
		StartCor(SpawnFlash02());
		yield return WaitTime(2.5);
		StartCor(SpawnFlash03());
		CancelAttack();
		AddBuffToTarget(_actor, 502510007);
		yield return WaitCustomEvent("T1");
		BeginLookAt_NotWait(GetCurrentPlayer(), 1, 150);
		yield return WaitCustomEvent("T2");
		StopLookAt();
		yield return WaitCustomEvent("T3");
		BeginLookAt_NotWait(GetCurrentPlayer(), 1, 150);
		yield return WaitCustomEvent("T4");
		StopLookAt();
		yield return WaitCustomEvent("T5");
		BeginLookAt_NotWait(GetCurrentPlayer(), 1, 360);
		yield return WaitCustomEvent("T6");
		StopLookAt();
		SetSuperArmorDisable();
		SetLockToughnessDisable();
		RemoveBuffFromTarget(_actor, 990020140);
		BeginLookAt_NotWait(GetCurrentPlayer(), 3, 150);
		yield return WaitTime(3);
		StopLookAt();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator SpawnFlash01()
	{
		FlashPos01 = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
		if (GetBuffNum(_actor, 502510009) >= 1)
		{
			PlayAreaEffect(AreaName02, FlashPos01);
			while (FlashTimes01 < 20)
			{
				FP flashTimes = FlashTimes01;
				TSVector2 RandomPos01 = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
				FlashTimes01 = flashTimes + 1;
				int num = 0;
				while (Distance(RandomPos01, FlashPos01) < 6 && num < 100)
				{
					RandomPos01 = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
					num++;
				}
				yield return WaitTime(0.1);
				FlashPos01 = RandomPos01;
				PlayAreaEffect(AreaName02, FlashPos01);
			}
			yield break;
		}
		PlayAreaEffect(AreaName02, FlashPos01);
		while (FlashTimes01 < 10)
		{
			FP flashTimes2 = FlashTimes01;
			TSVector2 RandomPos01 = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
			FlashTimes01 = flashTimes2 + 1;
			int num2 = 0;
			while (Distance(RandomPos01, FlashPos01) < 6 && num2 < 100)
			{
				RandomPos01 = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
				num2++;
			}
			yield return WaitTime(0.2);
			FlashPos01 = RandomPos01;
			PlayAreaEffect(AreaName02, FlashPos01);
		}
	}

	protected IEnumerator SpawnFlash02()
	{
		FlashPos02 = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
		if (GetBuffNum(_actor, 502510009) >= 1)
		{
			PlayAreaEffect(AreaName02, FlashPos02);
			while (FlashTimes02 < 12)
			{
				FP flashTimes = FlashTimes02;
				TSVector2 RandomPos02 = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
				FlashTimes02 = flashTimes + 1;
				int num = 0;
				while (Distance(RandomPos02, FlashPos02) < 6 && num < 100)
				{
					RandomPos02 = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
					num++;
				}
				yield return WaitTime(0.1);
				FlashPos02 = RandomPos02;
				PlayAreaEffect(AreaName02, FlashPos02);
			}
			yield break;
		}
		PlayAreaEffect(AreaName02, FlashPos02);
		while (FlashTimes02 < 6)
		{
			FP flashTimes2 = FlashTimes02;
			TSVector2 RandomPos02 = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
			FlashTimes02 = flashTimes2 + 1;
			int num2 = 0;
			while (Distance(RandomPos02, FlashPos02) < 6 && num2 < 100)
			{
				RandomPos02 = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
				num2++;
			}
			yield return WaitTime(0.2);
			FlashPos02 = RandomPos02;
			PlayAreaEffect(AreaName02, FlashPos02);
		}
	}

	protected IEnumerator SpawnFlash03()
	{
		if (GetBuffNum(_actor, 502510009) >= 1)
		{
			yield return WaitTime(0.1);
			FlashPos03 = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
			PlayAreaEffect(AreaName02, FlashPos03);
			while (FlashTimes03 < 16)
			{
				FP flashTimes = FlashTimes03;
				TSVector2 RandomPos03 = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
				FlashTimes03 = flashTimes + 1;
				int num = 0;
				while (Distance(RandomPos03, FlashPos03) < 6 && num < 100)
				{
					RandomPos03 = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
					num++;
				}
				yield return WaitTime(0.1);
				FlashPos03 = RandomPos03;
				PlayAreaEffect(AreaName02, FlashPos03);
			}
			yield break;
		}
		yield return WaitTime(0.2);
		FlashPos03 = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
		PlayAreaEffect(AreaName02, FlashPos03);
		while (FlashTimes03 < 8)
		{
			FP flashTimes2 = FlashTimes03;
			TSVector2 RandomPos03 = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
			FlashTimes03 = flashTimes2 + 1;
			int num2 = 0;
			while (Distance(RandomPos03, FlashPos03) < 6 && num2 < 100)
			{
				RandomPos03 = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
				num2++;
			}
			yield return WaitTime(0.2);
			FlashPos03 = RandomPos03;
			PlayAreaEffect(AreaName02, FlashPos03);
		}
	}

	protected IEnumerator SpawnFlash04()
	{
		if (GetBuffNum(_actor, 502510009) >= 1)
		{
			PlayAreaEffect(AreaName01, GetEntityPosition(GetCurrentPlayer()));
			yield return WaitTime(2.5);
			PlayAreaEffect(AreaName01, GetEntityPosition(GetCurrentPlayer()));
			yield return WaitTime(2.5);
			PlayAreaEffect(AreaName01, GetEntityPosition(GetCurrentPlayer()));
		}
		else
		{
			PlayAreaEffect(AreaName02, GetEntityPosition(GetCurrentPlayer()));
			yield return WaitTime(2.5);
			PlayAreaEffect(AreaName02, GetEntityPosition(GetCurrentPlayer()));
			yield return WaitTime(2.5);
			PlayAreaEffect(AreaName02, GetEntityPosition(GetCurrentPlayer()));
		}
	}
}
