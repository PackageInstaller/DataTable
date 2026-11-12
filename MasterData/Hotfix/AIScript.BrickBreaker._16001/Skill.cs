using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.BrickBreaker._16001;

public class Skill : SkillSimpleBase
{
	private readonly string combo_key = "Skill";

	private readonly FP bubbleDuration = 5;

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
		BeginAttack(1, combo_key, flushInputedKeys: true, forceInterruptAttack: true);
		List<Brick_Ball> energyBalls = Singleton<BrickBreakerManager>.Instance.GetEnergyBalls();
		if (energyBalls != null)
		{
			Singleton<BrickBreakerManager>.Instance?.CreateBubble(energyBalls.get_Item(0).tsTransform.Position, bubbleDuration);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	public void OnUpdate()
	{
	}

	protected override void OnCustomEvent(int comboIndex, string evt)
	{
	}
}
