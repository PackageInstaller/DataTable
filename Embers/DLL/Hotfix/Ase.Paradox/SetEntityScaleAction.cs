#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("修改实体Scale值", 0)]
[Description("根据指定的实体 ID 修改实体的缩放大小，并在必要时恢复原始大小。")]
[Category("✫ DragonLost/Entity")]
public class SetEntityScaleAction : ActionTaskBase
{
	[Name("实体Id", 0)]
	[RequiredField]
	[Description("要修改缩放的实体的唯一标识符。")]
	public BBParameter<int> entityId;

	[Name("尺寸大小", 0)]
	[Description("要设置的实体的新尺寸大小。")]
	public BBParameter<Vector3> scale;

	[Name("是否随行为树结束还原尺寸", 0)]
	[Description("指示是否在行为树结束时恢复实体的原始尺寸。")]
	public bool isRestore;

	[Name("绑点名字", 0)]
	[Description("用于修改实体尺寸的绑定点名称。")]
	public string pointName;

	[Name("还原尺寸", 0)]
	[ShowIf("isRestore", 1)]
	[Description("在行为树结束时恢复实体的原始尺寸。")]
	public Vector3 originalScale;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(entityId.value, isSyncEntity: false);
		if (entity == null)
		{
			LogActionError("修改实体Scale值错误: 实体为空!");
			EndAction();
		}
		else
		{
			entity.GetComponent<EntityViewComponent>().SetEntityScale(scale.value, pointName);
			OnActionFinish();
		}
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null)
		{
			BaseEntity entity = GetEntity(entityId.value, isSyncEntity: true);
			if (isRestore)
			{
				entity?.GetComponent<EntityViewComponent>().SetEntityScale(originalScale, pointName);
			}
		}
	}
}
