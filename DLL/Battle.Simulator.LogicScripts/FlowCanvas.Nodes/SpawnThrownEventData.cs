using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物创建数据", 0)]
[Category("Logic/抛掷物")]
[Description("抛掷物创建数据")]
public class SpawnThrownEventData : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			output.Call(f);
		});
		ValueInput<PostSpwanThrownEventInfo> spawnThrownEventVar = AddValueInput<PostSpwanThrownEventInfo>("抛掷物创建数据");
		AddValueOutput("抛掷物TimelineID：", () => spawnThrownEventVar.value.ID);
	}
}
