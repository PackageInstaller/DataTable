namespace ACT.Config;

public class SwitchCharacterOperateNodeConfig : OperateNodeConfig
{
	public int characterId;

	public bool includeSwitchSkill = true;

	protected override OperateNodeSuccessConditionType _successConditionType => OperateNodeSuccessConditionType.SwitchCharacter;

	public override int TargetCharacterId => characterId;

	public override bool IncludeSwitchSkill => includeSwitchSkill;
}
