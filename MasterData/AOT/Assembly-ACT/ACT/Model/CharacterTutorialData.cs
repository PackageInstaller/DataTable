using System.Collections.Generic;
using ACT.Config;
using ACT.Utility;

namespace ACT.Model;

public class CharacterTutorialData
{
	public int id;

	private List<PromptProcessData> _promptProcessDatas;

	private int _lastProcessId;

	public CharacterTutorialData(CharacterTutorialConfig config)
	{
		Init(config.id, config.promptProcessConfigs);
	}

	public CharacterTutorialData(CharacterTeamTutorialConfig config)
	{
		Init(config.id, config.promptProcessConfigs);
	}

	private void Init(int configId, List<PromptProcessConfig> promptProcessConfigs)
	{
		id = configId;
		_promptProcessDatas = new List<PromptProcessData>();
		if (promptProcessConfigs == null)
		{
			return;
		}
		for (int i = 0; i < promptProcessConfigs.Count; i++)
		{
			_promptProcessDatas.Add(new PromptProcessData(promptProcessConfigs[i]));
			if (i == promptProcessConfigs.GetLastIndex())
			{
				_lastProcessId = promptProcessConfigs[i].id;
			}
		}
	}

	public PromptProcessData GetPromptProcessData(int promptProcessId)
	{
		if (_promptProcessDatas == null)
		{
			return null;
		}
		return _promptProcessDatas.Find((PromptProcessData _) => _.id == promptProcessId);
	}

	public bool IsLastProcess(int processId)
	{
		return _lastProcessId == processId;
	}
}
