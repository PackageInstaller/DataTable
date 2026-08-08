using FlowCanvas;
using NetProcol;
using ParadoxNotion.Design;

[Name("发送复活命令", 0)]
[Category("Render/UI")]
[Description("发送复活命令")]
public class SendResurrectCommand : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> targetIDInput = AddValueInput<int>("目标实体ID");
		ValueInput<bool> resultInput = AddValueInput<bool>("是否复活");
		AddFlowOutput("");
		AddFlowInput("", delegate
		{
			ResurrectCommand resurrectCommand = CommandFactory.Create(NetprotoOperationCode.CmdResurrect) as ResurrectCommand;
			NAgent playerAgent = (NScene.GetCurrentScene() as BattleScene).GetPlayerAgent();
			if (playerAgent != null)
			{
				resurrectCommand.SetData(playerAgent.AgentID, targetIDInput.value, resultInput.value);
				ClientSimulator.Instance.SendLocalCommand(resurrectCommand);
			}
		});
	}
}
