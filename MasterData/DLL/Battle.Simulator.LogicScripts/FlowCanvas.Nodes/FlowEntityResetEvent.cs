using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("发送重置实体事件", 0)]
[Category("Logic/Entity")]
[Description("发送重置实体事件")]
public class FlowEntityResetEvent : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<EntityResetReason> reasonInput = AddValueInput<EntityResetReason>("原因");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddFlowInput("", delegate(Flow f)
		{
			EntityResetEvent evt = EntityResetEvent.Claim(reasonInput.value, entityIDInput.value);
			base.mSimContext.PostEvent(evt);
			output.Call(f);
		});
	}
}
