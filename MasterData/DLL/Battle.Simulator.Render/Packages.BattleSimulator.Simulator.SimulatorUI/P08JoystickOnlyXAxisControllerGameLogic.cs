using NetProcol;
using UnityEngine;

namespace Packages.BattleSimulator.Simulator.SimulatorUI;

public class P08JoystickOnlyXAxisControllerGameLogic : IStickControllerGameLogic
{
	private int preMoveDirection = int.MaxValue;

	private int FixtimeDirSndFrame;

	private bool PreControlEnable = true;

	private bool PreMoveEqualsZero;

	public void SendMoveDirection(NAgent player, Int3 lhs)
	{
		FixtimeDirSndFrame++;
		if (lhs != Int3.zero)
		{
			int i = IntMath.AngleOfVector(lhs).i;
			int num = i - preMoveDirection;
			bool flag = (!PreControlEnable && PreControlEnable != player.IsCanControl) || player.IsNeedForceControl;
			PreControlEnable = player.IsCanControl;
			if ((num > 1 || num < -1 || FixtimeDirSndFrame > 30) | flag)
			{
				preMoveDirection = i;
				FixtimeDirSndFrame = 0;
				MoveDirectionCommand moveDirectionCommand = CommandFactory.Create(NetprotoOperationCode.CmdMoveDir) as MoveDirectionCommand;
				moveDirectionCommand.SetData(player.AgentID, i, EMoveDirectionMode.CustomMovementLocal, 1);
				ClientSimulator.Instance.SendLocalCommand(moveDirectionCommand);
			}
			PreMoveEqualsZero = false;
		}
		else if (!PreMoveEqualsZero)
		{
			MoveDirectionCommand moveDirectionCommand2 = CommandFactory.Create(NetprotoOperationCode.CmdMoveDir) as MoveDirectionCommand;
			moveDirectionCommand2.SetData(player.AgentID, 9000, EMoveDirectionMode.CustomMovementLocal, lhs.x);
			ClientSimulator.Instance.SendLocalCommand(moveDirectionCommand2);
			PreMoveEqualsZero = true;
		}
	}

	public void UpdateLogic(Vector2 joystickForwardVector)
	{
		if (SceneDirector.Instance == null)
		{
			return;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (null == battleScene || battleScene.GetBattleSimulatorSystem() == null)
		{
			return;
		}
		AgentManager agentManager = battleScene.GetAgentManager();
		if (agentManager != null)
		{
			NAgent playerAgent = agentManager.GetPlayerAgent();
			if (!(playerAgent == null))
			{
				Int3 lhs = (Int3)new Vector3(joystickForwardVector.x, 0f, 1f);
				SendMoveDirection(playerAgent, lhs);
			}
		}
	}
}
