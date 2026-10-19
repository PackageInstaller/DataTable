namespace ACT.Config;

public class CharacterStateOperateNodeConfig : OperateNodeConfig
{
	public int characterId;

	public string[] characterStateNames;

	public string[] ignoreStateNames;

	protected override OperateNodeSuccessConditionType _successConditionType => OperateNodeSuccessConditionType.CharacterState;
}
