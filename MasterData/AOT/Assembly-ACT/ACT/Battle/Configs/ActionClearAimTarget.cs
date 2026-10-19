using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("清除瞄准目标", "Action", new string[] { "clear", "aim", "target", "retarget" })]
public class ActionClearAimTarget : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		memory.target.entity.GetCompAim().ClearAimEntity();
	}
}
