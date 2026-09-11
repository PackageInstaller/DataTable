using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("清理下个区域的位置(AirTest)", 0)]
[Category("Render/Trigger")]
[Description("发送事件给对应的触发器(AirTest)")]
public class DisableNextAreaDirectionInAirTest : CallableActionNode
{
	public override void Invoke()
	{
		AirTestTool.CleanNextAreaDirection();
	}
}
