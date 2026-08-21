using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineHideCampAgentsNodeBehaviour : PlayableBehaviour
{
	public bool hideSelfAgent;

	public bool hideFriendAgent;

	public bool hideEnemyAgent;

	public bool showSelfAgent;

	public bool showFriendAgent;

	public bool showEnemyAgent;

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

	private bool GetCampResult(NAgent agent, bool flagSelf, bool flagFriend, bool flagOther)
	{
		if (agent == null)
		{
			return false;
		}
		if (agent.IsLocalPlayer & flagSelf)
		{
			return true;
		}
		if ((agent.Camp == 1 && !agent.IsLocalPlayer) & flagFriend)
		{
			return true;
		}
		if ((agent.Camp == 2) & flagOther)
		{
			return true;
		}
		return false;
	}

	private void ChangeAgentVisibleState()
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
			bool campResult = GetCampResult(entities[i], hideSelfAgent, hideFriendAgent, hideEnemyAgent);
			Debug.Log($"SetHide{campResult} {componentTimeline.mAgent.Camp}");
			if (campResult)
			{
				componentTimeline.DisableRenders();
			}
			campResult = GetCampResult(entities[i], showSelfAgent, showFriendAgent, showEnemyAgent);
			Debug.Log($"SetShow{campResult} {componentTimeline.mAgent.Camp}");
			if (campResult)
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
		ChangeAgentVisibleState();
		finished = true;
	}
}
