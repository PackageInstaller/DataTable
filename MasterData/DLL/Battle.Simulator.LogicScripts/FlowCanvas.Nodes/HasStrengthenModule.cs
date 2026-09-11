using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[模组]判断强化模块效果", 0)]
[Category("Logic/装备")]
[Description("判断强化模块/模组效果, 对应id的效果是否激活了")]
public class HasStrengthenModule : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> idInput = AddValueInput<int>("模块ID");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else if (CommonProcessor.HasStrengthenModule(entityWithEntityID.entityBlackboard.var.mAttributeID, idInput.value))
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
