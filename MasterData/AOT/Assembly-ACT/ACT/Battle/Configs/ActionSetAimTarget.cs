using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置瞄准目标", "Action", new string[] { "set", "aim", "target", "retarget" })]
public class ActionSetAimTarget : ConfigAction
{
	public string attachPoint = "waist";

	public override void Do(ActionMemory memory)
	{
		memory.owner.GetCompAim().SetAimEntity(memory.target.entity, attachPoint);
	}
}
