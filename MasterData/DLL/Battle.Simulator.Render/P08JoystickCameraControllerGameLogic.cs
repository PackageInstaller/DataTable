using NetProcol;
using UnityEngine;

public class P08JoystickCameraControllerGameLogic : IStickControllerGameLogic
{
	public float speed = 100f;

	private int preMoveDirection = int.MaxValue;

	private int FixtimeDirSndFrame;

	private bool PreControlEnable = true;

	private CameraParamComponent _cameraParam;

	private float _cameraSensitivity = 10f;

	private P08CinemachineTrackPathExtend _cinemachineTrackPathExtend;

	public P08JoystickCameraControllerGameLogic(float pCameraSensitivity)
	{
		_cameraSensitivity = pCameraSensitivity;
	}

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
		if (_cameraParam == null)
		{
			_cameraParam = battleScene.virtualCameraParam;
			_cinemachineTrackPathExtend = battleScene.virtualCameraParam.gameObject.GetComponent<P08CinemachineTrackPathExtend>();
			return;
		}
		float num = joystickForwardVector.x * _cameraSensitivity * speed * Time.deltaTime;
		if (!(Mathf.Abs(num) < 0.01f))
		{
			_cameraParam.transposer.m_XAxis.Value += num;
		}
		Vector3 vector = Camera.main.transform.forward.NewY(0f);
		if (_cinemachineTrackPathExtend != null)
		{
			float num2 = Vector3.Dot(_cinemachineTrackPathExtend.m_cart.transform.forward, _cinemachineTrackPathExtend.m_follow.transform.forward);
			WorldStateManager worldSatetManager = battleScene.GetWorldSatetManager();
			if (worldSatetManager != null)
			{
				worldSatetManager.m_isInReversed = num2 < 0f;
			}
		}
		Vector3 vector2 = new Vector3(0f, 0f, 1f);
		if (vector2.sqrMagnitude <= Mathf.Epsilon)
		{
			SendStopMove(playerAgent);
			return;
		}
		Vector3 vector3 = vector;
		vector3.y = 0f;
		Int3 lhs = (Int3)(Quaternion.LookRotation(vector3.normalized) * vector2);
		SendMoveDirection(playerAgent, lhs);
	}

	public float GetSpeed()
	{
		return speed;
	}

	public void SetSpeed(float pSpeed)
	{
		speed = pSpeed;
	}
}
