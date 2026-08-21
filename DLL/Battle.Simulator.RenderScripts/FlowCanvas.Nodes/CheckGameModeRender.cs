using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("检查游戏模式(渲染)", 0)]
[Category("Render/Control")]
[Description("根据游戏模式进行分支")]
public class CheckGameModeRender : FlowControlNodeOfRender
{
	private FlowOutput m_SinglePlayer;

	private FlowOutput m_Multiplayer;

	private FlowOutput m_Error;

	protected override void RegisterPorts()
	{
		m_SinglePlayer = AddFlowOutput("单人模式", "SinglePlayer");
		m_Multiplayer = AddFlowOutput("多人模式", "Multiplayer");
		m_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			switch ((NScene.GetCurrentScene() as BattleScene).mGameMode)
			{
			case GameMode.Replay:
			case GameMode.SinglePlayer:
			case GameMode.EditorSinglePlayer:
				m_SinglePlayer.Call(f);
				break;
			case GameMode.Multiplayer:
			case GameMode.EditorMultiPlayer:
			case GameMode.ReplayMultiPlayer:
				m_Multiplayer.Call(f);
				break;
			default:
				m_Error.Call(f);
				break;
			}
		});
	}
}
