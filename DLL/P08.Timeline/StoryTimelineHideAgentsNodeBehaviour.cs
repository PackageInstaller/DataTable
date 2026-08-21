using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineHideAgentsNodeBehaviour : PlayableBehaviour
{
	public bool hideAgent;

	private AgentManager agentManager;

	private bool finished;

	private AgentManager GetAgentManager()
	{
		if (SceneDirector.Instance == null)
		{
			return null;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return null;
		}
		if (battleScene.GetBattleSimulatorSystem() == null)
		{
			return null;
		}
		return battleScene.GetAgentManager();
	}

	private void ChangeAgentVisibleState(bool flag)
	{
		AgentManager agentManager = this.agentManager;
		if (agentManager == null)
		{
			return;
		}
		List<NAgent> entities = agentManager.Entities;
		for (int i = 0; i < entities.Count; i++)
		{
			ComponentTimeline componentTimeline = entities[i].ComponentTimeline;
			if (flag)
			{
				componentTimeline.DisableRenders();
			}
			else
			{
				componentTimeline.EnableRenders();
			}
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!Application.isPlaying || finished)
		{
			return;
		}
		if (agentManager == null)
		{
			agentManager = GetAgentManager();
			if (agentManager == null)
			{
				return;
			}
		}
		ChangeAgentVisibleState(hideAgent);
		finished = true;
	}
}
