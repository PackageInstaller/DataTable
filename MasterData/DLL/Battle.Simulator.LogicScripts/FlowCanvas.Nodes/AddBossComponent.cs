using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("添加boss选目标的组件", 0)]
[Category("Logic/Attribute")]
[Description("添加这个组件之后,boss选目标才能生效")]
public class AddBossComponent : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> deltaValueInput = AddValueInput<int>("增量");
		ValueInput<int> reductionTimeInput = AddValueInput<int>("衰减时间");
		ValueInput<int> reductionPercent = AddValueInput<int>("衰减比例");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			Dictionary<int, int> dictionary = new Dictionary<int, int>(4);
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			List<int> list = FrameListPool<int>.Claim();
			SimPhysics.Overlap(Int3.zero, 20000000, list, RoleCampProcessor.GetInterestCamp(entityWithEntityID.entityCamp.mRoleTypeCamp));
			for (int i = 0; i < list.Count; i++)
			{
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(list[i]);
				if (simEntityByMultiColliders != null && !simEntityByMultiColliders.hasEntityActionDeath && simEntityByMultiColliders.hasEntityBlackboard)
				{
					dictionary[simEntityByMultiColliders.creationIndex] = 0;
				}
			}
			list.Clear();
			entityWithEntityID.AddEntityBoss(deltaValueInput.value, reductionTimeInput.value, reductionPercent.value, 0, 0, dictionary);
			FrameListPool<int>.Release(list);
			output.Call(f);
		});
	}
}
