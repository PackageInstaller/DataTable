using NetProcol;
using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelinePostCommandBehaviour : PlayableBehaviour
{
	public StoryType m_storyType;

	public bool m_isEnter = true;

	private bool _isPost;

	private NAgent _playerAgent;

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
		storyCommand.storyType = m_storyType;
		storyCommand.enterState = m_isEnter;
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
		return battleScene.GetAgentManager()?.GetPlayerAgent();
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (Application.isPlaying && !_isPost)
		{
			_isPost = SendLocalCommand();
		}
	}
}
