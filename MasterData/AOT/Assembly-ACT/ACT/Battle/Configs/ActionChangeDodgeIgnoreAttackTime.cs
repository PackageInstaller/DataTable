using System;

namespace ACT.Battle.Configs;

[Obsolete]
[AbilityTypeMetadata("修改闪避忽略攻击时间", "Action", new string[] { "change", "dodge", "ignore", "attack", "time", "move", "movement", "position", "velocity" })]
public class ActionChangeDodgeIgnoreAttackTime : ConfigAction
{
	public EntityTag tag;

	public override void Do(ActionMemory memory)
	{
	}
}
