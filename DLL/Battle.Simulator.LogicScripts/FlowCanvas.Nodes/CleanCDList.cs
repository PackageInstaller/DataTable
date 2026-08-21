using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]移除全部CD", 0)]
[Category("Logic/Attribute")]
[Description("仅清理掉CD组件上记录的CD，而不是重置该组件")]
public class CleanCDList : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		FlowOutput trueOutput = AddFlowOutput("True", "true");
		FlowOutput errorOutput = AddFlowOutput("Error", "error");
		AddValueOutput("实体ID", "entityID", () => entityIDInput.GetValue());
		AddFlowInput("In", "in", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				errorOutput.Call(f);
			}
			else
			{
				CDProcessor.CleanCDList(entityWithEntityID);
				trueOutput.Call(f);
			}
		});
	}
}
