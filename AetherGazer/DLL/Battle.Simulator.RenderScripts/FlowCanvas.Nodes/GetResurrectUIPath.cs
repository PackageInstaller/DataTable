using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取QTE复活UI路径", 0)]
[Category("Render/Resurrect")]
[Description("获取QTE复活UI路径")]
public class GetResurrectUIPath : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("QTE复活UI路径", "ResurrectUIPath", (ValueHandler<string>)delegate
		{
			WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
			return (worldStateManager != null) ? worldStateManager.QTEResurrectUIPath : "";
		});
	}
}
