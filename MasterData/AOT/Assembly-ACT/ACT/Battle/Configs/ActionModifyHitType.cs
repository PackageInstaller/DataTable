namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改命中类型", "Action", new string[] { "modify", "hit", "type", "damage", "attack" })]
public class ActionModifyHitType : ConfigAction
{
	public HitType hitType;

	public override void Do(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData getAttackData)
		{
			getAttackData.GetAttackData().hitType = hitType;
		}
	}
}
