using NetProcol;
using UnityEngine;

public class P08Joystick2DRunForwardControllerGameLogic : IStickControllerGameLogic
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
				moveDirectionCommand.SetData(player.AgentID, i, EMoveDirectionMode.CustomMovementGlobal, 1);
				ClientSimulator.Instance.SendLocalCommand(moveDirectionCommand);
			}
			PreMoveEqualsZero = false;
		}
		else if (!PreMoveEqualsZero)
		{
			MoveDirectionStopCommand moveDirectionStopCommand = CommandFactory.Create(NetprotoOperationCode.CmdStopMoveDir) as MoveDirectionStopCommand;
			moveDirectionStopCommand.SetData(player.AgentID);
			ClientSimulator.Instance.SendLocalCommand(moveDirectionStopCommand);
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
				Int3 lhs = (Int3)new Vector3(0f - joystickForwardVector.y, 0f, 1f);
				SendMoveDirection(playerAgent, lhs);
			}
		}
	}
}
