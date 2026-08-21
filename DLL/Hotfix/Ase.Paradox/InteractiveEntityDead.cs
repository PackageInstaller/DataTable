using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("回收交互物", 0)]
[Description("回收指定实体的交互物。")]
[Category("✫ DragonLost/Entity")]
public class InteractiveEntityDead : ActionTaskBase
{
	[Name("实体Id", 0)]
	[Description("要回收的交互物实体的ID。")]
	public BBParameter<int> entityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(entityId.value);
		if (entity == null)
		{
			OnActionFinish();
			return;
		}
		entity.DoEntityDead();
		OnActionFinish();
	}
}
