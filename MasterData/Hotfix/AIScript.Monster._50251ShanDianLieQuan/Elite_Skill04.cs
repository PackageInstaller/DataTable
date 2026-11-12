using System.Collections;
using TrueSync;

namespace AIScript.Monster._50251ShanDianLieQuan;

public class Elite_Skill04 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.E,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] Attack02 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.E,
		ComboInputBuffer.ActionKey._2
	};

	private TSVector2 PlayerPos;

	private TSVector2 SelfPos;

	private long AreaEffectID;

	protected override void OnInterrupt(int comboIndex)
	{
		StopAreaEffect(AreaEffectID);
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Warning");
		PlayerPos = GetEntityPositionObsoleted(Targetenemy);
		AreaEffectID = PlayAreaEffect("Area_50251_Elite_Earth_01", PlayerPos);
		yield return WaitCustomEvent("Close");
		SetUnparalleledEnable();
		SetCloseBlockEnable();
		SetSearchedImmunityEnable();
		yield return WaitCustomEvent("Hide");
		SetHideModelEnable();
		Teleport(PlayerPos);
		yield return WaitTime(0.1);
		SelfPos = GetPosition() + TSVector2.Rotate(new TSVector2(0, 3f), _actor.tsTransform.Rotation);
		Teleport(SelfPos);
		yield return WaitTime(0.3);
		BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Appear");
		SetHideModelDisable();
		yield return WaitCustomEvent("Disable");
		SetSearchedImmunityDisable();
		SetUnparalleledDisable();
		yield return WaitCustomEvent("Open");
		SetCloseBlockDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
