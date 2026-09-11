using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("更新神系分数界面(渲染)", 0)]
[Category("Render/Attribute")]
[Description("更新本次战斗中评分界面不同阵营（主要是天垣）不同等级的描述")]
public class UpdateCombatScoreView : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		ValueInput<int> RaceTypeInput = AddValueInput<int>("多数神系", "RaceType");
		ValueInput<int> RaceNumInput = AddValueInput<int>("数量", "RaceNum");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			GameObject.Find("UICamera/Canvas/UIMain/BattlePanel").GetComponent<BattleUI>().GradeUI.RefreshDescript(RaceTypeInput.value, RaceNumInput.value);
			output.Call(f);
		});
	}
}
