using UnityEngine;

public class MasterSkillRenderMedium : MonoBehaviour
{
	public const string prefabPathMedium = "StoryTimeline/MasterSkill/Medium/QTE_Portrait";

	public const string prefabPathLow = "StoryTimeline/MasterSkill/Low/QTE_Head";

	public BattleUIPortrait battleUIPortrait;

	public float duringTime;

	public float intervalTime;

	public string parentPath = "BattlePop";

	private string _mainPath;

	private string _playerPath;

	private float _delayTime;

	public void SetPath(string mainPath, string playerPath)
	{
		_mainPath = mainPath;
		_playerPath = playerPath;
	}

	public void PlayFunction()
	{
		battleUIPortrait.Play(_mainPath, duringTime);
		_delayTime = intervalTime;
	}

	private void Update()
	{
		if (!(_delayTime <= 0f))
		{
			_delayTime -= Time.deltaTime;
			if (!(_delayTime > 0f))
			{
				battleUIPortrait.Play(_playerPath, duringTime);
			}
		}
	}

	public void PlayStoryCommand(int agentID, bool enterState)
	{
	}
}
