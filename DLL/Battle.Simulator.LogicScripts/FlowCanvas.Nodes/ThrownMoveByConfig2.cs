using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物使用配置移动(边缘坐标)(过时)", 0)]
[Category("Logic/抛掷物/移动")]
[Description("默认与1一样，区别在于会输出地图内的目标坐标,当抛掷物出界时候,该输出坐标为边缘坐标\n如果抛掷物无视网格,则边缘值为抛掷物位置")]
public class ThrownMoveByConfig2 : FlowControlNode
{
	protected override void RegisterPorts()
	{
		AddFlowOutput("out");
		AddFlowOutput("不移动");
		AddFlowOutput("异常");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		AddValueInput<int>("TimelineID");
		Int3 targetPosInGraph = Int3.zero;
		bool thrownIgnoreGraph = false;
		AddFlowInput("In", delegate
		{
		});
		AddValueOutput("抛掷物ID", () => thrownIDVar.value);
		AddValueOutput("是否无视网格", () => thrownIgnoreGraph);
		AddValueOutput("网格内目标坐标(出界为边缘坐标)", () => targetPosInGraph);
	}
}
