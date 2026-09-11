using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]是否有忽略的CD", 0)]
[Category("Logic/Attribute")]
[Description("是否有忽略的CD")]
public class HasCDIgnore : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityCD)
			{
				f.Call(falseOut);
			}
			else if (entityWithEntityID.entityCD.mIgnore.Count > 0)
			{
				f.Call(trueOut);
			}
			else
			{
				f.Call(falseOut);
			}
		});
	}
}
