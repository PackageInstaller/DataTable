using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检查是否在剧情关卡", 0)]
[Category("✫ DragonLost/Condition")]
[Description("检查当前是否在剧情关卡中。")]
public class CheckIsStoryWorld : ConditionTaskBase
{
	protected override bool OnCheck()
	{
		base.OnCheck();
		return GetOwnerEntity().GetSystem<BattleSystem>().BattleMode == BattleWorldMode.LevelBattle;
	}
}
