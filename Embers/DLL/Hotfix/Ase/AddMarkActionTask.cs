#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("增加标记", 0)]
[Category("✫ DragonLost/DataNode")]
[Description("为指定实体增加标记，用于数据节点系统中的标记管理")]
public class AddMarkActionTask : ActionTaskBase
{
	[RequiredField]
	[Name("目标Id", 0)]
	[Description("要添加标记的目标实体的ID。")]
	public BBParameter<int> targetEntity;

	[Name("标记Id", 0)]
	[Description("要添加的标记的ID。")]
	public BBParameter<string> markId;

	[Name("标记类型", 0)]
	[Description("要添加的标记的类型。")]
	public BBParameter<string> markType;

	[Name("层数", 0)]
	[Description("标记的层数。")]
	public BBParameter<int> layer = new BBParameter<int>(1);

	[Name("持续时间", 0)]
	[Description("标记的持续时间。")]
	public BBParameter<float> time = new BBParameter<float>(0f);

	[Name("标记计时类型", 0)]
	[Description("标记的计时类型。")]
	public BBParameter<MarkTimeType> markTimeType = new BBParameter<MarkTimeType>(MarkTimeType.TimerIsLifeDuration);

	[Name("是否跟随行为树销毁", 0)]
	[Description("如果为 true，则在行为树停止时移除标记。")]
	public BBParameter<bool> followTreeDispose;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (string.IsNullOrEmpty(markId.value))
		{
			LogActionError("标记Id不能为空...");
			EndAction();
			return;
		}
		BaseEntity entity = GetEntity(targetEntity.value, isSyncEntity: false);
		if (entity == null)
		{
			LogActionError("实体为空..");
			EndAction();
			return;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"增加标记 目标Id ： {targetEntity.value} 标记Id {markId.value}  标记类型 {markType.value}" + $"层数 {layer.value}  持续时间  {time.value} 标记计时类型 : {markTimeType.value}", entity);
		}
		markId.value = entity.GetComponent<DataNodeComponent>()?.AddMark(markId.value, layer.value, time.value, markType.value, markTimeType.value);
		EndAction();
	}

	protected override void OnGraphStop()
	{
		BaseEntity entity = GetEntity(targetEntity.value, isSyncEntity: false);
		if (entity == null)
		{
			LogActionError("实体为空..");
		}
		else if (followTreeDispose.value)
		{
			entity.GetComponent<DataNodeComponent>()?.RemoveMark(markId.value);
		}
	}
}
