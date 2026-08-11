using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("刷新实体动画机变量", 0)]
[Category("✫ DragonLost/Animator")]
[Description("用于刷新实体的动画机变量")]
public class RefreshEntityAnimatorParam : ActionTaskBase
{
	[RequiredField]
	[Name("实体ID", 0)]
	[Description("要刷新动画机变量的实体的ID")]
	public BBParameter<int> entityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(entityId.value, isSyncEntity: false);
		if (entity == null)
		{
			EndAction();
			return;
		}
		entity.GetComponent<AnimatorComponent>()?.ResetAnimatorDefaultParam();
		EndAction();
	}
}
