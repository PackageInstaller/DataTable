using System.Collections;
using TrueSync;

namespace AIScript.Monster._30271ShengDanQieChe;

public class Skill_SpecialSpawn : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Run = new ComboInputBuffer.ActionKey[1];

	private TSVector2 QieChe1;

	private TSVector2 QieChe2;

	private long Emoji;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		QieChe1 = GetPlaceHolderPosition("QieChe1");
		QieChe2 = GetPlaceHolderPosition("QieChe2");
		SetUnparalleledEnable();
		SetSearchedImmunityEnable();
		SetBattleOutEnable();
		SetCloseBlockEnable();
		SetSuperArmorEnable(autoDisableWhenSkillDisable: false);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopEffect(Emoji);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Run, flushInputedKeys: true, forceInterruptAttack: true);
		Emoji = PlayEffect("fx_m50801_loop_QiEBaoXiang_Call");
		StartCor(Jump01());
		yield return WaitTime(0.5);
		BeginLookAtByPos_NotWait(QieChe2, 0.5, 360);
		yield return WaitTime(0.5);
		StartCor(Jump02());
		yield return WaitTime(0.5);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator Jump01()
	{
		CrossJump(QieChe1, 0, 0.5, checkPositionReachable: false);
		yield return null;
	}

	protected IEnumerator Jump02()
	{
		CrossJump(QieChe2, 0, 0.5, checkPositionReachable: false);
		yield return null;
	}
}
