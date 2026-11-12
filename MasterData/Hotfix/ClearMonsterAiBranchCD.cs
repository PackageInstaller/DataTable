[AdventureEffect(HotfixEnum.effectType.CLEAR_MONSTER_AI_BRANCH_CD)]
public class ClearMonsterAiBranchCD : AdventureEffectBase
{
	public override void Execute()
	{
		base.Execute();
		for (int i = 0; i < _targets.Count; i++)
		{
			_targets.get_Item(i).DispatchEvent(AdventureClearMonsterAiBranchCDEvent.Generate());
		}
	}
}
