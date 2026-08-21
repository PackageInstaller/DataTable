#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取当前异常状态持续时间", 0)]
[Category("✫ DragonLost/State")]
public class GetAbnormalStateProgressAction : ActionTaskBase
{
	public enum TimeValueEnum
	{
		Cur,
		Max
	}

	[Name("目标实体ID", 0)]
	[Description("要附加异常状态的目标实体的ID。")]
	public BBParameter<int> EntityId;

	[Name("异常状态ID", 0)]
	[Description("要附加的异常状态的ID。")]
	public BBParameter<int> StateId;

	[Name("获取时间类型", 0)]
	public TimeValueEnum timeEnum;

	[Name("返回时间", 0)]
	public BBParameter<float> Progress;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: false);
		if (entity == null)
		{
			LogActionError($"目标附加异常状态错误: 实体ID {EntityId.value} 为空!");
			EndAction();
			return;
		}
		if (timeEnum == TimeValueEnum.Cur)
		{
			Progress.value = entity.GetComponent<AbnormalStateComponent>().GetAbnormalStateDuration(StateId.value);
		}
		else if (timeEnum == TimeValueEnum.Max)
		{
			Progress.value = entity.GetComponent<AbnormalStateComponent>().GetAbnormalStateConfigDuration(StateId.value);
		}
		EndAction();
	}
}
