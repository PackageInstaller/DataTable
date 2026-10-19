using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行隐藏角色", "Action", new string[] { "hide", "character", "state", "status", "tag" })]
public class ActionHideCharacter : ConfigAction
{
	public BaseFindTargets findTargets;

	public float fadeDuration = 0.5f;

	public override void Do(ActionMemory memory)
	{
		Entity owner = memory.owner;
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		WhereTargets whereTargets = new WhereTargets
		{
			alliance = owner.GetAlliance().GetOp(),
			canBeAttack = true
		};
		findTargets.FindTargets(memory, list, whereTargets);
		if (list.Count > 0)
		{
			foreach (FindTargetResult item in list)
			{
				MonoECS.instance.SetBehaveActive(item.entity, value: false);
				MonoECS.instance.EntityDissolve(item.entity, fadeDuration, isShow: false);
			}
		}
		ListPool<FindTargetResult>.Release(list);
	}
}
