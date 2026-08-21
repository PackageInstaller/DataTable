using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("停止极限闪避残影(逻辑)", 0)]
[Category("Logic/事件")]
[Description("当抛掷物接")]
public class StopShadowEvent : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput error = AddFlowOutput("Error", "error");
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.GetValue());
			if (entityWithEntityID == null)
			{
				error.Call(f);
			}
			else
			{
				if (entityWithEntityID.hasEntityActionAvoidShadow)
				{
					entityWithEntityID.RemoveEntityActionAvoidShadow();
				}
				output.Call(f);
			}
		});
	}
}
