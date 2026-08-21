#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("目标附加异常状态", 0)]
[Category("✫ DragonLost/State")]
[Description("向目标实体附加指定的异常状态，可以指定异常状态的程度。")]
public class AddAbnormalStateAction : ActionTaskBase
{
	[Name("目标实体ID", 0)]
	[Description("要附加异常状态的目标实体的ID。")]
	public BBParameter<int> EntityId;

	[Name("来源实体ID", 0)]
	public BBParameter<int> FromId;

	[Name("异常状态ID", 0)]
	[Description("要附加的异常状态的ID。")]
	public BBParameter<int> StateId;

	[Name("程度", 0)]
	[Description("异常状态的程度，通常用于指定异常状态的强度或持续时间。")]
	public BBParameter<float> Progress;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: false);
		if (entity == null)
		{
			LogActionError($"目标附加异常状态错误: 实体ID {EntityId.value} 为空!");
			EndAction();
		}
		else
		{
			entity.GetComponent<AbnormalStateComponent>().AddAbnormalState(StateId.value, FromId.value, Progress.value);
			EndAction();
		}
	}
}
