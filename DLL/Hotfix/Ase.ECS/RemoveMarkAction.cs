#define ENABLE_LOG
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.ECS;

[Name("移除标记", 0)]
[Description("移除实体的指定标记，可以按照标记类型或标记ID进行移除")]
[Category("✫ DragonLost/DataNode")]
public class RemoveMarkAction : ActionTaskBase
{
	[RequiredField]
	[Name("目标Id", 0)]
	[Description("要移除标记的实体的ID")]
	public BBParameter<int> entity;

	[Name("按类型移除", 0)]
	[Description("指示是否按照标记类型进行移除")]
	public bool removeByType;

	[ShowIf("removeByType", 1)]
	[Name("标记类型", 0)]
	[Description("要移除的标记的类型")]
	public BBParameter<string> markType;

	[ShowIf("removeByType", 0)]
	[Name("标记Id", 0)]
	[Description("要移除的标记的ID")]
	public BBParameter<string> markId;

	[Name("是否按层数移除", 0)]
	public bool isRemoveLayer;

	[Name("移除层数", 0)]
	[ShowIf("isRemoveLayer", true)]
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
		BaseEntity baseEntity = GetEntity(entity.value, isSyncEntity: false);
		if (baseEntity == null)
		{
			LogActionError($"没有找到实体Id = {entity.value} 的实体..");
			EndAction();
			return;
		}
		if (isRemoveLayer)
		{
			if (removeByType)
			{
				baseEntity.GetComponent<DataNodeComponent>()?.RemoveMarkLayerByType(markType.value, layer.value);
			}
			else
			{
				baseEntity.GetComponent<DataNodeComponent>()?.RemoveMarkLayer(markId.value, layer.value);
			}
		}
		else if (removeByType)
		{
			baseEntity.GetComponent<DataNodeComponent>()?.RemoveMarkByType(markType.value);
		}
		else
		{
			baseEntity.GetComponent<DataNodeComponent>()?.RemoveMark(markId.value);
		}
		EndAction();
	}
}
