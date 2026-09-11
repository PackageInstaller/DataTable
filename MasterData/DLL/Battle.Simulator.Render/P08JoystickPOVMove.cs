using System;
using NetProcol;
using UnityEngine;

public class P08JoystickPOVMove : IStickControllerGameLogic
{
	private Camera mainCamera;

	private int lastMoveDegree = int.MaxValue;

	private int lastLookatDegree = int.MaxValue;

	private int fixtimeDirSndFrame;

	private bool lastControlEnable = true;

	public void UpdateLogic(Vector2 joystickForwardVector)
	{
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (agentManager == null)
		{
			return;
		}
		NAgent playerAgent = agentManager.GetPlayerAgent();
		if (playerAgent == null)
		{
			return;
		}
		if (mainCamera == null)
		{
			mainCamera = Camera.main;
		}
		if (!(mainCamera == null))
		{
			Vector3 vector = new Vector3(joystickForwardVector.x, 0f, joystickForwardVector.y);
			if (vector.sqrMagnitude <= Mathf.Epsilon)
			{
				SendStopMove(playerAgent);
			}
			else
			{
				SendMoveDirection(playerAgent, (Int3)vector);
			}
		}
	}

	public void SendMoveDirection(NAgent player, Int3 inputDirection)
	{
		fixtimeDirSndFrame++;
		Int3 vector = (Int3)mainCamera.transform.forward;
		vector.y = 0;
		int i = IntMath.AngleOfVector(vector).i;
		int i2 = IntMath.AngleOfVector(inputDirection).i;
		int num = i2 - lastMoveDegree;
		int num2 = i - lastLookatDegree;
		bool flag = (!lastControlEnable && lastControlEnable != player.IsCanControl) || player.IsNeedForceControl;
		lastControlEnable = player.IsCanControl;
		if ((MathF.Abs(num) > 1f || MathF.Abs(num2) > 1f || fixtimeDirSndFrame > 30) | flag)
		{
			lastMoveDegree = i2;
			lastLookatDegree = i;
			fixtimeDirSndFrame = 0;
			MoveDirectionCommand moveDirectionCommand = CommandFactory.Create(NetprotoOperationCode.CmdMoveDir) as MoveDirectionCommand;
			moveDirectionCommand.SetData(player.AgentID, i, EMoveDirectionMode.Pov, i2);
			ClientSimulator.Instance.SendLocalCommand(moveDirectionCommand);
		}
	}

	public void SendStopMove(NAgent player)
	{
		if (lastMoveDegree != int.MaxValue)
		{
			lastMoveDegree = int.MaxValue;
			fixtimeDirSndFrame = 0;
			MoveDirectionStopCommand moveDirectionStopCommand = CommandFactory.Create(NetprotoOperationCode.CmdStopMoveDir) as MoveDirectionStopCommand;
			moveDirectionStopCommand.SetData(player.AgentID);
			ClientSimulator.Instance.SendLocalCommand(moveDirectionStopCommand);
		}
	}
}
