using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取实体出生位置", 0)]
[Category("✫ DragonLost/Entity")]
public class GetEntityBornPosition : ActionTaskBase
{
	[Name("返回坐标", 0)]
	[Description("存储获取到的实体出生位置。")]
	public BBParameter<Vector3> positionParam;

	[Name("目标实体", 0)]
	[Description("目前只适配关卡使用")]
	public BBParameter<int> targetId;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(targetId.value, isSyncEntity: true);
		if (entity == null)
		{
			EndAction();
			return;
		}
		BaseMapDataNode data = entity.GetData<BaseMapDataNode>("MAPDATANODEKEY");
		if (GetOwnerEntity().GetWorld().IsStoryWorld && (Object)(object)data != null)
		{
			positionParam.value = ((Component)(object)data).transform.position;
		}
		else
		{
			positionParam.value = entity.transform.position;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"获取实体位置 {positionParam.value}", ownerEntity);
		}
		OnActionFinish();
	}
}
