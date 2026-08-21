using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("显示实体表现层", 0)]
[Description("根据实体是否存活，显示其表现层。")]
[Category("✫ DragonLost/Entity")]
public class ShowEntityView : ActionTaskBase
{
	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity.IsSurvival)
		{
			ownerEntity.GetComponent<EntityViewComponent>().ShowEntityView();
		}
		OnActionFinish();
	}
}
