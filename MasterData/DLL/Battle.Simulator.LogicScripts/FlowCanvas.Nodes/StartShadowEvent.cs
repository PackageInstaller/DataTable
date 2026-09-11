using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("启动极限闪避残影(逻辑)", 0)]
[Category("Logic/事件")]
[Description("当抛掷物接")]
public class StartShadowEvent : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> leftTimeInput = AddValueInput<int>("时长");
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
				if (!entityWithEntityID.hasEntityActionAvoidShadow)
				{
					entityWithEntityID.AddEntityActionAvoidShadow(entityWithEntityID.entityPositon.mPosition, newPosted: false, leftTimeInput.value);
				}
				output.Call(f);
			}
		});
	}
}
