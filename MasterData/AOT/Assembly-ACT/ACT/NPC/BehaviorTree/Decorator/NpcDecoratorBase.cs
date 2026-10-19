using ACT.Battle;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.NPC.BehaviorTree.Decorator;

public abstract class NpcDecoratorBase : BehaviorDesigner.Runtime.Tasks.Decorator
{
	public Entity OwnerEntity => OwnerMonoEntity.entity;

	public MonoEntity OwnerMonoEntity { get; private set; }

	public override void OnAwake()
	{
		base.OnAwake();
		OwnerMonoEntity = Owner.GetComponent<MonoEntity>();
	}
}
