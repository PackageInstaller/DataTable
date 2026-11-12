#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50020ShaYuFaShi;

public class Skill_ShadowMeteor3_LD : SkillSimpleBase
{
	private static readonly int ComboIndex = 0;

	private static readonly ComboInputBuffer.ActionKey[] _ComboKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly FP RotateTime = 0.6;

	private static readonly FP RotateSPD = 360;

	private static readonly string Fx_Warning = "fx_common_base_Dark_YuJing_circular_2";

	private static readonly string AreaFx_Attack = "Dark_Meteorolite";

	private static readonly string BulletAlias = "Weapon_50200AnFaShi_Dark_Bullet";

	private static readonly bool AlignShoot = false;

	private static readonly FP AlignShootDelay = 0;

	private static readonly int BulletCount = 3;

	private static readonly FP Duration = 0;

	private static TSVector2 ShootPosition;

	private static readonly FP ShootPositionY = 0.75;

	private static TSVector2 MultiShootDirection;

	private static readonly FP BulletDirectionOffset = 0;

	private static readonly FP Angle = 75;

	private static readonly FP Radius = 0;

	private static readonly FP InnerRadius = 0;

	private static DeterministicShape Circle;

	private static readonly List<DeterministicShape> AttackRange = new List<DeterministicShape> { Circle, Circle, Circle };

	private static TSVector2 ShapePOS;

	private static readonly FP ShapeRaduis01 = 1;

	private static readonly FP ShapeRaduis02 = 3.5;

	private static readonly FP ShapeInnerRadius02 = ShapeRaduis02 - 0.5;

	private static readonly FP ShapeRaduis03 = 5.3;

	private static readonly FP ShapeInnerRadius03 = ShapeRaduis03 - 0.3;

	private static LogicEntity Target;

	private static TSVector2 TargetPOS;

	private static TSVector2 AttackPOS;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		Target = GetAttackTarget();
		if (Target == null)
		{
			InterruptSkill();
		}
		WaitLookAt_NoWait(Target, RotateTime, RotateSPD);
		BeginAttack(ComboIndex, _ComboKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.1);
		yield return StartCoroutine(Meteor());
		yield return WaitCombo(ComboAttackType.isComboFinish);
		NovaLogger.Debug("技能结束");
	}

	protected IEnumerator Meteor()
	{
		TargetPOS = GetEntityPositionObsoleted(Target);
		ShapePOS = TargetPOS;
		AttackRange.set_Item(0, GetShapeData(DeterministicShape.ShapeType.Circle, ShapePOS, default, default, ShapeRaduis01));
		AttackRange.set_Item(1, GetShapeData(DeterministicShape.ShapeType.Circle, ShapePOS, default, default, ShapeRaduis02, ShapeInnerRadius02));
		AttackRange.set_Item(2, GetShapeData(DeterministicShape.ShapeType.Circle, ShapePOS, default, default, ShapeRaduis03, ShapeInnerRadius03));
		for (int i = 0; i < 3; i++)
		{
			AttackPOS = GetShapeRandomPoint(AttackRange.get_Item(i), _actor, isReachable: true);
			TSVector2 attackPOS = AttackPOS;
			NovaLogger.Debug("攻击坐标为" + attackPOS.ToString());
			PlayAreaEffect(AreaFx_Attack, AttackPOS);
			yield return WaitTime(0.4);
			PlayEffect(Fx_Warning, 1f, default, AttackPOS);
		}
	}
}
