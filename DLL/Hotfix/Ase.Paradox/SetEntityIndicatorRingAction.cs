using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("控制角色指示环显隐", 0)]
[Description("控制角色指示环显隐")]
[Category("✫ DragonLost/Entity")]
public class SetEntityIndicatorRingAction : ActionTaskBase
{
	[Name("显示指示环", 0)]
	[Description("如果选择，实体在行为树结束时将恢复视觉表现。")]
	public bool showIndicatorRing;

	[Name("行为树结束是否重置", 0)]
	[Description("如果选择，实体在行为树结束时将恢复视觉表现。")]
	public bool resetIndicatorRing;

	[Name("重置显隐为", 0)]
	[ShowIf("resetIndicatorRing", 1)]
	[Description("如果选择，实体在行为树结束时将恢复视觉表现。")]
	public bool resetIndicatorRingState;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity?.GetComponent<HeroIndicatorRingComponent>()?.SetIndicateRingShow(showIndicatorRing);
		OnActionFinish();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && resetIndicatorRing)
		{
			ownerEntity?.GetComponent<HeroIndicatorRingComponent>()?.SetIndicateRingShow(resetIndicatorRingState);
		}
	}
}
