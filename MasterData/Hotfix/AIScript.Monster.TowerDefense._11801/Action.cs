using System;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.TowerDefense._11801;

public class Action : TowerCharacterBaseAI
{
	private FP searchRange = 6.5;

	private const int perkId_2 = 1180102;

	private const int searchRange_2 = 3;

	private List<LogicEntity> entities = new List<LogicEntity>();

	private Dictionary<int, Func<bool>> skillCondition;

	public override Dictionary<int, Func<bool>> SkillCondition => skillCondition;

	public override void OnEnable()
	{
		skillCondition = new Dictionary<int, Func<bool>>();
		skillCondition.Add(actor.mainSkillId, () =>
		{
			FP range = (GetPerk(1180102) ? (searchRange + 3) : searchRange);
			CommonUtils.SearchNearTargetsByCircleInTD(actor, actor.tsTransform.Position, range, entities, isConfront: true);
			return entities.Count > 0;
		});
		base.OnEnable();
	}
}
