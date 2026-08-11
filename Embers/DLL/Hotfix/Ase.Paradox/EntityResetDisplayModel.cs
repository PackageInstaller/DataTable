using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("重置显示模型", 0)]
[Category("✫ DragonLost/Entity")]
[Description("重置实体的显示模型。")]
public class EntityResetDisplayModel : ActionTaskBase
{
	protected override void OnExecute()
	{
		base.OnExecute();
		EntityViewComponent component = ownerEntity.GetComponent<EntityViewComponent>();
		if (component == null)
		{
			OnActionFail();
			return;
		}
		component.ResetDisplayModel();
		OnActionFinish();
	}
}
