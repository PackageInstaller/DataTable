using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("实体冻帧", 0)]
[Description("冻结指定实体一定数量的帧数，并可选择是否随行为树结束而解除冻结。冻结的类型0 = 空 1 = 动画 2 = 特效 3 = 两者 4 = 击中特效 冻结动画时会冻结行为树以及技能派生")]
[Category("✫ DragonLost/Entity")]
public class FrozenEntity : ActionTaskBase
{
	[Name("冻帧速度", 0)]
	[Description("冻结实体之后实体的动画等相关的速度")]
	public BBParameter<float> frozenSpeed = 0f;

	[RequiredField]
	[Name("目标ID", 0)]
	[Description("要冻结的实体的ID。")]
	public BBParameter<int> targetId;

	[Name("冻帧时长(逻辑帧)", 0)]
	[Description("冻结实体的帧数。")]
	public BBParameter<int> frozenFrame = 5;

	[Name("冻结的类型", 0)]
	[Description("0 = 空 1 = 动画 2 = 特效 3 = 两者 4 = 击中特效 冻结动画时会冻结行为树以及技能派生")]
	public int frozenTarget;

	[Name("优先级", 0)]
	public FrozenPriority FrozenPriority;

	[Name("是否随状态变化结束冻帧", 0)]
	[Description("有些状态会直接结束冻帧：")]
	public bool IsIgnoreStateEndFrozen;

	[Name("是否跟随行为树结束冻结", 0)]
	[Description("如果为 true，则冻结将随行为树结束而解除；否则，需要手动解除冻结。")]
	public bool followTreeDispose = true;

	private int? _frozenId;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(targetId.value, isSyncEntity: false);
		if (entity == null)
		{
			EndAction(success: true);
		}
		int priority = 0;
		switch (FrozenPriority)
		{
		case FrozenPriority.SamePriority:
			priority = 1;
			break;
		case FrozenPriority.LessThanBulletPriority:
			priority = 0;
			break;
		case FrozenPriority.GreaterThanBulletPriority:
			priority = 2;
			break;
		}
		_frozenId = entity.GetSystem<FrameFrozenSystem>()?.AddFrozenAndChaseFrame(frozenSpeed.value, priority, entity, frozenFrame.value, frozenTarget, null, IsIgnoreStateEndFrozen);
		EndAction();
	}

	protected override void OnGraphStop()
	{
		if (ownerEntity != null && followTreeDispose && _frozenId.HasValue)
		{
			ownerEntity.GetSystem<FrameFrozenSystem>()?.EndFrozenFrame(_frozenId.Value);
		}
	}
}
