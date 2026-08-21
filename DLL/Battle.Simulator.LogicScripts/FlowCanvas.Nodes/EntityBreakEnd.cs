using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("退出破防状态", 0)]
[Category("Logic/Attribute")]
[Description("退出破防状态, 调节点直接退出破防状态, 下一次tick时生效")]
public class EntityBreakEnd : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput output = AddFlowOutput("");
		FlowOutput notBreakOut = AddFlowOutput("不在破防状态");
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
			else if (entityWithEntityID.entityPostureValue.state != BreakState.breakState)
			{
				notBreakOut.Call(f);
			}
			else
			{
				entityWithEntityID.entityPostureValue.curTime = 0;
				output.Call(f);
			}
		});
	}
}
