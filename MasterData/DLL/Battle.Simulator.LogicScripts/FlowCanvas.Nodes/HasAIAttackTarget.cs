using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI是否拥有目标", 0)]
[Category("Logic/AI")]
[Description("AI 是否有目标")]
public class HasAIAttackTarget : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			if (AIProcessor.AIHasAttackTarget(entityIDInput.value))
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
