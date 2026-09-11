using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("人工AI输入事件(逻辑)", 0)]
[Category("Logic/事件")]
[Description("向AI发送操作指令,希望干预AI触发的事件")]
public class CommonManualAIInputEvent : ManualAIInputEventBase
{
	protected override void AddCustomValueInput()
	{
	}

	protected override void AddCustionValueOutput()
	{
	}
}
