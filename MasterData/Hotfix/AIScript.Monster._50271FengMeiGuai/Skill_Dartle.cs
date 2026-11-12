using System.Collections;
using TrueSync;

namespace AIScript.Monster._50271FengMeiGuai;

public class Skill_Dartle : SkillSimpleBase
{
	private LogicEntity target;

	private readonly int SB_StartIndex;

	private readonly string SB_StartKey = "SplitBullet_Start";

	private readonly int SB_InhaleIndex = 1;

	private readonly string SB_InhaleKey = "SplitBullet_Inale";

	private readonly int SB_AttackIndex = 2;

	private readonly string SB_AttackKey = "SplitBullet_Attack";

	private readonly int DartleStartIndex = 3;

	private readonly string DartleStartKey = "Dartle_Start";

	private readonly int DartleAttackIndex = 4;

	private readonly string DartleAttackKey = "Dartle_Attack";

	private string bullet = "FengMeiGuai_skill02_Dartlebullet";

	private bool turnSwitch;

	private FP turnOffset;

	private CoroutineNode shootCor;

	protected override void OnSkillEnable()
	{
		turnSwitch = false;
		turnOffset = 0;
	}

	protected override void OnSkillDisable()
	{
		StopLookAt();
	}

	protected override IEnumerator DoMainLogic()
	{
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			target = GetAttackTarget();
		}
		else
		{
			target = GetCurrentPlayer();
		}
		BeginAttack(DartleStartIndex, DartleStartKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.1);
		BeginAttack(SB_StartIndex, SB_StartKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.4);
		BeginAttack(SB_InhaleIndex, SB_InhaleKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(target, 99, 80);
		yield return WaitTime(1);
		BeginAttack(SB_AttackIndex, SB_AttackKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(0.67);
		PlayEffect("fx_common_base_charge_fire_actor", 1f, 2, GetPosition(), default, 2.5f);
		yield return WaitTime(0.3);
		BeginAttack(DartleAttackIndex, DartleAttackKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(2.5);
		CancelAttack();
		StopCor(shootCor);
		StopLookAt();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (comboIndex == DartleAttackIndex && eventName == "beginShoot")
		{
			shootCor = StartCor(DartleShoot());
		}
	}

	protected IEnumerator DartleShoot()
	{
		for (int i = 0; i < 99; i++)
		{
			TSVector2 multiShootDirection = RotateTo(GetForward(), UpdateAngle());
			FanMultipleShoot(bullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0.2)), 0.5, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, 5, 0, 3);
			yield return WaitTime(0.1);
		}
	}

	private FP UpdateAngle()
	{
		if (AngleBetween2TSVector(GetForward(), RotateTo(GetForward(), turnOffset), signed: false) > 25)
		{
			turnSwitch = !turnSwitch;
		}
		if (turnSwitch)
		{
			turnOffset -= (FP)4;
		}
		else
		{
			turnOffset += (FP)4;
		}
		return turnOffset;
	}
}
