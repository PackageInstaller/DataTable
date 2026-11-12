using System.Collections;

namespace AIScript.Monster._50111Xbuffjingling.Summons.CanChaZhu;

public class Skill_AddShield : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, new ComboInputBuffer.ActionKey[1], flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		LogicEntity logicEntity = GetTargetByTeammateIndex(0).get_Item(0);
		if (logicEntity != null)
		{
			AddShieldToTarget(logicEntity, 501110000);
		}
	}
}
