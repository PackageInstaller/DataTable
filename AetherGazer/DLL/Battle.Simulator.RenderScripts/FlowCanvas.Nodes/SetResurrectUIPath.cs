using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置QTE复活UI路径", 0)]
[Category("Render/Resurrect")]
[Description("设置QTE复活UI路径")]
public class SetResurrectUIPath : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<string> PathInput = AddValueInput<string>("设置QTE复活UI路径", "ResurrectUIPath");
		FlowOutput Output = AddFlowOutput("");
		FlowOutput ErrorOutput = AddFlowOutput("Error");
		AddFlowInput("", delegate(Flow f)
		{
			WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
			if (worldStateManager == null)
			{
				ErrorOutput.Call(f);
			}
			else
			{
				worldStateManager.QTEResurrectUIPath = PathInput.value;
				Output.Call(f);
			}
		});
	}
}
