using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[格挡]是否在格挡中(逻辑)", 0)]
[Category("Logic/格挡")]
[Description("判断角色是否在格挡中")]
public class IsInParrying : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		FlowOutput trueOut = AddFlowOutput("格挡中", "true");
		FlowOutput falseOut = AddFlowOutput("不在格挡中", "false");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (!CommonProcessor.IsAliveRole(entityWithEntityID))
			{
				errorOut.Call(f);
			}
			else if (!CommonProcessor.IsInParrying(entityWithEntityID))
			{
				falseOut.Call(f);
			}
			else
			{
				trueOut.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}
}
