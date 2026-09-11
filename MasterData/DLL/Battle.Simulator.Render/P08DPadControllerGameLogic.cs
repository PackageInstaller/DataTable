using NetProcol;
using UnityEngine;

public class P08DPadControllerGameLogic : IStickControllerGameLogic
{
	private int preMoveDirection = int.MaxValue;

	private int FixtimeDirSndFrame;

	private bool PreControlEnable = true;

	private En_DPadType _enDPadType;

	public P08DPadControllerGameLogic(En_DPadType pEnDPadType)
	{
		_enDPadType = pEnDPadType;
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
		float num = joystickForwardVector.x;
		float num2 = joystickForwardVector.y;
		switch (_enDPadType)
		{
		default:
			return;
		case En_DPadType.FourDirections:
		{
			float num3 = Mathf.Abs(num);
			float num4 = Mathf.Abs(num2);
			if (num3 < num4)
			{
				num = 0f;
			}
			else
			{
				num2 = 0f;
			}
			break;
		}
		case En_DPadType.OnlyHorizontal:
			num2 = 0f;
			break;
		case En_DPadType.OnlyVertical:
			num = 0f;
			break;
		case En_DPadType.None:
			return;
		case En_DPadType.EightDirections:
			break;
		}
		num = ((num > 0.5f) ? 1f : ((!(num < -0.5f)) ? 0f : (-1f)));
		num2 = ((num2 > 0.5f) ? 1f : ((!(num2 < -0.5f)) ? 0f : (-1f)));
		Vector3 vector = new Vector3(num, 0f, num2);
		if (vector.sqrMagnitude <= Mathf.Epsilon)
		{
			SendStopMove(playerAgent);
			return;
		}
		Vector3 forward = Camera.main.transform.forward;
		forward.y = 0f;
		Int3 lhs = (Int3)(Quaternion.LookRotation(forward.normalized) * vector);
		SendMoveDirection(playerAgent, lhs);
	}
}
