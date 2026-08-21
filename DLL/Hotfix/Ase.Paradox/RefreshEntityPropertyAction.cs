#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("恢复实体初始属性值", 0)]
[Description("恢复指定实体的指定属性值为初始值。")]
[Category("✫ DragonLost/Entity")]
public class RefreshEntityPropertyAction : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("要恢复属性的实体的ID。")]
	public BBParameter<int> EntityId;

	[Name("属性名", 0)]
	[Description("要恢复的属性的名称。")]
	public BBParameter<string> PropertyName;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: true);
		if (entity == null)
		{
			LogActionError("恢复实体初始属性值错误：实体为空!");
			EndAction();
		}
		else
		{
			entity.ResetProperty(PropertyName.value);
			EndAction();
		}
	}
}
