using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置右上角时间的显示方式", 0)]
[Category("Render/UI")]
[Description("设置右上角时间的显示方式, 只有倒计时的时候, 总时长才有效")]
public class SetBattlePanelUITimeType : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<UITimeType> typeInput = AddValueInput<UITimeType>("类型");
		ValueInput<int> timeInput = AddValueInput<int>("总时长");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
			if (worldStateManager != null)
			{
				worldStateManager.uITimeType = typeInput.value;
				worldStateManager.totalTime = timeInput.value;
				f.Call(output);
			}
		});
	}
}
