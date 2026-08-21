using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("隐藏实体血条", 0)]
[Description("隐藏实体的血条。")]
[Category("✫ DragonLost/Entity")]
public class HideEntityHpBar : ActionTaskBase
{
	protected override void OnExecute()
	{
		base.OnExecute();
		HpComponent component = ownerEntity.GetComponent<HpComponent>();
		if (component == null)
		{
			OnActionFail();
			return;
		}
		component.HideHpBar();
		OnActionFinish();
	}
}
