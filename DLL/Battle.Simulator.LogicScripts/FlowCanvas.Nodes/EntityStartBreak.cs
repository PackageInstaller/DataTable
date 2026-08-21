using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("进入破防状态", 0)]
[Category("Logic/Attribute")]
[Description("进入破防状态, 调节点直接进入破防状态, 下一次tick时生效")]
public class EntityStartBreak : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<bool> refreshInput = AddValueInput<bool>("已经是破防状态是否重置时间");
		ValueInput<bool> cdInput = AddValueInput<bool>("cd中也要进");
		ValueInput<bool> cantBreakInput = AddValueInput<bool>("不可破防状态也要进");
		FlowOutput output = AddFlowOutput("");
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
			else if (entityWithEntityID.entityPostureValue.state == BreakState.breakCDState && !cdInput.value)
			{
				output.Call(f);
			}
			else if (entityWithEntityID.entityPostureValue.cantBreakFlag != 0 && !cantBreakInput.value)
			{
				output.Call(f);
			}
			else if (entityWithEntityID.entityPostureValue.state == BreakState.breakState && refreshInput.value)
			{
				entityWithEntityID.entityPostureValue.curTime = entityWithEntityID.entityPostureValue.breakMaxTime;
				output.Call(f);
			}
			else
			{
				entityWithEntityID.entityPostureValue.value = 0;
				output.Call(f);
			}
		});
	}
}
