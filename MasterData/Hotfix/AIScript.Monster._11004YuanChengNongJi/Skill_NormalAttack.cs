using System.Collections;

namespace AIScript.Monster._11004YuanChengNongJi;

public class Skill_NormalAttack : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1];

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		BeginLookAt_NotWait(logicEntity, 1, 180);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
