using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("统计选择的强化效果ID", 0)]
[Category("Render/UI")]
[Description("统计选择的强化效果ID, 只能在表现层用")]
public class RecordChoosedID : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<int> idInput = AddValueInput<int>("ID");
		AddFlowInput("", delegate(Flow f)
		{
			WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
			if (worldStateManager != null)
			{
				worldStateManager.data.choosedEffectID.Add(idInput.value);
				output.Call(f);
			}
		});
	}
}
