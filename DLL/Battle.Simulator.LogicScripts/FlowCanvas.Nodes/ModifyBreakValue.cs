using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改破防值", 0)]
[Category("Logic/Attribute")]
[Description("修改破防值")]
public class ModifyBreakValue : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> deltaInput = AddValueInput<int>("变化值");
		FlowOutput output = AddFlowOutput("");
		FlowOutput falseOutput = AddFlowOutput("失败");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				errorOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityPostureValue)
			{
				errorOut.Call(f);
			}
			else if (entityWithEntityID.entityPostureValue.state == BreakState.breakState || entityWithEntityID.entityPostureValue.cantBreakFlag != 0)
			{
				falseOutput.Call(f);
			}
			else
			{
				entityWithEntityID.entityPostureValue.value += deltaInput.value;
				output.Call(f);
			}
		});
	}
}
