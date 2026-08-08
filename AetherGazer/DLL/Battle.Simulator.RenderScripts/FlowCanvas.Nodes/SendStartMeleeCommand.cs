using NetProcol;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("发送按键输入命令", 0)]
[Category("Render/UI")]
[Description("发送技能输入命令")]
public class SendStartMeleeCommand : FlowControlNodeOfRender
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "agentID");
		ValueInput<ButtonType> buttonIDInput = AddValueInput<ButtonType>("按钮类型", "buttonType");
		ValueInput<bool> pressInput = AddValueInput<bool>("按下还是抬起", "isPress");
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("In", delegate(Flow f)
		{
			StartMeleeCommand startMeleeCommand = CommandFactory.Create(NetprotoOperationCode.CmdMeleeAttack) as StartMeleeCommand;
			startMeleeCommand.SetData(agentIDInput.value, (int)buttonIDInput.value, pressInput.value);
			ClientSimulator.Instance.SendLocalCommand(startMeleeCommand);
			output.Call(f);
		});
		AddValueOutput("实体ID", "agentID", () => agentIDInput.value);
	}
}
