using System.Collections;
using TrueSync;

namespace AIScript.Monster._50551CanCha;

public class Skill_NearAttack : SkillSimpleBase
{
	private long warningFxID;

	private bool fxState;

	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly string custom_Turn = "Turn";

	private static readonly string custom_StopTurn = "StopTurn";

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (fxState)
		{
			StopEffect(warningFxID);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return BeginLookAt(GetCurrentPlayer(), 0.3, 300);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		TSVector2 tSVector = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0.4));
		Skill_NearAttack skill_NearAttack = this;
		Skill_NearAttack skill_NearAttack2 = this;
		TSVector2 position = tSVector;
		skill_NearAttack.warningFxID = skill_NearAttack2.PlayEffect("fx_common_base_Fire_YuJing_circular_4", 0.7f, default, position);
		fxState = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
		fxState = false;
	}
}
