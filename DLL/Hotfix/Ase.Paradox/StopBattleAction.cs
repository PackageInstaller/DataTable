using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("战斗倒计时结束节点", 0)]
[Category("✫ DragonLost/System")]
[Description("用于在战斗倒计时结束时停止战斗。")]
public class StopBattleAction : ActionTaskBase
{
	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<BattleSystem>().StopBattleTime();
		EndAction();
	}
}
