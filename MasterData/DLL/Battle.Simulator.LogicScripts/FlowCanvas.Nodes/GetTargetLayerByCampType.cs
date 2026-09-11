using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取目标LayerMask", 0)]
[Category("Logic/抛掷物")]
[Description("获取指定范围内对象")]
public class GetTargetLayerByCampType : FlowControlNode
{
	private uint targetLayerMask;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		ValueInput<uint> campVar = AddValueInput<uint>("发起者阵营");
		ValueInput<TargetCampType> targetCampType = AddValueInput<TargetCampType>("目标阵营关系");
		AddFlowInput("In", delegate(Flow f)
		{
			targetLayerMask = 0u;
			CommonProcessor.TryGetTargetLayerMask(campVar.GetValue(), targetCampType.GetValue(), out targetLayerMask);
			output.Call(f);
		});
		AddValueOutput("目标LayerMask(为0则检查目标阵营关系)：", () => targetLayerMask);
		AddValueOutput("目标阵营关系：", () => targetCampType.value);
	}
}
