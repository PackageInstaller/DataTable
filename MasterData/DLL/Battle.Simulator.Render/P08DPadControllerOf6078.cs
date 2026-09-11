using NetProcol;
using UnityEngine;

public class P08DPadControllerOf6078 : IStickControllerGameLogic
{
	private int preMoveDirection = int.MaxValue;

	private int FixtimeDirSndFrame;

	private bool PreControlEnable = true;

	private bool _isOverlookInput;

	private bool _sendStopCommand;

	public P08DPadControllerOf6078(bool pIsOverlookInput, bool pSendStopCommand)
	{
		_isOverlookInput = pIsOverlookInput;
		_sendStopCommand = pSendStopCommand;
	}

	public void SendStopMove(NAgent player, bool force = false)
	{
		if (_sendStopCommand && ((preMoveDirection != int.MaxValue) | force))
		{
			preMoveDirection = int.MaxValue;
			FixtimeDirSndFrame = 0;
			MoveDirectionStopCommand moveDirectionStopCommand = CommandFactory.Create(NetprotoOperationCode.CmdStopMoveDir) as MoveDirectionStopCommand;
			moveDirectionStopCommand.SetData(player.AgentID);
			ClientSimulator.Instance.SendLocalCommand(moveDirectionStopCommand);
		}
	}

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
				moveDirectionCommand.SetData(player.AgentID, i, EMoveDirectionMode.Lookat);
				ClientSimulator.Instance.SendLocalCommand(moveDirectionCommand);
			}
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
		if (agentManager == null)
		{
			return;
		}
		NAgent playerAgent = agentManager.GetPlayerAgent();
		if (playerAgent == null)
		{
			return;
		}
		Vector3 vector = new Vector3(joystickForwardVector.x, 0f, joystickForwardVector.y);
		float num = Mathf.Abs(vector.x);
		float num2 = Mathf.Abs(vector.z);
		if (num < num2)
		{
			vector.x = 0f;
		}
		else
		{
			vector.z = 0f;
		}
		if (vector.x > 0f)
		{
			vector.x = 1f;
		}
		else if (vector.x < 0f)
		{
			vector.x = -1f;
		}
		else
		{
			vector.x = 0f;
		}
		if (vector.z > 0f)
		{
			vector.z = 1f;
		}
		else if (vector.z < 0f)
		{
			vector.z = -1f;
		}
		else
		{
			vector.z = 0f;
		}
		if (vector.sqrMagnitude <= Mathf.Epsilon)
		{
			SendStopMove(playerAgent);
			return;
		}
		Vector3 forward = Camera.main.transform.forward;
		if (_isOverlookInput)
		{
			forward.z = forward.y;
		}
		forward.y = 0f;
		Int3 lhs = (Int3)(Quaternion.LookRotation(forward.normalized) * vector);
		SendMoveDirection(playerAgent, lhs);
	}
}
