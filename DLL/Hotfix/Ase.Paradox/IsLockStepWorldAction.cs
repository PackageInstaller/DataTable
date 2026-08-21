using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("是否是多人战斗", 0)]
[Category("✫ DragonLost/System")]
[Description("检查当前战斗是否为多人同步战斗模式。")]
public class IsLockStepWorldAction : ConditionTaskBase
{
	protected override bool OnCheck()
	{
		base.OnCheck();
		return ownerEntity.GetSystem<BattleSystem>().BattleMode == BattleWorldMode.SyncBattle;
	}
}
