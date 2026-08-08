using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI发起攻击", 0)]
[Category("Logic/AI")]
[Description("AI发起攻击.....")]
[ExposeAsDefinition]
public class AIStartAttack : CallableActionNode<int, int, Int3, int, bool>
{
	public override void Invoke(int entityID, int targetID, Int3 targetPostion, int abilityID, bool force)
	{
		AIProcessor.AIStartAttack(entityID, targetPostion, abilityID, force);
	}
}
