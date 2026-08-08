using NetProcol;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("发送剧情指令(看备注)(渲染)", 0)]
[Category("Render/事件")]
[Description("发送剧情指令，该事件用来处理剧情、boss出场、连携等;\n进出剧情需要成对存在")]
public class PostStoryCommand : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<StoryType> storyTypeInput = AddValueInput<StoryType>("剧情类型(可复选)", "storyType");
		ValueInput<bool> isEnterInput = AddValueInput<bool>("进入剧情(True进False出)", "isEnter").SetDefaultAndSerializedValue(v: true);
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			StoryCommand storyCommand = CommandFactory.Create(NetprotoOperationCode.CmdStory) as StoryCommand;
			NAgent playerAgent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetPlayerAgent();
			if (playerAgent != null)
			{
				storyCommand.storyType = storyTypeInput.value;
				storyCommand.enterState = isEnterInput.value;
				storyCommand.mOwner = playerAgent.AgentID;
				ClientSimulator.Instance.SendLocalCommand(storyCommand);
			}
			output.Call(f);
		});
	}
}
