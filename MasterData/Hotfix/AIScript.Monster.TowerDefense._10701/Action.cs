using System;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.TowerDefense._10701;

public class Action : TowerCharacterBaseAI
{
	public static readonly FP searchRange = 7.5;

	private readonly List<LogicEntity> entities = new List<LogicEntity>();

	private Dictionary<int, Func<bool>> skillCondition;

	public override Dictionary<int, Func<bool>> SkillCondition => skillCondition;

	public override void OnEnable()
	{
		skillCondition = new Dictionary<int, Func<bool>>();
		skillCondition.Add(actor.mainSkillId, () =>
		{
			CommonUtils.SearchNearTargetsByCircleInTD(actor, actor.tsTransform.Position, searchRange, entities, isConfront: true);
			return entities.Count > 0;
		});
		base.OnEnable();
	}
}
