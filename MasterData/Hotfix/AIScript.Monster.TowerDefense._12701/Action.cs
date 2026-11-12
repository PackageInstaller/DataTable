using System;
using System.Collections.Generic;
using AIScript.DynamicLevel;
using AIScript.Utils;

namespace AIScript.Monster.TowerDefense._12701;

public class Action : TowerCharacterBaseAI
{
	private List<LogicEntity> entities = new List<LogicEntity>();

	private Dictionary<int, Func<bool>> skillCondition;

	public override Dictionary<int, Func<bool>> SkillCondition => skillCondition;

	public override void OnEnable()
	{
		skillCondition = new Dictionary<int, Func<bool>>();
		skillCondition.Add(actor.mainSkillId, () =>
		{
			CommonUtils.SearchNearTargetsByCircleInTD(actor, actor.tsTransform.Position, 7.5, entities);
			bool result = false;
			for (int i = 0; i < entities.Count; i++)
			{
				TowerDefenseCharacterActor towerDefenseCharacterActor = entities.get_Item(i) as TowerDefenseCharacterActor;
				if (towerDefenseCharacterActor != null && towerDefenseCharacterActor.isPlayingAttackCombo)
				{
					result = true;
					break;
				}
			}
			return result;
		});
		base.OnEnable();
	}
}
