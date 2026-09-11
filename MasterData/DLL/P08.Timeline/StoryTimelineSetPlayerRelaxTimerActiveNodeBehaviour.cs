using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineSetPlayerRelaxTimerActiveNodeBehaviour : PlayableBehaviour
{
	public bool switchTag = true;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!Application.isPlaying || SceneDirector.Instance == null)
		{
			return;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null || battleScene.GetBattleSimulatorSystem() == null)
		{
			return;
		}
		AgentManager agentManager = battleScene.GetAgentManager();
		if (agentManager == null)
		{
			return;
		}
		for (int i = 0; i < agentManager.mPlayerList.Count; i++)
		{
			NAgent agent = agentManager.GetAgent(agentManager.mPlayerList[i]);
			if (!(agent != null))
			{
				continue;
			}
			ComponentTimeline componentTimeline = agent.ComponentTimeline;
			if (componentTimeline != null)
			{
				if (switchTag)
				{
					componentTimeline.EnableRelaxTimer();
				}
				else
				{
					componentTimeline.DisableRelaxTimer();
				}
			}
		}
	}
}
