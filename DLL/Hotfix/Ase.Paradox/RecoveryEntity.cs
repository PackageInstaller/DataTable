using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("回收实体", 0)]
[Description("回收指定实体，释放其占用的资源。")]
[Category("✫ DragonLost/Entity")]
public class RecoveryEntity : ActionTaskBase
{
	[Name("实体Id", 0)]
	[Description("要回收的实体的ID。")]
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
		entity.DoEntityRelease();
		OnActionFinish();
	}
}
