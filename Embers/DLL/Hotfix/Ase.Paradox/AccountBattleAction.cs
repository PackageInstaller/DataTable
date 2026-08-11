using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("金币副本结算", 0)]
[Category("✫ DragonLost/System")]
[Description("执行金币副本的结算操作。")]
public class AccountBattleAction : ActionTaskBase
{
	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<BattleSystem>().GoldGameSettlement();
		EndAction();
	}
}
