using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否配置连携奥义(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("True:配置了连携奥义;\nFalse:未配置连携奥义;\n实体ID在本节点仅传递")]
public class HasUsedCooperateUniqueSkill : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		FlowOutput trueOutput = AddFlowOutput("True", "TrueOutput");
		FlowOutput falseOutput = AddFlowOutput("False", "FalseOutput");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (base.mSimContext.sEntityWorldState.status.m_CooperateUniqueSkillID == 0)
			{
				falseOutput.Call(f);
			}
			else
			{
				trueOutput.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}
}
