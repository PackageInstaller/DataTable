using System.Collections;
using TrueSync;

namespace AIScript.Monster._50020ShaYuFaShi;

public class Skill_Spike : SkillSimpleBase
{
	private static readonly int ComboIndex = 0;

	private static readonly ComboInputBuffer.ActionKey[] _ComboAttack = new ComboInputBuffer.ActionKey[1];

	private static readonly string AreaFx = "AreaEffect_WaterTrap";

	private static LogicEntity Target;

	private static TSVector2 TargetPOS;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, "Spike", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isRecoveryBegin);
		FanMultipleShoot("ShaYuFaShi_Spike", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, GetPosition(), 0, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 5, 0, 3);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
