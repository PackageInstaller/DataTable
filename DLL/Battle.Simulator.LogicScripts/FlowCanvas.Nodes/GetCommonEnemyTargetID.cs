using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取系统指定的怪物ID", 0)]
[Category("Logic/Spawn")]
[Description("获取系统指定的怪物ID")]
public class GetCommonEnemyTargetID : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("", () => CommonProcessor.GetWorldState().targetEnemyType);
	}
}
