using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置约束中平面", "Action", new string[] { "set", "constrain", "in", "plane" })]
public class ActionSetConstrainInPlane : ConfigAction
{
	public bool res;

	public override void Do(ActionMemory memory)
	{
		memory.target.entity.GetCompPhysics().SetConstrainInPlane(res);
	}
}
