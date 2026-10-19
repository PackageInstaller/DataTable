using ACT.Config;

namespace ACT.Model;

public class CharacterAbilityOperateNodeData : OperateNodeData
{
	private string _abilityName;

	public CharacterAbilityOperateNodeData(OperateNodeConfig config, int index)
		: base(config, index)
	{
		CharacterAbilityOperateNodeConfig characterAbilityOperateNodeConfig = (CharacterAbilityOperateNodeConfig)config;
		_abilityName = characterAbilityOperateNodeConfig.abilityName;
	}

	public string GetAbilityName()
	{
		return _abilityName;
	}
}
