using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检查是否存在Boss", 0)]
[Category("✫ DragonLost/Condition")]
[Description("检查当前战斗模式是否存在Boss。")]
public class CheckBattleModel : ConditionTaskBase
{
	protected override bool OnCheck()
	{
		base.OnCheck();
		BattleWorldMode battleMode = GetOwnerEntity().GetSystem<BattleSystem>().BattleMode;
		bool result = true;
		if (battleMode == BattleWorldMode.LevelBattle)
		{
			result = ownerEntity.GetSystem<BattleSystem>().LevelBossMode;
		}
		return result;
	}
}
