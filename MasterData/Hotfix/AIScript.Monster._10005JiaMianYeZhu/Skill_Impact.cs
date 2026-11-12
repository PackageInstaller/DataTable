using System.Collections;
using TrueSync;

namespace AIScript.Monster._10005JiaMianYeZhu;

public class Skill_Impact : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Ready_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.T };

	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo_Normal = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo_Fast = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

	private static readonly FP DashSpeed = 17;

	private static readonly FP DashDistance = 6.2;

	private ComboInputBuffer.ActionKey[] Attack_Combo;

	protected override void OnSkillEnable()
	{
		if (GetBuffNum(_actor, 100050110) > 0)
		{
			Attack_Combo = Attack_Combo_Fast;
		}
		else
		{
			Attack_Combo = Attack_Combo_Normal;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Ready_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		BeginDash(1, GetForward() * -1, 6, 2, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(2, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isRecoveryBegin);
		BeginDash(2, GetForward(), DashSpeed, DashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
