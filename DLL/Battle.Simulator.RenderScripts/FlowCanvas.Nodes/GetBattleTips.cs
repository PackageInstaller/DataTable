using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取BattleTips的内容", 0)]
[Category("Render/UI")]
[Description("获取BattleTips的内容")]
public class GetBattleTips : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> idInput = AddValueInput<int>("id");
		AddValueOutput("内容", () => WorldStateManager.GetTipsContent(idInput.value));
	}
}
