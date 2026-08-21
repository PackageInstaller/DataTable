#define ENABLE_LOG
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.ECS;

[Name("获取标记层数", 0)]
[Category("✫ DragonLost/DataNode")]
[Description("获取指定实体上特定标记的层数。")]
public class GetMarkLayerAction : ActionTaskBase
{
	[Name("目标Id", 0)]
	[Description("要获取标记层数的实体的ID。")]
	public BBParameter<int> entityId;

	[Name("标记Id", 0)]
	[Description("要获取层数的标记的ID。")]
	public BBParameter<string> markId;

	[Name("层数", 0)]
	[Description("存储标记层数的变量。")]
	public BBParameter<int> layer;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (string.IsNullOrEmpty(markId.value))
		{
			LogActionError("标记Id不能为空...");
			EndAction();
			return;
		}
		BaseEntity entity = GetEntity(entityId.value, isSyncEntity: true);
		if (entity == null)
		{
			LogActionError($"没有找到实体Id = {entityId.value} 的实体..");
			EndAction();
		}
		else
		{
			layer.value = entity.GetComponent<DataNodeComponent>()?.GetMarkLayer(markId.value) ?? 0;
			EndAction();
		}
	}
}
