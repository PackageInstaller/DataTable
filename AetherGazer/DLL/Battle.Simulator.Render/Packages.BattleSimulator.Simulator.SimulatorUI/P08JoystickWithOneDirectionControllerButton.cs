using System;
using NetProcol;
using UnityEngine;

namespace Packages.BattleSimulator.Simulator.SimulatorUI;

public class P08JoystickWithOneDirectionControllerButton : P08EXButton
{
	public Diretion diretion;

	private int preMoveDirection = int.MaxValue;

	private int FixtimeDirSndFrame;

	private bool PreControlEnable = true;

	private bool PreMoveEqualsZero;

	private void Awake()
	{
		actionOnPointerDown = (Action)Delegate.Combine(actionOnPointerDown, new Action(ActionPointerDown));
		actionOnPointerUp = (Action)Delegate.Combine(actionOnPointerUp, new Action(ActionPointerUp));
	}

	private void OnDestroy()
	{
		actionOnPointerDown = (Action)Delegate.Remove(actionOnPointerDown, new Action(ActionPointerDown));
		actionOnPointerUp = (Action)Delegate.Remove(actionOnPointerUp, new Action(ActionPointerUp));
	}

	public void SendMoveDirection(NAgent player, Int3 lhs)
	{
		FixtimeDirSndFrame++;
		if (lhs != Int3.zero)
		{
			int i = IntMath.AngleOfVector(lhs).i;
			MoveDirectionCommand moveDirectionCommand = CommandFactory.Create(NetprotoOperationCode.CmdMoveDir) as MoveDirectionCommand;
			moveDirectionCommand.SetData(player.AgentID, i, EMoveDirectionMode.CustomMovementLocal, 1);
			ClientSimulator.Instance.SendLocalCommand(moveDirectionCommand);
			PreMoveEqualsZero = false;
		}
		else
		{
			MoveDirectionStopCommand moveDirectionStopCommand = CommandFactory.Create(NetprotoOperationCode.CmdStopMoveDir) as MoveDirectionStopCommand;
			moveDirectionStopCommand.SetData(player.AgentID);
			ClientSimulator.Instance.SendLocalCommand(moveDirectionStopCommand);
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
				Int3 lhs = (Int3)new Vector3(joystickForwardVector.x, 0f, joystickForwardVector.y);
				SendMoveDirection(playerAgent, lhs);
			}
		}
	}

	public void ActionPointerDown()
	{
		Vector2 zero = Vector2.zero;
		UpdateLogic(diretion switch
		{
			Diretion.forward => Vector2.up, 
			Diretion.backward => Vector2.down, 
			Diretion.left => Vector2.left, 
			Diretion.right => Vector2.right, 
			_ => Vector2.zero, 
		});
	}

	public void ActionPointerUp()
	{
		UpdateLogic(Vector2.zero);
	}
}
