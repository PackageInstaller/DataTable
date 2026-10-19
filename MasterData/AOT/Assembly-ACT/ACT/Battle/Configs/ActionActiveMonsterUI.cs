using ACT.UI;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("激活怪物UI", "Action", new string[] { "active", "monster", "ui", "hud", "text", "tip" })]
public class ActionActiveMonsterUI : ConfigAction
{
	public bool active;

	public override void Do(ActionMemory memory)
	{
		Entity entity = memory.target.entity;
		if (entity.IsMonster() && entity.IsValid && entity.IsAlive())
		{
			Singleton<EntityUIManager>.instance.SetUIActive(entity, active);
		}
	}
}
