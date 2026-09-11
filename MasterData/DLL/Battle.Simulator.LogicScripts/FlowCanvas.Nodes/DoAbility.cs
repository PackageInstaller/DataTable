using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("执行Ability", 0)]
[Category("Logic/Abilities")]
[Description("执行Ability.....")]
[ExposeAsDefinition]
public class DoAbility : CallableActionNode<int, int, Int3, int, bool>
{
	public override void Invoke(int entityID, int targetID, Int3 targetPostion, int abilityID, bool force)
	{
		AIProcessor.AIStartAttack(entityID, targetPostion, abilityID, force);
	}
}
