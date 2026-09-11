using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置能否被传送结果(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("该节点用于接在【能否被传送扩展事件】后,调整【能否被传送】的结果")]
public class SetCanBeTransferResult : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> beTransferEntityIDInput = AddValueInput<int>("被传送实体ID", "beTransferEntityID");
		ValueInput<bool> resutlInput = AddValueInput<bool>("新值", "result");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(beTransferEntityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				entityWithEntityID.entityBlackboard.var.mTempCanBeTransfer = resutlInput.value;
				output.Call(f);
			}
		});
	}
}
