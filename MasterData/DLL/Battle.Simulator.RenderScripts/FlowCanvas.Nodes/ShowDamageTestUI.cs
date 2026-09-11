using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("显示伤害测试窗口", 0)]
[Category("Render/UI")]
[Description("显示伤害测试窗口")]
public class ShowDamageTestUI : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			BattleUI battleUI = BattleUI.GetBattleUI();
			if (battleUI != null)
			{
				battleUI.ShowDamageTestUI();
			}
			output.Call(f);
		});
	}
}
