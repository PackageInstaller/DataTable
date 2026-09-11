using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("添加指挥官组件", 0)]
[Category("Logic/AI")]
[Description("添加指挥官组件")]
public class AddCommanderComponent : FlowNode
{
	protected override void RegisterPorts()
	{
		AddFlowOutput("");
		AddFlowInput("", delegate
		{
			SimEntity simEntityByTriggerID = CommonProcessor.GetSimEntityByTriggerID(0);
			List<TargetInfo> list = new List<TargetInfo>();
			List<EnemyInfo> list2 = new List<EnemyInfo>();
			SimEntity[] entities = base.mSimContext.GetEntities();
			TargetInfo item = default(TargetInfo);
			EnemyInfo item2 = default(EnemyInfo);
			for (int i = 0; i < entities.Length; i++)
			{
				if (entities[i].hasEntityCamp && entities[i].hasEntityBlackboard)
				{
					if (RoleCampProcessor.Is(RoleCampProcessor.GetInterestCamp(2u), entities[i].entityCamp.mRoleTypeCamp))
					{
						item.entityID = entities[i].creationIndex;
						item.lastAttackTime = base.mSimContext.simStatus.mSimTime;
						item.AimMeEnemyNumber = 0;
						list.Add(item);
					}
					else if (RoleCampProcessor.Is(entities[i].entityCamp.mRoleTypeCamp, 2u))
					{
						item2.entityID = entities[i].creationIndex;
						item2.lastAttackTime = base.mSimContext.simStatus.mSimTime;
						list2.Add(item2);
					}
				}
			}
			simEntityByTriggerID.AddEntityCommander(list2, list);
		});
	}
}
