using System.Collections;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_LaserSweep_LaserOrb : SkillSimpleBase
{
	private FP laserDuration_Low = 8;

	private FP laserRotateSpeed_Low = 60;

	private FP laserDuration_Mid = 8;

	private FP laserRotateSpeed_Mid = 60;

	private FP laserDuration_High = 10;

	private FP laserRotateSpeed_High = 90;

	private FP laserRotateSpeed = 90;

	private FP laserPhase2Duration = 10;

	private string SingleLaser_Combo = "SingleLaser";

	private string DoubleLaser_Combo = "DoubleLaser";

	private string TripleLaser_Combo = "TripleLaser";

	private FP laserWarningTime = 1;

	private FP _rotateSign;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_rotateSign = ((TSRandom.Range(0, 2) == 0) ? FP.One : (-FP.One));
		laserRotateSpeed = TSMath.Abs(laserRotateSpeed) * _rotateSign;
	}

	protected override IEnumerator DoMainLogic()
	{
		AdventureActor entity = _actor.GetLogicComponent<MonsterSummonInfo>()?.SummonActor;
		int num = (int)(long)GetLogicTagFpValue(entity, Config_JuXingMoXiang.PhaseTag);
		int strength = (int)(long)GetLogicTagFpValue(entity, Common_73001.PillarStrengthTag);
		if (num == 2)
		{
			yield return StartCor(DoPhase2());
		}
		else
		{
			yield return StartCor(DoPhase1(strength));
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(0.1);
	}

	private IEnumerator DoPhase1(int strength)
	{
		FP duration;
		FP speed;
		switch (strength)
		{
		case 0:
			duration = laserDuration_Low;
			speed = TSMath.Abs(laserRotateSpeed_Low) * _rotateSign;
			break;
		case 1:
			duration = laserDuration_Mid;
			speed = TSMath.Abs(laserRotateSpeed_Mid) * _rotateSign;
			break;
		default:
			duration = laserDuration_High;
			speed = TSMath.Abs(laserRotateSpeed_High) * _rotateSign;
			break;
		}
		string actionKey = ((strength == 0) ? SingleLaser_Combo : DoubleLaser_Combo);
		BeginAttack(1, actionKey, flushInputedKeys: true);
		yield return WaitTime(laserWarningTime);
		BeginRotateAngle_NotWait(speed * duration, TSMath.Abs(speed));
		yield return WaitTime(duration);
		CancelAttack();
	}

	private IEnumerator DoPhase2()
	{
		FP duration = GetLogicTagFpValue(_actor, Config_JuXingMoXiang.LaserOrbDurationTag);
		if (duration <= FP.Zero)
		{
			duration = laserPhase2Duration;
		}
		BeginAttack(1, TripleLaser_Combo, flushInputedKeys: true);
		yield return WaitTime(laserWarningTime);
		BeginRotateAngle_NotWait(laserRotateSpeed * duration, TSMath.Abs(laserRotateSpeed));
		yield return WaitTime(duration);
		CancelAttack();
	}
}
