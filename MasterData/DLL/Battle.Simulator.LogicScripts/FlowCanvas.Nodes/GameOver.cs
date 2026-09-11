using NetProcol;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("GameOver(过时)", 0)]
[Category("Logic/Control")]
[Description("GameOver")]
public class GameOver : CallableActionNode<bool>
{
	public override void Invoke(bool result)
	{
		CommandFactory.Create(NetprotoOperationCode.CmdGameStop);
		_ = (NScene.GetCurrentScene() as BattleScene).GetPlayerAgent() != null;
		if (ClientSimulator.Instance.mGameMode == GameMode.SinglePlayer || ClientSimulator.Instance.mGameMode == GameMode.EditorSinglePlayer)
		{
			ClientSimulator.Instance.StopSim();
		}
		SimEntity[] entities = base.parentNode.mSimContext.GetEntities();
		for (int i = 0; i < entities.Length; i++)
		{
			if (entities[i].hasEntityActionMoveDirection)
			{
				entities[i].RemoveEntityActionMoveDirection();
			}
			if (entities[i].hasEntityActionManualInput)
			{
				entities[i].RemoveEntityActionManualInput();
			}
		}
	}
}
