using System;
using System.Collections.Generic;

namespace AIScript.Monster.TowerDefense._12601;

public class Action : TowerCharacterBaseAI
{
	private Dictionary<int, Func<bool>> skillCondition;

	public override Dictionary<int, Func<bool>> SkillCondition => skillCondition;

	public override void OnEnable()
	{
		skillCondition = new Dictionary<int, Func<bool>>();
		skillCondition.Add(actor.mainSkillId, () => true);
		base.OnEnable();
	}
}
