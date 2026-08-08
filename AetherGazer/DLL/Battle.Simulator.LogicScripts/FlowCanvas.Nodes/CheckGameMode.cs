using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("检查游戏模式(逻辑)", 0)]
[Category("Logic/Control")]
[Description("根据游戏模式进行分支")]
public class CheckGameMode : FlowControlNode
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
			_ = base.mSimContext;
			if (CommonProcessor.IsSinglePlayerGameMode(base.mSimContext))
			{
				m_SinglePlayer.Call(f);
			}
			else if (CommonProcessor.IsMultiplePlayerGameMode(base.mSimContext))
			{
				m_Multiplayer.Call(f);
			}
			else
			{
				m_Error.Call(f);
			}
		});
	}
}
