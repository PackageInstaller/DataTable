using System;
using System.Collections.Generic;

namespace AIScript.Monster.TowerDefense;

public class TestCharacterAI : TowerCharacterBaseAI
{
	private Func<bool> condition_1120102 = () => true;

	private Dictionary<int, Func<bool>> skillCondition;

	public override Dictionary<int, Func<bool>> SkillCondition => skillCondition;

	public override void OnEnable()
	{
		base.OnEnable();
		skillCondition = new Dictionary<int, Func<bool>> { { 1001, condition_1120102 } };
	}
}
