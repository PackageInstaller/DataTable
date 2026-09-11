using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("清空当前成就", 0)]
[Category("Render/UI")]
[Description("清空当前成就, 为下一轮重新统计做准备")]
public class ClearCurrentAchievement : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
			if (worldStateManager == null)
			{
				errorOut.Call(f);
			}
			else
			{
				worldStateManager.data.currentAchievement.Clear();
				output.Call(f);
			}
		});
	}
}
