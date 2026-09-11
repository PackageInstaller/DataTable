using NetProcol;
using UnityEngine.Playables;

public class StoryTimelineMapTriggerNodeBehaviour : PlayableBehaviour
{
	public int targetTriggerID;

	public bool enable;

	private bool finished;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!finished)
		{
			NAgent playerAgent = StoryTimelineCharCtrlNodeBehaviour.GetPlayerAgent();
			if (!(playerAgent == null))
			{
				ChangeTriggerStateCommand changeTriggerStateCommand = CommandFactory.Create(NetprotoOperationCode.CmdModifyTriggerState) as ChangeTriggerStateCommand;
				changeTriggerStateCommand.SetData(playerAgent.AgentID, 0, targetTriggerID, enable);
				ClientSimulator.Instance.SendLocalCommand(changeTriggerStateCommand);
				finished = true;
			}
		}
	}
}
