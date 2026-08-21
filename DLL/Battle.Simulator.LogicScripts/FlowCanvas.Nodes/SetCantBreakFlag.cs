using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("不可破防状态", 0)]
[Category("Logic/Attribute")]
[Description("不可破防状态, true为不可破防")]
public class SetCantBreakFlag : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput output = AddFlowOutput("");
		ValueInput<CantBreakReason> reasonInput = AddValueInput<CantBreakReason>("原因");
		ValueInput<bool> valueInput = AddValueInput<bool>("值");
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
			else
			{
				if (valueInput.value)
				{
					entityWithEntityID.entityPostureValue.cantBreakFlag |= (uint)reasonInput.value;
				}
				else
				{
					entityWithEntityID.entityPostureValue.cantBreakFlag &= (uint)(~reasonInput.value);
				}
				output.Call(f);
			}
		});
	}
}
