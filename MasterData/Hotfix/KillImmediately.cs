[AdventureEffect(HotfixEnum.effectType.KILL_IMMEDIATELY)]
public class KillImmediately : AdventureEffectBase
{
	public override void Execute()
	{
		base.Execute();
		for (int i = 0; i < _targets.Count; i++)
		{
			_targets.get_Item(i).Kill(_owner.GetComponent<LogicEntity>());
		}
	}
}
