using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取抛掷物带的增益掉落ID(ID)", 0)]
[Category("Logic/抛掷物")]
[Description("获取抛掷物带的buff配置ID")]
public class GetThrownStateInfoBuffID : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput successOut = AddFlowOutput("有数据");
		FlowOutput failOut = AddFlowOutput("无数据");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		ThrownState thrownState = null;
		AddValueOutput("抛掷物ID：", () => thrownState.mCreationIndex);
		AddValueOutput("增益掉落ID：", () => thrownState.mBuffItemID);
		AddFlowInput("In", delegate(Flow f)
		{
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out thrownState))
			{
				failOut.Call(f);
			}
			else
			{
				successOut.Call(f);
			}
		});
	}
}
