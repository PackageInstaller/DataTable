using System.Collections;
using TrueSync;

namespace AIScript.Monster._50581DuoBiTaiDeng;

public class Skill_Die : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	private static readonly string airBorneDeathEffectAlias = "fx_common_base_die_airborne";

	private static readonly FP effectDuration = 2f;

	protected override IEnumerator DoMainLogic()
	{
		SetCloseBlockEnable();
		SendDeclareDeadEvent();
		ClearOwnerBullet();
		KillActors(GetTargetsByFaction(isFriend: true));
		_actor.PlayDeathAnim();
		BeginAttack(1, actionKeys);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
