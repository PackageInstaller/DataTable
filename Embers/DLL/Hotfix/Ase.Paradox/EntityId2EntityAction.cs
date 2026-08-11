#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("实体ID转换为实体", 0)]
[Description("通过实体ID获取对应的实体对象。")]
[Category("✫ DragonLost/Entity")]
public class EntityId2EntityAction : ActionTaskBase
{
	[RequiredField]
	[Name("实体Id", 0)]
	[Description("要转换的实体的实体Id。")]
	public BBParameter<int> entityId;

	[Name("返回的实体", 0)]
	[Description("转换后获取的实体对象。")]
	public BBParameter<BaseEntity> entity;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity baseEntity = ownerEntity.GetSystem<EntitySystem>().GetEntity(entityId.value);
		if (baseEntity != null)
		{
			entity.value = baseEntity;
		}
		else
		{
			LogActionError($"获取实体失败：Id：{entityId.value}对应的实体为空！");
		}
		EndAction();
	}
}
