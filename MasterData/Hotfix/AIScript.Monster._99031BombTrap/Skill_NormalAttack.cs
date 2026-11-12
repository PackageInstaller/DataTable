using System.Collections;
using AIScript.Monster.Trap;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._99031BombTrap;

public class Skill_NormalAttack : TrapSkillBase
{
	private int startKeyIndex1 = 1;

	private readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1];

	private int startKeyIndex2 = 2;

	private readonly ComboInputBuffer.ActionKey[] endKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private readonly string effectPath = "fx_m99032_loop_tip_atk_mat";

	private readonly FP waitTime = 2f;

	private readonly FP waitReviveTime = 8f;

	private readonly PlayFX playFX = new PlayFX();

	protected override void OnClear()
	{
		base.OnClear();
		playFX?.Stop();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(waitTime));
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(waitReviveTime));
		BeginAttack(startKeyIndex2, endKey);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		_skill?.Clear();
	}
}
