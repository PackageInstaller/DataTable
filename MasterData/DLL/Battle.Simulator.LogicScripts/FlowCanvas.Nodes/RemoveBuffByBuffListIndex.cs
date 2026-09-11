using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除Buff(数组下标)(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("移除数组下表对应的buff")]
[ExposeAsDefinition]
public class RemoveBuffByBuffListIndex : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("True");
		AddFlowOutput("false");
		ValueInput<int> p2 = AddValueInput<int>("持有者实体ID", "作用对象");
		ValueInput<int> p3 = AddValueInput<int>("数组下标", "buffListIndex");
		AddFlowInput(" ", delegate(Flow f)
		{
			BuffProcessor.RemoveBuffByListIndex(base.mSimContext.GetEntityWithEntityID(p2.GetValue()), p3.GetValue());
			trueOut.Call(f);
		});
		AddValueOutput("持有者实体ID", "ownerID", () => p2.GetValue());
	}
}
