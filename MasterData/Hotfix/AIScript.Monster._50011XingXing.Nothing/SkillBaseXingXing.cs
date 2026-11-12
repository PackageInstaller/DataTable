namespace AIScript.Monster._50011XingXing.Nothing;

public class SkillBaseXingXing : SkillSimpleBase
{
	protected static readonly string WarningFx = "fx_common_base_charge_fire_actor";

	protected static readonly int ATKLIndex = 0;

	protected static readonly string ATKLKey = "NormalAttack_Long";

	protected static readonly int TurnATKLIndex = 1;

	protected static readonly string TurnATKLKey = "TurnAttack_L";

	protected static readonly int TurnATKRIndex = 2;

	protected static readonly string TurnATKRKey = "TurnAttack_R";

	protected static readonly int ATKSIndex = 3;

	protected static readonly string ATKSKey = "NormalAttack_Short";

	protected static readonly int DashChargeIndex = 4;

	protected static readonly string DashChargeJumpKey = "Dash_Charge";

	protected static readonly int DashATKIndex = 5;

	protected static readonly string DashATKJumpKey = "Dash_Attack";

	protected static readonly int DropIndex = 6;

	protected static readonly string DropAttack = "Drop_Attack";

	protected static readonly int ESJumpIndex = 7;

	protected static readonly string ESJumpKey = "EarthShatter_Jump";

	protected static readonly int ESATKIndex = 8;

	protected static readonly string ESATKKey = "EarthShatter_Attack";

	protected static readonly int jumpIndex = 100;

	protected static readonly int earthQuakeDashIndex = 101;

	protected LogicEntity GetTarget()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (!CheckTargetIsValid(logicEntity))
		{
			logicEntity = GetCurrentPlayer();
		}
		return logicEntity;
	}
}
