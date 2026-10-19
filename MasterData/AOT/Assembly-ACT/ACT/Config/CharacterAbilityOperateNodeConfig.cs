namespace ACT.Config;

public class CharacterAbilityOperateNodeConfig : OperateNodeConfig
{
	public int characterId;

	public string abilityName;

	protected override OperateNodeSuccessConditionType _successConditionType => OperateNodeSuccessConditionType.CharacterAbility;
}
