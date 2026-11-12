using System.Collections;
using TrueSync;

namespace AIScript.Monster._50020ShaYuFaShi;

public class Skill_ShadowMeteor_LD : SkillSimpleBase
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

	private static LogicEntity Target;

	private static TSVector2 SelfPOS;

	private static TSVector2 SelfForward;

	private static TSVector2 RelativePoint;

	private static TSVector2 TargetPOS;

	private static long Warning;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		StopEffect(Warning);
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
		TargetPOS = GetEntityPositionObsoleted(Target);
		PlayAreaEffect(AreaFx_Attack, TargetPOS);
		yield return WaitTime(0.4);
		Warning = PlayEffect(Fx_Warning, 1f, default, TargetPOS);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
