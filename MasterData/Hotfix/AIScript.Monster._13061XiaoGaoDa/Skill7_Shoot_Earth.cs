using System.Collections;
using TrueSync;

namespace AIScript.Monster._13061XiaoGaoDa;

public class Skill7_Shoot_Earth : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	private static readonly string area_mid = "AreaEffect_XiaoGaoDa_Skill7_Mid";

	private static readonly string area_big = "AreaEffect_XiaoGaoDa_Skill7_Big";

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity attackTarget = GetAttackTarget();
		BeginLookAt_NotWait(attackTarget, 1, 400);
		yield return WaitTime(0.5);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitTime(2.5);
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetAttackTarget(isUpToDate: true));
		PlayAreaEffect(area_mid, entityPositionObsoleted);
		yield return WaitTime(1.2);
		PlayAreaEffect(area_big, GetEntityPositionObsoleted(GetAttackTarget(isUpToDate: true)));
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
