using System;
using System.Collections.Generic;
using AIScript.Utils;

namespace AIScript.Monster.TowerDefense._15701;

public class Action : TowerCharacterBaseAI
{
	private List<LogicEntity> entities = new List<LogicEntity>();

	private Dictionary<int, Func<bool>> skillCondition;

	public override Dictionary<int, Func<bool>> SkillCondition => skillCondition;

	public override void OnEnable()
	{
		skillCondition = new Dictionary<int, Func<bool>> { 
		{
			actor.mainSkillId,
			() =>
			{
				CommonUtils.SearchNearTargetsByCircleInTD(actor, actor.tsTransform.Position, actor.EffectiveSearchRange, entities, isConfront: true);
				return entities.Count > 0;
			}
		} };
		base.OnEnable();
	}
}
