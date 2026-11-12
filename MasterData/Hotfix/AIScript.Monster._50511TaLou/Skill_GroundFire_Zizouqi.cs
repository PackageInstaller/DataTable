using System.Collections;
using TrueSync;

namespace AIScript.Monster._50511TaLou;

public class Skill_GroundFire_Zizouqi : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Shoot_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private readonly FP AimTime = 1.5;

	private readonly FP AttackPrepareTimeNormal = 0.2;

	private readonly FP AttackPrepareTimePlus = 0;

	private readonly FP AttackShapeAngle = 120;

	private readonly int volcanoSkillId = 5051121;

	private TSVector2 AttackPosition;

	private TSVector2 LeftHandShootPosition;

	private TSVector2 RightHandShootPosition;

	private LogicEntity AimTarget;

	private CoroutineNode GetTargetPositionNode;

	private FP AimTimeCount;

	private long AimTargetLinkFX;

	private long AimTargetLinkFX_L;

	private long AimTargetLinkFX_R;

	private long AimPointLinkFX;

	private long AimPointLinkFX_L;

	private long AimPointLinkFX_R;

	private long BeginAttackFX;

	private long BeginAttackFX_L;

	private long BeginAttackFX_R;

	private long LeftHandFX;

	private long RightHandFX;

	private FP AttackPrepareTime;

	private DeterministicShape AttackShape;

	private FP Difficulty;

	protected override void OnSkillEnable()
	{
		AttackPosition = GetEntityPosition(GetAttackTarget());
		Difficulty = GetLogicTagFpValue(_actor, "Difficulty");
		AimTimeCount = AimTime;
		AttackPrepareTime = AttackPrepareTimeNormal;
	}

	protected override void OnSkillDisable()
	{
		StopEffect(AimTargetLinkFX);
		StopEffect(AimTargetLinkFX_L);
		StopEffect(AimTargetLinkFX_R);
		StopEffect(AimPointLinkFX);
		StopEffect(AimPointLinkFX_L);
		StopEffect(AimPointLinkFX_R);
		StopEffect(BeginAttackFX);
		StopEffect(BeginAttackFX_L);
		StopEffect(BeginAttackFX_R);
		StopEffect(LeftHandFX);
		StopEffect(RightHandFX);
	}

	protected override IEnumerator DoMainLogic()
	{
		Skill_GroundFire_Zizouqi skill_GroundFire_Zizouqi = this;
		Skill_GroundFire_Zizouqi skill_GroundFire_Zizouqi2 = this;
		TSVector2 position = GetPosition();
		FP radius = 200;
		FP innerRadius = 0;
		FP attackShapeAngle = AttackShapeAngle;
		FP rotation = GetRotation();
		skill_GroundFire_Zizouqi.AttackShape = skill_GroundFire_Zizouqi2.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, attackShapeAngle, rotation);
		LeftHandShootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(-2.24, 1.96));
		RightHandShootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(1.94, 1.94));
		BeginAttack(1, Shoot_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1);
		LeftHandFX = PlayEffect("Shoot_HandFX_L");
		RightHandFX = PlayEffect("Shoot_HandFX_R");
		AimTarget = GetAttackTarget(isUpToDate: true);
		if (CheckTargetIsValid(AimTarget))
		{
			StartCor(ref GetTargetPositionNode, GetTargetPosition());
			PlayAimTargetLinkFX("LaserA");
			while (AimTimeCount > 0)
			{
				if (!CheckTargetIsValid(AimTarget) || !AreaCheckMonsterTarget(AttackShape))
				{
					StopEffect(AimTargetLinkFX);
					StopCor(GetTargetPositionNode);
					PlayAimPointLinkFX("LaserA");
					AimTimeCount = 0;
				}
				AimTimeCount -= (FP)0.03;
				yield return null;
			}
		}
		else
		{
			PlayAimPointLinkFX("LaserA");
			yield return WaitTime(AimTime);
		}
		StopEffect(AimTargetLinkFX);
		StopEffect(AimTargetLinkFX_L);
		StopEffect(AimTargetLinkFX_R);
		StopEffect(AimPointLinkFX);
		StopEffect(AimPointLinkFX_L);
		StopEffect(AimPointLinkFX_R);
		StopCor(GetTargetPositionNode);
		PlayBeginAttackFX("LaserB");
		PlayAreaEffect("GroundFire_Plus", AttackPosition);
		yield return WaitTime(0.3);
		CancelAttack();
		yield return WaitTime(0.4);
		PlayLinkEffect("Laser_Shoot_L", useCustomSource: true, null, LeftHandShootPosition, 1.12, null, AttackPosition);
		PlayLinkEffect("Laser_Shoot_R", useCustomSource: true, null, RightHandShootPosition, 1.08, null, AttackPosition);
		StopEffect(BeginAttackFX);
		StopEffect(BeginAttackFX_L);
		StopEffect(BeginAttackFX_R);
		StopEffect(LeftHandFX);
		StopEffect(RightHandFX);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator GetTargetPosition()
	{
		while (CheckTargetIsValid(AimTarget))
		{
			if (AreaCheckMonsterTarget(AttackShape))
			{
				AttackPosition = GetEntityPosition(AimTarget);
			}
			yield return null;
		}
	}

	private void PlayAimTargetLinkFX(string FxName)
	{
		LogicEntity target = AimTarget;
		AimTargetLinkFX = PlayLinkEffect(FxName, useCustomSource: false, null, default, default, target);
		string fxAlias = FxName + "_L";
		target = AimTarget;
		AimTargetLinkFX_L = PlayLinkEffect(fxAlias, useCustomSource: false, null, default, default, target);
		string fxAlias2 = FxName + "_R";
		target = AimTarget;
		AimTargetLinkFX_R = PlayLinkEffect(fxAlias2, useCustomSource: false, null, default, default, target);
	}

	private void PlayAimPointLinkFX(string FxName)
	{
		TSVector2 attackPosition = AttackPosition;
		FP targetPositionY = 0;
		AimPointLinkFX = PlayLinkEffect(FxName, useCustomSource: false, null, default, default, null, attackPosition, targetPositionY);
		string fxAlias = FxName + "_L";
		attackPosition = AttackPosition;
		targetPositionY = 0;
		AimPointLinkFX_L = PlayLinkEffect(fxAlias, useCustomSource: false, null, default, default, null, attackPosition, targetPositionY);
		string fxAlias2 = FxName + "_R";
		attackPosition = AttackPosition;
		targetPositionY = 0;
		AimPointLinkFX_R = PlayLinkEffect(fxAlias2, useCustomSource: false, null, default, default, null, attackPosition, targetPositionY);
	}

	private void PlayBeginAttackFX(string FxName)
	{
		TSVector2 attackPosition = AttackPosition;
		FP targetPositionY = 0;
		BeginAttackFX = PlayLinkEffect(FxName, useCustomSource: false, null, default, default, null, attackPosition, targetPositionY);
		string fxAlias = FxName + "_L";
		attackPosition = AttackPosition;
		targetPositionY = 0;
		BeginAttackFX_L = PlayLinkEffect(fxAlias, useCustomSource: false, null, default, default, null, attackPosition, targetPositionY);
		string fxAlias2 = FxName + "_R";
		attackPosition = AttackPosition;
		targetPositionY = 0;
		BeginAttackFX_R = PlayLinkEffect(fxAlias2, useCustomSource: false, null, default, default, null, attackPosition, targetPositionY);
	}
}
