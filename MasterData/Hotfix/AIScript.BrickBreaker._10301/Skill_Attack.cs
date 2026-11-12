using System.Collections;

namespace AIScript.BrickBreaker._10301;

public class Skill_Attack : SkillSimpleBase
{
	private string combo_key = "Attack";

	protected readonly ComboInputBuffer.ActionKey[] actionKey_1 = new ComboInputBuffer.ActionKey[1];

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		Singleton<BrickBreakerManager>.Instance.SwitchBall(BrickBallType.Fire);
		BeginAttack(1, actionKey_1);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		_skill?.Clear();
	}

	public void OnUpdate()
	{
	}

	private void onCustomEvent(string evt)
	{
	}
}
