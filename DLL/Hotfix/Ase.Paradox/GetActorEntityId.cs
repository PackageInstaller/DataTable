using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取玩家操控的角色实体ID", 0)]
[Description("获取当前世界中玩家操控的角色实体的 ID。如果当前游戏模式为同步战斗模式，则不执行任何操作。")]
[Category("✫ DragonLost/Entity")]
public class GetActorEntityId : ActionTaskBase
{
	[Name("玩家操控的角色实体ID", 0)]
	[Description("玩家操控的角色实体的 ID。")]
	public BBParameter<int> resultEntityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity.GetSystem<BattleSystem>().BattleMode == BattleWorldMode.SyncBattle)
		{
			EndAction();
			return;
		}
		int actorId = ownerEntity.GetWorld().ActorId;
		BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(actorId);
		if (entity == null || !entity.IsSurvival)
		{
			resultEntityId.value = 0;
			EndAction();
		}
		else
		{
			resultEntityId.value = actorId;
			OnActionFinish();
		}
	}
}
