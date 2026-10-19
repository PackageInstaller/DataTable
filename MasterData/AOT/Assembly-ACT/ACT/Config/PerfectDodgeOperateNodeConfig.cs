namespace ACT.Config;

public class PerfectDodgeOperateNodeConfig : OperateNodeConfig
{
	public int characterId;

	protected override OperateNodeSuccessConditionType _successConditionType => OperateNodeSuccessConditionType.PerfectDodge;
}
