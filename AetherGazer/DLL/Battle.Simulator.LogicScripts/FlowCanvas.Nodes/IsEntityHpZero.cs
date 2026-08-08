using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断血量是否为0", 0)]
[Category("Logic/Attribute")]
[Description("判断血量是否小于等于0")]
public class IsEntityHpZero : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				trueOut.Call(f);
			}
			else if (entityWithEntityID.entityBlackboard.var.mHP <= 0)
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
