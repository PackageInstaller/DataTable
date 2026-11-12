using System.Collections;

namespace AIScript.Monster._18021FengGunCao;

public class Die : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		_actor.PlayDeathAnim();
		SetCloseBlockEnable();
		SendDeclareDeadEvent();
		BeginAttack(1, Attack_Combo);
		yield return WaitTime(0.3);
		DropItem(128, GetPosition());
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
