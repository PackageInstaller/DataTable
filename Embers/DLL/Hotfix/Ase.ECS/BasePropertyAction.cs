using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.ECS;

[Name("基础属性操作基类", 0)]
[Description("用于执行基础属性操作的基类。")]
public class BasePropertyAction : ActionTaskBase
{
	[Name("目标ID", 0)]
	[Description("操作的目标实体ID。")]
	public BBParameter<BaseEntity> entity;

	[Name("属性名", 0)]
	[Description("要操作的属性名称。")]
	public BBParameter<string> propertyKey;

	protected BaseEntity targetEntity;

	protected override void OnExecute()
	{
		base.OnExecute();
		targetEntity = entity.value;
		if (targetEntity == null)
		{
			EndAction(success: false);
		}
	}
}
