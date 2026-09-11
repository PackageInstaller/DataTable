using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("应用游戏设置", 0)]
[Category("Render/Trigger")]
[Description("应用游戏设置")]
public class UpdateGameSetting : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			WorldStateManager.GetWorldStateManager()?.UpdateSetting();
			f.Call(output);
		});
	}
}
