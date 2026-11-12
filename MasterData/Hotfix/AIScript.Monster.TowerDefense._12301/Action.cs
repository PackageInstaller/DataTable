using System;
using System.Collections.Generic;
using AIScript.Utils;

namespace AIScript.Monster.TowerDefense._12301;

public class Action : TowerCharacterBaseAI
{
	private int monsterId = 8012301;

	private List<MonsterAdventureActor> monsters = new List<MonsterAdventureActor>();

	private List<LogicEntity> entities = new List<LogicEntity>();

	private Dictionary<int, Func<bool>> skillCondition;

	public override Dictionary<int, Func<bool>> SkillCondition => skillCondition;

	public override void OnEnable()
	{
		skillCondition = new Dictionary<int, Func<bool>>();
		skillCondition.Add(actor.mainSkillId, () =>
		{
			CommonUtils.GetAllSummonsById(monsters, monsterId);
			CommonUtils.SearchNearTargetsByCircleInTD(actor, actor.tsTransform.Position, 7.5, entities, isConfront: true);
			return monsters.Count <= 0 && entities.Count > 0;
		});
		base.OnEnable();
	}
}
