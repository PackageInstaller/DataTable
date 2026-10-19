using System.Collections.Generic;
using ACT.Config;
using ACT.Utility;

namespace ACT.Model;

public class PromptProcessData
{
	public int id;

	private List<OperateNodeData> _operateNodeDatas;

	private int _curIndex;

	public LocalizeStringData describeLocalizeData;

	public LocalizeStringData titleLocalizeData;

	public int NodeCount => _operateNodeDatas?.Count ?? 0;

	private int _lastIndex => _operateNodeDatas.Count - 1;

	public PromptProcessData(PromptProcessConfig config)
	{
		id = config.id;
		_curIndex = -1;
		_operateNodeDatas = new List<OperateNodeData>();
		for (int i = 0; i < config.operateNodeConfigs.Count; i++)
		{
			if (config.operateNodeConfigs[i] is CharacterStateOperateNodeConfig)
			{
				_operateNodeDatas.Add(new CharacterStateOperateNodeData(config.operateNodeConfigs[i], i));
			}
			else if (config.operateNodeConfigs[i] is CharacterAbilityOperateNodeConfig)
			{
				_operateNodeDatas.Add(new CharacterAbilityOperateNodeData(config.operateNodeConfigs[i], i));
			}
			else if (config.operateNodeConfigs[i] is EnemyDieOperateNodeConfig)
			{
				_operateNodeDatas.Add(new EnemyDieOperateNodeData(config.operateNodeConfigs[i], i));
			}
			else if (config.operateNodeConfigs[i] is EnemyWeakOperateNodeConfig)
			{
				_operateNodeDatas.Add(new EnemyWeakOperateNodeData(config.operateNodeConfigs[i], i));
			}
			else if (config.operateNodeConfigs[i] is PerfectDodgeOperateNodeConfig)
			{
				_operateNodeDatas.Add(new PerfectDodgeOperateNodeData(config.operateNodeConfigs[i], i));
			}
			else if (config.operateNodeConfigs[i].SuccessConditionType == OperateNodeSuccessConditionType.SwitchCharacter)
			{
				_operateNodeDatas.Add(new SwitchCharacterOperateNodeData(config.operateNodeConfigs[i], i));
			}
		}
		describeLocalizeData = new LocalizeStringData(config.describeLocalizeConfig);
		titleLocalizeData = new LocalizeStringData(config.titleLocalizeConfig);
	}

	public OperateNodeData StartFirstNode()
	{
		List<OperateNodeData> operateNodeDatas = _operateNodeDatas;
		if (operateNodeDatas == null || operateNodeDatas.Count <= 0)
		{
			return null;
		}
		_curIndex = 0;
		_operateNodeDatas[_curIndex].SetState(OperateNodeState.Doing);
		return _operateNodeDatas[_curIndex];
	}

	public bool ToNextNode(out OperateNodeData operateNodeData)
	{
		if (_curIndex == _lastIndex)
		{
			operateNodeData = null;
			return false;
		}
		_operateNodeDatas[_curIndex].SetState(OperateNodeState.Finish);
		_curIndex++;
		_operateNodeDatas[_curIndex].SetState(OperateNodeState.Doing);
		operateNodeData = _operateNodeDatas[_curIndex];
		return true;
	}

	private OperateNodeData BackToNode(int backToIndex = 0)
	{
		if (backToIndex > _lastIndex)
		{
			return null;
		}
		if (backToIndex > _curIndex)
		{
			return null;
		}
		for (int i = backToIndex; i <= _curIndex; i++)
		{
			_operateNodeDatas[i].SetState(OperateNodeState.Coming);
		}
		_curIndex = backToIndex;
		_operateNodeDatas[_curIndex].SetState(OperateNodeState.Doing);
		return _operateNodeDatas[_curIndex];
	}

	public OperateNodeData BackToNode(OperateNodeData nodeData)
	{
		return BackToNode(nodeData.BackIndex);
	}

	public OperateNodeData GetNode(int index)
	{
		if (index > _lastIndex || index < 0)
		{
			return null;
		}
		return _operateNodeDatas[index];
	}

	public bool IsLastNode(OperateNodeData nodeData)
	{
		return _lastIndex == nodeData.Index;
	}
}
