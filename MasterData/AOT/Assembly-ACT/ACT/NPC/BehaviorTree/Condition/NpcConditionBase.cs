using ACT.Battle;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.NPC.BehaviorTree.Condition;

public abstract class NpcConditionBase : Conditional
{
	public Entity OwnerEntity => OwnerMonoEntity.entity;

	public MonoEntity OwnerMonoEntity { get; private set; }

	public override void OnAwake()
	{
		base.OnAwake();
		OwnerMonoEntity = Owner.GetComponent<MonoEntity>();
	}
}
