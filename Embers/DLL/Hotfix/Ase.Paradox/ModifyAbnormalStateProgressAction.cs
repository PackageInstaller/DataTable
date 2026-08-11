#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改异常状态持续时间", 0)]
[Category("✫ DragonLost/State")]
public class ModifyAbnormalStateProgressAction : ActionTaskBase
{
	public enum ModifyEnum
	{
		Set,
		Sub
	}

	[Name("目标实体ID", 0)]
	[Description("要附加异常状态的目标实体的ID。")]
	public BBParameter<int> EntityId;

	[Name("异常状态ID", 0)]
	[Description("要附加的异常状态的ID。")]
	public BBParameter<int> StateId;

	[Name("修改类型", 0)]
	public ModifyEnum modifyEnum;

	[Name("持续时间", 0)]
	[Description("通常用于指定异常状态的强度或持续时间。")]
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
		if (modifyEnum == ModifyEnum.Sub)
		{
			entity.GetComponent<AbnormalStateComponent>().AddAbnormalStateDuration(StateId.value, 0f - Progress.value);
		}
		else if (modifyEnum == ModifyEnum.Set)
		{
			entity.GetComponent<AbnormalStateComponent>().SetAbnormalStateDuration(StateId.value, Progress.value);
		}
		EndAction();
	}
}
