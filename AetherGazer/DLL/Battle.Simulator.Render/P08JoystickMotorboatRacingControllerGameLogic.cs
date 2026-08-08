using NetProcol;
using UnityEngine;

public class P08JoystickMotorboatRacingControllerGameLogic : IStickControllerGameLogic
{
	private int preMoveDirection = int.MaxValue;

	private int FixtimeDirSndFrame;

	private bool PreControlEnable = true;

	private CameraParamComponent _cameraParam;

	private P08CinemachineTrackPathExtend _cinemachineTrackPathExtend;

	public void SendStopMove(NAgent player, bool force = false)
	{
		if ((preMoveDirection != int.MaxValue) | force)
		{
			preMoveDirection = int.MaxValue;
			FixtimeDirSndFrame = 0;
			MoveDirectionStopCommand moveDirectionStopCommand = CommandFactory.Create(NetprotoOperationCode.CmdStopMoveDir) as MoveDirectionStopCommand;
			moveDirectionStopCommand.SetData(player.AgentID);
			ClientSimulator.Instance.SendLocalCommand(moveDirectionStopCommand);
		}
	}

	public void SendMoveDirection(NAgent player, Int3 lhs, bool isLimitTurn)
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
		if (_cameraParam == null)
		{
			_cameraParam = battleScene.virtualCameraParam;
			_cinemachineTrackPathExtend = battleScene.virtualCameraParam.gameObject.GetComponent<P08CinemachineTrackPathExtend>();
			return;
		}
		if (_cinemachineTrackPathExtend != null)
		{
			float num = Vector3.Dot(_cinemachineTrackPathExtend.m_cart.transform.forward, _cinemachineTrackPathExtend.m_follow.transform.forward);
			WorldStateManager worldSatetManager = battleScene.GetWorldSatetManager();
			if (worldSatetManager != null)
			{
				worldSatetManager.m_isInReversed = num < 0f;
			}
		}
		Vector3 vector = playerAgent.Forward;
		Vector3 vector2 = new Vector3(joystickForwardVector.x, 0f, joystickForwardVector.y);
		if (vector2.sqrMagnitude > Mathf.Epsilon)
		{
			Vector3 forward = playerAgent.Forward;
			forward.y = 0f;
			vector = Quaternion.LookRotation(forward.normalized) * vector2;
		}
		Int3 lhs = (Int3)vector;
		bool isLimitTurn = false;
		SendMoveDirection(playerAgent, lhs, isLimitTurn);
	}
}
