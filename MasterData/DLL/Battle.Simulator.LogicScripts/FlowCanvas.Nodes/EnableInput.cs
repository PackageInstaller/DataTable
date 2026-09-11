using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("启用输入(一直生效)", 0)]
[Description("设置可以输入")]
[Category("Logic/Control")]
public class EnableInput : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID.hasEntityBlackboard)
			{
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2010, 0L, 0L, 0L);
			}
			output.Call(f);
		});
	}
}
