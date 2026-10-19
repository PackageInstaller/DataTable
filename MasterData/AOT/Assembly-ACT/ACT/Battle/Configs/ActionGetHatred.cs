using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取仇恨", "Action", new string[] { "get", "hatred" })]
public class ActionGetHatred : ConfigAction
{
	public TargetBounds bounds;

	protected override AbilityAuth defaultAuth => AbilityAuth.Owner;

	public override void Do(ActionMemory memory)
	{
		Entity owner = memory.owner;
		CompHatred compHatred = owner.GetCompHatred();
		if (!compHatred.GetHatred().IsValid || compHatred.isTemp)
		{
			List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
			WhereTargets whereTargets = new WhereTargets
			{
				alliance = owner.GetAlliance().GetOp(),
				canBeAttack = true
			};
			BaseFindTargetsByArea.FindBoundsTargets(owner, bounds, BattleConsts.entityMask, list);
			whereTargets.FindTargets(list, memory.owner);
			if (list.Count > 0)
			{
				SelectTargets.Filter(list, SelectTargets.FilterType.Nearest, list.Count);
				owner.SetHatred(list[0].entity, temp: true);
			}
			ListPool<FindTargetResult>.Release(list);
		}
	}
}
