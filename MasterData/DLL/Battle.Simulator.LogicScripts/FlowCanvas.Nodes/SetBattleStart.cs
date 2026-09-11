using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置AI开关", 0)]
[Category("Logic/Trigger")]
[Description("设置战斗开始, 在战斗开始前, ai都不会动")]
public class SetBattleStart : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> flagInput = AddValueInput<bool>("开关");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			CommonProcessor.GetWorldState().mBattleStart = flagInput.value;
			f.Call(output);
		});
	}
}
