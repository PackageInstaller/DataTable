using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("统计战斗数据", 0)]
[Category("Render/UI")]
[Description("统计战斗数据, 只能在表现层用")]
public class RecordBattleData : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<int> idInput = AddValueInput<int>("ID");
		ValueInput<int> numInput = AddValueInput<int>("数量");
		AddFlowInput("", delegate(Flow f)
		{
			WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
			if (worldStateManager != null)
			{
				worldStateManager.RecordData(idInput.value, numInput.value);
				output.Call(f);
			}
		});
	}
}
