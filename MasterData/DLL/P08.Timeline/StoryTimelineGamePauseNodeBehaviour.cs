using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineGamePauseNodeBehaviour : PlayableBehaviour
{
	public bool pause = true;

	private BattleSimulatorSystem mBattleSimulator;

	private bool visibleState = true;

	private BattleSimulatorSystem GetBattleSimulatorSystem()
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
		return battleScene.GetBattleSimulatorSystem();
	}

	private void ChangeAgentVisibleState(bool flag)
	{
		if (visibleState == flag)
		{
			return;
		}
		visibleState = flag;
		AgentManager clientAgentManager = mBattleSimulator.ClientAgentManager;
		if (clientAgentManager == null)
		{
			return;
		}
		List<NAgent> entities = clientAgentManager.Entities;
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
		if (!Application.isPlaying)
		{
			return;
		}
		if (mBattleSimulator == null)
		{
			mBattleSimulator = GetBattleSimulatorSystem();
			if (mBattleSimulator == null)
			{
				return;
			}
		}
		if (pause && !BattleScene.isPause)
		{
			mBattleSimulator.PauseGame();
		}
		else if (!pause && BattleScene.isPause)
		{
			mBattleSimulator.ResumeGame();
		}
	}
}
