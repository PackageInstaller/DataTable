#define ENABLE_LOG
using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Pool;

namespace Ase;

[Name("增加标记到召唤物", 0)]
[Category("✫ DragonLost/DataNode")]
[Description("为指定实体的所有召唤物增加标记，用于数据节点系统中的标记管理")]
public class AddMarkToSummoned : ActionTaskBase
{
	[RequiredField]
	[Name("创建者实体ID", 0)]
	[Description("要添加标记的召唤物创建者的ID。")]
	public BBParameter<int> creatorID;

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

	[Space(10)]
	[Name("返回召唤物实体ID列表", 0)]
	public BBParameter<List<int>> summonedList;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (string.IsNullOrEmpty(markId.value))
		{
			LogActionError("标记Id不能为空...");
			EndAction();
			return;
		}
		BaseEntity entity = GetEntity(creatorID.value, isSyncEntity: false);
		if (entity == null)
		{
			LogActionError("实体为空..");
			EndAction();
			return;
		}
		List<SummonedEntity> list = entity.GetComponent<SummonedComponent>()?.GetSummonedEntities();
		if (list == null)
		{
			OnActionFail("当前实体未找到召唤物组件");
			return;
		}
		summonedList.value = new List<int>();
		for (int i = 0; i < list.Count; i++)
		{
			SummonedEntity summonedEntity = list[i];
			DataNodeComponent component = summonedEntity.GetComponent<DataNodeComponent>();
			if (component != null)
			{
				component.AddMark(markId.value, layer.value, time.value, markType.value, markTimeType.value);
				summonedList.value.Add(summonedEntity.Id);
			}
		}
		CollectionPool<List<SummonedEntity>, SummonedEntity>.Release(list);
		EndAction();
	}

	protected override void OnGraphStop()
	{
		BaseEntity entity = GetEntity(creatorID.value, isSyncEntity: false);
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
