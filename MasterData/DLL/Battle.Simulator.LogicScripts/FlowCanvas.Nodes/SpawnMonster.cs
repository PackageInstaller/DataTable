using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("创建怪物", 0)]
[Category("Logic/Spawn")]
[Description("创建怪物")]
[ExposeAsDefinition]
public class SpawnMonster : CallableFunctionNode<SimEntity, Int3, Int3, RoleType, int, int, int, int, int, int>
{
	public override SimEntity Invoke(Int3 spawnPoint, Int3 forward, RoleType camp, int ai_id, int roleID, int aiThinkTimer, int hp, int radius = 500, int moveSpeed = 800)
	{
		return SpawnProcessor.SpawnUnit(0L, spawnPoint, forward, new Int3(0, 1, 0), camp, ai_id, isLocalPlayer: false, roleID, aiThinkTimer, MemberPosition.None, hp, moveSpeed);
	}
}
