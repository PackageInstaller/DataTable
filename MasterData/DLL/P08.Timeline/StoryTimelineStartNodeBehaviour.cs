using NetProcol;
using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineStartNodeBehaviour : PlayableBehaviour
{
	public bool m_postCommand = true;

	private NAgent _playerAgent;

	private bool _posted;

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
		storyCommand.enterState = true;
		storyCommand.mOwner = _playerAgent.AgentID;
		ClientSimulator.Instance.SendLocalCommand(storyCommand);
		return true;
	}

	public NAgent GetPlayerAgent()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (null == battleScene)
		{
			return null;
		}
		return battleScene.GetAgentManager()?.GetPlayerAgent();
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (Application.isPlaying && m_postCommand)
		{
			if (!_posted)
			{
				_posted = SendLocalCommand();
			}
			_ = _posted;
		}
	}
}
