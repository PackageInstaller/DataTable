using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取战斗内活动道具(渲染)", 0)]
[Category("Render/UI")]
[Description("获取战斗内活动道具")]
public class GetItemInBattleRender : FlowNode
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
				worldStateManager.GetItem(idInput.value, numInput.value);
				output.Call(f);
			}
		});
	}
}
