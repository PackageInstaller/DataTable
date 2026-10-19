using ACT.Config;
using ACT.Core;
using ACT.Utility;
using UnityEngine;

namespace ACT.Model;

public abstract class OperateNodeData
{
	protected int _index;

	protected OperateNodeState _state;

	protected IOperateNodeSuccessCondition _successCondition;

	protected OperateNodeSuccessConditionType _successConditionType;

	private bool _ignoreFailCondition;

	protected int _backIndex;

	protected OperateNodeOperateType _operateType;

	protected GroupImageData _nodeImageData;

	protected LocalizeStringData _nodeNameLocalizeData;

	protected LocalizeStringData _extraInfoLocalizeData;

	protected LocalizeStringData _pcNodeNameLocalizeData;

	protected LocalizeStringData _pcExtraInfoLocalizeData;

	public int Index => _index;

	public OperateNodeSuccessConditionType SuccessConditionType => _successConditionType;

	public bool IgnoreFailCondition
	{
		get
		{
			if (_index != 0)
			{
				return _ignoreFailCondition;
			}
			return true;
		}
	}

	public int BackIndex => _backIndex;

	public int MessageId { get; private set; }

	public OperateNodeOperateType OperateType => _operateType;

	public GroupImageData NodeImageData => _nodeImageData;

	public LocalizeStringData NodeNameLocalizeData => _nodeNameLocalizeData;

	public LocalizeStringData ExtraInfoLocalizeData => _extraInfoLocalizeData;

	public LocalizeStringData PcNodeNameLocalizeData => _pcNodeNameLocalizeData;

	public LocalizeStringData PcExtraInfoLocalizeData => _pcExtraInfoLocalizeData;

	public OperateNodeData(OperateNodeConfig config, int index)
	{
		_index = index;
		MessageId = ResolveMessageId(config);
		_state = OperateNodeState.Coming;
		_backIndex = config.backIndex;
		_ignoreFailCondition = config.ignoreFailCondition;
		_successConditionType = config.SuccessConditionType;
		switch (config.SuccessConditionType)
		{
		case OperateNodeSuccessConditionType.CharacterState:
		{
			CharacterStateOperateNodeConfig characterStateOperateNodeConfig = (CharacterStateOperateNodeConfig)config;
			_successCondition = new CharacterStateSuccessCondition(CreateTargetMatcher(config, characterStateOperateNodeConfig.characterId, useRaidFirstTryRoleWhenDefault: true), characterStateOperateNodeConfig.characterStateNames, characterStateOperateNodeConfig.ignoreStateNames);
			break;
		}
		case OperateNodeSuccessConditionType.CharacterAbility:
		{
			CharacterAbilityOperateNodeConfig characterAbilityOperateNodeConfig = (CharacterAbilityOperateNodeConfig)config;
			_successCondition = new CharacterAbilitySuccessCondition(CreateTargetMatcher(config, characterAbilityOperateNodeConfig.characterId, useRaidFirstTryRoleWhenDefault: false), characterAbilityOperateNodeConfig.abilityName);
			break;
		}
		case OperateNodeSuccessConditionType.PerfectDodge:
		{
			PerfectDodgeOperateNodeConfig perfectDodgeOperateNodeConfig = (PerfectDodgeOperateNodeConfig)config;
			_successCondition = new PerfectDodgeSuccessCondition(CreateTargetMatcher(config, perfectDodgeOperateNodeConfig.characterId, useRaidFirstTryRoleWhenDefault: false));
			break;
		}
		case OperateNodeSuccessConditionType.EnemyDie:
			_ = (EnemyDieOperateNodeConfig)config;
			_successCondition = new EnemyDieSuccessCondition();
			break;
		case OperateNodeSuccessConditionType.EnemyWeak:
			_ = (EnemyWeakOperateNodeConfig)config;
			_successCondition = new EnemyWeakSuccessCondition();
			break;
		case OperateNodeSuccessConditionType.SwitchCharacter:
			_successCondition = new SwitchCharacterSuccessCondition(CreateTargetMatcher(config, config.TargetCharacterId, useRaidFirstTryRoleWhenDefault: false), config.IncludeSwitchSkill);
			break;
		}
		_operateType = config.operateType;
		_nodeImageData = new GroupImageData(config.nodeImageConfig);
		_nodeNameLocalizeData = new LocalizeStringData(config.nodeNameLocalizeConfig);
		_extraInfoLocalizeData = new LocalizeStringData(config.extraInfoLocalizeConfig);
		_pcNodeNameLocalizeData = new LocalizeStringData(config.pcNodeNameLocalizeConfig);
		_pcExtraInfoLocalizeData = new LocalizeStringData(config.pcExtraInfoLocalizeConfig);
	}

	private static CharacterTutorialTargetMatcher CreateTargetMatcher(OperateNodeConfig config, int configuredCharacterId, bool useRaidFirstTryRoleWhenDefault)
	{
		CharacterTutorialTargetType characterTutorialTargetType = config.targetType;
		int num = configuredCharacterId;
		if (characterTutorialTargetType == CharacterTutorialTargetType.RaidFirstTryRole || (useRaidFirstTryRoleWhenDefault && characterTutorialTargetType == CharacterTutorialTargetType.ConfigCharacterId && num <= 0))
		{
			num = GetRaidFirstTryRole();
			characterTutorialTargetType = CharacterTutorialTargetType.RaidFirstTryRole;
		}
		return new CharacterTutorialTargetMatcher(characterTutorialTargetType, num, config.teamSlot);
	}

	private static int ResolveMessageId(OperateNodeConfig config)
	{
		string text = ((config != null) ? config.name : null);
		if (string.IsNullOrEmpty(text))
		{
			return 0;
		}
		int num = text.LastIndexOf('_');
		if (num < 0 || num >= text.Length - 1)
		{
			return 0;
		}
		if (!int.TryParse(text.Substring(num + 1), out var result))
		{
			return 0;
		}
		return result;
	}

	private static int GetRaidFirstTryRole()
	{
		int currentRaidId = Model<RaidModel>.Interface.CurrentRaidId;
		Raid data = CoreUtils.GetData(currentRaidId, RuntimeConfigs.data.raids);
		int[] array = data?.tryRole;
		if (array != null && array.Length > 0)
		{
			return data.tryRole[0];
		}
		Debug.LogWarning($"副本 {currentRaidId} 的 tryRole 字段为空。。。");
		return 0;
	}

	public bool CanHandle(CharacterTutorialEventData evt)
	{
		return _successCondition.CanHandle(evt);
	}

	public bool IsSuccess(CharacterTutorialEventData evt)
	{
		return _successCondition.IsSuccess(evt);
	}

	public bool IsSuccessOnEnter()
	{
		return _successCondition.IsSuccessOnEnter();
	}

	public void SetState(OperateNodeState state)
	{
		_state = state;
	}
}
