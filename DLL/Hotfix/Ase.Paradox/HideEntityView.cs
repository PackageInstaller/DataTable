using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("隐藏实体表现层", 0)]
[Description("隐藏实体的视觉表现，可以选择在行为树结束时恢复。")]
[Category("✫ DragonLost/Entity")]
public class HideEntityView : ActionTaskBase
{
	[Name("是否随行为树结束还原", 0)]
	[Description("如果选择，实体在行为树结束时将恢复视觉表现。")]
	public bool isBack;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity?.GetComponent<EntityViewComponent>()?.HideEntityView();
		OnActionFinish();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && isBack)
		{
			ownerEntity?.GetComponent<EntityViewComponent>()?.ShowEntityView();
		}
	}
}
