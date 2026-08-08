using NetProcol;
using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineDestoryNodeBehaviour : PlayableBehaviour
{
	public bool m_postCommand = true;

	private NAgent _playerAgent;

	private bool _posted;

	private bool finished;

	public bool SendLocalCommand()
	{
		if (_playerAgent == null)
		{
			_playerAgent = GetPlayerAgent();
		}
		if (_playerAgent == null)
		{
			return false;
		}
		StoryCommand storyCommand = CommandFactory.Create(NetprotoOperationCode.CmdStory) as StoryCommand;
		storyCommand.storyType = StoryType.PlayBattleStory;
		storyCommand.enterState = false;
		storyCommand.mOwner = _playerAgent.AgentID;
		ClientSimulator.Instance.SendLocalCommand(storyCommand);
		return true;
	}

	public static NAgent GetPlayerAgent()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (null == battleScene)
		{
			return null;
		}
		if (battleScene.GetBattleSimulatorSystem() == null)
		{
			return null;
		}
		return battleScene.GetAgentManager()?.GetPlayerAgent();
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!Application.isPlaying)
		{
			return;
		}
		if (m_postCommand)
		{
			if (!_posted)
			{
				_posted = SendLocalCommand();
			}
			if (!_posted)
			{
				return;
			}
		}
		PlayableDirector playableDirector = playable.GetGraph().GetResolver() as PlayableDirector;
		if (playableDirector != null && !finished)
		{
			playableDirector.gameObject.SetActive(value: false);
			if (Application.isPlaying)
			{
				Object.Destroy(playableDirector.gameObject, (float)playable.GetDuration());
			}
			finished = true;
		}
	}
}
