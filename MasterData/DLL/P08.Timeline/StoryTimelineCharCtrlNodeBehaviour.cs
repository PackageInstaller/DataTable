using NetProcol;
using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineCharCtrlNodeBehaviour : PlayableBehaviour
{
	public CharCtrlType charCtrlType;

	public Vector3 targetPosition;

	public bool stopWhenArrived;

	private bool finished;

	private NAgent playerAgent;

	public static NAgent GetPlayerAgent()
	{
		if (!Application.isPlaying)
		{
			return null;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (null == battleScene)
		{
			return null;
		}
		return battleScene.GetAgentManager()?.GetPlayerAgent();
	}

	public void MoveCommand()
	{
		int i = IntMath.AngleOfVector((Int3)(targetPosition - playerAgent.Position)).i;
		MoveDirectionCommand moveDirectionCommand = CommandFactory.Create(NetprotoOperationCode.CmdMoveDir) as MoveDirectionCommand;
		moveDirectionCommand.SetData(playerAgent.AgentID, i, EMoveDirectionMode.Lookat);
		ClientSimulator.Instance.SendLocalCommand(moveDirectionCommand);
	}

	public void StopCommand()
	{
		MoveDirectionStopCommand moveDirectionStopCommand = CommandFactory.Create(NetprotoOperationCode.CmdStopMoveDir) as MoveDirectionStopCommand;
		moveDirectionStopCommand.SetData(playerAgent.AgentID);
		ClientSimulator.Instance.SendLocalCommand(moveDirectionStopCommand);
	}

	public bool SendLocalCommand()
	{
		if (playerAgent == null)
		{
			playerAgent = GetPlayerAgent();
		}
		if (playerAgent == null)
		{
			return false;
		}
		switch (charCtrlType)
		{
		case CharCtrlType.MOVE:
			MoveCommand();
			break;
		case CharCtrlType.STOP:
			StopCommand();
			break;
		}
		return true;
	}

	public void JumpToEnd(Playable playable)
	{
		float num = (float)playable.GetTime();
		float num2 = (float)playable.GetDuration();
		PlayableDirector playableDirector = playable.GetGraph().GetResolver() as PlayableDirector;
		if (playableDirector != null && (double)(num2 - num) > 0.1)
		{
			playableDirector.time += num2 - num;
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		base.OnBehaviourPause(playable, info);
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		base.OnBehaviourPlay(playable, info);
		if (!finished)
		{
			finished = SendLocalCommand();
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		base.PrepareFrame(playable, info);
		if (!finished)
		{
			finished = SendLocalCommand();
		}
		if (charCtrlType == CharCtrlType.MOVE && playerAgent != null && stopWhenArrived && (playerAgent.Position - targetPosition).sqrMagnitude < 1f)
		{
			StopCommand();
		}
	}

	public override void OnGraphStop(Playable playable)
	{
		base.OnGraphStop(playable);
		finished = false;
	}
}
