#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50271FengMeiGuai;

public class Skill_TurnShoot : SkillSimpleBase
{
	private readonly int TS_StartIndex;

	private readonly string TS_StartKey = "TurnShoot_Start";

	private readonly int TS_InhaleIndex = 1;

	private readonly string TS_InhaleKey = "TurnShoot_Inhale";

	private readonly int TS_SwitchIndex = 2;

	private readonly string TS_SwitchKey = "TurnShoot_Switch";

	private readonly int TS_AttackIndex = 3;

	private readonly string TS_AttackKey = "TurnShoot_Attack";

	private int TS_AttackLoopCount;

	private bool ChargeFxSwitch;

	private string bullet = "FengMeiGuai_skill03_bullet";

	private CoroutineNode shootCor;

	private bool isTurnShootTriggered;

	protected override void OnSkillEnable()
	{
		TS_AttackLoopCount = 0;
		ChargeFxSwitch = false;
	}

	protected override void OnSkillDisable()
	{
		StopLookAt();
		StopCor(shootCor);
		isTurnShootTriggered = false;
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.8, 225, 30);
		BeginAttack(TS_StartIndex, TS_StartKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.17);
		BeginAttack(TS_InhaleIndex, TS_InhaleKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.2);
		BeginAttack(TS_SwitchIndex, TS_SwitchKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.5);
		BeginAttack(TS_AttackIndex, TS_AttackKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isRecoveryBegin);
		yield return WaitTime(0.15);
		StopCor(shootCor);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (comboIndex == TS_AttackIndex && eventName == "ChargeFx" && !ChargeFxSwitch)
		{
			PlayEffect("fx_common_base_charge_fire_actor", 1f, 2, GetPosition(), default, 2.5f);
			ChargeFxSwitch = true;
			NovaLogger.Debug("风媒怪.转身射击.标签状态" + ChargeFxSwitch);
		}
	}

	protected IEnumerator TurnShoot()
	{
		FP animationDuration = 1;
		TSVector2 shootDirection = GetForward();
		FP shootDuration = 0.03;
		for (int i = 0; i < 99; i++)
		{
			FanMultipleShoot(bullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, GetPosition(), 1.3, shootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, 5, 0, 3);
			yield return WaitTime(shootDuration);
			shootDirection = RotateTo(shootDirection, -(360 / animationDuration) * shootDuration);
		}
	}

	protected IEnumerator TurnShoot1()
	{
		FP animationDuration = 1;
		TSVector2 shootDirection = GetForward();
		FP shootDuration = 0.03;
		for (int i = 0; i < 67; i++)
		{
			FanMultipleShoot("FengMeiGuai_skill03_bullet02", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, GetPosition(), 1.3, shootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, 5, 0, 3);
			yield return WaitTime(shootDuration);
			shootDirection = RotateTo(shootDirection, -(360 / animationDuration) * shootDuration);
		}
	}

	protected override void OnComboLoop(int comboIndex)
	{
		if (comboIndex != TS_AttackIndex)
		{
			return;
		}
		if (GetBuffNum(_actor, 502710000) >= 1)
		{
			if (TS_AttackLoopCount > 1)
			{
				CancelAttack();
				return;
			}
			TS_AttackLoopCount++;
			if (!isTurnShootTriggered)
			{
				shootCor = StartCor(TurnShoot1());
				isTurnShootTriggered = true;
				shootCor = StartCor(TurnShoot1());
			}
		}
		else if (TS_AttackLoopCount > 0)
		{
			CancelAttack();
		}
		else
		{
			TS_AttackLoopCount++;
			shootCor = StartCor(TurnShoot());
		}
	}
}
