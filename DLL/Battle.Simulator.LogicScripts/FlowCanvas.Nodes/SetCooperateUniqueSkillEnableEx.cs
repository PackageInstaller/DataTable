using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[连携奥义]设置扩展的\"禁用标记\"(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("额外的32种开关,需要自行记住对应索引代表的含义,非计数;\nOut:设置成功;\nError:索引不在[0,31]范围")]
public class SetCooperateUniqueSkillEnableEx : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> indexInput = AddValueInput<int>("索引(0-31)", "index");
		ValueInput<bool> boolInput = AddValueInput<bool>("涂抹", "boolInput");
		FlowOutput output = AddFlowOutput("Out", "output");
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
				if (boolInput.value)
				{
					simWorldState.m_cooperateUniqueSkillDisableFlag = (uint)(1 << indexInput.value) | simWorldState.m_cooperateUniqueSkillDisableFlag;
				}
				else
				{
					simWorldState.m_cooperateUniqueSkillDisableFlag = (uint)(~(1 << indexInput.value)) & simWorldState.m_cooperateUniqueSkillDisableFlag;
				}
				output.Call(f);
			}
		});
	}
}
