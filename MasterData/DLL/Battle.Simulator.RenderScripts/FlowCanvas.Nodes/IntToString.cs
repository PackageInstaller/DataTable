using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("数字转字符串和时间", 0)]
[Category("Render/UI")]
[Description("数字转字符串, 时间的话, 传毫秒数, 结果是 10:20 类型的 分钟:秒 ")]
public class IntToString : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> valueInput = AddValueInput<int>("数字");
		AddValueOutput("字符串", () => CommonString.GetNumbers(valueInput.value));
		AddValueOutput("时间格式", () => CommonString.GetTimestamp(valueInput.value));
	}
}
