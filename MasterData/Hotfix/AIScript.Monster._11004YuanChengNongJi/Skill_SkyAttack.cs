using System.Collections;

namespace AIScript.Monster._11004YuanChengNongJi;

public class Skill_SkyAttack : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private long AreaEffect01;

	private long AreaEffect02;

	protected override void OnInterrupt(int comboIndex)
	{
		StopAreaEffect(AreaEffect01);
		StopAreaEffect(AreaEffect02);
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		BeginLookAt_NotWait(Targetenemy, 0.5, 220);
		yield return WaitCustomEvent("Spawn");
		AreaEffect01 = PlayAreaEffect("Area_11004_SkyAttack", GetEntityPositionObsoleted(Targetenemy));
		AreaEffect02 = PlayAreaEffect("Area_11004_SkyAttack_Warning", GetEntityPositionObsoleted(Targetenemy));
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
