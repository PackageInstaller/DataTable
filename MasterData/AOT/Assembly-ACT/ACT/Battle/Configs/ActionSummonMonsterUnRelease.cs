namespace ACT.Battle.Configs;

[AbilityTypeMetadata("召唤怪物取消Release", "Action", new string[] { "summon", "monster", "un", "release" })]
public class ActionSummonMonsterUnRelease : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		if (memory.evt is EvtBeforeRemoveSummonMonster evtBeforeRemoveSummonMonster)
		{
			evtBeforeRemoveSummonMonster.removeSummonMonsterParam.release = false;
		}
	}
}
