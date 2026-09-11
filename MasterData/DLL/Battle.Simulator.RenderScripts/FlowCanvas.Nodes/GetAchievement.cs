using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获得成就", 0)]
[Category("Render/UI")]
[Description("获得成就")]
public class GetAchievement : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> idInput = AddValueInput<int>("成就ID");
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
				int value = idInput.value;
				worldStateManager.data.currentAchievement.Add(value);
				worldStateManager.data.finishedAchievement.Add(value);
				output.Call(f);
			}
		});
	}
}
