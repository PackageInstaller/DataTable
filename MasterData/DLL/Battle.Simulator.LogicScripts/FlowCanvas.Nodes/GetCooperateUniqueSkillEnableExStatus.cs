using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[连携奥义]得到扩展的\"禁用标记\"(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("额外的32种开关,需要自行记住对应索引代表的含义,非计数;\n已标记:对应索引的扩展开关被涂抹;\n未标记:对应索引的扩展开关未标记;\nError:索引不在[0,31]范围")]
public class GetCooperateUniqueSkillEnableExStatus : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> indexInput = AddValueInput<int>("索引(0-31)", "index");
		AddValueInput<bool>("开关", "boolInput");
		FlowOutput trueOut = AddFlowOutput("已标记", "true");
		FlowOutput falseOut = AddFlowOutput("未标记", "false");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (indexInput.value > 31 || indexInput.value < 0)
			{
				errorOut.Call(f);
			}
			else
			{
				SimWorldState simWorldState = base.mSimContext.sEntityWorldState.status;
				if (((uint)(1 << indexInput.value) & simWorldState.m_cooperateUniqueSkillDisableFlag) != 0)
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
		});
	}
}
