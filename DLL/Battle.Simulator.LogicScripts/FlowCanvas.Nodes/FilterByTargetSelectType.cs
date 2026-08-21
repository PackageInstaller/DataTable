using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("过滤目标", 0)]
[Category("Logic/抛掷物")]
[Description("过滤目标")]
public class FilterByTargetSelectType : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		ValueInput<int> creationIndexVar = AddValueInput<int>("创建ID", "creationIndex");
		ValueInput<Int3> centerPositionVar = AddValueInput<Int3>("判定中心", "centerPosVar");
		ValueInput<List<int>> waitFilterListVar = AddValueInput<List<int>>("待过滤组", "waitFilterListVar");
		ValueInput<TargetSelectType> targetSelectTypeVar = AddValueInput<TargetSelectType>("过滤条件", "targetSelectTypeVar");
		ValueInput<int> countVar = AddValueInput<int>("取得数量", "countVar");
		ValueInput<List<int>> collisionsVar = AddValueInput<List<int>>("目标EntityID的List");
		AddFlowInput("In", delegate(Flow f)
		{
			TargetSelectType value = targetSelectTypeVar.GetValue();
			List<int> list = null;
			if (value == TargetSelectType.WithoutSelf)
			{
				list = FrameListPool<int>.Claim();
				if (CommonProcessor.TryGetEntityIDOrCasterID(base.mSimContext, creationIndexVar.GetValue(), out var _, out var entityID))
				{
					list.Add(entityID);
				}
			}
			CommonProcessor.TryFilterCollisions(base.mSimContext, centerPositionVar.GetValue(), waitFilterListVar.GetValue(), targetSelectTypeVar.GetValue(), countVar.GetValue(), collisionsVar.GetValue(), list);
			if (list != null)
			{
				FrameListPool<int>.Release(list);
			}
			output.Call(f);
		});
		AddValueOutput("结果：", () => collisionsVar.value);
		AddValueOutput("中心位置：", () => centerPositionVar.value);
	}
}
