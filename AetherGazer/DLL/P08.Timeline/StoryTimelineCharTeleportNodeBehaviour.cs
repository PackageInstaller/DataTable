using NetProcol;
using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineCharTeleportNodeBehaviour : PlayableBehaviour
{
	public int mTargetID;

	public Int3 mTargetPos;

	public int mForwardAngle;

	private bool finished;

	private NAgent playerAgent;

	public static NAgent GetPlayerAgent()
	{
		if (!Application.isPlaying)
		{
			return null;
		}
		return AgentManager.GetAgentManager()?.GetPlayerAgent();
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
		MoveToCommand moveToCommand = CommandFactory.Create(NetprotoOperationCode.CmdMoveToPos) as MoveToCommand;
		moveToCommand.SetData(playerAgent.AgentID, mTargetID, mTargetPos, mForwardAngle);
		ClientSimulator.Instance.SendLocalCommand(moveToCommand);
		return true;
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		base.PrepareFrame(playable, info);
		if (!finished)
		{
			finished = SendLocalCommand();
		}
	}
}
