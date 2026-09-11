using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("逻辑输入事件(奥义)(逻辑)", 0)]
[Category("Logic/事件")]
[Description("在获取输入的时候触发")]
public class QTELogicInputEvent : LogicInputEventBase
{
	protected override bool Condition(int pEntityID, int pInputKey)
	{
		return pInputKey == 7;
	}
}
