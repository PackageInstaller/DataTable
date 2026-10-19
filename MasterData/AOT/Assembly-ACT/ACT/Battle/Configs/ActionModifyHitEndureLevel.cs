namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改命中硬直等级", "Action", new string[] { "modify", "hit", "endure", "level", "damage", "attack" })]
public class ActionModifyHitEndureLevel : ConfigAction
{
	public EndureType hitEndureType;

	public override void Do(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData getAttackData)
		{
			getAttackData.GetAttackData().endureType = hitEndureType;
		}
	}
}
