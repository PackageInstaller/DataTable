using System.Collections;
using TrueSync;

namespace AIScript.Monster._50151PoShuiGuai;

public class Skill_Attack_LookAt : SkillSimpleBase
{
	private const string _customEventName_start_lookAt = "A";

	private const string _customEventName_end_lookAt = "B";

	private readonly FP _rotateSpeed = 120;

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1];

	private const int AttackIndex = 1;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (comboIndex != 1)
		{
			return;
		}
		if (!(eventName == "A"))
		{
			if (eventName == "B")
			{
				StopLookAt();
			}
		}
		else
		{
			BeginLookAt_NotWait(_actor.monsterTarget, 999, _rotateSpeed);
		}
	}
}
