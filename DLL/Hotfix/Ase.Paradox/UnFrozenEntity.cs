using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("提前结束实体某些类型的冻帧", 0)]
[Description("提前结束实体某些类型的冻帧，结束冻结的类型0 = 空 1 = 动画 2 = 特效 3 = 两者 4 = 击中特效 ")]
public class UnFrozenEntity : ActionTaskBase
{
	[RequiredField]
	[Name("目标ID", 0)]
	[Description("要冻结的实体的ID。")]
	public BBParameter<int> targetId;

	[Name("冻结的类型", 0)]
	[Description("0 = 空 1 = 动画 2 = 特效 3 = 两者 4 = 击中特效 冻结动画时会冻结行为树以及技能派生")]
	public int frozenTarget;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(targetId.value, isSyncEntity: false);
		if (entity == null)
		{
			EndAction(success: true);
		}
		entity.GetSystem<FrameFrozenSystem>().EndFrozenFrame(targetId.value, frozenTarget);
		EndAction(success: true);
	}
}
