using UnityEngine;

namespace ACT.Config;

public abstract class OperateNodeConfig : ScriptableObject
{
	public bool ignoreFailCondition;

	public int backIndex;

	public OperateNodeOperateType operateType;

	public CharacterTutorialTargetType targetType;

	public int teamSlot = -1;

	public GroupImageConfig nodeImageConfig;

	public LocalizeStringConfig nodeNameLocalizeConfig;

	public LocalizeStringConfig extraInfoLocalizeConfig;

	public LocalizeStringConfig pcNodeNameLocalizeConfig;

	public LocalizeStringConfig pcExtraInfoLocalizeConfig;

	protected abstract OperateNodeSuccessConditionType _successConditionType { get; }

	public OperateNodeSuccessConditionType SuccessConditionType => _successConditionType;

	public virtual int TargetCharacterId => 0;

	public virtual bool IncludeSwitchSkill => false;
}
