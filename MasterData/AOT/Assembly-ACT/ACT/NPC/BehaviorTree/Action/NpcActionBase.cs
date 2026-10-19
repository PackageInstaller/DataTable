using ACT.Battle;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.NPC.BehaviorTree.Action;

public abstract class NpcActionBase : BehaviorDesigner.Runtime.Tasks.Action
{
	public Entity OwnerEntity => OwnerMonoEntity.entity;

	public MonoEntity OwnerMonoEntity { get; private set; }

	public override void OnAwake()
	{
		base.OnAwake();
		OwnerMonoEntity = Owner.GetComponent<MonoEntity>();
	}
}
