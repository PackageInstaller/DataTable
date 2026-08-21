#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("实体转换为实体Id", 0)]
[Description("将指定的实体转换为实体Id，并将其存储到指定的黑板参数中。")]
[Category("✫ DragonLost/Entity")]
public class Entity2EntityIdAction : ActionTaskBase
{
	[RequiredField]
	[Name("实体", 0)]
	[Description("要转换为实体Id的实体。")]
	public BBParameter<BaseEntity> entity;

	[Name("返回的实体Id", 0)]
	[Description("存储实体Id的黑板参数。")]
	public BBParameter<int> entityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (entity.value == null)
		{
			LogActionError("实体转换为实体Id失败：实体为空！");
		}
		else
		{
			entityId.value = entity.value.Id;
		}
		EndAction();
	}
}
