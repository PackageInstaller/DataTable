using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("切换控制角色", 0)]
[Category("✫ DragonLost/System")]
[Description("切换当前控制的角色实体。")]
public class ChangeActorAction : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("要切换为控制角色的实体的ID。")]
	public BBParameter<int> EntityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<BattleSystem>().SetAIToActor(EntityId.value, isForce: true);
		EndAction();
	}
}
