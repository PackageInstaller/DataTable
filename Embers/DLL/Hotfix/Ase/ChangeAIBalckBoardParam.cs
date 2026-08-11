using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

[Trigger("改变角色AI黑板参数")]
public class ChangeAIBalckBoardParam : BaseTrigger
{
	public string Key;

	public string Value;

	public override string TriggerName => "改变角色AI黑板参数";

	protected override void DoExecute()
	{
		base.DoExecute();
		List<HeroEntity> teamHero = sceneSystem.GetSystem<EntitySystem>().GetTeamHero();
		if (teamHero == null)
		{
			return;
		}
		foreach (HeroEntity item in teamHero)
		{
			if (item != null && item.IsAi)
			{
				item.GetComponent<AIParadoxComponent>()?.SetVariableValues(Key, Value);
			}
		}
	}
}
