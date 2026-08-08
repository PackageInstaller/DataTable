using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取状态", 0)]
[Category("Logic/Attribute")]
[Description("获取变身后的状态,出现的那只怪的位置朝向血量")]
public class GetState : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityID = AddValueInput<int>("entityID");
		AddValueOutput("position", () => base.mSimContext.GetEntityWithEntityID(entityID.value).entityPositon.mPosition);
		AddValueOutput("forward", () => base.mSimContext.GetEntityWithEntityID(entityID.value).entityPositon.mForward);
		AddValueOutput("hp", () => base.mSimContext.GetEntityWithEntityID(entityID.value).entityBlackboard.var.mHP);
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			f.Call(output);
		});
	}
}
